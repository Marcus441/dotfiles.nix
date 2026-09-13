_: {
  flake.modules.homeManager.dwl = {
    config,
    lib,
    pkgs,
    ...
  }: let
    cfg = config.dwl;

    configH = pkgs.writeText "dwl-config.h" (import ./_config-h.nix {inherit config lib pkgs;});

    dwl = pkgs.dwl.overrideAttrs (old: {
      patches = (old.patches or []) ++ cfg.patches;
      buildInputs = (old.buildInputs or []) ++ cfg.buildInputs;

      postPatch =
        (old.postPatch or "")
        + ''
          cp ${configH} config.h
        '';
    });

    autostart =
      pkgs.writeShellScript "dwl-autostart"
      (lib.concatMapStrings (c: "${c} &\n") config.desktop.autostart);

    statusFeed = lib.optionalString (cfg.statusCommand != "") "{ ${cfg.statusCommand}; } | ";
  in {
    options.dwl = {
      bar = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether the compiled dwl has a bar. Selects which symbols config.h defines: showbar/fonts/tags[]/colors[][3] against upstream's bordercolor/focuscolor/urgentcolor and TAGCOUNT.";
      };

      patches = lib.mkOption {
        type = lib.types.listOf lib.types.path;
        default = [];
        description = "Applied to nixpkgs' dwl before config.h is copied in.";
      };

      buildInputs = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        default = [];
        description = "Extra buildInputs the patches need.";
      };

      statusCommand = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "Shell command whose stdout dwl reads as bar status. Empty when the compositor was built without a bar, in which case nothing is piped into it.";
      };
    };

    config.home.packages = [
      dwl
      (pkgs.writeShellScriptBin "dwl-start" ''
        ${statusFeed}${lib.getExe' dwl "dwl"} -s ${autostart}
      '')
    ];
  };

  flake.modules.nixos.dwl = {pkgs, ...}: let
    # dwl itself comes from the standalone home profile, so the session only
    # loads that profile and hands over to its dwl-start.
    session = pkgs.writeShellScript "dwl-session" ''
      hm_vars="$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      [ -f "$hm_vars" ] && . "$hm_vars"
      export PATH="$HOME/.nix-profile/bin:$PATH"
      export XDG_CURRENT_DESKTOP=dwl
      export XDG_SESSION_TYPE=wayland

      exec dwl-start
    '';

    desktopEntry = pkgs.writeTextFile {
      name = "dwl-session";
      destination = "/share/wayland-sessions/dwl.desktop";
      text = ''
        [Desktop Entry]
        Name=dwl
        Comment=dwl
        Exec=${session}
        Type=Application
      '';
      passthru.providedSessions = ["dwl"];
    };
  in {
    services.displayManager.sessionPackages = [desktopEntry];

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
      config.dwl = {
        default = ["gtk"];
        "org.freedesktop.impl.portal.Screenshot" = ["wlr"];
        "org.freedesktop.impl.portal.ScreenCast" = ["wlr"];
      };
    };
  };
}
