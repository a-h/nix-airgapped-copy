#!/bin/bash
# Restore the nix store into the airgapped machine.
nix copy --all --offline --impure --no-check-sigs --from file://$PWD/nix-export/
# Demonstrate that it's possible to build the output.
# Use --no-link to avoid symlinks to the store that's in the Docker container.
nix build --offline --impure --out-link ./result-tmp
# Move the result to the final location.
cp -rL ./result-tmp ./result
# Clean up the temporary result.
rm -rf ./result-tmp
