.PHONY: test

UNAME := $(shell uname)

ifeq ($(UNAME), Darwin)
ifeq ($(LOVE_VERSION), 0.9.0)
  OSXZIP = love-0.9.0-macosx-x64.zip
else
  OSXZIP = love-0.8.0-macosx-ub.zip
endif
ifeq ($(LOVE_VERSION), 0.9.0)
  LOVE = /usr/bin/love9
else
  LOVE = /usr/bin/love8
endif
endif

ifeq ($(shell which wget),)
  WGET = curl -s -O -L
else
  WGET = wget -q --no-check-certificate
endif

test: $(LOVE)
	cp glove.lua src/glove.lua
	$(LOVE) src

bin/love.app/Contents/MacOS/love:
	mkdir -p bin
	$(WGET) https://bitbucket.org/rude/love/downloads/$(OSXZIP)
	unzip -q $(OSXZIP)
	rm -f $(OSXZIP)
	mv love.app bin

/usr/bin/love9:
	wget https://bitbucket.org/rude/love/downloads/love_0.8.0-0precise1_amd64.deb
	-sudo dpkg -i love_0.8.0-0precise1_amd64.deb
	sudo apt-get update -y
	sudo apt-get install -f -y
	sudo ln -s /usr/bin/love /usr/bin/love9

/usr/bin/love8:
	sudo add-apt-repository -y ppa:bartbes/love-stable
	sudo apt-get update -y
	sudo apt-get install -y love
	sudo ln -s /usr/bin/love /usr/bin/love8

