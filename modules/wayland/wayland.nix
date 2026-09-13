_: {
  flake.modules.homeManager.wayland = {lib, ...}: {
    options.desktop.autostart = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Commands the session backgrounds once the compositor is up, resolved from PATH. Session pieces add to it; the compositor aspect decides how to launch them.";
    };

    config.home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland";
    };
  };
}
