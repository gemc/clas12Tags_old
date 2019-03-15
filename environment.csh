#!/bin/tcsh -f

# tcsh instead of csh as some distributions of Linux with obsolete versions of csh

if( "$1" != "" ) then
	setenv CLAS12TAG $1
else
	setenv CLAS12TAG 4.3.0
	echo Warning: TAG not given, set to default 4.3.0
endif

setenv GEMC /group/clas12/gemc/$CLAS12TAG/source
setenv GEMC_VERSION $CLAS12TAG
setenv GEMC_DATA_DIR /group/clas12/gemc/$CLAS12TAG
setenv FIELD_DIR /site/12gev_phys/noarch/data

if($CLAS12TAG == 4.3.0 || $CLAS12TAG == 4.3.1) then
	source /site/12gev_phys/softenv.csh 2.3 keepmine
else if($CLAS12TAG == 4a.2.4) then
	source /site/12gev_phys/softenv.csh 2.2 keepmine
else
	source /site/12gev_phys/softenv.csh 2.1 keepmine
endif

set path = ($GEMC/bin/$OSRELEASE $path)

