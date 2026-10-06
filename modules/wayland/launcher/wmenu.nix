_: {
  flake.modules.homeManager.wayland = {
    config,
    lib,
    pkgs,
    ...
  }: let
    inherit (config.desktop) font;

    cliphist = lib.getExe pkgs.cliphist;
    wlCopy = lib.getExe' pkgs.wl-clipboard "wl-copy";

    wmenu = lib.getExe pkgs.wmenu;
    wmenuRun = lib.getExe' pkgs.wmenu "wmenu-run";
    pkill = lib.getExe' pkgs.procps "pkill";
    flags = lib.escapeShellArgs [
      "-f"
      "${font.name} 12"
      "-l"
      "10"
    ];
  in {
    options.wmenu.cliphist-command = lib.mkOption {
      type = lib.types.str;
      description = "Command to spawn the clipboard history in wmenu";
    };
    options.wmenu.launcher-command = lib.mkOption {
      type = lib.types.str;
      description = "Command to spawn the .desktop app launcher in wmenu";
    };

    config = {
      home.packages = [pkgs.wmenu];

      wmenu.cliphist-command = "${pkill} -x wmenu || ${cliphist} list | ${wmenu} ${flags} | ${cliphist} decode | ${wlCopy}";
      wmenu.launcher-command = "${pkill} -x wmenu-run || ${wmenuRun} ${flags}";
    };
  };
}
