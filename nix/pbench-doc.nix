{ stdenv, pbenchDocSrc, pandoc, myTexlive }:

stdenv.mkDerivation rec {
  name = "pbench-doc";

  src = pbenchDocSrc;

  buildInputs = [ pandoc myTexlive ];

  installPhase = ''
    mkdir -p $out
    cp *.html *.pdf *.md $out
  '';

  meta = {
    description = "Documentation for the program benchmarking toolkit.";
    license = "Apache";
    homepage = http://deepsea.inria.fr/pbench/;
  };

}
