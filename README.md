# dirtyisp
A tool to obfuscate internet history by visiting many random websites.

Required packages:
bash
lynx

Steps for use:
1) download files
2) place dirtyisp.bash in a directory of your choosing (options default to /scripts/)
3) edit dirtyisp.bash configuration section to match your needs.
4) point dirtyisp.bash at a seed_list file, a sample file is included.
5) run dirtyisp.bash

steps for having always running daemon (on systemd):
1) place the dirtyisp.service file in /etc/systemd/system
2) edit dirtyisp.service to point to your script location
3) as root/sudo, run "systemctl enable dirtyisp"
4) as root/sudo, run "systemctl start dirtyisp"

This script has tested on a raspberry pi 1B, 2, and 3, and was able to perform well on all three.
