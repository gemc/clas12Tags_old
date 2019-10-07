#!/bin/csh 


# Copy the latest production gcard to ecAll gcard
# Modify ecAll gcard if necessary
# Copy content to pcal, then remove ec.
# Copy pcal content to ftof, then remove pcal. ETC.

set GVERSION = 4.3.2
set NEVENTS = 5000


setenv GEMC_DATA_DIR /opt/projects/gemc/clas12Tags/$GVERSION/

echo
echo
echo GEMC_DATA_DIR: $GEMC_DATA_DIR
echo
echo

mkdir -p results/$GVERSION

foreach g (`\ls *.gcard`)
	set c = `echo $g | awk -F. '{print $1}'`
	echo
	echo $c $c $c $c $c $c $c $c $c
	echo $c $c $c $c $c $c $c $c $c
	echo $c $c $c $c $c $c $c $c $c
	echo $c $c $c $c $c $c $c $c $c
	echo

	rm -f $c.txt
	gemc $g -USE_GUI=0 -N=$NEVENTS  > $c.txt

	mv $c.txt results/$GVERSION
end
