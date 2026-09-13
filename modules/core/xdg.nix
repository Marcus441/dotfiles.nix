_: {
  flake.modules.homeManager.core = {
    lib,
    pkgs,
    ...
  }: {
    xdg.enable = true;

    home.preferXdgDirectories = true;

    xdg.userDirs = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
      enable = true;
      createDirectories = true;

      setSessionVariables = false;
    };
  };
}
