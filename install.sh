# Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"

# Install developer stuff
brew install nginx dnsmasq python readline ack ffmpeg rabbitmq node mongo mysql libksba

# Install npm
curl http://npmjs.org/install.sh | sh

# Install pip
easy_install pip

# Install rvm
bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)
rvm install 1.9.3
rvm system ; rvm gemset export system.gems ; rvm 1.9.3 ; rvm gemset import system.gems
rvm alias create default 1.9.3

# Make a symlink for dnsmasq.conf
ln -s $HOME/misc/dnsmasq.conf /usr/local/etc/dnsmasq.conf

# Install ls++
cpan Term::ExtendedColor
git clone git://github.com/trapd00r/ls--.git
cd ls--
perl Makefile.PL
make && sudo 'make install'

# Install Python requirements
pip install flake8 virtualenv

# Install Node.js requirements
npm install coffee-script uglify-js

# Install Ruby requirements
gem install rake compass watchr rb-inotify jekyll lunchy

