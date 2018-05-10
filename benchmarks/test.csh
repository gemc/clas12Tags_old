#!/bin/csh


foreach g (`\ls *.gcard`)
	set c = `echo $g | awk -F. '{print $1}'`
	echo
	echo $c
	echo

	rm -f $c.txt
	gemc $g -USE_GUI=0 -N=2000 -PRODUCTIONCUT=20 > $c.txt

end
