_: {
  flake.modules.homeManager.gaming = {pkgs, ...}: {
    home.packages = [
      pkgs.lutris
      pkgs.heroic
      pkgs.bottles
      pkgs.ludusavi
    ];
  };
}
