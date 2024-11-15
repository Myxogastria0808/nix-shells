{
  pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05") { },
}:

pkgs.mkShellNoCC {
  packages = with pkgs; [
    (python3.withPackages (ps: [
      ps.numpy
    ]))
  ];
}
