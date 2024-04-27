OLD_SUBMODULE_VERSION ?= v2.21.0
NEW_SUBMODULE_VERSION ?= v2.21.0
TEMP_SUBMODULE_NAME ?= tempSubmodule
#########################################################
# 				New Patch File Creation                 #
# If need to create the new patch file, follow the step #  
#########################################################
.PHONY: git-submodule-update
update-submodule: 
	git submodule update --init --recursive

# patch with the pervious patch file 
.PHONY: patch-file
patching:
	git submodule update --init --recursive
	-patch -p0 < ./patch/subModule-$(OLD_SUBMODULE_VERSION).patch
	-patch -p0 ./submoduleACME/acme/errorlist.go < ./patch/acme.errorlist.go.patch

# After Modifying, Create a new temp submodule to make patch file
.PHONY: copy-docs-main
cp-docs-main: 
	cp -r submoduleACME/docs .

.PHONY: git-submodule-create
create-submodule: 
	git submodule add --force https://github.com/vancluever/terraform-provider-acme.git ./$(TEMP_SUBMODULE_NAME)

# Exchange the name with the temp submodule
# Patch file can only apply to the origin dir name, follow with the creation of the patch file  
# command : diff originDir modifiedDir > patch file
.PHONY: exchange-submodule-name
exchange-name-submodule-old-new: 
	mv  ./submoduleACME ./temp
	mv  ./$(TEMP_SUBMODULE_NAME) ./submoduleACME
	mv  ./temp ./$(TEMP_SUBMODULE_NAME)

.PHONY: create-patch
create-patch:
	diff -ruN --exclude=.git/ --exclude=.git  --exclude=.git. --exclude=errorlist.go ./submoduleACME/ ./$(TEMP_SUBMODULE_NAME)/ > ./patch/subModule-$(NEW_SUBMODULE_VERSION).patch || exit 0

# Remove the new created temp submodule
.PHONY: rm-submoduleACME
rm-submoduleACME:
	git submodule deinit -f $(TEMP_SUBMODULE_NAME)
	git rm -f $(TEMP_SUBMODULE_NAME)
	rm -rf .git/modules/$(TEMP_SUBMODULE_NAME)
	rm -rf ./submoduleACME
	git submodule update --init --recursive

#########################################################
# Use in github action to move the submodule to the main 
# for running the gorelease
#########################################################
.PHONY: move-sub-module-to-main
move-sub-to-main:
	# rsync -av --progress ./submoduleACME/ . --exclude .git --exclude .gitignore --exclude GNUmakefile --exclude .github/ 
	cp ./submoduleACME/.goreleaser.yml .
