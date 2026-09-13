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
    ];

    system.stateVersion = 6;
  };

  flake.modules.homeManager.mbp = {
    imports = with inputs.self.modules.homeManager; [
      core
      zsh
      dev
    ];
  };
}
