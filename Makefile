# The url of Terraform provider.
NEW_VERSION ?= v2.21.0

.PHONY: git-submodule-create
create-submodule: 
	git submodule add --force https://github.com/vancluever/terraform-provider-acme.git ./vancluever/origin

.PHONY: git-submodule-update
update-submodule: 
	git submodule update --init --recursive

.PHONY: create-patch
create-patch:
	diff -ruN --exclude=.git/ --exclude=.git  --exclude=.git. ./submoduleACME ./vancluever/v2.21.0 > ./patch/subModule2.patch || exit 0

.PHONY: move-sub-module-to-main
move-sub-to-main:
	git submodule update --init --recursive
	rsync -av --progress ./submoduleACME/ . --exclude .git --exclude .gitignore --exclude *.md --exclude GNUmakefile --exclude .github/ 

.PHONY: patch-file
patching:
	git submodule update --init --recursive
	-patch -p0 < ./patch/subModule2.patch
	-patch -p0 ./submoduleACME/acme/errorlist.go < ./patch/acme.errorlist.go.patch

.PHONY: rm-submoduleACME
rm-submoduleACME:
	rm -rf ./submoduleACME