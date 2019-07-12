{ buildDunePackage }:

buildDunePackage rec {
  pname = "pbench";
  version = "1.0";
  src = ./ocaml;
}
