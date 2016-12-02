#!/bin/csh -f


source /site/12gev_phys/production.csh 2.0


if( "$1" != "" ) then
	setenv CLAS12TAG $1
else
	setenv CLAS12TAG = 3a.0.0
endif

setenv GEMC /group/clas12/gemc/$CLAS12TAG/source
setenv GEMC_VERSION $CLAS12TAG
set path = ($GEMC/bin/$OSRELEASE $path)

