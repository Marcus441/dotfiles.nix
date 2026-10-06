_:
let
  cli = { pkgs, ... }: { environment.systemPackages = [ pkgs.home-manager ]; };
in
{
  flake.modules.nixos.core = cli;
  flake.modules.darwin.core = cli;
}
