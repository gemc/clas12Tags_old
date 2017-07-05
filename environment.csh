#!/bin/csh -f

if( "$1" != "" ) then
	setenv CLAS12TAG $1
else
	setenv CLAS12TAG 4a.1.0
endif

if($CLAS12TAG == 4a.1.1) then
	source /site/12gev_phys/production.csh 2.1
else
	source /site/12gev_phys/production.csh 2.1
endif

setenv GEMC /group/clas12/gemc/$CLAS12TAG/source
setenv GEMC_VERSION $CLAS12TAG
set path = ($GEMC/bin/$OSRELEASE $path)

