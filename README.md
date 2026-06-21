# NixOS-Confing

My NixOS dots.

---

## 🚀 Bootstrapping

```bash
./bootstrap.sh thinkpad # nix profile
```

---

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
sudo -H nix run nix-darwin/nix-darwin-26.05#darwin-rebuild -- switch --flake .#macbook
```

---

## 🍫 NixOS-WSL

[Visit NixOS-WSL](https://github.com/nix-community/NixOS-WSL)

### Apply

```bash
./bootstrap.sh wsl
```

---

## 🧩 Host feature flags

Home-Manager modules are shared across NixOS, NixOS-WSL, and nix-darwin.
Host-specific behavior is controlled through the `hostFeatures` attrset in
`flake.nix`.

Each host passes `hostFeatures` through `home-manager.extraSpecialArgs`:

```nix
hostFeatures = mkHostFeatures {
  name = "thinkpad";
  platform = "linux-desktop";
  isNixOS = true;
  withGui = true;
  withWayland = true;
  withHyprland = true;
  withDesktopApps = true;
  withRclone = true;
  withEmail = true;
  withSpicetify = true;
};
```

The shared program entrypoint is `modules/programs/default.nix`. It always
imports the core CLI modules, then conditionally imports desktop, Wayland,
Hyprland, and service-specific modules from `hostFeatures`.

Current flags:

| Flag              | Meaning                                                   |
| ----------------- | --------------------------------------------------------- |
| `name`            | Logical host name, for host-specific checks if needed     |
| `platform`        | Human-readable platform group, such as `linux-desktop`    |
| `isNixOS`         | True for NixOS-based hosts, including WSL                 |
| `isWsl`           | True for the NixOS-WSL host                               |
| `isDarwin`        | True for nix-darwin hosts                                 |
| `withGui`         | Enable GUI-capable Home-Manager modules and GUI settings  |
| `withWayland`     | Enable Wayland-specific modules and packages              |
| `withHyprland`    | Enable Hyprland-specific Home-Manager modules             |
| `withDesktopApps` | Enable Linux desktop app modules such as Vesktop and Anki |
| `withInfraTools`  | Enable Kubernetes, Terraform, cloud, and related tooling  |
| `withRclone`      | Enable the user `gdrive-mount` systemd service            |
| `withEmail`       | Enable email clients and email-related session variables  |
| `withSpicetify`   | Enable Spicetify; requires its Home-Manager module import |

### Adding a new host

1. Add the NixOS or darwin configuration in `flake.nix`.
2. Create a matching profile under `home/profiles/`.
3. Import `../../modules/programs` and `../../modules/shell` from that profile.
4. Pass a `hostFeatures = mkHostFeatures { ... };` value through
   `home-manager.extraSpecialArgs`.
5. Only import external Home-Manager modules in the host when a feature actually
   needs them. For example, `spicetify-nix.homeManagerModules.default` is only
   imported by the ThinkPad host because only that host enables `withSpicetify`.

### Adding a new feature flag

Add the flag with a conservative default in `mkHostFeatures`, then add the same
default in `modules/programs/default.nix`:

```nix
mkHostFeatures = {
  withFoo ? false,
  ...
}: {
  inherit withFoo;
};
```

```nix
cfg =
  {
    withFoo = false;
  }
  // hostFeatures;
```

Use it with `lib.optionals` for imports or package lists:

```nix
imports =
  [
    ./git
    ./fetches
  ]
  ++ lib.optionals cfg.withFoo [./foo];
```

Use `lib.mkIf` for option definitions:

```nix
programs.foo = lib.mkIf cfg.withFoo {
  enable = true;
};
```

Important: avoid reading `pkgs`, `config`, or evaluated options while computing
`imports`. Nix evaluates module imports before the full module graph is built, so
imports should depend only on plain values passed through `hostFeatures`.

For platform-specific packages or settings, use `pkgs.stdenv.hostPlatform` inside
normal option definitions, not while deciding imports:

```nix
home.packages =
  []
  ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [pkgs.strace]
  ++ lib.optionals pkgs.stdenv.hostPlatform.isDarwin [pkgs.mtr];
```

---

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

---

## ✍️ Neovim (nvf) keybindings

Leader key: `<Space>`

### General

| Mode | Key         | Action           |
| ---- | ----------- | ---------------- |
| n    | `<leader>e` | Toggle explorer  |
| n    | `<leader>h` | Clear highlights |

### Window navigation

| Mode | Key     | Action     |
| ---- | ------- | ---------- |
| n    | `<C-h>` | Move left  |
| n    | `<C-j>` | Move down  |
| n    | `<C-k>` | Move up    |
| n    | `<C-l>` | Move right |

### Buffers

| Mode | Key     | Action       |
| ---- | ------- | ------------ |
| n    | `<A-,>` | Prev buffer  |
| n    | `<A-.>` | Next buffer  |
| n    | `<A-c>` | Close buffer |

### Telescope

| Mode | Key          | Action     |
| ---- | ------------ | ---------- |
| n    | `<leader>ff` | Find files |
| n    | `<leader>fg` | Live grep  |
| n    | `<leader>fb` | Buffers    |
| n    | `<leader>fh` | Help       |

### LSP

| Mode | Key          | Action           |
| ---- | ------------ | ---------------- |
| n    | `gd`         | Go to definition |
| n    | `K`          | Hover            |
| n    | `gr`         | References       |
| n    | `<leader>ca` | Code action      |
| n    | `<leader>rn` | Rename           |

### Git (gitsigns)

| Mode | Key          | Action     |
| ---- | ------------ | ---------- |
| n    | `<leader>hs` | Stage hunk |
| n    | `<leader>hr` | Reset hunk |
| n    | `<leader>hb` | Blame line |
| n    | `]c`         | Next hunk  |
| n    | `[c`         | Prev hunk  |

### Save

| Mode | Key     | Action |
| ---- | ------- | ------ |
| n    | `<C-s>` | Save   |
| i    | `<C-s>` | Save   |

### Visual indent

| Mode | Key | Action       |
| ---- | --- | ------------ |
| v    | `<` | Indent left  |
| v    | `>` | Indent right |

### Harpoon

| Mode | Key          | Action       |
| ---- | ------------ | ------------ |
| n    | `<leader>a`  | Harpoon add  |
| n    | `<C-e>`      | Harpoon menu |
| n    | `<leader>hp` | Harpoon prev |
| n    | `<leader>hn` | Harpoon next |

### Completion (nvim-cmp)

| Mode | Key         | Action           |
| ---- | ----------- | ---------------- |
| i    | `<CR>`      | Confirm          |
| i    | `<C-Space>` | Complete         |
| i    | `<C-b>`     | Scroll docs up   |
| i    | `<C-f>`     | Scroll docs down |
| i    | `<C-e>`     | Close            |
| i    | `<C-n>`     | Next item        |
| i    | `<C-p>`     | Prev item        |

---

## Caelestia Shell

Currently, Caelestia config is not managed by Nix.

Instead, you can manually import setup from `caelestia/shell-example.json`

```bash
cp caelestia/shell-example.json ~/.config/caelestia/shell.json
```
