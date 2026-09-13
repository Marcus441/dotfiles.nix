{
  inputs,
  lib,
  ...
}: {
  options.flake.lib = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    default = {};
    description = "Helpers that turn a host's aspect module into a configuration.";
  };

  # Each helper evaluates the aspect named after the host; the host file
  # decides everything else by what it imports.
  config.flake.lib = let
    inherit (inputs.self) modules;
  in {
    mkNixos = system: name:
      inputs.nixpkgs.lib.nixosSystem {
        modules = [
          modules.nixos.${name}
          {
            nixpkgs.hostPlatform = system;
            networking.hostName = name;
          }
        ];
      };

    mkDarwin = system: name:
      inputs.nix-darwin.lib.darwinSystem {
        modules = [
          modules.darwin.${name}
          {
            nixpkgs.hostPlatform = system;
            networking.hostName = name;
          }
        ];
      };

    mkHome = system: name:
      inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        modules = [modules.homeManager.${name}];
      };
  };
}
