#! /bin/bash
####### Define Variables ######
echo "What is the domain name?"
read DOMAINNAME

echo "Enter path for Docker data.  ie. /mnt/docker"
read DOCKERPATH
sudo mkdir $DOCKERPATH

echo "Enter your Google OAuth Client ID"
read OAUTHCLIENT

echo "Enter your Google OAuth Secret"
read OAUTHSECRET

echo "Enter comma separated list of authorized users.  ie. user1@gmail.com,user2@gmail.com,"
read AUTHORIZEDUSERS

echo "Enter Certificate Contact Email Address"
read CERTCONTACT

echo "Enter path for Plex Media"
read MEDIAPATH 
sudo mkdir $MEDIAPATH

echo "Enter Claim token from plex.tv/claim"
read PLEXCLAIM

echo "PIA VPN Username"
read PIAUSER

echo "PIA VPN Password"
read PIAPASS

echo "Enter Local Network in CIDR Notation"
read LOCALNET

##Generate Secret Key
SECRETKEY=$(hexdump -n 16 -e '4/4 "%08X" 1 "\n"' /dev/random)

export DOMAINNAME=$DOMAINNAME
export DOCKERPATH=$DOCKERPATH
export OAUTHCLIENT=$OAUTHCLIENT
export OAUTHSECRET=$OAUTHSECRET
export AUTHORIZEDUSERS=$AUTHORIZEDUSERS
export CERTCONTACT=$CERTCONTACT
export SECRETKEY=$SECRETKEY
export MEDIAPATH=$MEDIAPATH
export PLEXCLAIM=$PLEXCLAIM
export PIAUSER=$PIAUSER
export PIAPASS=$PIAPASS
export LOCALNET=$LOCALNET

#sudo rm ./frontend/.env
#sudo rm ./backend/.env
#sudo rm ./infrastructure/.env
cat > ./frontend/.env << EOF1
DOMAINNAME=$DOMAINNAME
DOCKERPATH=$DOCKERPATH
OAUTHCLIENT=$OAUTHCLIENT
OAUTHSECRET=$OAUTHSECRET
AUTHORIZEDUSERS=$AUTHORIZEDUSERS
CERTCONTACT=$CERTCONTACT
SECRETKEY=$SECRETKEY
MEDIAPATH=$MEDIAPATH
PLEXCLAIM=$PLEXCLAIM
PIAUSER=$PIAUSER
PIAPASS=$PIAPASS
LOCALNET=$LOCALNET
EOF1

cat > ./backend/.env << EOF1
DOMAINNAME=$DOMAINNAME
DOCKERPATH=$DOCKERPATH
OAUTHCLIENT=$OAUTHCLIENT
OAUTHSECRET=$OAUTHSECRET
AUTHORIZEDUSERS=$AUTHORIZEDUSERS
CERTCONTACT=$CERTCONTACT
SECRETKEY=$SECRETKEY
MEDIAPATH=$MEDIAPATH
PLEXCLAIM=$PLEXCLAIM
PIAUSER=$PIAUSER
PIAPASS=$PIAPASS
LOCALNET=$LOCALNET
EOF1

cat > ./infrastructure/.env << EOF1
DOMAINNAME=$DOMAINNAME
DOCKERPATH=$DOCKERPATH
OAUTHCLIENT=$OAUTHCLIENT
OAUTHSECRET=$OAUTHSECRET
AUTHORIZEDUSERS=$AUTHORIZEDUSERS
CERTCONTACT=$CERTCONTACT
SECRETKEY=$SECRETKEY
MEDIAPATH=$MEDIAPATH
PLEXCLAIM=$PLEXCLAIM
PIAUSER=$PIAUSER
PIAPASS=$PIAPASS
LOCALNET=$LOCALNET
EOF1

###############################

##########   Docker ###########
sh ./docker.sh
###############################

########.Create Docker Networks .#######
sudo docker network create -d bridge --subnet=172.19.0.0/24 internal 
sudo docker network create -d bridge --subnet=172.20.0.0/24 external
###############################

##########   Traefik Configure ###########
sh ./traefik.sh
########################################

#########.Install Components.####
sudo docker-compose -f ./infrastructure/docker-compose.yaml up -data
sudo docker-compose -f ./frontend/docker-compose.yaml up -data
sudo docker-compose -f ./backend/docker-compose.yaml up -data
sudo rm ./frontend/.env
sudo rm ./backend/.env
sudo rm ./infrastructure/.env