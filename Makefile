.PHONY: install update unlink

install:
	./install.sh

update:
	git pull --rebase --autostash
	./install.sh

# Removes the symlinks only. Remove the source/include lines from ~/.zshrc and
# ~/.gitconfig by hand.
unlink:
	for f in .gitignore .githelpers .gemrc .irbrc; do \
		[ -L "$(HOME)/$$f" ] && unlink "$(HOME)/$$f" || true; \
	done
