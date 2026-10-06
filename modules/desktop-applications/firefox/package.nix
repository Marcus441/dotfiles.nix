{ config, inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      inherit (pkgs) lib;

      home = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          config.flake.modules.homeManager.firefox
          config.flake.modules.homeManager.firefox-profile
          {
            home.username = "firefox";
            home.homeDirectory = "/var/empty";
            home.stateVersion = "25.11";
          }
        ];
      };

      dir = "${home.config.programs.firefox.profilesPath}/default/";
      files = lib.filterAttrs (
        n: _: lib.hasPrefix dir n && baseNameOf n != ".keep"
      ) home.config.home.file;
    in
    {
      packages.firefox-profile = pkgs.linkFarm "firefox-profile" (
        lib.mapAttrsToList (n: f: {
          name = lib.removePrefix dir n;
          path = f.source;
        }) files
      );
    };
}
