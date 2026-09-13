{
  config,
  inputs,
  ...
}: let
  inherit (config.flake.lib) mkNixos mkHome;
in {
  flake.nixosConfigurations.gpc = mkNixos "x86_64-linux" "gpc";
  flake.homeConfigurations."${config.meta.user}@gpc" = mkHome "x86_64-linux" "gpc";

  flake.modules.nixos.gpc = {
    imports = with inputs.self.modules.nixos; [
      ./_hardware-configuration.nix
      core
      zsh
      wayland
      gaming
      nvidia
      apps
    ];

    system.stateVersion = "25.11";
  };

  flake.modules.homeManager.gpc = {
    imports = with inputs.self.modules.homeManager; [
      core
      zsh
      wayland
      firefox
      gaming
      nvidia
      apps
    ];

    desktop.font.terminalSize = 20;

    desktop.monitors = [
      {
        name = "DisplayPort-1";
        width = 2560;
        height = 1440;
        refresh = 144;
      }
      {
        name = "DisplayPort-2";
        width = 1920;
        height = 1080;
        x = 2560;
      }
    ];
  };
}
