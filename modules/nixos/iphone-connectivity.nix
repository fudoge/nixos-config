{
  config,
  pkgs,
  lib,
  ...
}: {
  services.usbmuxd.enable = true;

  environment.systemPackages = with pkgs; [
    libimobiledevice
    ifuse

    # for factory reset
    idevicerestore
  ];
}
