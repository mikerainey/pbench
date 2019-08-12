let pkgs = import <nixpkgs> {}; in

let pbenchSrc = pkgs.fetchFromGitHub {
    owner  = "mikerainey";
    repo   = "pbench";
    rev    = "68f05d6d0b86d558d7362d4d40eece4d6ad5498a";
    sha256 = "09p7pfzkldzngqfhdpqmfg8xjq8dp62fq3zv8936r9rx1bqiwwsi";
  };
in

{

  pbenchSrc = pbenchSrc;
  pbenchOcamlSrc = "${pbenchSrc}/ocaml";
  prunTimeoutSrc = "${pbenchSrc}/timeout";
  pbenchDocSrc = "${pbenchSrc}/doc";
  pbenchExamplesSrc = "${pbenchSrc}/examples";
  
}
