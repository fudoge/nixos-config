{
  config,
  pkgs,
  lib,
  ...
}: {
  catppuccin = {
    autoEnable = true;
    enable = true;
    flavor = "frappe";

    accent = "sky";

    nvim.enable = false;
    zed.enable = false;
  };
}
