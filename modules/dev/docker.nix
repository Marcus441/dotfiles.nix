_: {
  flake.modules.nixos.dev = {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = false;
    };
  };

  # Darwin has no Docker daemon: Colima runs one in a VM as a launchd agent,
  # and DOCKER_HOST points the CLI and lazydocker at its socket.
  flake.modules.homeManager.dev = {
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

      # On darwin the docker package is the client, with the compose plugin.
      home.packages = [
        config.services.colima.dockerPackage
        pkgs.docker-credential-helpers
      ];
    };
}
