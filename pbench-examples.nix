{ buildDunePackage, pbench }:

buildDunePackage rec {
  pname = "pbench-examples";
  version = "1.0";
  src = ./examples;
  buildInputs = [ pbench ];
}
