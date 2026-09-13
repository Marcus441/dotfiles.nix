{config, ...}: {
  flake.modules.nixos.core = {
    programs.nh = {
      enable = true;
      flake = "/home/${config.meta.user}/.dotfiles/flake";
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep-since 14d --keep 5";
      };
    };
  };
}
