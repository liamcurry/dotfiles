# Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"

# Install developer stuff
brew install nginx dnsmasq python readline ack ffmpeg rabbitmq node mongo mysql

# Install npm
curl http://npmjs.org/install.sh | sh

# Make a symlink for dnsmasq.conf
ln -s $HOME/misc/dnsmasq.conf /usr/local/etc/dnsmasq.conf

# Install ls++
cpan Term::ExtendedColor
git clone git://github.com/trapd00r/ls--.git
cd ls--
perl Makefile.PL
make && sudo 'make install'
