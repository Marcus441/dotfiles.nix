_: {
  flake.modules.homeManager.wayland =
    { config, ... }:
    let
      inherit (config.desktop) font;
      # dwl colors (RRGGBBAA)
      norm = {
        fg = "bbbbbbff";
        bg = "222222ff";
        border = "444444ff";
      };
      sel = {
        fg = "eeeeeeff";
        bg = "005577ff";
        border = "005577ff";
      };
      urg = {
        border = "770000ff";
      };
      transparent = "00000000";
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
          color = norm.bg;

          inside-color = norm.bg;
          ring-color = norm.border;
          line-color = norm.bg;
          text-color = norm.fg;
          separator-color = transparent;

          key-hl-color = sel.bg;
          bs-hl-color = urg.border;

          inside-ver-color = sel.bg;
          ring-ver-color = sel.border;
          line-ver-color = sel.bg;
          text-ver-color = sel.fg;

          inside-wrong-color = norm.bg;
          ring-wrong-color = urg.border;
          line-wrong-color = norm.bg;
          text-wrong-color = norm.fg;

          inside-clear-color = norm.bg;
          ring-clear-color = norm.border;
          line-clear-color = norm.bg;
          text-clear-color = norm.fg;

          inside-caps-lock-color = norm.bg;
          ring-caps-lock-color = sel.border;
          line-caps-lock-color = norm.bg;
          text-caps-lock-color = sel.fg;

          layout-bg-color = norm.bg;
          layout-border-color = norm.border;
          layout-text-color = norm.fg;
        };
      };
    };

  flake.modules.nixos.wayland = {
    security.pam.services.swaylock = { };
  };
}
