{
  config,
  pkgs,
  lib,
  ...
}: {
  xdg.configFile."zed/themes/Lumin.json".source = ./Lumin.json;

  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "rust"
      "go"
      "python"
      "c"
      "cpp"
      "yaml"
      "hcl"
      "json"
      "lua"
      "make"
      "django"
    ];
    userSettings = {
      theme = {
        mode = "dark";
        dark = "Lumin Blur";
        light = "Lumin Light";
      };

      terminal = {
        alternate_scroll = "off";
        blinking = "off";
        copy_on_select = false;
        env = {
          TERM = "ghostty";
        };
        font_family = "JetBrains Mono Nerd Font SemiBold";
        font_features = null;
        font_size = null;
        line_height = "standard";
        option_as_meta = false;
        shell = {
          program = "zsh";
        };
        toolbar = {
          title = true;
        };
        working_directory = "current_project_directory";
      };
      lsp = {
        nix = {
          binary = {
            path_lookup = true;
          };
        };
      };
      vim_mode = true;
      hour_format = "hour24";
      load_direnv = "shell_hook";
      base_keymap = "VSCode";
      show_whitespaces = "all";
      ui_font_size = 16;
      buffer_font_size = 16;
    };
  };
}
