_: {
  flake.modules.homeManager.laptop = {pkgs, ...}: {
    home.packages = [pkgs.brightnessctl];
  };
}
