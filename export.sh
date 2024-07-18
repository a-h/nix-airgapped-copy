#!/bin/bash
nix develop
nix build
nix copy --derivation --all --impure --to file://$PWD/nix-export/
grep StorePath nix-export/*.narinfo | awk '{print $2}' > nix-export.txt
cat nix-export.txt | wc -l
nix flake archive --to file://$PWD/nix-export/
grep StorePath nix-export/*.narinfo | awk '{print $2}' >> nix-export.txt
cat nix-export.txt | wc -l
