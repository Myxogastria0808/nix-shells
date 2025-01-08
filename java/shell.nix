{
  pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.11") { },
}:

pkgs.mkShell {
  buildInputs = with pkgs; [
    temurin-bin
  ];
}
