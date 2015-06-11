debug "Sourcing ~/.profile.d/common/nix.sh"

# If we aren't already on NixOS and nixpkgs is installed
if [ ! -e /etc/NIXOS ] && [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
	. $HOME/.nix-profile/etc/profile.d/nix.sh;
fi

