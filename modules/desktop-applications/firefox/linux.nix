_: {
  flake.modules.homeManager.firefox = {
    config,
    lib,
    pkgs,
    ...
  }:
    lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
      xdg.mimeApps.defaultApplications = {
        "application/x-extension-htm" = "firefox.desktop";
        "application/x-extension-html" = "firefox.desktop";
        "application/x-extension-shtml" = "firefox.desktop";
        "application/x-extension-xht" = "firefox.desktop";
        "application/x-extension-xhtml" = "firefox.desktop";
        "application/xhtml+xml" = "firefox.desktop";
        "text/html" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/mailto" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
        "x-scheme-handler/webcal" = "firefox.desktop";
      };

      programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";

      programs.firefox.profiles.default.settings = {
        "widget.use-xdg-desktop-portal.file-picker" = 2;
        "widget.use-xdg-desktop-portal.mime-handler" = 1;
        "gfx.font_rendering.fontconfig.max_generic_substitutions" = 127;
        "font.name-list.emoji" = "emoji";
        "apz.gtk.kinetic_scroll.enabled" = false;
        "browser.quitShortcut.disabled" = true;
      };
    };
}
