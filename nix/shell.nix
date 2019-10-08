{ pkgs   ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
  sources ? import ./local-sources.nix,
  pbench ? import sources.pbench { pkgs = pkgs; }
}:
  
stdenv.mkDerivation {
  name = "pbench-shell";
  buildInputs = [ pbench ];
  shellHook = ''
    export PBENCH_PATH=${pbench}
    export PATH=$PBENCH_PATH:$PATH
  '';
}
