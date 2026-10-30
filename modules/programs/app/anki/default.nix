{pkgs, ...}: let
  anki = pkgs.anki.overrideAttrs (_: {
    # uv initializes an HTTP client even in offline builds; Nix's sandbox
    # sets SSL_CERT_FILE to /no-cert-file.crt, which makes that step fail.
    SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
  });
in {
  home.packages = [anki];
}
