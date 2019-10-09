{ pkgs   ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
  buildDunePackage ? pkgs.ocamlPackages.buildDunePackage,
  makeWrapper ? pkgs.makeWrapper,
  R ? pkgs.R,
  myTexlive ? pkgs.texlive.combined.scheme-small,
  sources ? import ./local-sources.nix,
  prunTimeout ? import sources.prunTimeout {},
  pbenchOcaml ? import sources.pbenchOcaml { buildDunePackage = buildDunePackage;
                                             pbenchOcamlSrc = sources.pbenchOcamlSrc; }
}:

let pbenchOcamlExamples =
      buildDunePackage rec {
        pname = "pbench-examples";
        version = "1.0";
        src = sources.pbenchExamplesSrc;
        buildInputs = [ pbenchOcaml ];
      };
in

let basic = import sources.pbenchCustom {
                   benchSrc = sources.pbenchExamplesSrc;
                   bench = "${pbenchOcamlExamples}/bin/basic"; };
    others = import sources.pbenchCustom {
                   benchSrc = sources.pbenchExamplesSrc;
                   bench = "${pbenchOcamlExamples}/bin/other"; };
in

stdenv.mkDerivation rec {
  name = "pbench-examples-full";

  src = sources.pbenchExamplesSrc;

  buildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/basic
    cp ${pbenchOcamlExamples}/bin/fib $out/basic/
    cp ${basic}/bench $out/basic/basic
    wrapProgram $out/basic/basic \
        --prefix PATH ":" $out/basic \
        --add-flags "-skip make"
    mkdir -p $out/others
    cp ${pbenchOcamlExamples}/bin/*.sh $out/others/
    cp ${others}/bench $out/others/other
    wrapProgram $out/others/other \
        --prefix PATH ":" $out/others \
        --add-flags "-skip make"
  '';

}

