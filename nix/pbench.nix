{ pkgs, stdenv, pbenchSrc, pbenchOcaml, prunTimeout, pbenchDoc, gcc, R, myTexlive, makeWrapper }:

stdenv.mkDerivation rec {
  name = "pbench";

  src = pbenchSrc;

  buildInputs =
    [ R myTexlive makeWrapper pbenchOcaml prunTimeout ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out
  
    cp ${prunTimeout}/prun_timeout $out/

    cp ${pbenchOcaml}/bin/prun $out/prun
    wrapProgram $out/prun \
        --prefix PATH ":" $out/

    cp ${pbenchOcaml}/bin/pplot $out/pplot
    wrapProgram $out/pplot \
        --prefix PATH ":" ${myTexlive}/bin \
        --prefix PATH ":" ${R}/bin

    mkdir -p $out/doc/
    cp ${pbenchDoc}/*.html $out/doc
    cp ${pbenchDoc}/*.pdf $out/doc
    cp ${pbenchDoc}/*.md $out/doc
  '';

  meta = {
    description = "Program benchmarking toolkit.";
    license = "Apache";
    homepage = http://deepsea.inria.fr/pbench/;
  };

}
