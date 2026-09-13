_: let
  timezone = {time.timeZone = "Australia/Brisbane";};
in {
  flake.modules.nixos.core = timezone;
  flake.modules.darwin.core = timezone;
}
