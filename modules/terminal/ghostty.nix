_: {
  flake.modules.homeManager.ghostty = {
    config,
    lib,
    pkgs,
    ...
  }: let
    inherit (config.desktop) ansi font colors16;
  in {
    programs.ghostty = {
      enable = true;
      package = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin pkgs.ghostty-bin;

      settings =
        {
          font-family = [font.name "DejaVu Sans Mono" "Noto Sans Mono"];
          font-size = font.terminalSize;

          window-padding-x = 8;
          window-padding-y = 8;
          window-padding-balance = true;
          window-theme = "ghostty";

          scrollback-limit = 10000000; # bytes, not lines
          mouse-hide-while-typing = true;

          foreground = colors16.base05;
          background = colors16.base00;

          cursor-color = colors16.base05;
          cursor-text = colors16.base00;

          selection-foreground = colors16.base06;
          selection-background = colors16.base02;

          palette =
            lib.imap0 (i: hex: "${toString i}=${hex}") ansi
            ++ [
              "16=${colors16.base09}"
              "17=${colors16.base0F}"
            ];
        }
        // lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
          macos-option-as-alt = "left";
          macos-titlebar-style = "transparent";
          window-save-state = "always";
          auto-update = "off";
        };
    };
  };
}
