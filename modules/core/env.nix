_: {
  flake.modules.nixos.core = let
    binHome = "$HOME/.local/bin";
  in {
    environment.sessionVariables = {
      EDITOR = "nvim";
      XDG_BIN_HOME = binHome;
      PATH = [binHome];
    };
  };
}
