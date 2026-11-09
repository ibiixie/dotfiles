shell := "fish"

[group('rebuild')]
switch host:
    sudo nixos-rebuild switch --flake .#{{host}}

[group('rebuild')]
test host:
    sudo nixos-rebuild test --flake .#{{host}}

[group('flake')]
check:
    nix flake check

[group('flake')]
update *input:
    nix flake update {{input}}

[group('develop')]
dev:
    nix develop -c {{shell}}

[group('util')]
clean:
    sudo nh clean all
    nix store optimise
