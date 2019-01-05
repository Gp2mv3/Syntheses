# run make all for every synthèse discarding stdout and stderr (-qq)
all:
	cd src; smartcp -v -qq -x "make all" -n config.yml

# same but also copy to the destination
release:
	cd src; python3 ~/git/smartcp/smartcp.py --google-drive -v -qq -x "make all" -s quadri=2 config.yml

# run make clean for all synthèse
clean:
	cd src; smartcp -v -qq -x "make clean" -n config.yml
