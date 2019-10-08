let pbenchSrc = ../.;
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
