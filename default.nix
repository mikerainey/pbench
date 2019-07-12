{ pkgs   ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
  ocamlPbench ? import ./ocaml-pbench.nix { buildDunePackage = pkgs.ocamlPackages.buildDunePackage; },
  gcc ? pkgs.gcc,
  R ? pkgs.R,
  myTexlive ? pkgs.texlive.combined.scheme-small,
  makeWrapper ? pkgs.makeWrapper
}:

stdenv.mkDerivation rec {
  name = "pbench";

  src = ./.;

  buildInputs =
    [ gcc R myTexlive makeWrapper ocamlPbench ];

  installPhase = ''
    mkdir -p $out
  
    cp prun_timeout $out

    cp ${ocamlPbench}/bin/prun $out/prun

    cp ${ocamlPbench}/bin/pplot $out/pplot
    wrapProgram $out/pplot \
        --prefix PATH ":" ${myTexlive}/bin \
        --prefix PATH ":" ${R}/bin
  '';

  meta = {
    description = "Parallel algorithm benchmarking toolkit.";
    license = "MIT";
    homepage = http://deepsea.inria.fr/pbench/;
  };

}
