{ pkgs   ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
  makeWrapper ? pkgs.makeWrapper,
  R ? pkgs.R,
  myTexlive ? pkgs.texlive.combined.scheme-small,
  sources ? import ./local-sources.nix,
  prunTimeout ? import sources.prunTimeout {},
  benchSrc,
  bench
}:

stdenv.mkDerivation rec {
  name = "pbench-custom";

  src = benchSrc;

  buildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out
    ln -s ${prunTimeout}/prun_timeout $out/
    cp ${bench} $out/bench
    wrapProgram $out/bench \
      --prefix PATH ":" $out \
      --prefix PATH ":" ${myTexlive}/bin \
      --prefix PATH ":" ${R}/bin
  '';

}
