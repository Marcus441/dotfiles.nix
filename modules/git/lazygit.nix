_: {
  flake.modules.homeManager.dev = {config, ...}: let
    inherit (config.terminal) colors;
  in {
    programs.lazygit = {
      enable = true;
      settings = {
        gui = {
          showFileIcons = true;
          nerdFontsVersion = 3;
          theme = {
            lightTheme = false;

            selectedLineBgColor = ["default"];

            activeBorderColor = [colors.blue "bold"];
            inactiveBorderColor = [colors.brightBlack];
            searchingActiveBorderColor = [colors.white "bold"];
            defaultFgColor = [colors.foreground];
            optionsTextColor = [colors.foreground];
            unstagedChangesColor = [colors.red];
            cherryPickedCommitBgColor = [colors.selectionBackground];
            cherryPickedCommitFgColor = [colors.brightBlack];
          };
        };
      };
    };
  };
}
