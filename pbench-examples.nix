{ buildDunePackage, pbenchOcaml }:

buildDunePackage rec {
  pname = "pbench-examples";
  version = "1.0";
  src = ./examples;
  buildInputs = [ pbenchOcaml ];
}
