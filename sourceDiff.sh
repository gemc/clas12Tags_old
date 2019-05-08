#!/bin/csh -f

# script to show differences between source and a tag source
# if second option prompt is given, then the script will ask for user input
# to copy each file into the tag

# note: if gemc.cc has differences other than the tag version, it will be considered as well
# make sure that the tag source version is the right one
set sourceTAG = "2.8"

if( "$1" != "" ) then
	set tagVersion = $1
else
	echo Warning: TAG not given
	exit
endif


set prompt = "no"
if( "$2" == "prompt" ) then
	set prompt = "yes"
endif

echo
echo TAG: $tagVersion
echo Prompt: $prompt
echo


# doing the diff one dir up
cd ..

# diff summary printed on screen
echo DIFF OUTPUT:
echo
diff -r -q source clas12Tags/$tagVersion/source | grep -v \.git | grep -v sconsign\.dblite | grep -v gemc\.cc
echo
echo

# assuming format like:
# Files source/utilities/options.h and clas12Tags/4.3.1/source/utilities/options.h differ

set sourcesChanged = `diff -r -q source clas12Tags/$tagVersion/source | grep -v gemc.cc | grep differ | awk '{print $2}'`
set tagFiles       = `diff -r -q source clas12Tags/$tagVersion/source | grep -v gemc.cc | grep differ | awk '{print $4}'`

echo FILES CHANGED:
set i = 1
foreach file ($sourcesChanged)
	if ($prompt == "no") then
		echo source: $sourcesChanged[$i]", destination: "$tagFiles[$i]
	else
		echo Source: $sourcesChanged[$i]", destination: "$tagFiles[$i] ". Resolve diff (y/n)?"
		set req = $<
		if ($req == "y") then
			cp $sourcesChanged[$i] $tagFiles[$i]
			echo source: $sourcesChanged[$i]" copied to destination: "$tagFiles[$i]
			echo
			echo
		endif
	endif
	@ i += 1
end
echo


# not checking gemc.cc
set maincc = `diff source/gemc.cc clas12Tags/$tagVersion/source/gemc.cc | grep -v GEMC\_VERSION | head -1`
# if the differentce is NOT GEMC_VERSION (line 32)
if ("$maincc" != "32c32") then
	if ($prompt == "no") then
		echo FOUND gemc.cc differences other than the tag version
		diff source/gemc.cc clas12Tags/$tagVersion/source/gemc.cc | grep -v GEMC\_VERSION
	else
		echo
		echo "gemc.cc has changes. Resolve (y/n)?"
		set req = $<
		if ($req == "y") then
			cp source/gemc.cc clas12Tags/$tagVersion/source/
		endif
	endif
endif

# checking that the right version is on gemc.cc
cd clas12Tags/$tagVersion/source
set GVERSION = `grep GEMC\_VERSION gemc.cc | grep $tagVersion | wc | awk '{print $1}'`
if ($GVERSION != "1") then
	echo gemc tag version is not $tagVersion. Fixing it.
	sed -i '' s/"const char .*"/'const char *GEMC_VERSION = "gemc 4.3.2" ; '/ gemc.cc
endif
