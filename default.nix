{ pkgs   ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
  pbenchOcaml ? import ./pbench-ocaml.nix { buildDunePackage = pkgs.ocamlPackages.buildDunePackage; },
  prunTimeout ? import ./prun-timeout.nix { pkgs = pkgs; },
  pbenchExamples ? import ./pbench-examples.nix { buildDunePackage = pkgs.ocamlPackages.buildDunePackage; pbench = pbenchOcaml; },
  pbenchDoc ? import ./pbench-doc.nix { pkgs = pkgs; },
  gcc ? pkgs.gcc,
  R ? pkgs.R,
  myTexlive ? pkgs.texlive.combined.scheme-small,
  makeWrapper ? pkgs.makeWrapper
}:

stdenv.mkDerivation rec {
  name = "pbench";

  src = ./.;

  buildInputs =
    [ R myTexlive makeWrapper pbenchOcaml prunTimeout pbenchExamples ];

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

    mkdir -p $out/examples
    mkdir -p $out/examples/basic
    cp ${pbenchExamples}/bin/basic $out/examples/basic/
    cp ${pbenchExamples}/bin/fib $out/examples/basic/
    wrapProgram $out/examples/basic/basic \
        --prefix PATH ":" $out/examples/basic \
        --prefix PATH ":" $out/ \
        --add-flags "-skip make"
    mkdir -p $out/examples/others
    cp ${pbenchExamples}/bin/other $out/examples/others/
    cp ${pbenchExamples}/bin/*.sh $out/examples/others/
    wrapProgram $out/examples/others/other \
        --prefix PATH ":" $out/examples/others \
        --prefix PATH ":" $out/ \
        --add-flags "-skip make"

    mkdir -p $out/doc/
    cp ${pbenchDoc}/*.html $out/doc
    cp ${pbenchDoc}/*.pdf $out/doc
  '';

  meta = {
    description = "Program benchmarking toolkit.";
    license = "Apache";
    homepage = http://deepsea.inria.fr/pbench/;
  };

}
