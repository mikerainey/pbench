{ pkgs   ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
  buildDunePackage ? pkgs.ocamlPackages.buildDunePackage,
  pbenchOcamlSrc ? ../ocaml
}:

buildDunePackage rec {
  pname = "pbench";
  version = "1.0";
  src = pbenchOcamlSrc;
}
