{ buildDunePackage, pbenchExamplesSrc, pbenchOcaml }:

buildDunePackage rec {
  pname = "pbench-examples";
  version = "1.0";
  src = pbenchExamplesSrc;
  buildInputs = [ pbenchOcaml ];
}
