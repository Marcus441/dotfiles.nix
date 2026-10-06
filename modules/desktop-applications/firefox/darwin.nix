{ inputs, ... }:
{
  flake.modules.homeManager.firefox =
    { lib, pkgs, ... }:
    lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
      programs.firefox.package = pkgs.firefox-bin-unwrapped;
    };

  flake.modules.homeManager.firefox-profile =
    { lib, pkgs, ... }:
    lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
      programs.firefox.profiles.default.extensions.packages = [
        (inputs.firefox-addons.lib.${pkgs.stdenv.hostPlatform.system}.buildFirefoxXpiAddon {
          pname = "raycast-tab-manager";
          version = "1.0.2";
          addonId = "raycast-firefox@lau.engineering";
          url = "https://addons.mozilla.org/firefox/downloads/file/4724473/raycast_tab_manager-1.0.2.xpi";
          sha256 = "sha256-bRoAwlU+8jNSZ/oaZVo+oJaIGF0v8Qd2/VcKYNd4cxs=";
          meta = { };
        })
      ];
    };
}
