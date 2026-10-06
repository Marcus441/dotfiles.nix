{ inputs, ... }: {
  flake.modules.homeManager.core =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (pkgs.stdenv.hostPlatform) system;
      neovim = inputs.neovim-config.packages.${system};
    in
    {
      options.editor.package = lib.mkOption {
        type = lib.types.package;
        default = neovim.min;
        description = "Neovim build to install.";
      };

      config.home = {
        packages = [ config.editor.package ];
        sessionVariables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
        };
      };
    };

  flake.modules.homeManager.dev =
    { pkgs, ... }:
    let
      inherit (pkgs.stdenv.hostPlatform) system;
      neovim = inputs.neovim-config.packages.${system};
    in
    {
      editor.package = neovim.full;

      home.packages = [
        pkgs.ghostscript
        pkgs.tectonic
      ];
    };
}
