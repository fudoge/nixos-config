{pkgs, ...}: let
  odSender = pkgs.stdenv.mkDerivation {
    pname = "od-sender";
    version = "1.30.1";

    src = pkgs.fetchurl {
      url = "https://github.com/peetzweg/opendisplay/releases/download/v1.30.1/od-sender-x86_64-unknown-linux-gnu.tar.gz";
      hash = "sha256-VCcBQnOLKIGNcMr9hqHTueGeTG1q1AMBT36ihbGj3Bw=";
    };

    nativeBuildInputs = [pkgs.autoPatchelfHook];
    buildInputs = [pkgs.pipewire pkgs.stdenv.cc.cc.lib];
    dontBuild = true;

    installPhase = ''
      runHook preInstall
      install -Dm755 od-sender $out/bin/od-sender
      mkdir -p $out/share/applications $out/share/systemd/user
      substitute od-sender.desktop $out/share/applications/od-sender.desktop \
        --replace-fail /usr/bin/od-sender $out/bin/od-sender
      substitute od-sender@.service $out/share/systemd/user/od-sender@.service \
        --replace-fail /usr/bin/od-sender $out/bin/od-sender
      runHook postInstall
    '';
  };
in {
  home.packages = [odSender];
  xdg.configFile."systemd/user/od-sender@.service".source = "${odSender}/share/systemd/user/od-sender@.service";
}
