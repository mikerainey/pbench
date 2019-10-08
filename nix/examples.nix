{ pkgs   ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
  buildDunePackage ? pkgs.ocamlPackages.buildDunePackage,
  makeWrapper ? pkgs.makeWrapper,
  R ? pkgs.R,
  myTexlive ? pkgs.texlive.combined.scheme-small,
  sources ? import ./local-sources.nix,
  prunTimeout ? import sources.prunTimeout {},
  pbenchOcamlSrc ? sources.pbenchOcamlSrc,
  pbenchExamplesSrc ? sources.pbenchExamplesSrc,
  pbenchOcaml ? import sources.pbenchOcaml { buildDunePackage = buildDunePackage;
                                             pbenchOcamlSrc = pbenchOcamlSrc; }
}:

let pbenchExamples =
      buildDunePackage rec {
        pname = "pbench-examples";
        version = "1.0";
        src = pbenchExamplesSrc;
        buildInputs = [ pbenchOcaml ];
      };
in

stdenv.mkDerivation rec {
  name = "bench";

  src = sources.pbenchExamplesSrc;

  buildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/basic
    cp ${pbenchExamples}/bin/basic $out/basic/
    cp ${pbenchExamples}/bin/fib $out/basic/
    wrapProgram $out/basic/basic \
        --prefix PATH ":" $out/basic \
        --prefix PATH ":" ${prunTimeout} \
        --prefix PATH ":" ${myTexlive}/bin \
        --prefix PATH ":" ${R}/bin \
        --add-flags "-skip make"
    mkdir -p $out/others
    cp ${pbenchExamples}/bin/other $out/others/
    cp ${pbenchExamples}/bin/*.sh $out/others/
    wrapProgram $out/others/other \
        --prefix PATH ":" $out/others \
        --prefix PATH ":" ${prunTimeout} \
        --prefix PATH ":" ${myTexlive}/bin \
        --prefix PATH ":" ${R}/bin \
        --add-flags "-skip make"
  '';

}

