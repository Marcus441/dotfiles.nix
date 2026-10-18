_: {
  flake.modules.homeManager.wayland =
    { pkgs, ... }:
    let
      wallpaper = pkgs.fetchurl {
        url = "https://w.wallhaven.cc/full/o5/wallhaven-o5o8o9.jpg";
        hash = "sha256-oCfukMMpOxwLSLy03TXcPa9xpIkpeJAhuGum7jKVctQ=";
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
