# The url of Terraform provider.
NEW_VERSION ?= v2.21.0

.PHONY: create-patch
create-patch:
	diff -ruN --exclude=acme/errorlist.go --exclude=.git/ --exclude=.git  --exclude=.git. . ./vancluever/v2.21.0 > ./patch/subModule1.patch || exit 0

.PHONY: patch-file
patching-acme:
	git submodule update --init --recursive
	-patch -p0  < ./patch/subModule1.patch
	-patch -p0 .acme/errorlist.go < ./patch/acme.errorlist.go.patch

.PHONY: move-sub-dir-to-main
move-sub-file:
	git submodule update --init --recursive
	rsync -av --progress ./vancluever/v2.21.0/* . --exclude .git --exclude .gitignore --exclude README.md --exclude GNUmakefile --exclude .github/
