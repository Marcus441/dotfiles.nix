_: {
  flake.modules.homeManager.dev = {config, ...}: let
    inherit (config.terminal) colors;
  in {
    programs.lazydocker = {
      enable = true;
      settings = {
        gui.theme = {
          selectedLineBgColor = ["default"];

          activeBorderColor = [colors.blue "bold"];
          inactiveBorderColor = [colors.brightBlack];
          optionsTextColor = [colors.foreground];
        };
      };
    };
  };
}
