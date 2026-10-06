_: {
  flake.modules.homeManager.core =
    {
      config,
      lib,
      ...
    }:
    {
      options.terminal.colors = lib.mkOption {
        type = lib.types.attrsOf (lib.types.strMatching "#[0-9a-fA-F]{6}");
        description = ''
          Terminal palette (hex, with leading '#'): the sixteen ANSI slots by
          name plus the special colours, as Ghostty's Modus Vivendi theme sets
          them. Ghostty loads the theme itself; foot and the programs that run
          inside either copy it.
        '';
      };

      options.terminal.ansi = lib.mkOption {
        type = lib.types.listOf (lib.types.strMatching "#[0-9a-fA-F]{6}");
        readOnly = true;
        default = with config.terminal.colors; [
          black
          red
          green
          yellow
          blue
          magenta
          cyan
          white

          brightBlack
          brightRed
          brightGreen
          brightYellow
          brightBlue
          brightMagenta
          brightCyan
          brightWhite
        ];
        description = "`terminal.colors` in ANSI slot order, 0-7 then the brights. The list index *is* the slot number.";
      };

      options.terminal.colorsRgb = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        readOnly = true;
        default = lib.mapAttrs (
          _: hex:
          let
            h = lib.removePrefix "#" hex;
          in
          lib.concatMapStringsSep ";" (i: toString (lib.fromHexString (builtins.substring i 2 h))) [
            0
            2
            4
          ]
        ) config.terminal.colors;
        description = "`terminal.colors` as `r;g;b`, the parameters of a 24-bit SGR sequence.";
      };

      config.terminal.colors = {
        background = "#000000";
        foreground = "#ffffff";
        cursor = "#ffffff";
        cursorText = "#000000";
        selectionBackground = "#5a5a5a";
        selectionForeground = "#ffffff";

        black = "#000000";
        red = "#ff5f59";
        green = "#44bc44";
        yellow = "#d0bc00";
        blue = "#2fafff";
        magenta = "#feacd0";
        cyan = "#00d3d0";
        white = "#a6a6a6";

        brightBlack = "#595959";
        brightRed = "#ff7f9f";
        brightGreen = "#00c06f";
        brightYellow = "#fec43f";
        brightBlue = "#79a8ff";
        brightMagenta = "#b6a0ff";
        brightCyan = "#6ae4b9";
        brightWhite = "#ffffff";
      };
    };
}
