#!/bin/csh -f


set filename = $1

echo porting $filename

# replacing volume definition, removing obsolete hit_type
sed s/dimensions/parameters/ $filename | grep -v "hit_type" > port1
sed s/identifiers/touchableID/ port1 > port2
sed s/mfield/emfield/ port2 > port3
sed s/root/world/ port3 > port4
sed s/rotation/rot/ port4 > port5

# replacing geant4 volume definitions
sed s/Box/G4Box/                       port5  > portx4
sed s/Parallelepiped/G4Para/           portx4 > portx5
sed s/Sphere/G4Sphere/                 portx5 > portx6
sed s/Ellipsoid/G4Ellipsoid/           portx6 > portx7
sed s/Paraboloid/G4Paraboloid/         portx7 > portx8
sed s/Hype/G4Hype/                     portx8 > portx9
sed s/Tube/G4Tubs/                     portx9 > portx10
sed s/CTube/G4CutTubs/                 portx10 > portx11
sed s/EllipticalTube/G4EllipticalTube/ portx11 > portx12
sed s/Cons/G4Cons/                     portx12 > portx13
sed s/Trd/G4Trd/                       portx13 > portx14
sed s/ITrd/G4Trap/                     portx14 > portx15
sed s/Pgon/G4Polyhedra/                portx15 > portx16
sed s/Polycone/G4Polycone/             portx16 > portx17

mv portx17 geometry3.pl
rm port*



