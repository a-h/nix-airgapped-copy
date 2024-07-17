## Tasks

### docker-build

```bash
docker build -t nixpkgs-offline .
```

### flake-export

Run this command to export your flake's inputs (`nix flake archive`), dev shells (`nix copy --derivation`) and the package outputs (`nix copy`).

The path output on a Linux x86-64 machine is: /nix/store/gd59r1b49isi9pxi5q5hiy67bvk385h8-hello-nix-build

Dir: ./example-flake

```bash
nix flake archive .# --to file://$PWD/export/
nix copy .# --derivation --to file://$PWD/export
nix copy .# --to file://$PWD/export
echo "Note the path."
nix path-info ".#"
```

### docker-run

Inside the Docker container, we have no Internet connection, but we have mounted the export from the non-airgapped machine.

First, we need to import all the Nix store paths with:

`nix copy --all --from file:///example-flake/export --no-check-sigs --verbose`

Then, we can build or run the custom flake by `cd /example-flake` and `nix build`.

```bash
docker run -it --rm --network none -v $PWD/example-flake:/example-flake nixpkgs-offline
```

