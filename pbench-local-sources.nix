let pkgs = import <nixpkgs> {}; in

{

  pbenchSrc = ./.;
  pbenchOcamlSrc = ./ocaml;
  pbenchTimeoutSrc = ./timeout;
  pbenchExamplesSrc = ./examples;
  pbenchDocSrc = ./doc;

}
