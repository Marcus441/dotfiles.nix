_: {
  flake.modules.homeManager.wayland = { pkgs, ... }: {
    home.packages = [
      pkgs.wl-clipboard
      pkgs.cliphist
    ];
  };
}
