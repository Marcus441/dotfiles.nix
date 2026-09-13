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
          settings = {
            # Rosetta runs x86_64 images and binaries in the arm64 VM; it
            # needs Apple's Virtualization.framework (vz), not qemu.
            vmType = "vz";
            rosetta = true;

            # Colima takes every field from this file over its own defaults,
            # so a field left out starts at zero: restate the defaults.
            cpu = 2;
            memory = 2;
            disk = 100;
            rootDisk = 20;
            arch = "host";
            cpuType = "host";
            runtime = "docker";
            modelRunner = "docker";
            sshConfig = true;
            network = {
              mode = "shared";
              interface = "en0";
              gatewayAddress = "192.168.5.2";
              dnsHosts."host.docker.internal" = "host.lima.internal";
            };
          };
        };
      };

      # On darwin the docker package is the client, with the compose plugin.
      home.packages = [config.services.colima.dockerPackage];
    };
}
