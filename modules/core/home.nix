{config, ...}: let
  inherit (config.meta) user;
in {
  flake.modules.homeManager.core = {
    lib,
    pkgs,
    ...
  }: {
    home = {
      username = user;
      homeDirectory =
        if pkgs.stdenv.hostPlatform.isDarwin
        then "/Users/${user}"
        else "/home/${user}";
      stateVersion = lib.mkDefault "25.11";
    };
  };
}
