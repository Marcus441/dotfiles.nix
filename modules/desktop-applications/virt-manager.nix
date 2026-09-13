{config, ...}: let
  inherit (config.meta) user;
in {
  flake.modules.nixos.apps = {
    lib,
    pkgs,
    ...
  }: {
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = false;
          swtpm.enable = true;
        };
      };
      spiceUSBRedirection.enable = true;
    };
    programs.virt-manager.enable = true;
    networking.firewall.trustedInterfaces = ["virbr0"];
    users.users.${user}.extraGroups = ["libvirtd" "kvm"];

    systemd.services.libvirtd.wantedBy = lib.mkForce [];
    systemd.services.libvirt-guests.wantedBy = lib.mkForce [];
  };
}
