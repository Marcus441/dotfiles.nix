{config, ...}: let
  inherit (config.meta) user;
in {
  flake.modules.nixos.core = {
    users.users.${user} = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" "docker"];
    };
  };

  flake.modules.darwin.core = {
    system.primaryUser = user;
    users.users.${user}.home = "/Users/${user}";
  };
}
