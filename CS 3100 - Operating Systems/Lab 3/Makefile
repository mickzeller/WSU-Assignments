FILES = syscall.c syscall.h sysproc.c trap.c user.h usys.S peep.c

install: 
	cp $(FILES) xv6-public/ 
	cd xv6-public; make qemu-nox

get:
	cd xv6-public; cp -vn $(FILES) ..

run:
	cd xv6-public; make qemu-nox
