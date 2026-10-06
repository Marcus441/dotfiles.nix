_: {
  flake.modules.homeManager.wayland =
    { config, ... }:
    let
      inherit (config.desktop) font;
    in
    {
      programs.swaylock = {
        enable = true;
        settings = {
          font = font.name;
          font-size = font.terminalSize;

          indicator-radius = 100;
          indicator-thickness = 8;
          indicator-caps-lock = true;

          ignore-empty-password = true;
          show-failed-attempts = true;
        };
      };
    };

  flake.modules.nixos.wayland = {
    security.pam.services.swaylock = { };
  };
}
