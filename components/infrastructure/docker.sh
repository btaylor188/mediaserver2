#! /bin/bash
echo "Installing Docker"

#### RedHat ####
#sudo yum check-update #> docker.log 2>&1
#curl -fsSL https://get.docker.com/ | sh #> docker.log 2>&1




####  Ubuntu ####  
sudo apt update  #> docker.log 2>&1
sudo apt install \
	curl \
	apt-transport-https \
	ca-certificates \
	gnupg-agent \
	software-properties-common -y  #> docker.log 2>&1
  
# Install Docker
## add GPG key	
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
## Add Repo
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable" -y #> docker.log 2>&1
sudo echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list -y > /dev/null
## Install Docker as service and start
sudo apt update #> docker.log 2>&1
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose -y #> docker.log 2>&1
sudo systemctl enable docker --now #> docker.log 2>&1

