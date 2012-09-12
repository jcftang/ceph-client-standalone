all: rbd ceph

libceph:
	make -C libceph

rbd: libceph
	cp libceph/Module.symvers rbd
	make -C rbd

ceph: libceph
	cp libceph/Module.symvers ceph
	make -C ceph

install: ceph-install rbd-install

ceph-install: libceph-install
	make -C ceph modules_install

rbd-install: libceph-install
	make -C rbd modules_install

libceph-install:
	make -C libceph modules_install

dist:
	git archive --format tar --prefix=$$(git describe)/ HEAD | \
                gzip > $$(git describe).tar.gz

.PHONY: libceph ceph rbd
