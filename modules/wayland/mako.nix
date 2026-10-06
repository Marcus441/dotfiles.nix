_: {
  flake.modules.homeManager.wayland = {config, ...}: let
    inherit (config.desktop) font;
  in {
    services.mako = {
      enable = true;

      settings = {
        anchor = "top-right";
        default-timeout = 5000;
        border-size = 2;
        padding = 10;

        font = "${font.name} ${toString font.terminalSize}";

        ignore-timeout = false;
        max-icon-size = 32;
        outer-margin = 20;
        width = 420;
        height = 110;

      };

      extraConfig = ''
        [app-name=notify-send summary="OCR*"]
        default-timeout=3000

        [summary="*screenshot*"]
        default-timeout=5000
      '';
    };

    desktop.autostart = ["mako"];
  };

  flake.modules.homeManager.laptop = {
    services.mako.extraConfig = ''
      [summary="*Battery*"]
      default-timeout=20000
    '';
  };
}
