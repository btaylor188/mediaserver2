#! /bin/bash 

#Install Plex
echo" Installing Plex"
echo "###############################################################"
echo "### Nvidia Hardware Transcoding Requires additional scripts ###"
echo "### located in the addons folder. #############################"
echo "###############################################################"
echo "Enter path for Plex Media"
read MEDIAPATH 
sudo mkdir $MEDIAPATH > plex.log 2>&1
echo "Enter Claim token from plex.tv/claim"
read PLEXCLAIM

cat > ./components/.env << EOF1
MEDIAPATH=$MEDIAPATH
PLEXCLAIM=$PLEXCLAIM

EOF1
