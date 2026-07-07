{
  config,
  pkgs,
  lib,
  hostFeatures ? {},
  ...
}: let
  cfg = {theme = "lumin";} // hostFeatures;
  validThemes = ["lumin" "rose-pine"];
  theme =
    if lib.elem cfg.theme validThemes
    then cfg.theme
    else throw "Unsupported theme '${cfg.theme}'. Expected one of: ${lib.concatStringsSep ", " validThemes}";
  isLumin = theme == "lumin";
in {
  # starship prompt
  programs.starship = {
    enable = true;
    settings =
      {
        add_newline = true;
        time.disabled = false;
        time.format = "$time ($style) ";
      }
      // lib.optionalAttrs isLumin {
        git_branch.style = "#EFB080";
      };
  };
}
