#!/bin/csh -f

if( "$1" != "" ) then
	setenv CLAS12TAG $1
else
	setenv CLAS12TAG 4a.2.3
	echo Warning: TAG not given, set to default 4a.2.3
endif

setenv GEMC /group/clas12/gemc/$CLAS12TAG/source
setenv GEMC_VERSION $CLAS12TAG

if($CLAS12TAG == 4a.2.4) then
	source /site/12gev_phys/production.csh 2.2 keepmine
	setenv GEMC_DATA_DIR /group/clas12/gemc/4a.2.4
else
	source /site/12gev_phys/production.csh 2.1 keepmine
endif

set path = ($GEMC/bin/$OSRELEASE $path)

