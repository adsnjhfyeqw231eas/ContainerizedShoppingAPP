# verify setup 
#!/bin/bash
java -version
terraform --version
ansible --version
jenkins --version
sudo systemctl status jenkins

# note: [Docker not needed]