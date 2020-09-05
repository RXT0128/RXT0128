# Generated using: grep -oP "^[a-zA-Z-]+\:.*" Makefile | sed s/:.*// | grep -v PHONY | tr '\n' ' '
PHONY: all list build

# Metadata
NAME ?= RXT0128
VERSION = 0.0.0

# Command overrides
READ ?= read
CHMOD ?= chmod
PRINTF ?= printf
EMACS ?= emacs
GREP ?= grep
SED ?= sed
CAT ?= cat
TRUE ?= true
MKDIR ?= mkdir
EXIT ?= exit
GIT ?= git
ED ?= ed
CP ?= cp
RM ?= rm
SH ?= sh
ENV ?= env
MAKE ?= make

# Directory overrides
BUILD ?= "$(PWD)/build"
DISTRO_DIR ?= "$(PWD)/src/RXT0128/

#@ Default target invoked on 'make' (outputs syntax error on this project)
all:
	@ $(error Target 'all' is not allowed, use 'make list' to list available targets or read the 'Makefile' file)
	@ "$(EXIT)" 2

#@ List all targets
list:
	@ printf 'FIXME: %s\n' "Puts ': something' in the output, implement in a way that is comforming posix"
	@ "$(TRUE)" \
		&& "$(GREP)" -A 1 "^#@.*" Makefile | "$(SED)" s/--//gm | "$(SED)" "s/#@/#/gm" | while IFS= "$(READ)" -r line; do \
			case "$$line" in \
				"#"*|"") "$(PRINTF)" '%s\n' "$$line" ;; \
				*) "$(PRINTF)" '%s\n' "make $$line"; \
			esac; \
		done

#@ Remove temporary pathnames
clean:
	@ : "FIXME: Outputs: /bin/sh: 1: rm -f: not found when '$(RM)' is used"
	@ [ ! -d "$(BUILD)" ] || rm -rf "$(BUILD)"


#@ Build the distribution
build: clean build-init-prepend build-codeblocks build-init-append

#@ Build: Build the prepended part of init.el
build-init-prepend:
	@ [ -d "$(BUILD)" ] || "$(MKDIR)" "$(BUILD)"
	@ [ -d "$(BUILD)/$(NAME)" ] || "$(MKDIR)" "$(BUILD)/$(NAME)"
	@ [ -f "$(BUILD)/$(NAME)/init.el" ] || "$(CAT)" "$(DISTRO_DIR)/00-init-prepend.el" | grep -v ";;;-" | "$(SED)" "s/APPEND_DISTRO_NAME/$(NAME)/" > "$(BUILD)/$(NAME)/init.el"

#@ Build: Build the appended part of init.el
build-init-append:
	@ [ -d "$(BUILD)" ] || "$(MKDIR)" "$(BUILD)"
	@ [ -d "$(BUILD)/$(NAME)" ] || "$(MKDIR)" "$(BUILD)/$(NAME)"
	@ : "FIXME: Sanitize this step"
	@ "$(CAT)" "$(DISTRO_DIR)/01-init-append.el" | grep -v ";;;-" >> "$(BUILD)/$(NAME)/init.el"

#@ Build: Codeblocks
build-codeblocks: build-codeblocks-find-emacs-dirs

#@ Build: Codeblock find-emacs-dirs
build-codeblocks-find-emacs-dirs:
	@ [ -d "$(BUILD)" ] || "$(MAKE)" build-init-prepend
	@ [ -d "$(BUILD)/$(NAME)" ] || "$(MKDIR)" "$(BUILD)/$(NAME)"
	@ "$(GREP)" -q "# find-emacs-dirs.el" "$(BUILD)/$(NAME)/init.el" || "$(CAT)" "$(DISTRO_DIR)/codeblocks/00-find-emacs-dirs.el" >> "$(BUILD)/$(NAME)/init.el"

## RUNTIME ##

#@ Runtime: Open emacs with distro release
runtime-emacs-gui: build
	@ "$(ENV)" EMACS_DIR="$(BUILD)/$(NAME)/" "$(EMACS)" -q --load "$(BUILD)/$(NAME)/init.el"

#@ Runtime: Run only the elisp script through emacs and output in terminal
runtime-emacs-script: build
	@ "$(ENV)" EMACS_DIR="$(BUILD)/$(NAME)/" "$(EMACS)" --script "$(BUILD)/$(NAME)/init.el"
