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

sudo rm ./components/.env
cat > ./components/.env << EOF1
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
while true; do
    read -p "Install Docker?" yn
    case $yn in
        [Yy]* ) sh ./components/docker.sh ; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

###############################
sudo docker network create -d bridge --subnet=172.19.0.0/24 internal 
sudo docker network create -d bridge --subnet=172.20.0.0/24 external
######### Watchtower #############
docker-compose -f ./components/watchtower.yaml up -d

###############################

######### Portainer #############

while true; do
    read -p "Install Portainer?" yn
    case $yn in
        [Yy]* ) docker-compose -f ./components/portainer.yaml up -d ; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done


###############################

######### Traefik #############

while true; do
    read -p "Install Traefik?" yn
    case $yn in
        [Yy]* ) sh ./components/traefik.sh ; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

###############################






######### Netdata #############

while true; do
    read -p "Install Netdata?" yn
    case $yn in
        [Yy]* ) docker-compose -f ./components/netdata.yaml up -d ; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

###############################

######### Plex #############

while true; do
    read -p "Install Plex?" yn
    case $yn in
        [Yy]* ) docker-compose -f ./components/plex.yaml up -d ; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

###############################

######### NZBGet ##############

while true; do
    read -p "Install NZBGet?" yn
    case $yn in
        [Yy]* ) docker-compose -f ./components/nzbget.yaml up -d  ; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

###############################




######### Sonar ###############

while true; do
    read -p "Install Sonarr?" yn
    case $yn in
        [Yy]* ) docker-compose -f ./components/sonarr.yaml up -d ; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

###############################

######### Radarr ##############

while true; do
    read -p "Install Radarr?" yn
    case $yn in
        [Yy]* )docker-compose -f ./components/radarr.yaml up -d ; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

###############################

######### Bazarr ##############

while true; do
    read -p "Install Bazarr?" yn
    case $yn in
        [Yy]* ) docker-compose -f ./components/bazarr.yaml up -d  ; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

###############################



###### Overseerr #########

while true; do
    read -p "Install Overseerr?" yn
    case $yn in
        [Yy]* ) docker-compose -f ./components/overseerr.yaml up -d  ; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

###############################

######## Speedtest ############

while true; do
    read -p "Install Speedtest?" yn
    case $yn in
        [Yy]* ) docker-compose -f ./components/speedtest.yaml up -d  ; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

###############################


######### Tdarr #############

while true; do
    read -p "Install Tdarr?" yn
    case $yn in
        [Yy]* ) docker-compose -f ./components/tdarr.yaml up -d ; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

rm ./components/.env
###############################

echo "############################"
echo "#######   All Done   #######"
echo "############################"
