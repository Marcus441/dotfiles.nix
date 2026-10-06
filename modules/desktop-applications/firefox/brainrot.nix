{ inputs, ... }:
let
  shorts = "https://raw.githubusercontent.com/gijsdev/ublock-hide-yt-shorts/master/list.txt";
in
{
  flake.modules.homeManager.firefox = {
    programs.firefox.policies = {
      "3rdparty".Extensions."uBlock0@raymondhill.net".adminSettings = {
        selectedFilterLists = [ shorts ];

        userSettings.importedLists = [ shorts ];

        userFilters = ''
          www.youtube.com##ytd-browse[page-subtype="home"] ytd-rich-grid-renderer
          www.youtube.com##ytd-watch-next-secondary-results-renderer
          www.youtube.com###comments
          www.youtube.com##.ytp-ce-element
          www.youtube.com##.ytp-endscreen-content
          www.youtube.com##.ytp-autonav-endscreen-upnext-container
        '';
      };
    };
  };

  flake.modules.homeManager.firefox-profile =
    { pkgs, ... }:
    let
      addons = inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      programs.firefox.profiles.default.extensions.packages = [
        addons.dearrow
        addons.return-youtube-dislikes
      ];
    };
}
