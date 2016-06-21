#!/bin/bash
# (c) 2016 Norbert Preining
# License: GPLv3+
#
# USAGE:
# call this script with the two envvars below set to proper values
# eg:
#   TLCHECKOUT=/path/to/tl/svn/checkout TLNETDEST=/path/to/created/repo update.sh
# at the moment the generated repository in TLCHECKOUT is *not* signed
# due to the --no-sign option. You would need the TL distribtuion key
# to sign. But you can sign with a different key and tell the users to
# use tlmgr key add etc, see manual.

TLCHECKOUT=${TLCHECKOUT:-/src/TeX/texlive.git}
TLNETDEST=${TLNETDEST:-/var/www/norbert/tlmojca-scheme}

# we don't do TeX Catalogue updates
unset TEX_CATALOGUE

# update tlpdb
$TLCHECKOUT/Master/tlpkg/bin/tl-update-tlpdb \
	-with-w32-pattern-warning -from-files -no-reverse-revision-check \
	--keep-revisions --master=`pwd`

$TLCHECKOUT/Master/tlpkg/bin/tl-update-containers \
	-no-sign     \
	-master `pwd` \
	-location $TLNETDEST	\
	-all -recreate

# sometimes -recreate might be necessary to fully rebuild!

