_: {
  flake.modules.homeManager.core =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (config.terminal.colors)
        background
        foreground
        selectionBackground
        red
        green
        yellow
        magenta
        brightBlack
        brightYellow
        ;
      inherit (config.terminal) syntax;

      fg = name: scope: foreground: {
        inherit name scope;
        settings = { inherit foreground; };
      };

      on = name: scope: background: foreground: {
        inherit name scope;
        settings = { inherit background foreground; };
      };

      emph = name: scope: fontStyle: foreground: {
        inherit name scope;
        settings = { inherit fontStyle foreground; };
      };
    in
    {
      options.terminal.syntax = lib.mkOption {
        type = lib.types.attrsOf (lib.types.strMatching "#[0-9a-fA-F]{6}");
        description = "Syntax roles of the editor colorscheme.";
      };

      options.terminal.syntaxTheme = lib.mkOption {
        type = lib.types.path;
        readOnly = true;
        description = "syntect theme rendered from the terminal palette.";
      };

      config.terminal.syntax = {
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

      config.terminal.syntaxTheme = pkgs.writeText "modus-vivendi.tmTheme" (
        lib.generators.toPlist { escape = true; } {
          name = "Modus Vivendi";
          author = "Template: Chris Kempson; palette: Ghostty's Modus Vivendi";
          colorSpaceName = "sRGB";

          settings = [
            {
              settings = {
                inherit background foreground;
                caret = foreground;
                invisibles = brightBlack;
                lineHighlight = brightBlack;
                selection = selectionBackground;
                gutter = background;
                gutterForeground = brightBlack;
              };
            }

            (fg "Text" "variable.parameter.function" syntax.identifier)
            (emph "Comments" "comment, punctuation.definition.comment" "italic" syntax.comment)
            (fg "Punctuation"
              "punctuation.definition.variable, punctuation.definition.parameters, punctuation.definition.array"
              foreground
            )
            (fg "Operators" "keyword.operator" foreground)
            (emph "Keywords" "keyword" "italic" syntax.keyword)
            (fg "Imports"
              "keyword.control.import, keyword.other.import, meta.preprocessor, keyword.control.directive"
              syntax.preproc
            )
            (fg "Variables" "variable" syntax.identifier)
            (fg "Parameters" "variable.parameter" syntax.identifier)
            (fg "Built-in Variables" "variable.language" syntax.keyword)
            (fg "Functions" "entity.name.function, meta.require, support.function.any-method" syntax.function)
            (fg "Labels" "entity.name.label" syntax.identifier)
            (fg "Classes" "support.class, entity.name.class, entity.name.type.class, entity.name" syntax.type)
            (fg "Classes" "meta.class" foreground)
            (fg "Types" "entity.name.type, support.type" syntax.type)
            (fg "Methods" "keyword.other.special-method" syntax.function)
            (fg "Storage" "storage" syntax.keyword)
            (fg "Support" "support.function" syntax.builtin)
            (fg "Strings" "string" syntax.string)
            (fg "Symbols" "constant.other.symbol" syntax.identifier)
            (fg "Inherited Class" "entity.other.inherited-class" syntax.type)
            (fg "Integers" "constant.numeric" syntax.number)
            (fg "Constants" "constant" foreground)
            (fg "Language Constants" "constant.language" syntax.builtin)
            (emph "Booleans" "constant.language.boolean" "bold" syntax.boolean)
            (fg "Tags" "entity.name.tag" syntax.identifier)
            (fg "Attributes" "entity.other.attribute-name" syntax.preproc)
            (fg "Attribute IDs" "entity.other.attribute-name.id, punctuation.definition.entity" syntax.preproc)
            (fg "Selector" "meta.selector" syntax.keyword)
            (emph "Headings" "markup.heading, punctuation.definition.heading, entity.name.section" "bold"
              syntax.heading
            )
            (fg "Units" "keyword.other.unit" syntax.number)
            (emph "Bold" "markup.bold, punctuation.definition.bold" "bold" foreground)
            (emph "Italic" "markup.italic, punctuation.definition.italic" "italic" foreground)
            (fg "Code" "markup.raw.inline" syntax.string)
            (fg "Link Text"
              "string.other.link, punctuation.definition.string.end.markdown, punctuation.definition.string.begin.markdown"
              syntax.string
            )
            (fg "Link Url" "meta.link" syntax.type)
            (fg "Quotes" "markup.quote" syntax.comment)
            (on "Separator" "meta.separator" selectionBackground foreground)
            (fg "Inserted" "markup.inserted" green)
            (fg "Deleted" "markup.deleted" red)
            (fg "Changed" "markup.changed" yellow)
            (fg "Colors" "constant.other.color" syntax.number)
            (fg "Regular Expressions" "string.regexp" syntax.regex)
            (fg "Escape Characters" "constant.character.escape" syntax.escape)
            (fg "Embedded" "punctuation.section.embedded, variable.interpolation" foreground)
            (on "Illegal" "invalid.illegal" red foreground)
            (on "Broken" "invalid.broken" brightYellow background)
            (on "Deprecated" "invalid.deprecated" magenta background)
            (on "Unimplemented" "invalid.unimplemented" brightBlack foreground)

            (fg "Delimiters" "none" foreground)
            (fg "Floats" "none" syntax.number)
            (fg "Boolean" "none" syntax.boolean)
            (fg "Values" "none" syntax.number)
          ];
        }
      );
    };
}
