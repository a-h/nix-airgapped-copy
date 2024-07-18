#!/bin/bash
nix copy --all --offline --impure  --no-check-sigs --from file://$PWD/nix-export/
nix build --offline --impure
