{ config, ... }:
let
  user = config.meta.user;

  nhCommon = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 14d --keep 5";
    };
  };
in
{
  flake.modules.nixos.core.programs.nh = nhCommon // {
    flake = "/home/${user}/.dotfiles/flake";
    clean = nhCommon.clean // {
      dates = "Sun 03:15";
    };
  };

  flake.modules.darwin.core.programs.nh = nhCommon // {
    flake = "/Users/${user}/.dotfiles/flake";
  };
}
