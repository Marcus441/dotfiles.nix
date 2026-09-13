_: {
  flake.modules.homeManager.wayland = {
    config,
    lib,
    pkgs,
    ...
  }: let
    inherit (lib) mkOption types;

    monitor = types.submodule {
      options = {
        name = mkOption {
          type = types.str;
          description = "Connector, as the kernel names it (`HDMI-A-1`).";
        };

        width = mkOption {type = types.ints.positive;};
        height = mkOption {type = types.ints.positive;};

        refresh = mkOption {
          type = types.numbers.positive;
          default = 60;
        };

        x = mkOption {
          type = types.int;
          default = 0;
        };

        y = mkOption {
          type = types.int;
          default = 0;
        };

        scale = mkOption {
          type = types.numbers.positive;
          default = 1;
        };
      };
    };

    toWlrRandr = m: ''
      wlr-randr --output ${m.name} \
        --mode ${toString m.width}x${toString m.height}@${toString m.refresh}Hz \
        --pos ${toString m.x},${toString m.y} \
        --scale ${toString m.scale} --on
    '';

    names = map (m: m.name) config.desktop.monitors;
  in {
    options.desktop.monitors = mkOption {
      type = types.listOf monitor;
      default = [];
      description = "This host's outputs. Applied with wlr-randr at session start, so any wlroots compositor honours them.";
    };

    config = {
      assertions = [
        {
          assertion = lib.allUnique names;
          message = "desktop.monitors: duplicate connector in ${lib.concatStringsSep ", " names}";
        }
      ];

      home.packages = [
        (pkgs.writeShellApplication {
          name = "session-monitors";
          runtimeInputs = [pkgs.wlr-randr];
          text = lib.concatMapStringsSep "\n" toWlrRandr config.desktop.monitors;
        })
      ];

      desktop.autostart = ["session-monitors"];
    };
  };
}
