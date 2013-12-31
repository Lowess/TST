# license type: free of charge license for academic and research purpose
# see license.txt
# author: Bertrand Ducourthial
# revision: 25/04/2012

# Makefile of the Airplug Software Distribution.
# Layer 3 Makefile for TclTk applications *not* in the skeleton distribution.
# Generic makefile: no adaptation for a given application.

# NB: adding a new module or a new file to the application does not require
#     to adapt the Makefile providing the file has been named according to
#     the rule: nameoftheapplication-nameofthemodule.tk
#     In the converse, the TGZ_PUB and TGZ_DEV should be adapted and the
#     Makefile is no more generic (this should be precised line 6).

# To avoid any problem from the inheritage of SHELL variable from the
# environment
SHELL = /bin/bash

# Language (if the LANGUAGE env variable contains fr, then french, else english)
TEXT = $(shell if [ x`env | grep LANGUAGE | grep fr` = x ] ; then echo "english" ; else echo "french" ; fi )

# Name of the application (= name of the directory in lower cases)
# NB: taking the name of the parent directory to avoid including version number.
OUTPUT = $(shell pwd | rev | cut -d'/' -f 2 | rev | tr '[:upper:]' '[:lower:]')

# Current directory (without version suffix)
# NB: inherited from parent Makefile (see -e make option in ../Makefile)
DIR = $(shell pwd | rev | cut -d'/' -f 2 | rev)

# Real current directory name (for display purpose)
DIRNAME = $(shell pwd | rev | cut -d'/' -f 1 | rev)

# Install directory of the whole distribution
export DIR_INSTALL = ../..

# SOURCES stands for all sources files belonging to the application
# whenever the naming rules are fulfilled
#  RC is either empty or equal to rc-$(OUTPUT).tk if it exists
RC = $(shell if [ -e rc-$(OUTPUT).tk ] ; then echo rc-$(OUTPUT).tk ; else echo "" ; fi )
#  LIB is either empty or equal to libapg-app-$(OUTPUT).tk if it exists
LIB = $(shell if [ -e libapg-app-$(OUTPUT).tk ] ; then echo libapg-app-$(OUTPUT).tk ; else echo "" ; fi )
# NB : wildcard does the immediat expansion.
SOURCES = $(wildcard $(OUTPUT)*.tk) $(RC) $(LIB) 

# List of all files for the public archive
TGZ_PUB = $(SOURCES) \
	Makefile \
	license.txt \
	README.pub \
	tgz-history.txt \
	apg-icon-$(OUTPUT).ppm \
	apg-appicon-$(OUTPUT).ppm
# Complete here if there are other specific files to be added in the archive.
# In this case, the Makefile is no more generic and this should be indicated
# on line 8.

# List of all files for the devel archive
TGZ_DEV = $(TGZ_PUB) \
	README.dev \
	apg-icon-$(OUTPUT).obj \
	apg-appicon-$(OUTPUT).obj

# List of all files for the distribution skeleton archive
TGZ_SKL =

MAKE = make

# make options:
# -s : silent
# -e : variables which are exported here predominates those initialized in sub-makefiles
MFLAGS = -s -e

# tgif program for generating icons
TGIF = tgif

# To avoid any problem in case a file has the name of a rule
.PHONY: build clean depend icon files-tgz-dev files-tgz-skl files-tgz-pub \
	help icon incr install list mod-version new-version print-tgz-dev reset \
	show-version tgz-pub tgz-dev tgz-skl

# First rule = default rule (help)
help:
	@if [ $(TEXT) = "french" ]; then \
		echo " +++ $(DIR) : aide pour le Makefile de la Suite logicielle Airplug" ; \
		echo "     make build        : compilation" ; \
		echo "     make clean        : suppression des fichiers temporaires" ; \
		echo "     make depend       : calcul des dependances (avant compilation)" ; \
		echo "     make help         : affiche cette aide"; \
		echo "     make icon         : creation de l'icone de l'application" ; \
		echo "     make incr         : similaire a make new-version" ; \
		echo "     make install      : installation du programme (apres compilation)" ; \
		echo "     make list         : liste des fichiers" ; \
		echo "     make mod-version  : modifie la version courante de l'application" ; \
		echo "     make new-version  : cree une nouvelle version de l'application" ; \
		echo "     make reset        : clean + suppression des executables compiles" ; \
		echo "     make show-version : affichage de la version, du type de license et des auteurs" ; \
		echo "     make tgz-pub      : archivage des sources pour distribution publique" ; \
		echo "     make tgz-dev      : archivage des sources pour distribution de developpement" ; \
		echo "     make tgz-skl      : archivage des sources pour embryon de distribution" ; \
	else \
		echo " +++ $(DIR) : help for Makefile of the Airplug Software Distribution" ; \
		echo "     make build        : compilation" ; \
		echo "     make clean        : delete temporary files" ; \
		echo "     make depend       : compute the dependencies (before compilation)" ; \
		echo "     make help         : display this help"; \
		echo "     make icon         : create the application icon" ; \
		echo "     make incr         : same as make new-version" ; \
		echo "     make install      : install the program (after compilation)" ; \
		echo "     make list         : list the files" ; \
		echo "     make mod-version  : modify the current version of the application" ; \
		echo "     make new-version  : create a new version of the application" ; \
		echo "     make reset        : clean + delete the compiled executables" ; \
		echo "     make show-version : display the version, the license type and the authors" ; \
		echo "     make tgz-pub      : archive sources for the public distribution" ; \
		echo "     make tgz-dev      : archive sources for the devel distribution" ; \
		echo "     make tgz-skl      : archive sources for the skeleton distribution" ; \
	fi ;


# NB: no compilation for this TclTk makefile so build and depend rules have no
#     effect here.
#     Version management has no effect in layer 3 Makefile.
#     tgz-pub, tgz-dev should be used on the parent directory only.
#     tgz-skl, files-tgz-skl not used because the application is not in the skl
#     distribution.
build depend incr mod-version new-version show-version tgz-pub tgz-dev tgz-skl files-tgz-skl:
	@if [ $(TEXT) = "french" ]; then \
		echo "  ++ $(DIRNAME) : regle $@ => sans effet ici" ; \
	else \
		echo "  ++ $(DIRNAME) : $@ rule => no effect here" ; \
	fi ;

# NB: no executable, so clean=reset
clean reset:
	@if [ $(TEXT) = "french" ]; then \
		echo "  ++ $(DIRNAME) : regle $@" ; \
		echo "     suppression des *~ *bak *tgz files-tgz-*.txt" ; \
	else \
		echo "  ++ $(DIRNAME) : $@ rule" ; \
		echo "     deleting *~ *bak *tgz files-tgz-*.txt" ; \
	fi ; \
	rm -f *~ *bak *tgz files-tgz-*.txt ;

list:
	@if [ $(TEXT) = "french" ]; then \
		echo "   + $(DIRNAME) : regle $@" ; \
	else \
		echo "   + $(DIRNAME) : $@ rule" ; \
	fi ; \
	echo "     Sources : $(SOURCES)" ; \
	for F in $(SOURCES) ; do \
		if ! [ -e $$F ]; then \
			if [ $(TEXT) = "french" ]; then \
				echo "! $(DIRNAME) : $$F manquant" ; \
			else \
				echo "! $(DIRNAME) : $$F not found" ; \
			fi ; \
		fi; \
	done ;


files-tgz-dev:
	@if [ $(TEXT) = "french" ]; then \
		echo "  ++ $(DIRNAME) : regle $@" ; \
	else \
		echo "  ++ $(DIRNAME) : $@ rule" ; \
	fi ; \
	if [ -e ./files-tgz-dev.txt ] ; then \
		rm ./files-tgz-dev.txt ; \
	fi ; \
	for F in $(TGZ_DEV) ; do \
		if [ -e $$F ]; then \
			echo $$F >> ./files-tgz-dev.txt ; \
		else \
			if [ $(TEXT) = "french" ]; then \
				echo "!    $(DIRNAME) : $$F manquant" ; \
			else \
				echo "!    $(DIRNAME) : $$F not found" ; \
			fi ; \
		fi ; \
	done ;

files-tgz-pub:
	@if [ $(TEXT) = "french" ]; then \
		echo "  ++ $(DIRNAME) : regle $@" ; \
	else \
		echo "  ++ $(DIRNAME) : $@ rule" ; \
	fi ; \
	if [ -e ./files-tgz-pub.txt ] ; then \
		rm ./files-tgz-pub.txt ; \
	fi ; \
	for F in $(TGZ_PUB) ; do \
		if [ -e $$F ]; then \
			echo $$F >> ./files-tgz-pub.txt ; \
		else \
			if [ $(TEXT) = "french" ]; then \
				echo "!    $(DIRNAME) : $$F manquant" ; \
			else \
				echo "!    $(DIRNAME) : $$F not found" ; \
			fi ; \
		fi ; \
	done ;

icon: 
	@if [ $(TEXT) = "french" ]; then \
		echo "  ++ $(DIRNAME) : regle $@" ; \
		echo "     creation des icones apg-icon-$(OUTPUT).ppm et apg-appicon-$(OUTPUT).ppm" ; \
	else \
		echo "  ++ $(DIRNAME) : $@ rule" ; \
		echo "     creating icons for apg-icon-$(OUTPUT).ppm and apg-appicon-$(OUTPUT).ppm" ; \
	fi ; \
	sed -e "s/APP/$(DIR)/g" < $(DIR_INSTALL)/icons/apg-icon-default.obj > apg-icon-$(OUTPUT).obj ; \
	sed -e "s/APP/$(DIR)/g" < $(DIR_INSTALL)/icons/apg-appicon-default.obj > apg-appicon-$(OUTPUT).obj ; \
	if [ "x`which $(TGIF)`" = "x" ]; then \
		if [ $(TEXT) = "french" ]; then \
				echo "- $(DIRNAME) : $(TGIF) non trouve. Verifier que ce logiciel est installe." ; \
		else \
				echo "- $(DIRNAME) : $(TGIF) not found. Check that this software is installed." ; \
		fi ; \
	else \
		$(TGIF) -print -ppm apg-icon-$(OUTPUT).obj 2> /dev/null ; \
		$(TGIF) -print -ppm apg-appicon-$(OUTPUT).obj 2> /dev/null ; \
	fi

instal install:
	@if [ $(TEXT) = "french" ]; then \
		echo "  ++ $(DIRNAME) : regle $@" ; \
		echo "     repertoire de la distribution : $(DIR_INSTALL)" ; \
		echo "     repertoire des sources : $(DIR)" ; \
		echo "     lien vers $(OUTPUT).tk dans $(DIR_INSTALL)/bin" ; \
	else \
		echo "  ++ $(DIRNAME) : $@ rule" ; \
		echo "     install directory : $(DIR_INSTALL)" ; \
		echo "     sources directory : $(DIR)" ; \
		echo "     link towards $(OUTPUT).tk in $(DIR_INSTALL)/bin" ; \
	fi ;
# Executable
	@ln -sf --target-directory $(DIR_INSTALL)/bin ../$(DIR)/$(DIR)/$(OUTPUT).tk ;
# Library if present
	@if [ -e libapg-app-$(OUTPUT).tk ] ; then \
		if [ $(TEXT) = "french" ]; then \
			echo "     lien vers libapg-app-$(OUTPUT).tk dans $(DIR_INSTALL)/LIBAPGTK/LIBAPGTK" ; \
		else \
			echo "     link towards libapg-app-$(OUTPUT).tk in $(DIR_INSTALL)/LIBAPGTK/LIBAPGTK" ; \
		fi ; \
		ln -sf --target-directory $(DIR_INSTALL)/LIBAPGTK/LIBAPGTK ../../$(DIR)/$(DIR)/libapg-app-$(OUTPUT).tk ; \
	fi ;
# Icon
	@if [ $(TEXT) = "french" ]; then \
		echo "     lien vers apg-icon-$(OUTPUT).ppm dans $(DIR_INSTALL)/icons" ; \
	else \
		echo "     link towards apg-icon-$(OUTPUT).ppm in $(DIR_INSTALL)/icons" ; \
	fi ; \
	ln -sf --target-directory $(DIR_INSTALL)/icons ../$(DIR)/$(DIR)/apg-icon-$(OUTPUT).ppm ;
# Appicon for Window Maker
	@if [ $(TEXT) = "french" ]; then \
		echo "     lien vers apg-appicon-$(OUTPUT).ppm dans $(DIR_INSTALL)/icons (Window Maker)" ; \
	else \
		echo "     link towards apg-appicon-$(OUTPUT).ppm dans $(DIR_INSTALL)/icons (Window Maker)" ; \
	fi ; \
	ln -sf --target-directory $(DIR_INSTALL)/icons ../$(DIR)/$(DIR)/apg-appicon-$(OUTPUT).ppm ;
	@if [ -e ~/GNUstep/Library/Icons ] ; then \
		if [ $(TEXT) = "french" ]; then \
			echo "     lien vers apg-icon-$(OUTPUT).ppm dans ~/GNUstep/Library/Icons (Window Maker)" ; \
		else \
			echo "     link towards apg-icon-$(OUTPUT).ppm in ~/GNUstep/Library/Icons (Window Maker)" ; \
		fi ; \
		ln -sf --target-directory ~/GNUstep/Library/Icons `pwd`/apg-icon-$(OUTPUT).ppm ; \
	fi ;
# Subdirectory in output
	@if [ $(TEXT) = "french" ]; then \
		echo "     creation du sous-repertoire $(OUTPUT) dans $(DIR_INSTALL)/output (si absent)" ; \
	else \
		echo "     creating subdirectory $(OUTPUT) in $(DIR_INSTALL)/output (if not existing)" ; \
	fi ; \
	mkdir -p $(DIR_INSTALL)/output/$(OUTPUT)
# Subdirectory in input
	@if [ $(TEXT) = "french" ]; then \
		echo "     creation du sous-repertoire $(OUTPUT) dans $(DIR_INSTALL)/input (si absent)" ; \
	else \
		echo "     creating subdirectory $(OUTPUT) in $(DIR_INSTALL)/input (if not existing)" ; \
	fi ; \
	mkdir -p $(DIR_INSTALL)/input/$(OUTPUT)
# Complete here if there are other specific files to be installed.
# In this case, the Makefile is no more generic and this should be
# indicated on line 8.

# Used by the newapp.sh shell script
print-tgz-dev:
	@echo "$(TGZ_DEV)"
