{
  pkgs,
  inputs,
  importsFromAttrs,
  ...
}:
{
  imports = importsFromAttrs {
    importByDefault = true;
    modules = inputs.self.moduleTree.nixos;
    imports = {
      configurations = false;
      profiles = {
        servers.openssh = false;
        desktop.work = false;
      };
    };
  };

  disko.devices.disk.disk0.device = "/dev/disk/by-id/nvme-SAMSUNG_MZVLQ256HBJD-00BH1_S672NX0W316765";

  # Firmware
  services.fwupd.enable = true; # https://fwupd.org/lvfs/devices/

  # CPU
  powerManagement.cpuFreqGovernor = "schedutil";

  # GPU acceleration
  hardware.graphics.extraPackages = with pkgs; [ intel-media-driver ];

  # RAM-specific
  boot.tmp.useTmpfs = true;
  zramSwap.memoryPercent = 50;

  # other host-specific settings
  services.tlp.settings = {
    START_CHARGE_THRESH_BAT0 = 40;
    STOP_CHARGE_THRESH_BAT0 = 50;
  };

  xdg.portal.wlr.settings.screencast = {
    output_name = "eDP-1";
    max_fps = 60;
    chooser_type = "none";
  };

  system.stateVersion = "24.05";
}
