_: let
  registry.templates.to = {
    type = "github";
    owner = "Marcus441";
    repo = "templates";
  };

  settings = {
    experimental-features = ["nix-command" "flakes"];
    warn-dirty = false;
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://nvf.cachix.org"
      "https://devenv.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nvf.cachix.org-1:GMQWiUhZ6ux9D5CvFFMwnc2nFrUHTeGaXRlVBXo+naI="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
  };
in {
  flake.modules.homeManager.core = {pkgs, ...}: {
    home.packages = [pkgs.nix-prefetch-scripts];
  };

  flake.modules.nixos.core = {
    nix = {
      inherit registry;
      settings = settings // {auto-optimise-store = true;};
    };
  };

  flake.modules.darwin.core = {
    nix = {
      inherit registry settings;
      # auto-optimise-store is unsafe on darwin; optimise on a timer instead.
      optimise.automatic = true;
    };
  };
}
