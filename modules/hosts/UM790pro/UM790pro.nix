{
  config,
  inputs,
  ...
}:
let
  inherit (config.flake.lib) mkNixos mkHome;
in
{
  flake.nixosConfigurations.UM790pro = mkNixos "x86_64-linux" "UM790pro";
  flake.homeConfigurations."${config.meta.user}@UM790pro" = mkHome "x86_64-linux" "UM790pro";

  flake.modules.nixos.UM790pro =
    {
      lib,
      pkgs,
      ...
    }:
    {
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
      boot.kernelParams = [ "usbcore.autosuspend=-1" ];
      services.udev.extraRules = ''
        ACTION=="add", SUBSYSTEM=="net", KERNEL=="wlan*", RUN+="${lib.getExe pkgs.iw} dev $name set power_save off"
      '';

      programs.nix-ld = {
        enable = true;
        libraries = [
          pkgs.libbsd
          pkgs.dbus
          pkgs.libdrm
          pkgs.expat
          pkgs.libgbm
          pkgs.nspr
          pkgs.nss
          pkgs.libpng
          pkgs.libpulseaudio
          pkgs.libuuid
          pkgs.zlib
          pkgs.libice
          pkgs.libsm
          pkgs.libx11
          pkgs.libxcb
          pkgs.libxext
          pkgs.libxi
          pkgs.libxkbfile

          pkgs.libglvnd
          pkgs.libxau
          pkgs.vulkan-loader
          pkgs.wayland
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
      firefox-profile
      apps
      yazi
    ];

    terminal.font.terminalSize = 20;

    desktop.monitors = [
      {
        name = "DP-1";
        width = 5120;
        height = 2880;
        scale = 2;
        refresh = 144.051;
      }
    ];
  };
}
