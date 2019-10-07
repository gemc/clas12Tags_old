#!/bin/csh 


# Copy the latest production gcard to ecAll gcard
# Modify ecAll gcard if necessary
# Copy content to pcal, then remove ec.
# Copy pcal content to ftof, then remove pcal. ETC.

set GVERSION = 4.3.2
set NEVENTS = 1000


setenv GEMC_DATA_DIR /opt/projects/gemc/clas12Tags/$GVERSION/

echo
echo
echo GEMC_DATA_DIR: $GEMC_DATA_DIR
echo
echo

mkdir -p results/$GVERSION

foreach g (ltcc ftof)
#foreach d (target svt ctof cnd solenoid mm htcc torus ft dc rich ltcc ftof pcal ecAll)

	echo
	echo $g $g $g $g $g
	echo

	rm -f $g.txt
	gemc $g".gcard" -USE_GUI=0 -N=$NEVENTS  > $g.txt

	mv $g.txt results/$GVERSION
end
