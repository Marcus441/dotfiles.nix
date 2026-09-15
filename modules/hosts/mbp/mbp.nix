{
  config,
  inputs,
  ...
}: let
  inherit (config.flake.lib) mkDarwin mkHome;
in {
  flake.darwinConfigurations.mbp = mkDarwin "aarch64-darwin" "mbp";
  flake.homeConfigurations."${config.meta.user}@mbp" = mkHome "aarch64-darwin" "mbp";

  flake.modules.darwin.mbp = {
    imports = with inputs.self.modules.darwin; [
      core
      zsh
      apps
    ];

    system.stateVersion = 6;
  };

  flake.modules.homeManager.mbp = {
    desktop.font.terminalSize = 24;
    imports = with inputs.self.modules.homeManager; [
      core
      zsh
      dev
      ghostty
    ];
  };
}
