_: {
  flake.modules.homeManager.core = { pkgs, ... }: {
    home.packages = [
      pkgs.gh
      pkgs.git-graph
    ];

    programs.git = {
      enable = true;
      settings = {
        user.name = "Marcus441";
        user.email = "88486170+Marcus441@users.noreply.github.com";
        url."git@github.com:".insteadOf = "https://github.com/";
        submodule.recurse = true;
      };
    };
  };
}
