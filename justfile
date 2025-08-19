SOPS_FILE := "secrets.yaml"

# default recipe to display help information
default:
  @just --list

deploy USER HOST:
    scripts/deploy.sh -u {{USER}} -h {{HOST}}

deploy-xucxich: 
    just deploy xucxich 192.168.0.133 

deploy-chabo: 
    just deploy chabo 192.168.0.134

rebuild-pre:
  just update-nix-secrets
  git add *.nix

rebuild-post:
  just check-sops

rebuild-simple:
  scripts/system-flake-rebuild.sh

# Requires sops to be running and you must have reboot after inital rebuild
rebuild-full:
  just rebuild-pre
  scripts/system-flake-rebuild.sh
  just rebuild-post

# Requires sops to be running and you must have reboot after inital rebuild
rebuild-trace:
  just rebuild-pre
  scripts/system-flake-rebuild-trace.sh
  just rebuild-post

update:
  nix flake update

rebuild-darwin:
  zsh ./scripts/nix-rebuild.sh

rm-rebuild-darwin:
  sudo nix run nix-darwin/nix-darwin-25.05#darwin-rebuild -- \
    --option extra-substituters https://install.determinate.systems \
    --option extra-trusted-public-keys cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM= \
    --build-host xucxich@192.168.0.133\
    switch --flake \
    .#imbp --impure --fallback --show-trace

rebuild-update:
  just update
  just rebuild

diff:
  git diff ':!flake.lock'

sops:
  echo "Editing {{SOPS_FILE}}"
  nix-shell -p sops --run "SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt sops {{SOPS_FILE}}"

age-key:
  nix-shell -p age --run "age-keygen"

rekey:
  cd ../nix-secrets && (\
    sops updatekeys -y secrets.yaml && \
    (pre-commit run --all-files || true) && \
    git add -u && (git commit -m "chore: rekey" || true) && git push \
  )
check-sops:
  scripts/check-sops.sh

update-nix-secrets:
  (cd ../nix-secrets && git fetch && git rebase) || true
  nix flake lock --update-input nix-secrets

iso:
  # If we dont remove this folder, libvirtd VM doesnt run with the new iso...
  rm -rf result
  nix build ./nixos-installer#nixosConfigurations.iso.config.system.build.isoImage

iso-install DRIVE:
  just iso
  sudo dd if=$(eza --sort changed result/iso/*.iso | tail -n1) of={{DRIVE}} bs=4M status=progress oflag=sync

disko DRIVE PASSWORD:
  echo "{{PASSWORD}}" > /tmp/disko-password
  sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- \
    --mode disko \
    disks/btrfs-luks-impermanence-disko.nix \
    --arg disk '"{{DRIVE}}"' \
    --arg password '"{{PASSWORD}}"'
  rm /tmp/disko-password

sync USER HOST:
  rsync -av --filter=':- .gitignore' -e "ssh -l {{USER}}" . {{USER}}@{{HOST}}:nix-config/

sync-secrets USER HOST:
  rsync -av --filter=':- .gitignore' -e "ssh -l {{USER}}" . {{USER}}@{{HOST}}:nix-secrets/
