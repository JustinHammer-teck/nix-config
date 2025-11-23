SOPS_FILE := "secrets.yaml"

# default recipe to display help information
default:
    @just --list

rebuild-pre:
    just update-nix-secrets
    git add *.nix

rebuild-post:
    just check-sops

update:
    nix flake update

deploy $host $user:
    bash ./scripts/deploy.sh host={{ host }} user={{ user }}

rebuild-darwin:
    zsh ./scripts/darwin-rebuild.sh

rebuild $host *ARG:
    bash ./scripts/nixos-rebuild.sh {{ host }} {{ ARG }}

rebuild-update $host:
    just update
    just rebuild  {{ host }}

# Utils
clean:
    nix-collect-garbage --delete-older-than 7d

diff:
    git diff ':!flake.lock'

sops:
    echo "Editing {{ SOPS_FILE }}"
    nix-shell -p sops --run "SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt sops {{ SOPS_FILE }}"

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
    sudo dd if=$(eza --sort changed result/iso/*.iso | tail -n1) of={{ DRIVE }} bs=4M status=progress oflag=sync

disko DRIVE PASSWORD:
    echo "{{ PASSWORD }}" > /tmp/disko-password
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- \
      --mode disko \
      disks/btrfs-luks-impermanence-disko.nix \
      --arg disk '"{{ DRIVE }}"' \
      --arg password '"{{ PASSWORD }}"'
    rm /tmp/disko-password

sync USER HOST:
    rsync -av --filter=':- .gitignore' -e "ssh -l {{ USER }}" . {{ USER }}@{{ HOST }}:nix-config/

sync-secrets USER HOST:
    rsync -av --filter=':- .gitignore' -e "ssh -l {{ USER }}" . {{ USER }}@{{ HOST }}:nix-secrets/
