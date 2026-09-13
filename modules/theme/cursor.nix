_: {
  flake.modules.homeManager.wayland = {pkgs, ...}: let
    name = "DMZ-Black";
    size = 24;
  in {
    home.pointerCursor = {
      enable = true;
      inherit name size;
      package = pkgs.vanilla-dmz;
      gtk.enable = true;
      x11.enable = true;
    };

    home.sessionVariables = {
      XCURSOR_THEME = name;
      XCURSOR_SIZE = toString size;
    };
  };
}
