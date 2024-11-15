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
      version = "1.81.0";
      channel = "stable";
    }).rust
  ];
  RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
}
```

### `rust-toolchain.toml`

```toml
#参考サイト: https://rust-lang.github.io/rustup/overrides.html
[toolchain]
channel = "1.81.0"
```

### 参考サイト

https://scrapbox.io/mrsekut-p/nix-shell%E3%81%A7Rust%E7%92%B0%E5%A2%83%E3%82%92setup%E3%81%99%E3%82%8B

## python

### `shell.nix`

```nix
{
  pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05") { },
}:

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
{
  pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05") { },
}:

pkgs.mkShell {
  buildInputs = with pkgs; [
    nodejs
    corepack
  ];
}
```

### 参考サイト

https://blog.tomoyukim.net/entry/nix-shell-nodejs/

## R

### `shell.nix`

```nix
let
  pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/658e7223191d2598641d50ee4e898126768fe847.tar.gz") {};

  rpkgs = builtins.attrValues {
    inherit (pkgs.rPackages)
        #e.g. ggplot2
      languageserver;
  };
  system_packages = builtins.attrValues {
    inherit (pkgs)
      glibcLocales
      nix
      R;
  };
in

pkgs.mkShell {
  LOCALE_ARCHIVE = if pkgs.system == "x86_64-linux" then "${pkgs.glibcLocales}/lib/locale/locale-archive" else "";
  LANG = "en_US.UTF-8";
   LC_ALL = "en_US.UTF-8";
   LC_TIME = "en_US.UTF-8";
   LC_MONETARY = "en_US.UTF-8";
   LC_PAPER = "en_US.UTF-8";
   LC_MEASUREMENT = "en_US.UTF-8";
  buildInputs = [  rpkgs  system_packages   ];
}
```
