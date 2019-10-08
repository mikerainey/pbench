{ pkgs   ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
  makeWrapper ? pkgs.makeWrapper,
  R ? pkgs.R,
  myTexlive ? pkgs.texlive.combined.scheme-small,
  sources ? import ./local-sources.nix,
  prunTimeout ? import sources.prunTimeout {},
  benchSrc,
  benchDune
}:

stdenv.mkDerivation rec {
  name = "bench";

  src = benchSrc;

  buildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out
    ln -s ${prunTimeout}/prun_timeout $out/
    cp ${benchDune}/bin/bench $out/
    wrapProgram $out/bench \
      --prefix PATH ":" $out \
      --prefix PATH ":" ${myTexlive}/bin \
      --prefix PATH ":" ${R}/bin
  '';

}
