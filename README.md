# clas12Tags


This is a series of tags of the GEMC source code to match the various simulation/calibration/reconstruction software versions.

The tags also contain the geometry files and the gcard to run gemc.

Every tag is installed in /group/clas12/gemc

To use: 

source /group/clas12/gemc/environment.csh

If no tag is given, the script will currently load 3a.0.0.

Tags
----

- 3a.0.1: same as 3a.0.0 but ctof has status working.
- 3a.0.0: git commit d3a5dc1, Dec 2 2016. Includes FTOF and CTOF paddle delays from CCDB, and CTOF center off-set.
