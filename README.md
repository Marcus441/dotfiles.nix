# NixOS Config

My personal NixOS configuration, featuring a Kanagawa Dragon themed desktop.

It follows **the dendritic pattern**: every `.nix` file under `modules/` is a
flake-parts module, and NixOS / nix-darwin / home-manager modules are stored as
option values under `flake.modules.<class>.<aspect>` rather than imported from
paths. A host is itself an aspect that imports the aspects it wants — there is
no generator, no host record and no profile tree. Adding a feature means adding
one file.

## Inspiration and Attribution

The pattern is not mine, and neither is most of the reasoning behind it. What
each source actually contributed:

**[mightyiam/dendritic](https://github.com/mightyiam/dendritic)**

**[The Dendritic Pattern — NixOS
Discourse](https://discourse.nixos.org/t/the-dendritic-pattern/61271)** —

**[Doc-Steve/dendritic-design-with-flake-parts](https://github.com/Doc-Steve/dendritic-design-with-flake-parts)**

**[import-tree](https://github.com/vic/import-tree)** — the auto-import library,

**[Search for best dotfiles structure: Dendritic
edition](https://discourse.nixos.org/t/search-for-best-dotfiles-structure-dendritic-edition/75134)**

## Layout

```
flake.nix               inputs, then import-tree ./modules
modules/
  flake/                flake-parts plumbing: flake.modules, meta.user, mkNixos / mkDarwin / mkHome
  hosts/<host>/         <host>.nix and its _hardware-configuration.nix
  core/                 the baseline every machine gets, for nixos, darwin and homeManager
  wayland/              compositor-neutral wlroots session: ly, audio, mako, lock, idle,
                        wallpaper, monitors, launcher, screenshots
  wayland/dwl/          the dwl compositor
  cli/ shell/ git/ editor/ theme/ dev/ gaming/ nvidia/ hardware/ desktop-applications/
```

import-tree skips any path containing `/_`, which is how hardware configs,
dwl's `config.h` template and local package definitions live next to the
modules that use them.

## Aspects

| aspect      | nixos | darwin | homeManager |
| ----------- | :---: | :----: | :---------: |
| `core`      |   ✓   |   ✓    |      ✓      |
| `zsh`       |   ✓   |   ✓    |      ✓      |
| `dev`       |   ✓   |        |      ✓      |
| `wayland`   |   ✓   |        |      ✓      |
| `dwl`       |   ✓   |        |      ✓      |
| `dwl-bar`   |       |        |      ✓      |
| `foot`      |       |        |      ✓      |
| `firefox`   |       |        |      ✓      |
| `apps`      |   ✓   |        |      ✓      |
| `gaming`    |   ✓   |        |      ✓      |
| `nvidia`    |   ✓   |        |      ✓      |
| `laptop`    |   ✓   |        |      ✓      |
| `keychron`  |   ✓   |        |             |

`homeManager.core` is cross-platform; Linux-only pieces are guarded with
`pkgs.stdenv.hostPlatform.isLinux`, so the same home baseline evaluates on a Mac.

Hosts import aspects flat. flake-parts does not deduplicate modules, so an
aspect must not import another aspect that a host could also list — its options
would be declared twice. Importing an aspect a class doesn't define is an
evaluation error, which is the only dependency check needed.

## Hosts

Every host is two build targets: its system — `nixosConfigurations.<host>` or
`darwinConfigurations.<host>` — and its home, `homeConfigurations."marcus@<host>"`.
Home Manager is **standalone**, activated separately rather than as a NixOS or
nix-darwin module, so a home also works on a machine Nix merely runs on.

A NixOS host, `modules/hosts/<host>/<host>.nix`:

```nix
{config, inputs, ...}: let
  inherit (config.flake.lib) mkNixos mkHome;
in {
  flake.nixosConfigurations.box = mkNixos "x86_64-linux" "box";
  flake.homeConfigurations."${config.meta.user}@box" = mkHome "x86_64-linux" "box";

  flake.modules.nixos.box = {
    imports = with inputs.self.modules.nixos; [
      ./_hardware-configuration.nix
      core
      wayland
      dwl
    ];
    system.stateVersion = "25.11";
  };

  flake.modules.homeManager.box = {
    imports = with inputs.self.modules.homeManager; [core wayland dwl foot];
    desktop.font.terminalSize = 16;
    desktop.monitors = [{name = "eDP-1"; width = 1920; height = 1080;}];
  };
}
```

A Mac is the same shape with `mkDarwin "aarch64-darwin" "mac"`,
`flake.modules.darwin.mac` importing `core` (and `zsh`), and
`system.stateVersion = 6;` — no hardware configuration.

## Adding a compositor

The session pieces in `wayland` know nothing about dwl. Each one installs its
program and appends a command to `desktop.autostart`; outputs are declared once
per host in `desktop.monitors` and applied by `session-monitors` through
wlr-randr. A new compositor such as mangowm only needs:

1. `flake.modules.nixos.<wm>` — register the session with the display manager
   and configure its portals.
2. `flake.modules.homeManager.<wm>` — build and configure the compositor, and
   run every `config.desktop.autostart` entry at startup. dwl does this by
   handing a generated script to `dwl -s`.

A host then imports `<wm>` in place of `dwl` in both of its aspect lists.

## Installing

1. **Install NixOS** using the official
   [installation guide](https://nixos.org/manual/nixos/stable/#sec-installation),
   then clone this repository:

   ```bash
   git clone https://github.com/Marcus441/dotfiles.nix.git ~/.dotfiles/flake
   cd ~/.dotfiles/flake
   ```

2. **Drop in the hardware config** — the one machine-generated file, never
   edited by hand:

   ```bash
   mkdir -p modules/hosts/<hostname>
   cp /etc/nixos/hardware-configuration.nix modules/hosts/<hostname>/_hardware-configuration.nix
   ```

3. **Write `modules/hosts/<hostname>/<hostname>.nix`** — copy an existing host
   and change its aspect lists and facts.

4. **Activate.** Flakes only see tracked files, so stage first:

   ```bash
   git add -A
   ```

   Then switch

   ```bash
   sudo nixos-rebuild switch --flake .#<hostname>
   home-manager switch --flake .#marcus@<hostname>
   ```

   On a Mac, `sudo nix run nix-darwin -- switch --flake .#<hostname>` replaces
   the first command.

   After that it is `nh os` / `nh home` as the daily driver.
