#!/bin/csh -f

if( "$1" != "" ) then
	setenv CLAS12TAG $1
else
	setenv CLAS12TAG 4a.2.3
        echo Warning: TAG not given, set to default 4a.2.3
endif

setenv JLAB_ROOT /jlab
setenv JLAB_VERSION 2.1

setenv GEMC /jlab/clas12tags/$CLAS12TAG/source
setenv GEMC_VERSION $CLAS12TAG


source source $JLAB_ROOT/$JLAB_VERSION/ce/jlab.sh keepmine
