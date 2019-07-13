{ pkgs   ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
  sources ? import ./pbench-local-sources.nix,
  gcc ? pkgs.gcc,
  R ? pkgs.R,
  myTexlive ? pkgs.texlive.combined.scheme-small,
  makeWrapper ? pkgs.makeWrapper
}:

let

  callPackage = pkgs.lib.callPackageWith (pkgs // sources // self);

  self = {

    pkgs = pkgs;
    buildDunePackage = pkgs.ocamlPackages.buildDunePackage;
    myTexlive = myTexlive;
    gcc = gcc;
    R = R;
    makeWrapper = makeWrapper;

    pbenchOcaml = callPackage "${sources.pbenchSrc}/pbench-ocaml.nix" { };
    prunTimeout = callPackage "${sources.pbenchSrc}/prun-timeout.nix" { };
    pbenchDoc = callPackage "${sources.pbenchSrc}/pbench-doc.nix" { };
    pbench = callPackage "${sources.pbenchSrc}/pbench.nix" { };
    
  };

in

with self;

let     pbenchExamples = callPackage "${sources.pbenchSrc}/pbench-examples.nix" { };
in

stdenv.mkDerivation rec {
  name = "pbench-default";

  src = sources.pbenchSrc;

  buildInputs = [ makeWrapper ];

  dontBuild = true;
  
  installPhase = ''
    mkdir -p $out
    cp -r ${pbench}/* $out

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
  '';

}
