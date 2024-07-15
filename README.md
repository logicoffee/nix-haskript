# nix-haskript

Scripting Haskell with Nix easily!

## Prerequisites

- Nix
- direnv (optional)

## Usage

- Clone this repository.
- Turn on direnv.
    - `direnv allow`
- Add required packages.
- Run.
    - `runghc main.hs`

## Docker

You can dockerize the script.

```
docker build -t haskript .
```
