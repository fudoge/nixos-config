{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.aerc = {
    enable = true;
  };

  programs.thunderbird = {
    enable = true;

    profiles."default" = {
      isDefault = true;

      # Preferences written to the profile (user.js style).
      # Keep this to non-secret, non-credential preferences.
      settings = {
        # Don’t auto-disable installed extensions (useful if you later manage add-ons).
        "extensions.autoDisableScopes" = 0;

        # UI / convenience
        "mail.tabs.drawInTitlebar" = true;
        "mail.biff.show_alert" = false;
        "mail.chat.enabled" = false;

        # Privacy-ish defaults (optional)
        "mail.html_compose" = false;
        "privacy.donottrackheader.enabled" = true;
      };
    };
  };

  # Hyprland / Wayland: force native Wayland backend for Mozilla apps.
  # Thunderbird uses the same MOZ_ENABLE_WAYLAND switch.
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
  };
}
