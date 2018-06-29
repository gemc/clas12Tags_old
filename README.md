
The clas12Tags are a series of clas12 specific tags of the GEMC source code and geometry, installed in /group/clas12/gemc.

### Current PRODUCTION version: **_4a.2.3_**, compatible with **_COATJAVA 5b.3.3_** and above. JLAB_SOFTWARE version: 2.1.

<hr>

To use the latest production tag (currently 4a.2.3):

```source /group/clas12/gemc/environment.csh```

You can also specific a different tag:

```source /group/clas12/gemc/environment.csh <tag>  ```

To run gemc use the tagged gcard:

```gemc /group/clas12/gemc/4a.2.3/clas12.gcard -N=nevents -USE_GUI=0 ```

To run gemc using the **new magnetic field map**:

```gemc /group/clas12/gemc/4a.2.3/clas12NF.gcard -N=nevents -USE_GUI=0 ```

<br>

FTOn, FTOff configurations
--------------------------

The default configuration for the first experiment is with "FTOn" (Figure 1, Left): complete forward tagger is fully operational.
The other available configuration is "FTOff" (Figure 1, Right): the Forward Tagger tracker is replaced with shielding, and the tungsten cone is moved upstream.

The simulations in preparation of the first experiment should use the default version FTOn.
FTOff will be used only by experts for special studies in preparation for the engineering run.

<a href="url"><img src="https://github.com/gemc/clas12Tags/blob/master/ftOn.png" align="left" width="400" ></a>
<a href="url"><img src="https://github.com/gemc/clas12Tags/blob/master/ftOff.png" align="left" width="400" ></a>

<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br>


###### Figure 1. Left: FT On configuration: Full, OperationalForward Tagger. Right: FT Off configuration: FT Tracker replaced by shielding, Tungsten Cone moved upstream, FT if turned off.

<br>



To change configuration from FTOn to FTOff, replace the keywords and variations from:


```     
<detector name="ft" factory="TEXT" variation="FTOn"/>
<detector name="beamline" factory="TEXT" variation="FTOn"/>
<detector name="cadBeamline/" factory="CAD"/> 
```
    
to:


```
<detector name="ft" factory="TEXT" variation="FTOff"/>
<detector name="beamline" factory="TEXT" variation="FTOff"/>
<detector name="cadBeamlineFTOFF/" factory="CAD"/> 
```



<br><br>

Magnetic Fields
---------------

You can change the magnetic field using the SCALE_FIELD option. To do that copy the gcard somewhere first, then modify it. The gcard can work from any location.
Example on how to run at 80% torus field (inbending) and 60% solenoid field:

```
 <option name="SCALE_FIELD" value="TorusSymmetric, -0.8"/>
 <option name="SCALE_FIELD" value="clas12-solenoid, 0.6"/>
```

<br><br>

Hydrogen, Deuterium or empty target
-----------------------------------

By default the target cell is filled with liquid hydrogen. To use liquid deuterium instead use the SWITCH_MATERIALTO option:

```
 <option name="SWITCH_MATERIALTO" value="G4_lH2, LD2"/>
```

To use an empty target instead:
```
 <option name="SWITCH_MATERIALTO" value="G4_lH2, G4_Galactic"/>
```


<br><br>

How to install
----------------

Starting with 4a.2.4 gemc is distributed  <a href="https://gemc.jlab.org/gemc/html/docker.html"> using docker</a>.

<br><br>

How to install (4a.2.3 and earlier versions)
------------------------------------------------

The clas12tags can be installed on top of an existing [jlab installation. For 4a.2.3 it's JLAB_VERSION 2.1](https://www.jlab.org/12gev_phys/packages/sources/ceInstall/2.1_install.html).
To do that:

1. clone https://github.com/gemc/clas12Tags
2. cd to the tag you want to use
3. type `<scons -j4 OPT=1>`

This will compile a gemc executable in that directory. Remember to use the full path to that executable when running gemc, otherwise the OS will pick up the default from the $GEMC env variable.

Each tag has the production gcard inside its directory. To use: change the path from 
``` /group/clas12/gemc/4a.2.3 ``` to the proper location of your disk.

<br><br>

Software, Geometry Tags
=======================


	
Production:
-----------

<br>


- 4a.2.3 (compatible with COATJAVA 5b.3.3): Same as 4a.2.2 with in addition:

	- ctof, ftof banks: 1 ADC output / pmt instead of ADCL/ADCR for a single paddle)
	- CTOF, FTOF Paddle to PMT digitization for FADC
	- background merging algorithm framework
	- background merging algorithm implementation in digitization: DC, BST and MM.
	- Correct field geant4-caching
	- Solenoid integration method: G4ClassicalRK4 to fix some geant4 navigation issues in the field. Slower but more reliable (should have less crashes)
	- SYNRAD option to activate synchrotone radiation in vacuum (SYNRAD=1) or any material (SYNRAD=2)
	- dc gas material changed to 90% Ar, 10% G4_CARBON_DIOXIDE.
	- RF shift from target center: added option RFSTART: Radio-frequency time model. Available values are:
	  - "eventVertex, 0, 0, 0" (default): the RF time is the event start time + the light time-distance of the first particle from the point (0,0,0)
	  - "eventTime".....................: the RF time is identical to the event start time


<br>



In development:
---------------

<br>

- 4a.2.4: Same as 4a.2.3 but uses JLAB_VERSION 2.2. In addition:

	- Use new torus field map
	- FMT shift by 8mm
	- use run number 11 as default in the gcard
	- FMT background hits
	- production cut set for individual volumes in the options
	- new geant4 version
   - env variable "GEMC_DATA_DIR" as a base path in the gcard (gcard is now portable to other systems)


<br>

- 4a.2.5: Same as 4a.2.4 with in addition:

	- Solenoid from CAD models :soon:
	- cnd banks: 1 ADC output / pmt instead of ADCU/ADCD for a single paddle :soon:
	- solenoid field rotation :soon:


<br>

Previous Tags:
--------------


- 4a.2.2: Same as 4a.2.1 with in addition:

	- target from CAD
	- htcc wc invisible
	- no transparency in MM
	- threshold mechanism
	- rotate LUND bank to flat
	- final beamline configuration
	- LTCC sector 4 removed
	- LTCC sector 1 removed
	- DC: Removed unused lines and calculation of smeared doca
	- generator user information are now in two dedicate banks: user header (TAG 11), and user particle infos (TAG 22)
	- MM overlaps with target fixed
	- New numbering scheme for CTOF, CND

<br>

- 4a.2.1: Same as 4a.2.0 with in addition:

	- fixes to CAD modeling of both the beamline and the torus
	- forward carriage volume fixed to accomodate beamline and shielding
	- fixed CND / CTOF overlaps
	- updated latest micromegas geometry
	- MM: Adjust transverse diffusion and ionization potential
	- updated latest BST
	- 3 + 3 configuration BST + MM
	- new vacuum pipe
	- new shield downsttream of the torus
	- LTCC box hierarchy fixed
	- LTCC frame is CAD + copies
	- corrected mini-stagger values for DC
	- Added TDC calibration constants to ec,pcal hitprocess
	- FADC mode 1 (still tuning it to make it exactly like Serguei DAQ)
	- reading tdc_conv for ctof from database
	- fixed an issue with the header bank where the LUND info index was not correct

- 4a.2.0: Same as 4a.1.0 with in addition:
 
  - use JLAB_VERSION 2.1, with new mlibrary
  - Micromegas: updated  geometry and digitization
  - DC: realistic time to distance function, reading constants from CCDB
  - DC: ministagger for DC region 3: "even closer" layers 1,3,5: +300um, SL 2,4,6: -300um
  - LTCC: Reading CCDB SPE calibration constants
  - LTCC: Smearing ADC based on calibration constants
  - CTOF javacad instead of cad (should be indentical)
  - Fixed smeared infor in generated summary for FASTMC mode
  - improved/fixed CND digitization routine
  - updated RF timing (mlibrary) 
  - BST+MM: using 3+3 configurations (no FMT)
  

- 4a.1.0: Same as 4a.0.2 with in addition:

  - fixed a bug that affect output file size 
  - fixed bug that affected multiple cad imports
  - added micromegas geometry and hit processes
  - RF output correct frequency in the clas12 gcard
  - updated FT geometry and hit process
  - updated ftof geometry
  - added reading of FTOF reading of tdc conversion constants from the database
  - check if strip_id is not empty in bmt_ and fmt_strip.cc, otherwise fill it.


- 4a.0.2: Same as 4a.0.1 with in addition: 
  
  - full (box, mirrors, pmts shields and WC) LTCC geometry 
  - LTCC hit process routine.

- 4a.0.1: Same as 4a.0.0 with in addition: 

  - FTOF geometry fix

- 4a.0.0: KPP configuration: 

  - Fixes in source and hit process for FTOF
  - added EC gains. 
  - Java geometry uses now coatjava 3. 
  - Database fixed for DC geometry. 
  - Linear time-to-distance for DC.
  - CTOF in the KPP position configuration in the new kpp.gcard.
  
- 3a.1.0: same as 3a.0.2 with in addition:

  - DC time-to-distance implementation.
  
- 3a.0.2: same as 3a.0.1 with  in addition: 

  - CND fix.
 
- 3a.0.1: same as 3a.0.0 with  in addition:

  - ctof has status working.
  
- 3a.0.0: git commit d3a5dc1, Dec 2 2016. Includes:

  - FTOF and CTOF paddle delays from CCDB
  - CTOF center off-set.



To produce:
-----------

1. create new tag dir
2. change gcard to point to new location
3. change environment.csh to point to the new tag
4. copy $GEMC to source and clean up:

	- cd $GEMC
	- scons -c
	- cd newtag
	- cp -r $GEMC source
	- cd source
	- rm -rf .git*
	- cd api
	- rm -rf .git*

5. mkdir experiments, copy files from gemcApp/experiments
