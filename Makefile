all: link

install: update-local setup-nvm setup-rbenv link
update: update-local update-nvm  update-rbenv link

# Local

update-local:
	git pull --rebase || (git stash && git pull --rebase && git stash pop)

link:
		ln -hfsv $(PWD)/bashrc        $(HOME)/.bashrc
		ln -hfsv $(PWD)/gitconfig     $(HOME)/.gitconfig
		ln -hfsv $(PWD)/gitignore     $(HOME)/.gitignore
		ln -hfsv $(PWD)/gitcompletion $(HOME)/.gitcompletion
		ln -hfsv $(PWD)/gemrc         $(HOME)/.gemrc
		ln -hfsv $(PWD)/irbrc         $(HOME)/.irbrc

# nvm
#
# https://github.com/creationix/nvm

setup-nvm:
	install-nvm
install-nvm:
	git clone -- git://github.com/creationix/nvm.git $(HOME)/.nvm
update-nvm:
	cd $(HOME)/.nvm && git pull origin master
uninstall-nvm:
	rm -fR $(HOME)/.nvm

# rbenv
#
# https://github.com/sstephenson/rbenv

setup-rbenv:
	install-rbenv \
	install-rbenv-plugins
install-rbenv:
	git clone -- git://github.com/sstephenson/rbenv.git $(HOME)/.rbenv
install-rbenv-plugins:
	mkdir -p $(HOME)/.rbenv/plugins
	git clone -- git://github.com/sstephenson/ruby-build.git \
		$(HOME)/.rbenv/plugins/ruby-build
	git clone -- git://github.com/carsomyr/rbenv-bundler.git \
		$(HOME)/.rbenv/plugins/bundler
update-rbenv:
	cd $(HOME)/.rbenv \
		&& git pull origin master
	cd $(HOME)/.rbenv/plugins/ruby-build \
		&& git pull origin master
	cd $(HOME)/.rbenv/plugins/bundler \
		&& git pull origin master
uninstall-rbenv:
	rm -fR $(HOME)/.rbenv

# Homebrew
#
# https://github.com/mxcl/homebrew

setup-brew:
	install-brew \
	install-brew-formulae
install-brew:
	/usr/bin/ruby -e "$(/usr/bin/curl -fsSL \
		https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"
homebrew_formulae = \
	git \
	hub \
	imagemagick \
	memcached \
	mongodb \
	mysql \
	redis \
	yajl
install-brew-formulae:
	brew install $(homebrew_formulae)

# Uninstall

clean: uninstall unlink
uninstall: uninstall-nvm uninstall-rbenv

unlink:
	unlink $(HOME)/.bashrc
	unlink $(HOME)/.gitconfig
	unlink $(HOME)/.gitignore
	unlink $(HOME)/.gitcompletion
	unlink $(HOME)/.gemrc
	unlink $(HOME)/.irbrc
