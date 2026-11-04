_: {
  flake.modules.homeManager.dev =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      # nixpkgs puts elfutils (Linux-only) in ccache's nativeCheckInputs ungated, so
      # eval fails on Darwin. No checks => no check inputs => no elfutils.
      ccache = pkgs.ccache.overrideAttrs (
        lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin { doCheck = false; }
      );
    in
    {
      home = {
        packages = [ ccache ];
        sessionVariables = {
          CCACHE_DIR = "${config.xdg.cacheHome}/ccache";
          CMAKE_C_COMPILER_LAUNCHER = "ccache";
          CMAKE_CXX_COMPILER_LAUNCHER = "ccache";
        };
      };
    };
}
