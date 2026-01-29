# NixOS-Confing

My NixOS dots.

## 🚀 Bootstrapping

```bash
./bootstrap.sh thinkpad # nix profile
```

## 🍏 Install Nix-Darwin
[Determinate Nix](https://docs.determinate.systems/determinate-nix/)

## 🔒 Google drive authentication

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
