{ buildDunePackage, pbenchOcamlSrc }:

buildDunePackage rec {
  pname = "pbench";
  version = "1.0";
  src = pbenchOcamlSrc;
}
