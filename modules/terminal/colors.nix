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
        description = "Ghostty's Modus Vivendi palette: the sixteen ANSI slots by name plus the special colours.";
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
        description = "`terminal.colors` in ANSI slot order.";
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
        description = "`terminal.colors` as `r;g;b` for 24-bit SGR sequences.";
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
