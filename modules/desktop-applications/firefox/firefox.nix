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
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/australian-english-dictionary/latest.xpi";
          };
          "uBlock0@raymondhill.net" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          };

          "sponsorBlocker@ajay.app" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          };

          "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/refined-github-/latest.xpi";
          };

          "{85860b32-02a8-431a-b2b1-40fbd64c9c69}" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/github-file-icons/latest.xpi";
          };

          "search@kagi.com" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/kagi-search-for-firefox/latest.xpi";
          };

          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          };

          "addon@darkreader.org" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          };

          "@testpilot-containers" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
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
