_: let
  # Home Manager runs standalone; the system only ships the CLI that activates it.
  cli = {pkgs, ...}: {environment.systemPackages = [pkgs.home-manager];};
in {
  flake.modules.nixos.core = cli;
  flake.modules.darwin.core = cli;
}
