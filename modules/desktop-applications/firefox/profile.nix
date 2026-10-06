_: {
  flake.modules.homeManager.firefox-profile = { lib, pkgs, ... }: {
    programs.firefox.profiles.default = {
      id = 0;
      isDefault = true;

      search = {
        force = true;
        default = "Kagi";
        engines = {
          "Kagi" = {
            name = "Kagi";
            urls = [ { template = "https://kagi.com/search?q={searchTerms}"; } ];
            definedAliases = [ "@k" ];
          };
          "claude" = {
            name = "Claude";
            urls = [ { template = "https://claude.ai/new?q={searchTerms}"; } ];
            definedAliases = [ "@claude" ];
          };
          "nix-packages" = {
            name = "Nix Packages";
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = [ "@np" ];
          };
          "nix-options" = {
            name = "NixOS Options";
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = [ "@no" ];
          };
          "nix-wiki" = {
            name = "NixOS Wiki";
            urls = [
              {
                template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
              }
            ];
            definedAliases = [ "@nw" ];
          };
          "home-manager" = {
            name = "Home Manager Options";
            urls = [
              {
                template = "https://home-manager-options.extranix.com/";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                  {
                    name = "release";
                    value = "master";
                  }
                ];
              }
            ];
            definedAliases = [ "@hm" ];
          };
          "google".metaData.hidden = true;
          "bing".metaData.hidden = true;
          "amazon".metaData.hidden = true;
          "ebay".metaData.hidden = true;
          "ddg".metaData.hidden = true;
          "wikipedia".metaData.hidden = true;
        };
      };

      settings = {
        "intl.accept_languages" = "en-AU, en";
        "spellchecker.dictionary" = "en-AU";

        "browser.contentblocking.category" = "strict";

        "privacy.fingerprintingProtection" = true;

        "privacy.query_stripping.enabled" = true;
        "privacy.query_stripping.enabled.pbmode" = true;

        "network.http.referer.XOriginTrimmingPolicy" = 2;

        "dom.security.https_only_mode" = true;

        "media.peerconnection.ice.default_address_only" = true;

        "browser.safebrowsing.downloads.remote.enabled" = false;

        "browser.send_pings" = false;
        "beacon.enabled" = false;

        "network.IDN_show_punycode" = true;

        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;

        "privacy.userContext.enabled" = true;
        "privacy.userContext.ui.enabled" = true;

        "network.prefetch-next" = false;
        "network.dns.disablePrefetch" = true;
        "network.predictor.enabled" = false;
        "network.predictor.enable-prefetch" = false;
        "network.http.speculative-parallel-limit" = 0;
        "browser.urlbar.speculativeConnect.enabled" = false;

        "browser.urlbar.trending.featureGate" = false;
        "browser.urlbar.suggest.trending" = false;
        "browser.urlbar.quicksuggest.enabled" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;

        "network.captive-portal-service.enabled" = false;
        "network.connectivity-service.enabled" = false;

        "browser.region.update.enabled" = false;
        "browser.region.network.url" = "";

        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";
        "app.shield.optoutstudies.enabled" = false;

        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "browser.discovery.enabled" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;

        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;

        "gfx.font_rendering.opentype_svg.enabled" = false;

        "general.autoScroll" = true;
        "apz.autoscroll.enabled" = false;
        "general.smoothScroll" = true;
        "general.smoothScroll.msdPhysics.enabled" = true;
        "general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS" = 12;
        "general.smoothScroll.msdPhysics.motionBeginSpringConstant" = 600;
        "general.smoothScroll.msdPhysics.regularSpringConstant" = 650;
        "general.smoothScroll.msdPhysics.slowdownMinDeltaMS" = 12;
        "general.smoothScroll.msdPhysics.slowdownMinDeltaRatio" = 1.3;
        "general.smoothScroll.msdPhysics.slowdownSpringConstant" = 250;

        "network.http.max-persistent-connections-per-server" = 10;
        "network.http.max-urgent-start-excessive-connections-per-host" = 5;

        "browser.startup.page" = 3;
        "browser.startup.homepage" = "about:home";
        "browser.newtabpage.enabled" = true;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.startup.preXulSkeletonUI" = false;
        "ui.prefersReducedMotion" = 0;

        "extensions.autoDisableScopes" = 0;

        "browser.uidensity" = 1;
        "browser.compactmode.show" = true;
        "browser.tabs.firefox-view" = false;

        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "browser.tabs.hoverPreview.enabled" = true;
        "browser.tabs.loadBookmarksInTabs" = true;
        "browser.tabs.closeTabByDblclick" = true;

        "browser.urlbar.suggest.calculator" = true;
        "browser.urlbar.unitConversion.enabled" = true;
        "findbar.highlightAll" = true;

        "browser.sessionstore.interval" = 60000;
        "browser.aboutConfig.showWarning" = false;
        "browser.download.manager.addToRecentDocs" = false;
        "browser.download.alwaysOpenPanel" = false;
        "browser.translations.automaticallyPopup" = false;
        "cookiebanners.service.mode" = 2;
        "cookiebanners.service.mode.privateBrowsing" = 2;
        "middlemouse.paste" = false;
        "full-screen-api.transition-duration.enter" = "0 0";
        "full-screen-api.transition-duration.leave" = "0 0";
        "full-screen-api.warning.delay" = -1;

        "browser.download.useDownloadDir" = false;
        "browser.tabs.closeWindowWithLastTab" = false;
        "full-screen-api.warning.timeout" = 0;
      }
      // lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
        "widget.use-xdg-desktop-portal.file-picker" = 2;
        "widget.use-xdg-desktop-portal.mime-handler" = 1;
        "gfx.font_rendering.fontconfig.max_generic_substitutions" = 127;
        "font.name-list.emoji" = "emoji";
        "apz.gtk.kinetic_scroll.enabled" = false;
        "browser.quitShortcut.disabled" = true;
      };
    };
  };
}
