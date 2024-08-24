# 各言語のテンプレートファイル

## Rust

### `shell.nix`

```nix
let
  moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
  pkgs = import (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/5de1564aed415bf9d0f281461babc2d101dd49ff.tar.gz") {
    overlays = [ moz_overlay ];
  };
in pkgs.mkShell {
  buildInputs = with pkgs; [
    pkg-config
    openssl

    # If you have ./rust-toolchain.toml file, Use below:
    (rustChannelOf {
      rustToolchain = ./rust-toolchain.toml;
    }).rust

    (rustChannelOf {
      version = "1.80.0";
      channel = "stable";
    }).rust
  ];
}
```

### `rust-toolchain.toml`

```toml
#参考サイト: https://rust-lang.github.io/rustup/overrides.html
[toolchain]
channel = "1.80.0"
```

### 参考サイト

https://scrapbox.io/mrsekut-p/nix-shell%E3%81%A7Rust%E7%92%B0%E5%A2%83%E3%82%92setup%E3%81%99%E3%82%8B

## python

### `shell.nix`

```nix
{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.11") {} }:

pkgs.mkShellNoCC {
  packages = with pkgs; [
    (python3.withPackages (ps: [
      #e.g. ps.numpy
    ]))
  ];
}
```

### 参考サイト

https://nix.dev/guides/recipes/python-environment.html

## Node.js

### `shell.nix`

```nix
{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.11") {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    nodejs_21
    corepack_21
  ];
}
```

### 参考サイト

https://blog.tomoyukim.net/entry/nix-shell-nodejs/
