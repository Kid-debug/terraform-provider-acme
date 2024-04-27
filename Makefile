# The url of Terraform provider.
.PHONY: git-submodule-update
update-submodule: 
	git submodule update --init --recursive

.PHONY: patch-file
patching:
	# git submodule update --init --recursive
	-patch -p0 < ./patch/subModule.patch
	-patch -p0 ./submoduleACME/acme/errorlist.go < ./patch/acme.errorlist.go.patch

# After Modify, Create a new submodule to make patch file
TEMP_SUBMODULE_NAME ?= tempSubmodule
.PHONY: git-submodule-create
create-submodule: 
	git submodule add --force https://github.com/vancluever/terraform-provider-acme.git ./$(TEMP_SUBMODULE_NAME)

# exchange the name with the temp submodule
# Patch file can only apply to the origin dir name depend on creation of the patch file  
# command : diff originDir modifiedDir > patch file
.PHONY: git-submodule-create
exchange-name-submodule-old-new: 
	mv  ./submoduleACME ./tempSubmodule
	mv  ./$(TEMP_SUBMODULE_NAME) ./submoduleACME
	mv  ./tempSubmodule ./$(TEMP_SUBMODULE_NAME)

.PHONY: create-patch
create-patch:
	mv ./patch/subModule.patch ./patch/subModuleOld.patch
	diff -ruN --exclude=.git/ --exclude=.git  --exclude=.git. --exclude=errorlist.go ./submoduleACME/ ./$(TEMP_SUBMODULE_NAME)/ > ./patch/subModule.patch || exit 0

# Remove the new created submodule
.PHONY: rm-submoduleACME
rm-submoduleACME:
	git submodule deinit -f $(TEMP_SUBMODULE_NAME)
	git rm -f $(TEMP_SUBMODULE_NAME)
	# git commit -m "Removed submodule"
	rm -rf .git/modules/$(TEMP_SUBMODULE_NAME)

.PHONY: move-sub-module-to-main
move-sub-to-main:
	git submodule update --init --recursive
	rsync -av --progress ./submoduleACME/ . --exclude .git --exclude .gitignore --exclude *.md --exclude GNUmakefile --exclude .github/ 
