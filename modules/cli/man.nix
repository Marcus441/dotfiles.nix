_: {
  flake.modules.homeManager.core = {
    lib,
    pkgs,
    ...
  }: let
    esc = builtins.fromJSON ''"\u001b"'';
    sgr = params: "${esc}[${params}m";
  in {
    home.packages = [pkgs.man-pages-posix] ++ lib.optional pkgs.stdenv.hostPlatform.isLinux pkgs.man-pages;

    home.sessionVariables = {
      GROFF_NO_SGR = 1;
      LESS_TERMCAP_mb = sgr "1;32";
      LESS_TERMCAP_md = sgr "1;32";
      LESS_TERMCAP_me = sgr "0";
      LESS_TERMCAP_so = sgr "01;33";
      LESS_TERMCAP_se = sgr "0";
      LESS_TERMCAP_us = sgr "1;4;31";
      LESS_TERMCAP_ue = sgr "0";
    };
  };
}
