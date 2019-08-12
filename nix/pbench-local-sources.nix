let pkgs = import <nixpkgs> {}; in

let pbenchSrc = ./.; in

{

  pbenchSrc = pbenchSrc;
  pbenchOcamlSrc = "${pbenchSrc}/ocaml";
  prunTimeoutSrc = "${pbenchSrc}/timeout";
  pbenchDocSrc = "${pbenchSrc}/doc";
  pbenchExamplesSrc = "${pbenchSrc}/examples";

}
