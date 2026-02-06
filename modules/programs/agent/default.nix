{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./codex
    ./claude-code
    ./gemini-cli
  ];
}
