# assumes that these aliases exist: update, upgrade, install
update
upgrade

# antibody and zsh setup
mkdir ~/bin
curl -sfL git.io/antibody | sh -s - -b ~/bin
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh

install htop vim google-chrome-stable gimp vlc byobu feh

##########################################################################
#fun
install cowsay fortune sl

##########################################################################
#dropbox, via http://askubuntu.com/questions/126198/how-to-install-dropbox
#Add repository key
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
#Add repository
#TODO update for raring
sudo add-apt-repository -y "deb http://linux.dropbox.com/ubuntu raring main"
#Update your system and install Dropbox
sudo apt update && sudo apt install nautilus-dropbox

##########################################################################
#jekyll
install ruby1.9.1-full #rubygems might also be required
sudo gem install jekyll nokogiri liquid pygments.rb
####
#audacity
sudo add-apt-repository -y ppa:audacity-team/daily
install audacity

update
upgrade
