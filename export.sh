#!/bin/bash
# Build everything you want to transfer across the airgap.
nix develop
nix build
nix build .#docker-image
# Copy the whole of the local store to the export directory.
# The local store was populated by executing the builds.
nix copy --derivation --all --impure --to file://$PWD/nix-export/
# Copy the flake archive to the export directory.
nix flake archive --to file://$PWD/nix-export/
