let pkgs = import <nixpkgs> {}; in

let pbenchSrc = pkgs.fetchFromGitHub {
      owner  = "mikerainey";
      repo   = "pbench";
      rev    = "4cc46abdb3ae95f2b9355fe29fd9a932f0b5e647";
      sha256 = "100rp8nsrs2a9xixc2pkvv546xpi010wii2vr6dmkgfrdgj4jin4";
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
