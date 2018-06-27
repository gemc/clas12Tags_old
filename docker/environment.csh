#!/bin/csh -f

setenv JLAB_ROOT /jlab
setenv JLAB_VERSION 2.2
setenv CLAS12TAG 4a.2.3

setenv GEMC /jlab/clas12tags/$CLAS12TAG/source
setenv GEMC_VERSION $CLAS12TAG

source $JLAB_ROOT/$JLAB_VERSION/ce/jlab.csh keepmine
