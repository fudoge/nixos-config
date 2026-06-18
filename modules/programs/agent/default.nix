{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./codex
    ./claude-code
    ./antigravity-cli
    ./opencode
  ];
}
