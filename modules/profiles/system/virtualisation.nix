{
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
  };
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };
  users.users.default.extraGroups = [
    "libvirtd"
    "docker"
  ];
  # nixos-containers networking
  networking.nat = {
    enable = true;
    internalInterfaces = [ "ve-+" ];
  };
}
