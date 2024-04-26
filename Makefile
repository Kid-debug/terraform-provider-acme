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
	diff -ruN --exclude=acme/errorlist.go --exclude=.git/ --exclude=.git  --exclude=.git. . ./subModuleACME > ./patch/subModule1.patch || exit 0

.PHONY: move-sub-dir-to-main
move-sub-file:
	git submodule update --init --recursive
	rsync -av --progress ./subModuleACME/* . --exclude .git --exclude .gitignore --exclude README.md --exclude GNUmakefile --exclude .github/

.PHONY: patch-file
patching:
	git submodule update --init --recursive
	-patch -p0 < ./patch/subModule.patch
	-patch -p0 ./acme/errorlist.go < ./patch/acme.errorlist.go.patch