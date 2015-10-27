#!/usr/bin/env bash

dd if=/dev/zero of=/swapfile bs=1024 count=1048576
/sbin/mkswap /swapfile
/sbin/swapon /swapfile
echo '/swapfile swap swap defaults 0 0' >> /etc/fstab

apt-get update
apt-get install -y python-software-properties build-essential m4
add-apt-repository ppa:avsm/ppa
apt-get update
apt-get install -y ocaml ocaml-native-compilers camlp4 camlp4-extra opam git libssl-dev vim aspcud libgmp-dev libffi-dev
opam update
opam switch 4.02.3
eval $(opam config env)
opam pin add cohttp -k git 'https://github.com/rgrinberg/ocaml-cohttp#optionalize_uri'

cat > /etc/motd.tail <<'EOF'
               ,,__
     ..  ..   / o._)   ___   ____                _ 
    /--'/--\  \-'||   / _ \ / ___|__ _ _ __ ___ | |
   /        \_/ / |  | | | | |   / _` | '_ ` _ \| |
 .'\  \__\  __.'.'   | |_| | |__| (_| | | | | | | |
   )\ |  )\ |         \___/ \____\__,_|_| |_| |_|_|
  // \\ // \\
 ||_  \\|_  \\_    -- two humps are better than one
 '--' '--'' '--'    

Run 'utop' to get started with an interactive console.
Documentation is available at http://localhost:8000/
EOF

run-parts /etc/update-motd.d/
