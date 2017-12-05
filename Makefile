PREFIX =
BINDIR = ${PREFIX}/bin
MANDIR = ${PREFIX}/share/man
DESTDIR =

CC = gcc
CFLAGS = -g -std=gnu99 -Os -Wall -Wextra

BINARIES = inject
SUIDROOT = contain pseudo

all: ${BINARIES} ${SUIDROOT}

contain: contain.o console.o map.o mount.o util.o

inject: inject.o map.o util.o

pseudo: pseudo.o map.o util.o

clean:
	rm -f -- ${BINARIES} ${SUIDROOT} tags *.o

install: ${BINARIES} ${SUIDROOT}
	mkdir -p ${DESTDIR}${BINDIR} ${DESTDIR}${MANDIR}/man1 ${DESTDIR}${MANDIR}/man7
	install -s ${BINARIES} ${DESTDIR}${BINDIR}
	install -g root -m 4755 -o root -s ${SUIDROOT} ${DESTDIR}${BINDIR}
	install contain.1 pseudo.1 inject.1 ${DESTDIR}${MANDIR}/man1
	install containers.7 ${DESTDIR}${MANDIR}/man7

tags:
	ctags -R

.PHONY: all clean install tags
