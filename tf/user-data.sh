#!/bin/bash
sudo apt update -y
sudo apt install docker.io -y
sudo usermod -aG docker ubuntu
sudo mkdir /home/ubuntu/.ssh
sudo echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDa5d8BNhyq5ZIs9O7jJGrh/wK3RrOxCacICXDrlNWAdTnIYKwh5urU+PQouL0O+GqhVYwaxs610mB4XslpGceoNMY7e4G/sPkugHY/9M598pGv2u/srHC5tGZcO1J5FxIUCW4uVCz216NU+Y1Ya2uh7Z8LtSAksNiDl31GrlSlt2dDaTbpfyOmWF3oszMmNELF+oNuybPM1RFQkEX60fbPVmRlrkAG1p+9Sdi8zjtc2jD4Lp3ZlMoyUvwBfamzMUYyYh0QECJ1kZ/3iIYH/7eVeT9sIn0Q+Sr9S5PlL6gp7goSn3l1iQkTi/eWaeW/KhBlam17PbhoLTaYXWK2jEtDNY/rrvCoCfcipVHGrSsYdWiOgx768V7F0NsmAtSxP83zr4vR3uxog5CCeNdZBecv+Xg5IDMBaNciwEZQd4O3ehX2tlG/ASXhfqZPsyLC4QAiON6QbM0wD7oSFMjJCAtiMaDajNAPii1pP7hyz30NZeuJYLRrKdTRqywQRFfbXkM= jenkins@ip-172-31-57-10" >> /home/ubuntu/.ssh/authorized_keys
