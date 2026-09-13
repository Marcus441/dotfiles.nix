_: {
  flake.modules.nixos.core = {
    services.logind.settings.Login.KillUserProcesses = true;
  };
}
