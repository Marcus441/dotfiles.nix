_: {
  flake.modules.nixos.dev = { pkgs, ... }: {
    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

    services.usbmuxd.enable = true;

    environment.systemPackages = [
      pkgs.libimobiledevice
      pkgs.qemu_kvm
      pkgs.quickemu
    ];
  };
}
