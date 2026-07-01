{...}: {
  hardware.enableRedistributableFirmware = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  systemd.services.amdgpu-power-profile = {
    description = "Set AMD GPU power profile";
    wantedBy = ["multi-user.target"];
    after = ["systemd-udev-settle.service"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      for state in /sys/class/drm/card*/device/power_dpm_state; do
        [ -w "$state" ] || continue

        device_dir="$(dirname "$state")"
        vendor="$(cat "$device_dir/vendor" 2>/dev/null || true)"
        [ "$vendor" = "0x1002" ] || continue

        echo balanced > "$state"
      done
    '';
  };
}
