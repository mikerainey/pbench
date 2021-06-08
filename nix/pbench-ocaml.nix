# As of nix version 21.05, there is some bug preventing dune from building w/ ocaml. For now,
# we get around this issue by pinning the packages repository for dune/ocaml.
{ pkgs   ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/tags/20.09.tar.gz") {},
  stdenv ? pkgs.stdenv,
  buildDunePackage ? pkgs.ocamlPackages.buildDunePackage,
  pbenchOcamlSrc ? ../ocaml
}:

buildDunePackage rec {
  pname = "pbench";
  version = "1.0";
  src = pbenchOcamlSrc;
}
