_: {
  flake.modules.nixos.wayland = {
    services = {
      power-profiles-daemon.enable = true;
      upower.enable = true;
    };
  };
}
