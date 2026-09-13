_: {
  flake.modules.nixos.dev = {pkgs, ...}: {
    boot.binfmt.emulatedSystems = ["aarch64-linux"];

    services.usbmuxd.enable = true;

    environment.systemPackages = with pkgs; [
      libimobiledevice
      qemu_kvm
      quickemu
    ];
  };
}
