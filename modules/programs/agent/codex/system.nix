{
  lib,
  pkgs,
  ...
}: let
  settings = {
    model = "gpt-6-sol";
    model_reasoning_effort = "medium";

    features.hooks = true;

    plugins = {
      "browser@openai-bundled".enabled = true;
      "chrome@openai-bundled".enabled = false;
      "codex-app-tools@openai-bundled".enabled = true;
      "documents@openai-primary-runtime".enabled = true;
      "pdf@openai-primary-runtime".enabled = true;
      "presentations@openai-primary-runtime".enabled = true;
      "spreadsheets@openai-primary-runtime".enabled = true;
      "template-creator@openai-primary-runtime".enabled = true;
      "unified-computer-use@openai-bundled".enabled = true;
      "visualize@openai-bundled".enabled = true;
    };
  };
in {
  # Keep project trust, app-generated MCP paths, and marketplace paths in the
  # writable user config. These defaults are shared by all local users.
  environment.etc."codex/config.toml".source = (pkgs.formats.toml {}).generate "codex-system-config.toml" (
    settings
    // {
      mcp_servers =
        {
          context7.url = "https://mcp.context7.com/mcp";

          terraform = {
            command = lib.getExe pkgs.terraform-mcp-server;
            args = ["stdio"];
          };
        }
        // lib.optionalAttrs pkgs.stdenv.isLinux {
          nixos = {
            command = "${pkgs.uv}/bin/uvx";
            args = ["mcp-nixos"];
          };
        };
    }
  );
}
