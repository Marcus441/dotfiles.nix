_: {
  flake.modules.homeManager.wayland = { lib, ... }: {
    options.desktop.autostart = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Commands the session backgrounds once the compositor is up.";
    };

    config.home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland";
    };
  };
}
