# NixOS-Confing

My NixOS dots.

## 🚀 Bootstrapping

```bash
./bootstrap.sh thinkpad # nix profile
```

## 🍏 Nix-Darwin

For more information, visit [here](https://github.com/nix-darwin/nix-darwin?tab=readme-ov-file#step-1-creating-flakenix)

### Install Nix-Darwin
[Determinate Nix](https://docs.determinate.systems/determinate-nix/)

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install --determinate
```

### Apply
```bash
sudo -H nix run nix-darwin/nix-darwin-25.11#darwin-rebuild -- switch --flake .#macbook
```

## 🔒 Google Drive authentication

```bash
rclone config
```

Interactions:

| Key                             | Input                                |
| ------------------------------- | ------------------------------------ |
| name                            | gdrive                               |
| storage                         | drive                                |
| client_id                       | <empty>                              |
| client_secret                   | <empty>                              |
| scope                           | 1(fullaccess)                        |
| service_account_file            | <empty>                              |
| Use web browser to authenticate | y, then open browser to authenticate |
| Shared drive                    | n                                    |
| Keep this remote                | y                                    |

```bash
systemctl restart --user gdrive-mount
```
