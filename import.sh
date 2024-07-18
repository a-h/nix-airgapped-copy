#!/bin/bash
# Restore the nix store into the airgapped machine.
nix copy --all --offline --impure --no-check-sigs --from file://$PWD/nix-export/
# Demonstrate that it's possible to build the output.
nix build --offline --impure
# The result directory contains symlinks, so they need to be flattened.
cp -rL result/ tmp-result
rm -rf result
mv tmp-result result
