#!/bin/bash

export JLAB_ROOT=/jlab
export JLAB_VERSION=2.2
export CLAS12TAG=4a.2.4

export GEMC=/jlab/clas12Tags/$CLAS12TAG/source
export GEMC_VERSION=$CLAS12TAG

source $JLAB_ROOT/$JLAB_VERSION/ce/jlab.sh keepmine
export GEMC_DATA_DIR=/jlab/clas12Tags/$CLAS12TAG

set autolist
alias l='ls -l'
alias lt='ls -lt'

