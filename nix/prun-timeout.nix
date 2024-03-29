{ pkgs   ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
  prunTimeoutSrc ? ../timeout,
  gcc ? pkgs.gcc
}:

stdenv.mkDerivation rec {
  name = "prun-timeout";

  src = prunTimeoutSrc;

  buildInputs =  [ gcc ];

  installPhase = ''
    mkdir -p $out
    cp prun_timeout $out/
  '';

}
