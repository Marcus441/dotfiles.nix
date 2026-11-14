_: {
  flake.modules.homeManager.ghostty =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (config.terminal) font;
    in
    {
      programs.ghostty = {
        enable = true;
        package = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin pkgs.ghostty-bin;

        settings = {
          font-family = [
            font.name
            "DejaVu Sans Mono"
            "Noto Sans Mono"
          ];
          font-size = font.terminalSize;
          font-feature = lib.optionals (!font.ligatures) [
            "-calt"
            "-liga"
            "-dlig"
          ];

          window-padding-x = 8;
          window-padding-y = 8;
          window-padding-balance = true;
          window-theme = "ghostty";

          scrollback-limit = 10000000;
          mouse-hide-while-typing = true;
          confirm-close-surface = false;

          shell-integration-features = "sudo,ssh-env,ssh-terminfo";

          # Keybinds are for macOS currently
          keybind = [
            "super+left=goto_split:left"
            "super+down=goto_split:down"
            "super+up=goto_split:up"
            "super+right=goto_split:right"

            "shift+super+h=resize_split:left,40"
            "shift+super+j=resize_split:down,40"
            "shift+super+k=resize_split:up,40"
            "shift+super+l=resize_split:right,40"
            "super+.=equalize_splits"
          ]
          ++ lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin [
            "global:super+backquote=toggle_quick_terminal"
          ];

          unfocused-split-opacity = 0.85;
          cursor-style = "block";
          cursor-style-blink = false;

          theme = "Modus Vivendi";
        }
        // lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
          macos-option-as-alt = "true";
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
