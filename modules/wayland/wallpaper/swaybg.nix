_: {
  flake.modules.homeManager.wayland =
    { pkgs, ... }:
    let
      version = "0239cbace01c7b6179e5c873005df561037c1043";
      wallpaper = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/Marcus441/walls/${version}/walled_tiers/4k/macos/Big-Sur-Road-6016x3384.png";
        hash = "sha256-OB0O6HsHTHioS6YD1W/FGAUCH8xYK2erW4gPoQJnfbA=";
      };
    in
    {
      home.packages = [
        (pkgs.writeShellApplication {
          name = "session-wallpaper";
          runtimeInputs = [ pkgs.swaybg ];
          text = ''
            swaybg -i ${wallpaper} -m fill
          '';
        })
      ];

      desktop.autostart = [ "session-wallpaper" ];
    };
}
