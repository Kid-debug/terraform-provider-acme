SUBMODULE_VERSION ?= v2.21.0
PATCH_APPLY_VERSION ?= v2.21.0
PATCH_APPLY_DIRECTORY ?= submodule/acme
ORI_SUBMODULE_NAME ?= submodule/acme
RM_SUBMODULE_NAME ?= submoduleACME

.PHONY: git-submodule-update
update-submodule:
	git submodule update --init --recursive

.PHONY: create-patch
old-create-patch:
	diff -ruN --exclude=.git/ --exclude=.git  --exclude=.git. ./$(ORI_SUBMODULE_NAME) ./submodule/acme > ./patch/subModule-$(SUBMODULE_VERSION).patch || exit 0

.PHONY: create-patch
create-patch:
	diff -u $(ORI_SUBMODULE_NAME)/acme/acme_structure.go $(PATCH_APPLY_DIRECTORY)/acme/acme_structure.go > ./patch/$(SUBMODULE_VERSION)/acme_structure.go.patch  || exit 0
	diff -u $(ORI_SUBMODULE_NAME)/acme/certificate_challenges.go $(PATCH_APPLY_DIRECTORY)/acme/certificate_challenges.go > ./patch/$(SUBMODULE_VERSION)/certificate_challenges.go.patch  || exit 0
	diff -u $(ORI_SUBMODULE_NAME)/acme/dnsplugin/client.go $(PATCH_APPLY_DIRECTORY)/acme/dnsplugin/client.go > ./patch/$(SUBMODULE_VERSION)/client.go.patch  || exit 0
	diff -u $(ORI_SUBMODULE_NAME)/acme/dnsplugin/plugin.go $(PATCH_APPLY_DIRECTORY)/acme/dnsplugin/plugin.go > ./patch/$(SUBMODULE_VERSION)/plugin.go.patch || exit 0
	diff -u $(ORI_SUBMODULE_NAME)/acme/dnsplugin/plugin_test.go $(PATCH_APPLY_DIRECTORY)/acme/dnsplugin/plugin_test.go > ./patch/$(SUBMODULE_VERSION)/plugin_test.go.patch || exit 0
	diff -N $(ORI_SUBMODULE_NAME)/acme/errorlist.go $(PATCH_APPLY_DIRECTORY)/acme/errorlist.go > ./patch/$(SUBMODULE_VERSION)/errorlist.go.patch || exit 0
	diff -u $(ORI_SUBMODULE_NAME)/acme/provider_test.go $(PATCH_APPLY_DIRECTORY)/acme/provider_test.go > ./patch/$(SUBMODULE_VERSION)/provider_test.go.patch || exit 0
	diff -u $(ORI_SUBMODULE_NAME)/acme/resource_acme_certificate.go $(PATCH_APPLY_DIRECTORY)/acme/resource_acme_certificate.go > ./patch/$(SUBMODULE_VERSION)/resource_acme_certificate.go.patch || exit 0
	diff -u $(ORI_SUBMODULE_NAME)/acme/resource_acme_registration.go $(PATCH_APPLY_DIRECTORY)/acme/resource_acme_registration.go > ./patch/$(SUBMODULE_VERSION)/resource_acme_registration.go.patch || exit 0
	diff -u $(ORI_SUBMODULE_NAME)/docs/index.md $(PATCH_APPLY_DIRECTORY)/docs/index.md > ./patch/$(SUBMODULE_VERSION)/index.md.patch || exit 0
	diff -u $(ORI_SUBMODULE_NAME)/docs/resources/certificate.md $(PATCH_APPLY_DIRECTORY)/docs/resources/certificate.md > ./patch/$(SUBMODULE_VERSION)/certificate.md.patch || exit 0
	diff -u $(ORI_SUBMODULE_NAME)/.gitignore $(PATCH_APPLY_DIRECTORY)/.gitignore > ./patch/$(SUBMODULE_VERSION)/.gitignore.patch || exit 0
	diff -u $(ORI_SUBMODULE_NAME)/go.mod $(PATCH_APPLY_DIRECTORY)/go.mod > ./patch/$(SUBMODULE_VERSION)/go.mod.patch || exit 0
	diff -u $(ORI_SUBMODULE_NAME)/.goreleaser.yml $(PATCH_APPLY_DIRECTORY)/.goreleaser.yml > ./patch/$(SUBMODULE_VERSION)/.goreleaser.yml.patch || exit 0
	diff -u $(ORI_SUBMODULE_NAME)/go.sum $(PATCH_APPLY_DIRECTORY)/go.sum > ./patch/$(SUBMODULE_VERSION)/go.sum.patch || exit 0
	diff -u $(ORI_SUBMODULE_NAME)/main.go $(PATCH_APPLY_DIRECTORY)/main.go > ./patch/$(SUBMODULE_VERSION)/main.go.patch || exit 0
	diff -u $(ORI_SUBMODULE_NAME)/proto/dnsplugin/v1/dnsplugin.proto $(PATCH_APPLY_DIRECTORY)/proto/dnsplugin/v1/dnsplugin.proto > ./patch/$(SUBMODULE_VERSION)/dnsplugin.proto.patch || exit 0
	diff -u $(ORI_SUBMODULE_NAME)/README.md $(PATCH_APPLY_DIRECTORY)/README.md > ./patch/$(SUBMODULE_VERSION)/README.md.patch || exit 0

.PHONY: patch-file
old-patching:
	-patch --directory=$(PATCH_APPLY_DIRECTORY) -p3 < ./patch/subModule-$(PATCH_APPLY_VERSION).patch

.PHONY: patch-file
patching:
	-patch -p0 $(PATCH_APPLY_DIRECTORY)/acme/acme_structure.go < ./patch/$(SUBMODULE_VERSION)/acme_structure.go.patch
	-patch -p0 $(PATCH_APPLY_DIRECTORY)/acme/certificate_challenges.go < ./patch/$(SUBMODULE_VERSION)/certificate_challenges.go.patch
	-patch -p0 $(PATCH_APPLY_DIRECTORY)/acme/dnsplugin/client.go < ./patch/$(SUBMODULE_VERSION)/client.go.patch
	-patch -p0 $(PATCH_APPLY_DIRECTORY)/acme/dnsplugin/plugin.go < ./patch/$(SUBMODULE_VERSION)/plugin.go.patch
	-patch -p0 $(PATCH_APPLY_DIRECTORY)/acme/dnsplugin/plugin_test.go < ./patch/$(SUBMODULE_VERSION)/plugin_test.go.patch
	-patch -p0 $(PATCH_APPLY_DIRECTORY)/acme/errorlist.go < ./patch/$(SUBMODULE_VERSION)/errorlist.go.patch
	-patch -p0 $(PATCH_APPLY_DIRECTORY)/acme/provider_test.go < ./patch/$(SUBMODULE_VERSION)/provider_test.go.patch
	-patch -p0 $(PATCH_APPLY_DIRECTORY)/acme/resource_acme_certificate.go < ./patch/$(SUBMODULE_VERSION)/resource_acme_certificate.go.patch
	-patch -p0 $(PATCH_APPLY_DIRECTORY)/acme/resource_acme_registration.go < ./patch/$(SUBMODULE_VERSION)/resource_acme_registration.go.patch
	-patch -p0 $(PATCH_APPLY_DIRECTORY)/docs/index.md < ./patch/$(SUBMODULE_VERSION)/index.md.patch
	-patch -p0 $(PATCH_APPLY_DIRECTORY)/docs/resources/certificate.md < ./patch/$(SUBMODULE_VERSION)/certificate.md.patch
	-patch -p0 $(PATCH_APPLY_DIRECTORY)/.gitignore < ./patch/$(SUBMODULE_VERSION)/.gitignore.patch
	-patch -p0 $(PATCH_APPLY_DIRECTORY)/go.mod < ./patch/$(SUBMODULE_VERSION)/go.mod.patch
	-patch -p0 $(PATCH_APPLY_DIRECTORY)/.goreleaser.yml < ./patch/$(SUBMODULE_VERSION)/.goreleaser.yml.patch
	-patch -p0 $(PATCH_APPLY_DIRECTORY)/go.sum < ./patch/$(SUBMODULE_VERSION)/go.sum.patch
	-patch -p0 $(PATCH_APPLY_DIRECTORY)/main.go < ./patch/$(SUBMODULE_VERSION)/main.go.patch
	-patch -p0 $(PATCH_APPLY_DIRECTORY)/proto/dnsplugin/v1/dnsplugin.proto < ./patch/$(SUBMODULE_VERSION)/dnsplugin.proto.patch
	-patch -p0 $(PATCH_APPLY_DIRECTORY)/README.md < ./patch/$(SUBMODULE_VERSION)/README.md.patch

# copy the new docs to the main to have docs on terraform registry.
.PHONY: copy-docs-main
cp-docs-main:
	cp -r submodule/acme/docs .

.PHONY: copy-readme-main
cp-readme-main:
	cp -r submodule/acme/README.md .

# Remove submodule
.PHONY: rm-submodule-acme
rm-submodule-acme:
	git submodule deinit -f $(RM_SUBMODULE_NAME)
	git rm -f $(RM_SUBMODULE_NAME)
	rm -rf .git/modules/$(RM_SUBMODULE_NAME)
	rm -rf ./submoduleACME

#########################################################
# Use in github action to move the submodule to the main
# for running the gorelease
#########################################################
.PHONY: move-sub-module-to-main
move-sub-to-main:
	rsync -av --progress ./submoduleACME/ . --exclude .git --exclude .gitignore --exclude GNUmakefile --exclude .github/ --exclude *.md
