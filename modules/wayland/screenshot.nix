_: {
  flake.modules.homeManager.wayland = {pkgs, ...}: {
    home.packages = [
      (pkgs.callPackage ./_pkgs/areashot.nix {})
      (pkgs.callPackage ./_pkgs/ocr-copy.nix {})
      (pkgs.callPackage ./_pkgs/screenshot.nix {})
      pkgs.grim
      pkgs.slurp
    ];
  };
}
