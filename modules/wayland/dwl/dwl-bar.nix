_: {
  flake.modules.homeManager.dwl-bar = { pkgs, ... }: {
    dwl = {
      bar = true;

      patches = [ ../../../patches/dwl-bar.patch ];

      buildInputs = [
        pkgs.fcft
        pkgs.libdrm
      ];

      statusCommand = "while :; do date '+%a %d %b  %H:%M'; sleep 30; done";
    };
  };
}
