debug "Sourcing .profile.d/00-home_bin.sh"

# Add ~/bin and ~/.local/bin to the path, if they exist
add_to_path "$HOME/bin"
add_to_path "$HOME/.local/bin"
