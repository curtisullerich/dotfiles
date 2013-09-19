sudo apt-get -y update
sudo apt-get -y upgrade

#install tlp

sudo apt-get -y install htop vim google-chrome-stable gimp openjdk-6-jdk screen vlc

##########################################################################
#fun
sudo apt-get -y install cowsay fortune sl

##########################################################################
#dropbox, via http://askubuntu.com/questions/126198/how-to-install-dropbox
#Add repository key
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
#Add repository
#TODO update for raring
sudo add-apt-repository -y "deb http://linux.dropbox.com/ubuntu raring main"
#Update your system and install Dropbox
sudo apt-get update && sudo apt-get install nautilus-dropbox

##########################################################################
#sublime text 2
sudo add-apt-repository -y ppa:webupd8team/sublime-text-2
sudo apt-get -y update
sudo apt-get -y install sublime-text

##########################################################################
#jekyll
sudo apt-get -y install ruby1.9.1-full #rubygems might also be required
sudo gem install jekyll nokogiri liquid pygments.rb
####
#audacity
sudo add-apt-repository -y ppa:audacity-team/daily
sudo apt-get -y install audacity

sudo apt-get -y update
sudo apt-get -y upgrade
