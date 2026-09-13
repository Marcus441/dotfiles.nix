{inputs, ...}: {
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.home-manager.flakeModules.home-manager
    inputs.nix-darwin.flakeModules.default
  ];

  systems = ["x86_64-linux" "aarch64-darwin"];
}
