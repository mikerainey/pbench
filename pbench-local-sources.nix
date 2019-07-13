let pkgs = import <nixpkgs> {}; in

{

  pbenchSrc = ./.;
  pbenchOcamlSrc = ./ocaml;
  prunTimeoutSrc = ./timeout;
  pbenchDocSrc = ./doc;
  pbenchExamplesSrc = ./examples;

}
