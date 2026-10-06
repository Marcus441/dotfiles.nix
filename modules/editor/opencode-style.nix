_: {
  flake.modules.homeManager.apps = {config, ...}: let
    c = name: {
      dark = name;
      light = name;
    };
  in {
    xdg.configFile."opencode/themes/nix.json".text = builtins.toJSON {
      "$schema" = "https://opencode.ai/theme.json";
      defs = config.terminal.colors;
      theme = {
        primary = c "blue";
        secondary = c "cyan";
        accent = c "magenta";
        error = c "red";
        warning = c "yellow";
        success = c "green";
        info = c "blue";
        text = c "foreground";
        textMuted = c "brightBlack";
        background = c "background";
        backgroundPanel = c "background";
        backgroundElement = c "selectionBackground";
        border = c "brightBlack";
        borderActive = c "white";
        borderSubtle = c "brightBlack";
        diffAdded = c "green";
        diffRemoved = c "red";
        diffContext = c "brightBlack";
        diffHunkHeader = c "white";
        diffHighlightAdded = c "green";
        diffHighlightRemoved = c "red";
        diffAddedBg = c "background";
        diffRemovedBg = c "background";
        diffContextBg = c "background";
        diffLineNumber = c "brightBlack";
        diffAddedLineNumberBg = c "background";
        diffRemovedLineNumberBg = c "background";
        markdownText = c "foreground";
        markdownHeading = c "blue";
        markdownLink = c "brightYellow";
        markdownLinkText = c "red";
        markdownCode = c "green";
        markdownBlockQuote = c "brightBlack";
        markdownEmph = c "brightYellow";
        markdownStrong = c "yellow";
        markdownHorizontalRule = c "selectionBackground";
        markdownListItem = c "red";
        markdownListEnumeration = c "brightYellow";
        markdownImage = c "cyan";
        markdownImageText = c "red";
        markdownCodeBlock = c "foreground";
        syntaxComment = c "brightBlack";
        syntaxKeyword = c "magenta";
        syntaxFunction = c "blue";
        syntaxVariable = c "red";
        syntaxString = c "green";
        syntaxNumber = c "brightYellow";
        syntaxType = c "yellow";
        syntaxOperator = c "foreground";
        syntaxPunctuation = c "foreground";
      };
    };
  };
}
