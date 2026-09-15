_: {
  flake.modules.darwin.apps = {
    homebrew = {
      enable = true;

      onActivation = {
        autoUpdate = true;
        upgrade = true;
        cleanup = "zap";
      };

      casks = [
        "1password"
        "microsoft-teams"
        "notion"
        "raycast"
        "slack"
        "tidal"
      ];

      masApps = {
        "1Password for Safari" = 1569813296;
        "Bitwarden" = 1352778147;
        "Kagi for Safari" = 1622835804;
        "Noir - Dark Mode for Safari" = 1592917505;
        "Xcode" = 497799835;
        "uBlock Origin Lite" = 6745342698;
      };
    };
  };
}
