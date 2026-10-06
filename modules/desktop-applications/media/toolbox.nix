_: {
  flake.modules.homeManager.core = {pkgs, ...}: {
    home.packages = [
      pkgs.ffmpeg
      pkgs.imagemagick
      pkgs.mediainfo
      pkgs.yt-dlp
    ];
  };

  flake.modules.homeManager.wayland = {pkgs, ...}: {
    home.packages = [
      pkgs.imv
      pkgs.playerctl
    ];
  };
}
