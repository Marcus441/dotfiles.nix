_: {
  flake.modules.homeManager.core =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      options.desktop.font = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "Iosevka Fixed";
          description = "Primary monospace font family.";
        };
        package = lib.mkOption {
          type = lib.types.package;
          default = pkgs.iosevka-bin.override { variant = "SGr-IosevkaFixed"; };
          description = "Package providing the monospace font.";
        };
        terminalSize = lib.mkOption {
          type = lib.types.int;
          default = 12;
          description = "Monospace text size, in points.";
        };
      };

      options.terminal.font = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "Iosevka Term";
          description = "Terminal font family.";
        };
        package = lib.mkOption {
          type = lib.types.package;
          default = pkgs.iosevka-bin.override { variant = "SGr-IosevkaTerm"; };
          description = "Package providing the terminal font.";
        };
        terminalSize = lib.mkOption {
          type = lib.types.int;
          default = 24;
          description = "Terminal text size, in points.";
        };
        ligatures = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Whether terminals render the font's ligatures.";
        };
      };

      config = {
        home.packages = [
          config.desktop.font.package
          config.terminal.font.package
        ]
        ++ ([
          pkgs.dejavu_fonts
          pkgs.font-awesome
          pkgs.inter
          pkgs.nerd-fonts.symbols-only
          pkgs.noto-fonts
          pkgs.noto-fonts-color-emoji
          pkgs.noto-fonts-lgc-plus
        ]);
        fonts.fontconfig.enable = true;
      };
    };
}
