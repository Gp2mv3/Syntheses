# run make all for every synthèse discarding stdout and stderr (-qq)
all:
	cd src; smartcp -v -qq -x "make all" -n config.yml

# same but also copy to the destination
release:
	cd src; smartcp -v -qq -x "make all" config.yml
