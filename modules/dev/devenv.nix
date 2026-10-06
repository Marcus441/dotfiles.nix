{ inputs, ... }: {
  flake.modules.homeManager.dev = { pkgs, ... }: {
    programs.devenv = {
      enable = true;
      enableZshIntegration = false;
      package = inputs.devenv.packages.${pkgs.stdenv.hostPlatform.system}.devenv;
    };
  };
}
