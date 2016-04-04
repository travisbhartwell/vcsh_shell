debug "Sourcing ~/.shellrc.d/00-functions.sh"

# Useful functions for use at the command line
show_my_ip () {
    # I care about the ip of the interface that has my default route
    iface=$(route -n | grep "^0.0.0.0" | awk '{print $NF}')

    # Copied from http://stackoverflow.com/questions/13322485/how-to-i-get-the-primary-ip-address-of-the-local-machine-on-linux-and-os-x/22632822#22632822
    ip=$(ip -4 -o addr show dev $iface| awk '{split($4,a,"/");print a[1]}')

    echo "My IP is: $ip"
}

serve_this_directory () {
    show_my_ip

    cmd="twistd --pidfile /tmp/twistd.pid -n web --path . --port 8888"

    # Am I on Nix?
    if [ -n "${NIXPKGS_CONFIG}" ]; then
        nix-shell -p twisted --command "$cmd"
    else
        ${cmd}
    fi
}

serve_this_directory_localhost () {
    show_my_ip

    cmd="twistd --pidfile /tmp/twistd.pid -n web --path . --port tcp:8888:interface=127.0.0.1"

    # Am I on Nix?
    if [ -n "${NIXPKGS_CONFIG}" ]; then
        nix-shell -p twisted --command "$cmd"
    else
        ${cmd}
    fi
}
