{
  config,
  inputs,
  ...
}: let
  inherit (config.flake.lib) mkNixos mkHome;
in {
  flake.nixosConfigurations.swift5 = mkNixos "x86_64-linux" "swift5";
  flake.homeConfigurations."${config.meta.user}@swift5" = mkHome "x86_64-linux" "swift5";

  flake.modules.nixos.swift5 = {
    imports = with inputs.self.modules.nixos; [
      ./_hardware-configuration.nix
      core
      dev
      wayland
      dwl
      laptop
      keychron
    ];

    system.stateVersion = "25.11";
  };

  flake.modules.homeManager.swift5 = {
    imports = with inputs.self.modules.homeManager; [
      core
      dev
      wayland
      dwl
      dwl-bar
      foot
      firefox
      laptop
    ];

    desktop.font.terminalSize = 16;

    desktop.monitors = [
      {
        name = "eDP-1";
        width = 1920;
        height = 1080;
      }
    ];
  };
}
