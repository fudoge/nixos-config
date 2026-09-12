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

    btop.enable = false;
    bottom.enable = false;
    nvim.enable = false;
    yazi.enable = false;
    zed.enable = false;
    vscode.profiles.default.enable = false;
    kiro.profiles.default.enable = false;
  };
}
