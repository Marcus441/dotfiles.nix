_: {
  flake.modules.homeManager.apps = {pkgs, ...}: {
    xdg.mimeApps.defaultApplications."x-scheme-handler/discord" = "equibop.desktop";

    home = {
      packages = with pkgs; [equibop];
      file = {
        ".config/equibop/settings.json".source = ./equibop-settings.json;
        ".config/equibop/settings/settings.json".source =
          ./equibop-plugin-settings.json;
      };
    };
  };
}
