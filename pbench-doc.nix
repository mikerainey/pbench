{ pkgs   ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
  pandoc ? pkgs.pandoc,
  myTexlive ? pkgs.texlive.combined.scheme-small
}:

stdenv.mkDerivation rec {
  name = "pbench-doc";

  src = ./doc;

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
