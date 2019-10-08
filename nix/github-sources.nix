let pkgs = import <nixpkgs> {}; in

let pbenchSrc = pkgs.fetchFromGitHub {
    owner  = "mikerainey";
    repo   = "pbench";
    rev    = "68f05d6d0b86d558d7362d4d40eece4d6ad5498a";
    sha256 = "09p7pfzkldzngqfhdpqmfg8xjq8dp62fq3zv8936r9rx1bqiwwsi";
  };
in

let
  pbenchOcamlSrc = "${pbenchSrc}/ocaml";
  prunTimeoutSrc = "${pbenchSrc}/timeout";
  pbenchExamplesSrc = "${pbenchSrc}/examples";
in  

{
  pbenchSrc = pbenchSrc;
  pbenchOcamlSrc = pbenchOcamlSrc;
  prunTimeoutSrc = prunTimeoutSrc;
  pbenchExamplesSrc = pbenchExamplesSrc;

  pbench = "${pbenchSrc}/nix/default.nix";
  pbenchOcaml = "${pbenchSrc}/nix/pbench-ocaml.nix";
  prunTimeout = "${pbenchSrc}/nix/prun-timeout.nix";
  pbenchCustom = "${pbenchSrc}/nix/custom.nix";  
}
