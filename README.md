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

## ✍️ Neovim (nvf) keybindings

Leader key: `<Space>`

### General
| Mode | Key        | Action           |
| ---- | ---------- | ---------------- |
| n    | `<leader>e` | Toggle explorer  |
| n    | `<leader>h` | Clear highlights |

### Window navigation
| Mode | Key    | Action     |
| ---- | ------ | ---------- |
| n    | `<C-h>` | Move left  |
| n    | `<C-j>` | Move down  |
| n    | `<C-k>` | Move up    |
| n    | `<C-l>` | Move right |

### Buffers
| Mode | Key     | Action      |
| ---- | ------- | ----------- |
| n    | `<A-,>` | Prev buffer |
| n    | `<A-.>` | Next buffer |
| n    | `<A-c>` | Close buffer |

### Telescope
| Mode | Key          | Action      |
| ---- | ------------ | ----------- |
| n    | `<leader>ff` | Find files  |
| n    | `<leader>fg` | Live grep   |
| n    | `<leader>fb` | Buffers     |
| n    | `<leader>fh` | Help        |

### LSP
| Mode | Key         | Action           |
| ---- | ----------- | ---------------- |
| n    | `gd`        | Go to definition |
| n    | `K`         | Hover            |
| n    | `gr`        | References       |
| n    | `<leader>ca` | Code action      |
| n    | `<leader>rn` | Rename           |

### Git (gitsigns)
| Mode | Key         | Action     |
| ---- | ----------- | ---------- |
| n    | `<leader>hs` | Stage hunk |
| n    | `<leader>hr` | Reset hunk |
| n    | `<leader>hb` | Blame line |
| n    | `]c`        | Next hunk  |
| n    | `[c`        | Prev hunk  |

### Save
| Mode | Key    | Action |
| ---- | ------ | ------ |
| n    | `<C-s>` | Save   |
| i    | `<C-s>` | Save   |

### Visual indent
| Mode | Key | Action      |
| ---- | --- | ----------- |
| v    | `<` | Indent left |
| v    | `>` | Indent right |

### Harpoon
| Mode | Key         | Action       |
| ---- | ----------- | ------------ |
| n    | `<leader>a` | Harpoon add  |
| n    | `<C-e>`     | Harpoon menu |
| n    | `<leader>hp` | Harpoon prev |
| n    | `<leader>hn` | Harpoon next |

### Completion (nvim-cmp)
| Mode | Key         | Action        |
| ---- | ----------- | ------------- |
| i    | `<CR>`      | Confirm       |
| i    | `<C-Space>` | Complete      |
| i    | `<C-b>`     | Scroll docs up |
| i    | `<C-f>`     | Scroll docs down |
| i    | `<C-e>`     | Close         |
| i    | `<C-n>`     | Next item     |
| i    | `<C-p>`     | Prev item     |
