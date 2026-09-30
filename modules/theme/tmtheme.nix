_: {
  flake.modules.homeManager.core = {
    config,
    lib,
    pkgs,
    ...
  }: let
    inherit
      (config.desktop.colors)
      base00
      base01
      base02
      base03
      base05
      base08
      base09
      base0A
      base0B
      base0F
      ;
    inherit (config.desktop) syntax;

    fg = name: scope: foreground: {
      inherit name scope;
      settings = {inherit foreground;};
    };

    on = name: scope: background: foreground: {
      inherit name scope;
      settings = {inherit background foreground;};
    };

    emph = name: scope: fontStyle: foreground: {
      inherit name scope;
      settings = {inherit fontStyle foreground;};
    };
  in {
    options.desktop.syntaxTheme = lib.mkOption {
      type = lib.types.path;
      readOnly = true;
      description = "syntect theme rendered from desktop.colors and desktop.syntax.";
    };

    config.desktop.syntaxTheme = pkgs.writeText "modus-vivendi.tmTheme" (
      lib.generators.toPlist {escape = true;} {
        name = "Modus Vivendi";
        author = "Template: Chris Kempson; scheme: base24 Modus Vivendi";
        colorSpaceName = "sRGB";

        settings = [
          {
            settings = {
              background = base00;
              caret = base05;
              foreground = base05;
              invisibles = base03;
              lineHighlight = base03;
              selection = base02;
              gutter = base01;
              gutterForeground = base03;
            };
          }

          (fg "Text" "variable.parameter.function" syntax.identifier)
          (emph "Comments" "comment, punctuation.definition.comment" "italic" syntax.comment)
          (fg "Punctuation" "punctuation.definition.variable, punctuation.definition.parameters, punctuation.definition.array" base05)
          (fg "Operators" "keyword.operator" base05)
          (emph "Keywords" "keyword" "italic" syntax.keyword)
          (fg "Imports" "keyword.control.import, keyword.other.import, meta.preprocessor, keyword.control.directive" syntax.preproc)
          (fg "Variables" "variable" syntax.identifier)
          (fg "Parameters" "variable.parameter" syntax.identifier)
          (fg "Built-in Variables" "variable.language" syntax.keyword)
          (fg "Functions" "entity.name.function, meta.require, support.function.any-method" syntax.function)
          (fg "Labels" "entity.name.label" syntax.identifier)
          (fg "Classes" "support.class, entity.name.class, entity.name.type.class, entity.name" syntax.type)
          (fg "Classes" "meta.class" base05)
          (fg "Types" "entity.name.type, support.type" syntax.type)
          (fg "Methods" "keyword.other.special-method" syntax.function)
          (fg "Storage" "storage" syntax.keyword)
          (fg "Support" "support.function" syntax.builtin)
          (fg "Strings" "string" syntax.string)
          (fg "Symbols" "constant.other.symbol" syntax.identifier)
          (fg "Inherited Class" "entity.other.inherited-class" syntax.type)
          (fg "Integers" "constant.numeric" syntax.number)
          (fg "Constants" "constant" base05)
          (fg "Language Constants" "constant.language" syntax.builtin)
          (emph "Booleans" "constant.language.boolean" "bold" syntax.boolean)
          (fg "Tags" "entity.name.tag" syntax.identifier)
          (fg "Attributes" "entity.other.attribute-name" syntax.preproc)
          (fg "Attribute IDs" "entity.other.attribute-name.id, punctuation.definition.entity" syntax.preproc)
          (fg "Selector" "meta.selector" syntax.keyword)
          (emph "Headings" "markup.heading, punctuation.definition.heading, entity.name.section" "bold" syntax.heading)
          (fg "Units" "keyword.other.unit" syntax.number)
          (emph "Bold" "markup.bold, punctuation.definition.bold" "bold" base05)
          (emph "Italic" "markup.italic, punctuation.definition.italic" "italic" base05)
          (fg "Code" "markup.raw.inline" syntax.string)
          (fg "Link Text" "string.other.link, punctuation.definition.string.end.markdown, punctuation.definition.string.begin.markdown" syntax.string)
          (fg "Link Url" "meta.link" syntax.type)
          (fg "Quotes" "markup.quote" syntax.comment)
          (on "Separator" "meta.separator" base02 base05)
          (fg "Inserted" "markup.inserted" base0B)
          (fg "Deleted" "markup.deleted" base08)
          (fg "Changed" "markup.changed" base0A)
          (fg "Colors" "constant.other.color" syntax.number)
          (fg "Regular Expressions" "string.regexp" syntax.regex)
          (fg "Escape Characters" "constant.character.escape" syntax.escape)
          (fg "Embedded" "punctuation.section.embedded, variable.interpolation" base05)
          (on "Illegal" "invalid.illegal" base08 base05)
          (on "Broken" "invalid.broken" base09 base00)
          (on "Deprecated" "invalid.deprecated" base0F base05)
          (on "Unimplemented" "invalid.unimplemented" base03 base05)

          (fg "Delimiters" "none" base05)
          (fg "Floats" "none" syntax.number)
          (fg "Boolean" "none" syntax.boolean)
          (fg "Values" "none" syntax.number)
        ];
      }
    );
  };
}
