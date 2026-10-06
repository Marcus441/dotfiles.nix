_: {
  flake.modules.homeManager.ghostty = {
    config,
    lib,
    pkgs,
    ...
  }: let
    inherit (config.desktop) ansi colors16;
    inherit (config.terminal) font;
  in {
    programs.ghostty = {
      enable = true;
      package = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin pkgs.ghostty-bin;

      settings =
        {
          font-family = [font.name "DejaVu Sans Mono" "Noto Sans Mono"];
          font-size = font.terminalSize;
          font-feature = lib.optionals (!font.ligatures) ["-calt" "-liga" "-dlig"];

          window-padding-x = 8;
          window-padding-y = 8;
          window-padding-balance = true;
          window-theme = "ghostty";

          scrollback-limit = 10000000;
          mouse-hide-while-typing = true;
          confirm-close-surface = false;

          shell-integration-features = "sudo,ssh-env,ssh-terminfo";

          keybind =
            [
              "ctrl+alt+h=goto_split:left"
              "ctrl+alt+j=goto_split:down"
              "ctrl+alt+k=goto_split:up"
              "ctrl+alt+l=goto_split:right"

              "ctrl+super+h=resize_split:left,40"
              "ctrl+super+j=resize_split:down,40"
              "ctrl+super+k=resize_split:up,40"
              "ctrl+super+l=resize_split:right,40"
              "ctrl+alt+equal=equalize_splits"
            ]
            ++ lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin [
              "global:super+backquote=toggle_quick_terminal"
            ];

          unfocused-split-opacity = 0.85;
          cursor-style = "block";
          cursor-style-blink = false;

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
          quit-after-last-window-closed = true;
        }
        // lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
          app-notifications = "no-clipboard-copy";
          quit-after-last-window-closed = true;
        };
    };
  };
}
