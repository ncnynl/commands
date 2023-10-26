
sudo cat > var-run-sdp.path <<_EOF_
########################################
/etc/systemd/system/var-run-sdp.path
########################################

[Unit]
Descrption=Monitor /var/run/sdp

[Install]
WantedBy=bluetooth.service

[Path]
PathExists=/var/run/sdp
Unit=var-run-sdp.service
_EOF_


sudo cat > var-run-sdp.service <<_EOF_
########################################
/etc/systemd/system/var-run-sdp.service:
########################################

[Unit]
Description=Set permission of /var/run/sdp

[Install]
RequiredBy=var-run-sdp.path

[Service]
Type=simple
ExecStart=/bin/chgrp bluetooth /var/run/sdp
_EOF_