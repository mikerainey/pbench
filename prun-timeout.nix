{ pkgs   ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
  gcc ? pkgs.gcc,
}:

stdenv.mkDerivation rec {
  name = "prun-timeout";

  src = ./prun_timeout;

  buildInputs =  [ gcc ];

  installPhase = ''
    mkdir -p $out
    cp prun_timeout $out/
  '';

}
