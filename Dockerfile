# This is based on the following article
# https://mitchellh.com/writing/nix-with-dockerfiles

FROM nixos/nix:latest AS builder

COPY . /tmp/build
WORKDIR /tmp/build

RUN nix \
    --extra-experimental-features "nix-command flakes" \
    --option filter-syscalls false \
    build

RUN mkdir /tmp/nix-store
RUN cp -R $(nix-store -qR result/) /tmp/nix-store


FROM scratch

WORKDIR /app

COPY --from=builder /tmp/nix-store /nix/store
COPY --from=builder /tmp/build/result /app
CMD ["/app/bin/main"]
