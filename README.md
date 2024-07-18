## Tasks

### docker-build

```bash
docker build -t nixpkgs-offline .
```

### flake-export

Run this command to export your flake's inputs (`nix flake archive`), dev shells (`nix copy --derivation`) and the package outputs (`nix copy`).

The path output on a Linux x86-64 machine is: /nix/store/r65a96c8qnj386n89n92v8p4bglszha1-app

```bash
docker run --rm -v $PWD:/code:Z -w '/code' --entrypoint="/code/export.sh" nixpkgs-offline
```

### flake-import-build

```bash
docker run --rm -v $PWD:/code:Z -w '/code' --entrypoint="/code/import.sh" nixpkgs-offline
```

## Notes

# nix flake archive --to file://$PWD/export/
nix develop --store file://$PWD/export/
#nix copy --impure --to file://$PWD/export/
#nix copy --impure --derivation --to file://$PWD/export/
nix build .# --store file://$PWD/export/
echo "Note the path."
nix path-info ".#"
# Copy the list of nar files.
#grep StorePath export/*.narinfo | awk '{print $2}' > export/nix-export.txt

### docker-run

Inside the Docker container, we have no Internet connection, but we have mounted the export from the non-airgapped machine.

First, we need to import all the Nix store paths with:

`nix copy --offline --impure --from file:///code/export/ --no-check-sigs --verbose`

Then, we can build or run the custom flake by `cd /code` and `nix build`, or enter the dev tools with `nix develop`.

```bash
docker run -it --rm --network none -v $PWD/code:/code nixpkgs-offline
```

