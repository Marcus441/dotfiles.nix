_: {
  flake.modules.homeManager.apps = { pkgs, ... }: {
    xdg.mimeApps.defaultApplications."x-scheme-handler/discord" = "equibop.desktop";

    home.packages = [ pkgs.equibop ];

    xdg.configFile = {
      "equibop/settings.json".source = ./equibop-settings.json;
      "equibop/settings/settings.json".source = ./equibop-plugin-settings.json;
    };
  };
}
