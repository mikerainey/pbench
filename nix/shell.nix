{ pkgs   ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
  pbench ? import ./default.nix { pkgs = pkgs; }
}:
  
stdenv.mkDerivation {
  name = "pbench-shell";
  buildInputs = [ pbench ];
  shellHook = ''
    export PBENCH_PATH=${pbench}
    export PBENCH_EXAMPLES_PATH=$PBENCH_PATH/examples
    export PBENCH_DOC_PATH=$PBENCH_PATH/share/doc/
    export PATH=$PBENCH_PATH:$PATH
  '';
}
