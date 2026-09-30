_: {
  flake.modules.homeManager.core = {
    config,
    lib,
    ...
  }: {
    options.desktop.colors = lib.mkOption {
      type = lib.types.attrsOf (lib.types.strMatching "#[0-9a-fA-F]{6}");
      description = "base24 colour palette (hex, with leading '#').";
    };

    options.desktop.colors16 = lib.mkOption {
      type = lib.types.attrsOf (lib.types.strMatching "#[0-9a-fA-F]{6}");
      readOnly = true;
      default = lib.filterAttrs (n: _: lib.hasPrefix "base0" n) config.desktop.colors;
      description = "the base16 subset of `desktop.colors`.";
    };

    options.desktop.ansi = lib.mkOption {
      type = lib.types.listOf (lib.types.strMatching "#[0-9a-fA-F]{6}");
      readOnly = true;
      default = with config.desktop.colors; [
        base11
        base08
        base0B
        base0A
        base0D
        base0E
        base0C
        base06

        base04
        base12
        base14
        base13
        base16
        base17
        base15
        base07
      ];
      description = "`desktop.colors` in ANSI slot order, 0-7 then the brights. The list index *is* the slot number, so every terminal renders the same mapping into its own vocabulary.";
    };

    options.desktop.syntax = lib.mkOption {
      type = lib.types.attrsOf (lib.types.strMatching "#[0-9a-fA-F]{6}");
      description = "Syntax roles from the editor colorscheme, for highlighters outside it.";
    };

    options.desktop.colorsRgb = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      readOnly = true;
      default =
        lib.mapAttrs (
          _: hex: let
            h = lib.removePrefix "#" hex;
          in
            lib.concatMapStringsSep ";" (i: toString (lib.fromHexString (builtins.substring i 2 h))) [0 2 4]
        )
        config.desktop.colors16;
      description = "`desktop.colors16` as `r;g;b`, the parameters of a 24-bit SGR sequence.";
    };

    config.desktop.colors = {
      base00 = "#000000";
      base01 = "#1e1e1e";
      base02 = "#303030";
      base03 = "#989898";
      base04 = "#bfc0c4";
      base05 = "#ffffff";
      base06 = "#f4f4f4";
      base07 = "#ffffff";

      base08 = "#ff5f59";
      base09 = "#db7b5f";
      base0A = "#d0bc00";
      base0B = "#44bc44";
      base0C = "#00d3d0";
      base0D = "#2fafff";
      base0E = "#feacd0";
      base0F = "#c0965b";

      base10 = "#0f0f0f";
      base11 = "#000000";
      base12 = "#ff5f5f";
      base13 = "#efef00";
      base14 = "#44df44";
      base15 = "#00eff0";
      base16 = "#338fff";
      base17 = "#ff66ff";
    };

    config.desktop.syntax = {
      comment = "#989898";
      keyword = "#b6a0ff";
      function = "#feacd0";
      builtin = "#f78fe7";
      string = "#79a8ff";
      type = "#6ae4b9";
      identifier = "#00d3d0";
      number = "#82b0ec";
      boolean = "#2fafff";
      preproc = "#ff7f9f";
      regex = "#00c06f";
      escape = "#d2b580";
      heading = "#c6daff";
    };
  };
}
