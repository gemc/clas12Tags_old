#
# This is the DetecorPy package, a set of Python classes that help in building Geant4
# geometry for GEMC.
#
# All classes have internal documentation.
#
# Authors:
#    Maurik Holtrop  (holtrop@jlab.org)
#
__all__ = ["detector","volume","material","mirror","sensitiveDetector"]

from detector import detector
from volume   import volume
from sensitiveDetector import sensitiveDetector
from material import material
from mirror   import mirror

# Various output factories:
from GeometryText import GeometryText

try:
    import MySQLdb
    from GeometryMySQL import GeometryMySQL
except:
    print("Python was not able to import MySQLdb, so export/import to/from MySQL is not available.")


try:
    import ROOT
    from GeometryROOT import GeometryROOT
except:
    print("Python was not able to import ROOT (i.e. PyROOT), so export/import to/from ROOT, and showing geometry with GeometryROOT, is not available.")
