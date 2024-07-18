## Tasks

### docker-build

```bash
docker build -t nixpkgs-offline .
```

### flake-export

Run this command to export your flake's inputs, dev shell, and package outputs.

```bash
docker run --rm -v $PWD:/code:Z -w '/code' --entrypoint="/code/export.sh" nixpkgs-offline
```

### flake-import-build

The import script demonstrates how to import the flake's inputs and build the flake.

```bash
docker run --network none --rm -v $PWD:/code:Z -w '/code' --entrypoint="/code/import.sh" nixpkgs-offline
```

### docker-run

To run through the steps manually, we can use the following commands.

Inside the Docker container, we have no Internet connection, but we have mounted the export from the non-airgapped machine to `/code/nix-export`.

First, we need to import all the Nix store paths with:

`nix copy --all --offline --impure --no-check-sigs --from file://$PWD/nix-export/`

Then, we can build or run the custom flake by `cd /code` and `nix build`, or enter the dev tools with `nix develop`.

```bash
docker run -it --rm --network none -v $PWD:/code:Z -w '/code' nixpkgs-offline
```

