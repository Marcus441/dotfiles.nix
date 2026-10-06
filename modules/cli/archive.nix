_: {
  flake.modules.homeManager.core = { pkgs, ... }: {
    home.packages = [
      pkgs.unzip
      pkgs.zip
    ];
  };
}
