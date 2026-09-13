_: {
  flake.modules.homeManager.core = {
    lib,
    pkgs,
    ...
  }: {
    options.desktop.font = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "JetbrainsMono Nerd Font";
        description = "Primary monospace font family.";
      };
      terminalSize = lib.mkOption {
        type = lib.types.int;
        default = 12;
        description = "Terminal and monospace text size, in points. Hosts set it for their panel.";
      };
    };

    config = {
      home.packages = with pkgs; [
        dejavu_fonts
        font-awesome
        inter
        nerd-fonts.jetbrains-mono
        nerd-fonts.symbols-only
        noto-fonts
        noto-fonts-color-emoji
        noto-fonts-lgc-plus
      ];
      fonts.fontconfig.enable = true;
    };
  };
}
