#!/bin/csh -f

set GVERSION = 4.3.2
set res = results/$GVERSION/results.txt

rm $res ; touch $res

foreach c (`\ls results/$GVERSION/*.txt | grep -v results.txt`)
	echo " > "$c  >> $res
	grep " Events only time" $c >> $res
end

# Ordering results for the screen

foreach d (target svt ctof cnd solenoid mm htcc ft torus dc ltcc rich ftof pcal ecAll)
	echo $d `grep -A1 $d $res | tail -1 | awk -F"Events only time:" '{print $2}' | awk '{print $1}'`
end

