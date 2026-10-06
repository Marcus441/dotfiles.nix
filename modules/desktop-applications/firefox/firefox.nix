_: {
  flake.modules.homeManager.firefox = {
    programs.firefox = {
      enable = true;
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableFormHistory = true;

        AIControls = {
          Default = {
            Value = "blocked";
            Locked = true;
          };
        };

        PasswordManagerEnabled = false;
        OfferToSaveLogins = false;

        NoDefaultBookmarks = true;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        DontCheckDefaultBrowser = true;
        DisableFeedbackCommands = true;

        FirefoxHome = {
          Search = true;
          TopSites = false;
          SponsoredTopSites = false;
          Highlights = false;
          Pocket = false;
          SponsoredPocket = false;
          Snippets = false;
          Locked = true;
        };

        UserMessaging = {
          ExtensionRecommendations = false;
          FeatureRecommendations = false;
          UrlbarInterventions = false;
          MoreFromMozilla = false;
          SkipOnboarding = true;
          Locked = true;
        };

        Permissions = {
          Notifications = {
            Allow = [
              "https://mail.google.com"
              "https://outlook.live.com"
              "https://outlook.office.com"
            ];
            BlockNewRequests = true;
            Locked = false;
          };
        };

        ExtensionSettings = {
          "AussieDic@dictionaries.addons.mozilla.org" = {
            installation_mode = "normal_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/australian-english-dictionary/latest.xpi";
          };
        };

        "3rdparty".Extensions."uBlock0@raymondhill.net".adminSettings.selectedFilterLists = [
          "user-filters"

          "ublock-filters"
          "ublock-badware"
          "ublock-privacy"
          "ublock-unbreak"
          "ublock-quick-fixes"

          "privacy-tracking"
          "urlhaus-1"
          "ublock-annoyances"
        ];
      };
    };
  };
}
