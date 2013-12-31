# license type: free of charge license for academic and research purpose
# see license.txt
# author: Bertrand Ducourthial
# revision: 18/04/2012

# Makefile of the Airplug Software Distribution.
# Layer 2 Makefile for applications *not* in the skeleton distribution.
# Generic makefile: no adaptation for a given application.

# To avoid any problem from the inheritage of SHELL variable from the
# environment
SHELL = /bin/bash

# Language (if the LANGUAGE env variable contains fr, then french, else english)
TEXT = $(shell if [ x`env | grep LANGUAGE | grep fr` = x ] ; then echo "english" ; else echo "french" ; fi )

# Install directory of the whole distribution
DIR_INSTALL = ..

# List of all files for the public archive
TGZ_PUB = Makefile tgz-history.txt license.txt README.pub

# List of all files for the devel archive
TGZ_DEV = $(TGZ_PUB) README.dev

# List of all files for the distribution skeleton archive
TGZ_SKL =

# Step for the version number incrementation
#  (the version number will be increased by VERSION_STEP when using make
#   new_version or make incr)
VERSION_STEP="0.01"

# Exporting the DIR variable for sub-makefiles
export DIR=$(shell pwd | rev | cut -d'/' -f 1 | rev)

VERSION=$(shell ls -l | grep -e "->" | cut -d'>' -f 2 | rev | cut -d '-' -f 1 | rev | cut -d'/' -f1)

MAKE = make

# make options:
# -s : silent
# -e : variables which are exported here predominates those initialized in sub-makefiles
MFLAGS = -e -s

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
	fi;

build depend icon instal install list reset:
	@if [ $(TEXT) = "french" ]; then \
		echo " +++ $(DIR) : regle $@" ;	\
	else \
		echo " +++ $(DIR) : $@ rule" ;	\
	fi ; \
	if [ -e $(DIR)/Makefile ]; then \
		$(MAKE) $@ $(MFLAGS) -C $(DIR) ; \
	else \
		if [ $(TEXT) = "french" ]; then \
			echo " !   $(DIR) : absence de Makefile dans $(DIR)/$(DIR)" ; \
		else \
			echo " !   $(DIR) : no Makefile in $(DIR)/$(DIR)" ; \
		fi ; \
	fi ;

# This application does not belong to the skeleton distribution.
tgz-skl files-tgz-skl:
	@if [ $(TEXT) = "french" ]; then \
		echo " +++ $(DIR) : regle $@ => sans effet ici" ; \
	else \
		echo " +++ $(DIR) : $@ rule => no effect here" ; \
	fi;

clean:
	@if [ $(TEXT) = "french" ]; then \
		echo " +++ $(DIR) : regle $@" ; \
		echo "     suppression des *~ *bak *tgz files-tgz-*.txt" ; \
	else \
		echo " +++ $(DIR) : $@ rule" ; \
		echo "     deleting *~ *bak *tgz files-tgz-*.txt" ; \
	fi ; \
	rm -f *~ *bak *tgz files-tgz-*.txt ; \
	if [ -e $(DIR)/Makefile ]; then \
		$(MAKE) $@ $(MFLAGS) -C $(DIR) ; \
	else \
		if [ $(TEXT) = "french" ]; then \
			echo " !   $(DIR) : absence de Makefile dans $(DIR)/$(DIR)" ; \
		else \
			echo " !   $(DIR) : no Makefile in $(DIR)/$(DIR)" ; \
		fi ; \
	fi ;

incr: new-version

files-tgz-dev:
	@if [ $(TEXT) = "french" ]; then \
		echo " +++ $(DIR) : regle $@" ; \
	else \
		echo " +++ $(DIR) : $@ rule" ; \
	fi ; \
	if [ -e ./files-tgz-dev.txt ] ; then \
		rm ./files-tgz-dev.txt ; \
	fi ; \
	for F in $(TGZ_DEV) ; do \
		if [ -e $$F ]; then \
			echo $$F >> ./files-tgz-dev.txt ; \
		else \
			if [ $(TEXT) = "french" ]; then \
				echo "! $(DIR) : $$F manquant" ; \
			else \
				echo "! $(DIR) : $$F not found" ; \
			fi ; \
		fi ; \
	done ; \
	echo "$(DIR)" >> ./files-tgz-dev.txt ; \
	echo "$(DIR)-$(VERSION)" >> ./files-tgz-dev.txt ; \
	if [ -e $(DIR)/Makefile ]; then \
		$(MAKE) $@ $(MFLAGS) -C $(DIR) ; \
		for F in `cat $(DIR)/files-tgz-dev.txt` ; do \
			echo "$(DIR)-$(VERSION)/$$F" >> ./files-tgz-dev.txt ; \
		done ; \
	else \
		if [ $(TEXT) = "french" ]; then \
			echo " !   $(DIR) : absence de Makefile dans $(DIR)/$(DIR)" ; \
		else \
			echo " !   $(DIR) : no Makefile in $(DIR)/$(DIR)" ; \
		fi ; \
	fi ;

files-tgz-pub:
	@if [ $(TEXT) = "french" ]; then \
		echo " +++ $(DIR) : regle $@" ; \
	else \
		echo " +++ $(DIR) : $@ rule" ; \
	fi ; \
	if [ -e ./files-tgz-pub.txt ] ; then \
		rm ./files-tgz-pub.txt ; \
	fi ; \
	for F in $(TGZ_PUB) ; do \
		if [ -e $$F ]; then \
			echo $$F >> ./files-tgz-pub.txt ; \
		else \
			if [ $(TEXT) = "french" ]; then \
				echo "! $(DIR) : $$F manquant" ; \
			else \
				echo "! $(DIR) : $$F not found" ; \
			fi ; \
		fi ; \
	done ; \
	echo "$(DIR)" >> ./files-tgz-pub.txt ; \
	echo "$(DIR)-$(VERSION)" >> ./files-tgz-pub.txt ; \
	if [ -e $(DIR)/Makefile ]; then \
		$(MAKE) $@ $(MFLAGS) -C $(DIR) ; \
		for F in `cat $(DIR)/files-tgz-pub.txt` ; do \
			echo "$(DIR)/$$F" >> ./files-tgz-pub.txt ; \
		done ; \
	else \
		if [ $(TEXT) = "french" ]; then \
			echo " !   $(DIR) : absence de Makefile dans $(DIR)/$(DIR)" ; \
		else \
			echo " !   $(DIR) : no Makefile in $(DIR)/$(DIR)" ; \
		fi ; \
	fi ;

mod-version:
	@if [ $(TEXT) = "french" ]; then \
		echo " +++ $(DIR) : regle $@"; \
		echo "   + version actuelle : $(VERSION)" ; \
		echo -n "   + versions disponibles : " ; \
	else \
		echo " +++ $(DIR) : $@ rule"; \
		echo "   + current version: $(VERSION)" ; \
		echo -n "   + available versions: " ; \
	fi ; \
	for F in $(DIR)-* ; do echo -n `echo $$F | cut -d'-' -f 2 `" "; done ; \
	echo ; \
	if [ $(TEXT) = "french" ]; then \
		echo -n "   + nouvelle version : " ; \
	else \
		echo -n "   + new version: " ; \
	fi ; \
	read new_version ; \
  if ! [ -e $(DIR)-$$new_version ]; then \
		if [ $(TEXT) = "french" ]; then \
			echo "   - la version $$new_version n'existe pas ($(DIR)-$$new_version non trouve) ;" ; \
			echo "     vous pourrier creer une nouvelle version avec make new-version" ; \
		else \
			echo "   - the version $$new_version does not exist ($(DIR)-$$new_version not found);" ; \
			echo "     you may create a new version by using make new-version" ; \
		fi ; \
		exit ; \
	fi ; \
	if [ $(TEXT) = "french" ]; then \
		echo "   + test d'existence de $(DIR)-$$new_version : ok" ; \
	else \
		echo "   + testing the existence of $(DIR)-$$new_version: ok" ; \
	fi ; \
	if ! [ -e $(DIR) ]; then \
		if [ $(TEXT) = "french" ]; then \
			echo "   * pas de version valide trouvee (aucun lien WHA --> WHA-vX.YZ valide)" ; \
		else \
			echo "   * no current valid version (no valid link WHA --> WHA-vX.YZ)" ; \
		fi ; \
		if [ $(TEXT) = "french" ]; then \
			echo "   + positionnement de la version courante sur $$new_version" ; \
		else \
			echo "   + setting the current version to $$new_version" ; \
		fi ; \
	else \
		if [ `readlink $(DIR)` = $(DIR)-$$new_version ]; then \
			if [ $(TEXT) = "french" ]; then \
				echo "   * $$new_version est deja la version actuelle" ; \
			else \
				echo "   * $$new_version is already the current version" ; \
			fi ; \
			exit ; \
		fi ; \
		if [ $(TEXT) = "french" ]; then \
			echo "   + test de modification : $(VERSION) != $$new_version : ok" ; \
		else \
			echo "   + testing the modification: $(VERSION) != $$new_version: ok" ; \
		fi ; \
		if [ $(TEXT) = "french" ]; then \
			echo "   + passage de la version $(VERSION) a v-$$new_version" ; \
		else \
			echo "   + jump from version $(VERSION) to v-$$new_version" ; \
		fi ; \
	fi ; \
	\rm -f $(DIR) 2> /dev/null ; \
	ln -s $(DIR)-$$new_version $(DIR) ; \
	if [ $(TEXT) = "french" ]; then \
		echo "   + lien $(DIR) --> $(DIR)-$$new_version cree" ; \
		echo "   + la version courrante est maintenant : $(DIR)-$$new_version" ; \
	else \
		echo "   + link $(DIR) --> $(DIR)-$$new_version created" ; \
		echo "   + current version is now: $(DIR)-$$new_version" ; \
	fi ;

new-version:
	@if [ $(TEXT) = "french" ]; then \
		echo " +++ $(DIR) : regle $@" ; \
	else \
		echo " +++ $(DIR) : $@ rule" ; \
	fi ; \
	if ! [ -e $(DIR)-$(VERSION) ] ; then \
		if [ $(TEXT) = "french" ]; then \
			echo "   - la version actuelle n'est pas valide (pas de lien valide $(DIR)-vX.YZ)" ; \
			echo "     vous pouvez reparer cela avec make mod-version" ; \
		else \
			echo "   - current version is not valid (no valid link $(DIR)-vX.YZ)" ; \
			echo "     you may repair this using make mod-version" ; \
		fi ; \
		exit ; \
	fi ; \
	current_version_nb=`echo $(VERSION) | cut -d 'v' -f 2 ` ; \
	new_version_nb=`echo "$(VERSION_STEP) + $$current_version_nb" | bc` ; \
	if [ `echo "$$new_version_nb < 1.0" | bc` ] ; then \
		new_version_nb="0$$new_version_nb" ; \
	fi ; \
	new_version_nb=$${new_version_nb/%0/} ; \
	new_version_nb=$${new_version_nb/%.0/} ; \
	if [ $(TEXT) = "french" ]; then \
		echo "   + passage de la version $(VERSION) a v-$$new_version_nb" ; \
	else \
		echo "   + jump from version $(VERSION) to v-$$new_version_nb" ; \
	fi ; \
	if [ -e $(DIR)-v$$new_version_nb ]; then \
		if [ $(TEXT) = "french" ]; then \
			echo "   - $(DIR) : $(DIR)-v$$new_version_nb existe deja ;" ; \
			echo "           vous pourrier modifier le numero de version actuel avec make mod-version" ; \
		else \
			echo "   - $(DIR) : $(DIR)-v$$new_version_nb already exists;" ; \
			echo "           you may modify the current version number using make mod-version" ; \
		fi ; \
		exit ; \
	fi ; \
	cp -r $(DIR)-$(VERSION) $(DIR)-v$$new_version_nb ; \
	if [ $(TEXT) = "french" ]; then \
		echo "   + repertoire $(DIR)-v$$new_version_nb cree a partir de $(DIR)-$(VERSION)" ; \
	else \
		echo "   + directory $(DIR)-v$$new_version_nb created from $(DIR)-$(VERSION)" ; \
	fi ; \
	rm $(DIR) ; \
	ln -s $(DIR)-v$$new_version_nb $(DIR) ; \
	if [ $(TEXT) = "french" ]; then \
		echo "   + lien $(DIR) --> $(DIR)-v$$new_version_nb cree" ; \
		echo "   + la version courrante est maintenant : $(DIR)-v$$new_version_nb" ; \
	else \
		echo "   + link $(DIR) --> $(DIR)-v$$new_version_nb created" ; \
		echo "   + current version is now: $(DIR)-v$$new_version_nb" ; \
	fi ;

# Used by the newapp.sh shell script
print-tgz-dev:
	@echo "$(TGZ_DEV)"

show-version:
	@if [ $(TEXT) = "french" ]; then \
		echo " +++ $(DIR) : regle $@" ; \
		echo "     repertoire d'installation = $(DIR_INSTALL)" ; \
		echo "     version utilisee = $(VERSION)" ; \
		echo "     license   =`cat license.txt | grep "license type:" | cut -d':' -f2`" ; \
		echo "     auteur(s) =`cat license.txt | grep "software author(s):" | cut -d':' -f2`" ; \
	else \
		echo " +++ $(DIR) : $@ rule" ; \
		echo "     install directory = $(DIR_INSTALL)" ; \
		echo "     current version = $(VERSION)" ; \
	  echo "     license   =`cat license.txt | grep "license type:" | cut -d':' -f2`" ; \
	  echo "     author(s) =`cat license.txt | grep "software author(s):" | cut -d':' -f2`" ; \
	fi ;


tgz-pub: files-tgz-pub
	@if [ $(TEXT) = "french" ]; then \
		echo " +++ $(DIR) : regle $@" ; \
	  echo "     fabrication de l'archive airplug-$(DIR)-$(VERSION)-pub-`hostname`-`date +%Y"-"%m"-"%d`.tgz" ; \
	else \
		echo " +++ $(DIR) : $@ rule" ; \
	  echo "     building archive airplug-$(DIR)-$(VERSION)-pub-`hostname`-`date +%Y"-"%m"-"%d`.tgz" ; \
	fi ; \
	if  ! [ -e tgz-history.txt ] ; then \
		touch tgz-history.txt ; \
	fi ; \
	if [ $(TEXT) = "french" ]; then \
		echo "$@ dans `pwd` sur `hostname` le `date +%A" "%d" "%B" "%Y" a "%k"h"%M":"%S`" >> tgz-history.txt ; \
	else	\
		echo "$@ in `pwd` on `hostname`, `date +%A" "%d" "%B" "%Y" at "%k"h"%M":"%S`" >> tgz-history.txt ; \
	fi ; \
	tar --no-recursion -czf airplug-$(DIR)-$(VERSION)-pub-`hostname`-`date +%Y"-"%m"-"%d`.tgz `cat files-tgz-pub.txt` ;


tgz-dev: files-tgz-dev
	@if [ $(TEXT) = "french" ]; then \
		echo " +++ $(DIR) : regle $@" ; \
		echo "     fabrication de l'archive airplug-$(DIR)-$(VERSION)-dev-`hostname`-`date +%Y"-"%m"-"%d`.tgz" ; \
	else \
		echo " +++ $(DIR) : $@ rule" ; \
		echo "     building archive airplug-$(DIR)-$(VERSION)-dev-`hostname`-`date +%Y"-"%m"-"%d`.tgz" ; \
	fi ; \
	if  ! [ -e tgz-history.txt ] ; then \
		touch tgz-history.txt ; \
	fi ; \
	if [ $(TEXT) = "french" ]; then \
		echo "$@ dans `pwd` sur `hostname` le `date +%A" "%d" "%B" "%Y" a "%k"h"%M":"%S`" >> tgz-history.txt ; \
	else \
		echo "$@ in `pwd` on `hostname`, `date +%A" "%d" "%B" "%Y" at "%k"h"%M":"%S`" >> tgz-history.txt ; \
	fi ; \
	tar --no-recursion -czf airplug-$(DIR)-$(VERSION)-dev-`hostname`-`date +%Y"-"%m"-"%d`.tgz `cat files-tgz-dev.txt` ;


