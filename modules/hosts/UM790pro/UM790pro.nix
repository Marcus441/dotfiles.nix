{
  config,
  inputs,
  ...
}: let
  inherit (config.flake.lib) mkNixos mkHome;
in {
  flake.nixosConfigurations.UM790pro = mkNixos "x86_64-linux" "UM790pro";
  flake.homeConfigurations."${config.meta.user}@UM790pro" = mkHome "x86_64-linux" "UM790pro";

  flake.modules.nixos.UM790pro = {pkgs, ...}: {
    imports = with inputs.self.modules.nixos; [
      ./_hardware-configuration.nix
      core
      dev
      zsh
      wayland
      dwl
      apps
      keychron
    ];

    system.stateVersion = "25.11";

    # The wifi card drops out when it or its USB bus is allowed to sleep.
    networking.networkmanager.wifi.powersave = false;
    boot.kernelParams = ["usbcore.autosuspend=-1"];
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="net", KERNEL=="wlan*", RUN+="${pkgs.iw}/bin/iw dev $name set power_save off"
    '';

    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        libbsd
        dbus
        libdrm
        expat
        libgbm
        nspr
        nss
        libpng
        libpulseaudio
        libuuid
        zlib
        libice
        libsm
        libx11
        libxcb
        libxext
        libxi
        libxkbfile

        libglvnd
        libxau
        vulkan-loader
        wayland
      ];
    };
  };

  flake.modules.homeManager.UM790pro = {
    imports = with inputs.self.modules.homeManager; [
      core
      dev
      zsh
      wayland
      dwl
      dwl-bar
      foot
      firefox
      apps
    ];

    desktop.font.terminalSize = 24;

    desktop.monitors = [
      {
        name = "DP-11";
        width = 3840;
        height = 2160;
        refresh = 120;
      }
    ];
  };
}
