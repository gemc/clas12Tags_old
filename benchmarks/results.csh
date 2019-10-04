#!/bin/csh -f


# Notice: The order of the gcards is very important, check that the detectors are loaded accordingly

set GVERSION = 4.3.2
set NEVENTS = 500
set res = results/$GVERSION/results.txt

rm $res ; touch $res

foreach c (`\ls results/$GVERSION/*.txt | grep -v results.txt`)
	echo " > "$c  >> $res
	grep " Events only time" $c >> $res
end

# Ordering results for the screen

foreach d (target svt ctof cnd solenoid mm htcc dc torus ft rich ltcc ftof pcal ecAll)
	if (`grep $NEVENTS  results/$GVERSION/$d.txt | grep Routine | wc | awk '{print $1}'` == "2") then
		echo $d `grep -A1 $d $res | tail -1 | awk -F"Events only time:" '{print $2}' | awk '{print $1}'`
	else
		echo
		echo Error: $d does not have $NEVENTS Events
		echo
	endif
end

