{
  pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05") { },
}:

pkgs.mkShell {
  buildInputs = with pkgs; [
    nodejs
    corepack
  ];
}
