MAKEFLAGS += --no-builtin-rules --no-builtin-variables --warn-undefined-variables

# Names
CMD_NAME = cdisk
CMP_NAME = _cdisk.bash

# Version
VERSION_FILE = ./VERSION
VERSION = $(file < $(VERSION_FILE))

# Sources
BASH_SCRIPT = ./src/bin/$(CMD_NAME)
BASH_COMPLETION = ./src/bash-completion/completions/$(CMP_NAME)

# XDG Default
XDG_DATA_HOME ?= $(HOME)/.local/share

# Destinations
DEST_BIN ?= $(HOME)/.local/bin
DEST_COMPLETION = $(XDG_DATA_HOME)/bash-completion/completions
STOW_TARGET ?= $(HOME)/.local

# Optionally simulate the stow procedures
SIMULATE ?= false

# Stow options
STOW_OPTS ?= $(if $(filter true,$(SIMULATE)), --simulate) \
			 --no-folding --verbose --target=$(STOW_TARGET) src

.PHONY: version
version: VERSION
	@echo "Update $(CMD_NAME) to $(VERSION)"
	@sed --in-place 's/__VERSION__=.*/__VERSION__=$(VERSION)/' $(BASH_SCRIPT)

.PHONY: install
install: install-script install-completion

.PHONY: install-script
install-script:
	@mkdir -p $(DEST_BIN)
	@echo "Installing script to $(DEST_BIN)"
	@install -m 755 $(BASH_SCRIPT) $(DEST_BIN)

.PHONY: install-completion
install-completion:
	@mkdir -p $(DEST_COMPLETION)
	@echo "Installing completion to $(DEST_COMPLETION)"
	@install -m 644 $(BASH_COMPLETION) $(DEST_COMPLETION)

.PHONY: uninstall
uninstall: uninstall-script uninstall-completion

.PHONY: uninstall-script
uninstall-script:
	@echo "Removing script from $(DEST_BIN)"
	@rm -f $(DEST_BIN)/$(CMD_NAME)

.PHONY: uninstall-completion
uninstall-completion:
	@echo "Removing completion from $(DEST_COMPLETION)"
	@rm -f $(DEST_COMPLETION)/$(CMP_NAME)

.PHONY: stow
stow:
	@echo "Stowing files"
	@stow $(STOW_OPTS)

.PHONY: unstow
unstow:
	@echo "Un-stow files"
	@stow --delete $(STOW_OPTS)

.PHONY: restow
restow:
	@echo "Restow files"
	@stow --restow $(STOW_OPTS)
