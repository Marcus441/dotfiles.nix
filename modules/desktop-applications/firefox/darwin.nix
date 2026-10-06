_: {
  flake.modules.homeManager.firefox =
    { lib, pkgs, ... }:
    lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
      programs.firefox.policies.ExtensionSettings = {
        "raycast-firefox@lau.engineering" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/raycast-tab-manager/latest.xpi";
        };
      };
    };
}
