#!/bin/csh -f


foreach c (`\ls *.txt`)
	echo
	echo " > "$c
	grep " Events only time" $c

end
