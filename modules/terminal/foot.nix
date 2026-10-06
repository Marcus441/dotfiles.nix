_: {
  flake.modules.homeManager.foot =
    {
      config,
      lib,
      ...
    }:
    let
      inherit (config.terminal) ansi colors;
      inherit (config.terminal) font;
      fontAt =
        size:
        let
          fonts = [
            "${font.name}:size=${toString size}"
          ]
          ++ map (f: "${f}:size=${toString size}") [
            "Symbols Nerd Font"
            "DejaVu Sans Mono"
            "Noto Sans Mono"
          ];
        in
        lib.concatStringsSep "," fonts;

      fontStr = fontAt font.terminalSize;

      strip = c: lib.removePrefix "#" c;
    in
    {
      programs.foot = {
        enable = true;
        server.enable = false;
        settings = {
          main = {
            font = fontStr;
            pad = "8x8";
            initial-color-theme = "dark";
            gamma-correct-blending = "yes";
          };
          scrollback.lines = 10000;
          mouse.hide-when-typing = "yes";
          mouse.alternate-scroll-mode = "no";

          key-bindings.clipboard-copy = "Control+Shift+c XF86Copy XF86Cut";

          colors-dark = {
            foreground = strip colors.foreground;
            background = strip colors.background;

            cursor = "${strip colors.cursorText} ${strip colors.cursor}";

            selection-foreground = strip colors.selectionForeground;
            selection-background = strip colors.selectionBackground;
          }
          // lib.listToAttrs (
            lib.imap0 (
              i: hex:
              lib.nameValuePair "${if i < 8 then "regular" else "bright"}${toString (lib.mod i 8)}" (strip hex)
            ) ansi
          );
        };
      };
    };
}
