{
  config,
  pkgs,
  lib,
  unstable,
  ...
}: {
  programs.antigravity-cli = {
    enable = true;
    package = unstable.gemini-cli;
    settings = {
      general = {
        preferredEditor = "nvim";
        previewFeatures = true;
        vimMode = true;
      };
      ide = {
        enabled = true;
      };
      privacy = {
        usageStatisticsEnabled = false;
      };
      security = {
        auth = {
          selectedType = "oauth-personal";
        };
      };
    };
  };
}
