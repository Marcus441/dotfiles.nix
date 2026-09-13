_: {
  flake.modules.homeManager.wayland = {
    config,
    pkgs,
    ...
  }: let
    lockNow = "pgrep -x swaylock > /dev/null || swaylock -f";
  in {
    home.packages = [
      (pkgs.writeShellApplication {
        name = "session-idle";
        runtimeInputs = [
          pkgs.swayidle
          pkgs.brightnessctl
          pkgs.wlopm
          pkgs.procps
          config.programs.swaylock.package
        ];
        text = ''
          exec swayidle -w \
            timeout 180 'brightnessctl -s set 30' resume 'brightnessctl -r' \
            timeout 300 'loginctl lock-session' \
            timeout 600 'wlopm --off "*"' resume 'wlopm --on "*"' \
            timeout 1200 'systemctl suspend' \
            before-sleep '${lockNow}' \
            after-resume 'wlopm --on "*"' \
            lock '${lockNow}'
        '';
      })
    ];

    desktop.autostart = ["session-idle"];
  };
}
