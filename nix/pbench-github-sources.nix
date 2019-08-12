let pkgs = import <nixpkgs> {}; in

let pbenchSrc = pkgs.fetchFromGitHub {
    owner  = "mikerainey";
    repo   = "pbench";
    rev    = "14cd6a256b72f22f58d3ea6b25a7f86812fc5ab5";
    sha256 = "1sbz9z0g9df9mgi751xkbc5bqglvkqccrk0bj2kdxsa122kis96g";
  };
in

{

  pbenchSrc = pbenchSrc;
  pbenchOcamlSrc = "${pbenchSrc}/ocaml";
  prunTimeoutSrc = "${pbenchSrc}/timeout";
  pbenchDocSrc = "${pbenchSrc}/doc";
  pbenchExamplesSrc = "${pbenchSrc}/examples";
  
}
