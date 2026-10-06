_: {
  flake.modules.nixos.dev = {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = false;
    };
  };

  flake.modules.homeManager.dev =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
      services.colima = {
        enable = true;
        profiles.default = {
          isService = true;
          setDockerHost = true;
        };
      };

      home.packages = [
        config.services.colima.dockerPackage
        pkgs.docker-credential-helpers
      ];
    };
}
