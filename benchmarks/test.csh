#!/bin/csh

# Copy the latest production gcard to ecAll gcard
# Modify ecAll gcard if necessary
# Copy content to pcal, then remove ec.
# Copy pcal content to ftof, then remove pcal. ETC.

set GVERSION = 4.3.2

mkdir -p results/$GVERSION

foreach g (`\ls *.gcard`)
	set c = `echo $g | awk -F. '{print $1}'`
	echo
	echo $c
	echo

	rm -f $c.txt
	gemc $g -USE_GUI=0 -N=2000 -PRODUCTIONCUT=20 > $c.txt

	mv $c.txt results/$GVERSION
end
