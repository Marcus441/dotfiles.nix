_: {
  flake.modules.homeManager.wayland =
    { config, ... }:
    let
      qfont = family: size: ''"${family},${toString size},-1,5,50,0,0,0,0,0"'';

      conf = ''
        [Appearance]
        icon_theme=${config.gtk.iconTheme.name}
        standard_dialogs=default
        style=Fusion

        [Fonts]
        general=${qfont config.gtk.font.name config.gtk.font.size}
        fixed=${qfont config.desktop.font.name config.desktop.font.terminalSize}
      '';
    in
    {
      qt = {
        enable = true;
        platformTheme.name = "qtct";
      };

      xdg.configFile = {
        "qt5ct/qt5ct.conf".text = conf;
        "qt6ct/qt6ct.conf".text = conf;
      };
    };
}
