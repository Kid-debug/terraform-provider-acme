# The url of Terraform provider.
NEW_VERSION ?= v2.21.0

.PHONY: create-patch
create-patch:
	diff -ruN --exclude=acme/errorlist.go ./vancluever/$(NEW_VERSION) ./vancluever/v2.21.0 > ./patch/subModule.patch || exit 0

.PHONY: patch-file
patching-acme:
	-patch -p0 < ./patch/subModule.patch
	-patch -p0 ./vancluever/$(NEW_VERSION)/acme/errorlist.go < ./patch/acme.errorlist.go.patch
