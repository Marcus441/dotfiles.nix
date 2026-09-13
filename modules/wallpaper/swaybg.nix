_: {
  flake.modules.homeManager.dwl = [
    (
      {
        config,
        pkgs,
        ...
      }: let
        wallpaper = pkgs.fetchFromGitHub {
          owner = "Marcus441";
          repo = "walls";
          rev = "b11022653952ac634b0c9af6966c560bb0ef0876";
          hash = "sha256-ncCvJdy1wCVRdTK/WWnR63kfXw02q0I0xjIQdVM/jvU=";
          sparseCheckout = ["/walled_tiers/4k/aerial/waves_crashing_on_rocks.png"];
        };
        wallpaperImage = "${wallpaper}/walled_tiers/4k/aerial/waves_crashing_on_rocks.png";
      in {
        home.packages = [
          (pkgs.writeShellApplication {
            name = "dwl-wallpaper";
            runtimeInputs = [
              pkgs.swaybg
            ];
            text = ''
              ${pkgs.swaybg}/bin/swaybg -i ${wallpaperImage} -m fill
            '';
          })
        ];
      }
    )
  ];

  flake.modules.nixos.dwl = [
    {dwl.autostart = ["dwl-wallpaper"];}
  ];
}
