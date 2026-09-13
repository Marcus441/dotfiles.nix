_: let
  unfree = {nixpkgs.config.allowUnfree = true;};
in {
  flake.modules.nixos.core = unfree;
  flake.modules.darwin.core = unfree;
  flake.modules.homeManager.core = unfree;
}
