SCHEME = full
PREFIX = /opt/texlive

all: texlive.profile installer/install-tl

configure: configure.ac
	autoconf

texlive.profile: configure
	./configure --prefix=$(PREFIX)

install-tl-unx.tar.gz:
	wget ftp://tug.org/texlive/tlnet/$@ -O $@

installer/install-tl: install-tl-unx.tar.gz
	if [ ! -d installer ];then mkdir installer;fi
	tar --strip-components=1 -C installer -xf install-tl-unx.tar.gz
	if [ -x $@ ];then touch $@;fi

install: all
	cd installer;./install-tl -profile ../texlive.profile -scheme $(SCHEME)

clean:
	rm -rf config.log config.status texlive.profile autom4te.cache

distclean: clean
	rm -rf installer install-tl-unx.tar.gz
