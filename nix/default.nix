{ pkgs   ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
  gcc ? pkgs.gcc,
  R ? pkgs.R,
  myTexlive ? pkgs.texlive.combined.scheme-small,
  makeWrapper ? pkgs.makeWrapper,
  pandoc ? pkgs.pandoc,
  sources ? import ./local-sources.nix,
  prunTimeout ? import sources.prunTimeout {},
  pbenchOcaml ? import sources.pbenchOcaml { pkgs = pkgs; stdenv = stdenv;
                                             pbenchOcamlSrc = sources.pbenchOcamlSrc; }
}:

let pbenchDoc =
      stdenv.mkDerivation rec {
        name = "pbench-doc";
        
        src = "${sources.pbenchSrc}/doc";
        
        buildInputs = [ pandoc myTexlive ];
        
        installPhase = ''
          mkdir -p $out
          cp *.html *.pdf *.md $out
          '';
      };
in

stdenv.mkDerivation rec {
  name = "pbench";

  src = sources.pbenchSrc;

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
