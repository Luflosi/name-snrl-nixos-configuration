{
  lib,
  pkgs,
  inputs,
  config,
  importsFromAttrs,
  ...
}:
{
  imports =
    [ ./hw-config.nix ]
    ++ importsFromAttrs {
      importByDefault = true;
      modules = inputs.self.nixosModules;
      imports = {
        profiles.system.servers.openssh = false;
      };
    };

  boot.initrd.kernelModules = [ "i915" ]; # Enable early KMS

  # Firmware
  #services.fwupd.enable = true; # https://fwupd.org/lvfs/devices/

  # CPU
  powerManagement.cpuFreqGovernor = "schedutil";

  # GPU acceleration
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "i965";
    VDPAU_DRIVER = lib.mkIf config.hardware.opengl.enable (lib.mkDefault "va_gl");
  };
  hardware.opengl.extraPackages = with pkgs; [
    intel-vaapi-driver
    libvdpau-va-gl
  ];

  host-specs = {
    device-type = "laptop";
    output-name = "eDP-1";
    cores = 4;
    ram = 8;
    wifi = true;
    bluetooth = true;
    battery = true;
    webcam = true;
    als = false;
    tlp-settings = {
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 60;

      START_CHARGE_THRESH_BAT1 = 40;
      STOP_CHARGE_THRESH_BAT1 = 55;
    };
  };

  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "22.05";
}
