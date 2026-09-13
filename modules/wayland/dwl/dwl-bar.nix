_: {
  flake.modules.homeManager.dwl-bar = {pkgs, ...}: {
    dwl = {
      bar = true;

      patches = [
        (pkgs.fetchpatch {
          name = "dwl-bar.patch";
          url = "https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/bar/bar.patch";
          hash = "sha256-guW5Gan9jg5S8O7F/LfvQpUJy7Cgs8ly89peL7YazeI=";
        })
      ];

      buildInputs = [pkgs.fcft pkgs.libdrm];

      statusCommand = "while :; do date '+%a %d %b  %H:%M'; sleep 30; done";
    };
  };
}
