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
docker run --network none --rm -v $PWD:/code:Z -w '/code' --entrypoint="/code/import.sh" nixpkgs-offline
```

### docker-run

Inside the Docker container, we have no Internet connection, but we have mounted the export from the non-airgapped machine.

First, we need to import all the Nix store paths with:

`nix copy --all --offline --impure --no-check-sigs --from file://$PWD/nix-export/`

Then, we can build or run the custom flake by `cd /code` and `nix build`, or enter the dev tools with `nix develop`.

```bash
docker run -it --rm --network none -v $PWD:/code:Z -w '/code' nixpkgs-offline
```

