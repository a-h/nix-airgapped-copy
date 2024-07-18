#!/bin/bash
nix copy --all --offline --impure --no-check-sigs --from file://$PWD/nix-export/
nix build --offline --impure
cp -rL result/ tmp-result
rm -rf result
mv tmp-result result
