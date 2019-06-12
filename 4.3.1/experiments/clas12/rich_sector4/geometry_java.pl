# Written by Andrey Kim (kenjo@jlab.org)
package coatjava;

use strict;
use warnings;

use geometry;
use GXML;

my ($mothers, $positions, $rotations, $types, $dimensions, $ids);

my $npaddles = 48;

sub makeRICH
{
	($mothers, $positions, $rotations, $types, $dimensions, $ids) = @main::volumes;

	my $dirName = shift;
	build_gxml($dirName);
}

sub build_gxml
{
	my $dirName = shift;
	my $gxmlFile = new GXML($dirName);

	build_MESH($gxmlFile);
	build_PMTs();
	#build_upLightGuides($gxmlFile);
	#build_downLightGuides($gxmlFile);

	$gxmlFile->print();
}

sub build_MESH
{
	my $gxmlFile = shift;
#	my @allMeshes =("OpticalGasVolume", "Aluminum","AerogelTiles","CFRP","Glass","TedlarWrapping","SphericalMirrors");
	my @allMeshes =("Aluminum","AerogelTiles","CFRP","Glass","TedlarWrapping","SphericalMirrors","BottomMirror","BottomRightMirror","TopRightMirror","BottomLeftMirror","TopLeftMirror");
	foreach my $mesh (@allMeshes)
	{
		my %detector = init_det();

		my $vname                = $mesh;

		$detector{"name"}        = $vname;
		$detector{"pos"}         = $positions->{$vname};
		$detector{"rotation"}    = $rotations->{$vname};
		$detector{"mother"}      = $mothers->{$vname};
		
		if($mesh eq "Aluminum"){
			$detector{"color"}       = "4444ff";
			$detector{"material"}    = "G4_Al";
			$detector{"identifiers"}    = "aluminum";
		}
		elsif($mesh eq "AerogelTiles"){
			$detector{"color"}       = "664444";
			$detector{"material"}    = "aerogel";
			$detector{"identifiers"}    = "aluminum";

		}
		elsif($mesh eq "CFRP"){
			$detector{"color"}       = "44ff44";
			$detector{"material"}    = "CarbonFiber";
			$detector{"identifiers"}    = "aluminum";
		}
		elsif($mesh eq "Glass"){
			$detector{"color"}       = "777777";
			$detector{"material"}    = "G4_PYREX_GLASS";
      $detector{"sensitivity"}    = "mirror: rich_AlMgF2";
      $detector{"hit_type"}    = "mirror";
      $detector{"identifiers"}    = "sector manual 4 pad manual 998 pixel manual 8";

		}
		elsif($mesh eq "TedlarWrapping"){
			$detector{"color"}       = "444444";
			$detector{"material"}    = "G4_AIR";
			$detector{"identifiers"}    = "aluminum";
		}
		elsif($mesh eq "OpticalGasVolume"){
			$detector{"color"}       = "444444";
			$detector{"style"}       = "wireframe";
			$detector{"material"}    = "Air_Opt";
		}
    elsif($mesh eq "SphericalMirrors"){
      $detector{"color"}       = "b399ff";
      $detector{"material"}    = "CarbonFiber";
      $detector{"sensitivity"}    = "mirror: rich_AlMgF2";
      $detector{"hit_type"}    = "mirror";
      $detector{"identifiers"}    = "sector manual 1";
    }
    
    elsif($mesh eq "BottomMirror"){
      $detector{"color"}       = "99ccff";
      $detector{"material"}    = "G4_PYREX_GLASS";
      $detector{"sensitivity"}    = "mirror: rich_AlMgF2";
      $detector{"hit_type"}    = "mirror";
      $detector{"identifiers"}    = "sector manual 2";
    }
    elsif($mesh eq "BottomRightMirror"){
      $detector{"color"}       = "b399ff";
      $detector{"material"}    = "G4_PYREX_GLASS";
      $detector{"sensitivity"}    = "mirror: rich_AlMgF2";
      $detector{"hit_type"}    = "mirror";
      $detector{"identifiers"}    = "sector manual 3";
    }
    elsif($mesh eq "TopRightMirror"){
      $detector{"color"}       = "cc99ff";
      $detector{"material"}    = "G4_PYREX_GLASS";
      $detector{"sensitivity"}    = "mirror: rich_AlMgF2";
      $detector{"hit_type"}    = "mirror";
      $detector{"identifiers"}    = "sector manual 4";
    }
    elsif($mesh eq "BottomLeftMirror"){
      $detector{"color"}       = "b399ff";
      $detector{"material"}    = "G4_PYREX_GLASS";
      $detector{"sensitivity"}    = "mirror: rich_AlMgF2";
      $detector{"hit_type"}    = "mirror";
      $detector{"identifiers"}    = "sector manual 5";
    }
    elsif($mesh eq "TopLeftMirror"){
      $detector{"color"}       = "cc99ff";
      $detector{"material"}    = "G4_PYREX_GLASS";
      $detector{"sensitivity"}    = "mirror: rich_AlMgF2";
      $detector{"hit_type"}    = "mirror";
      $detector{"identifiers"}    = "sector manual 6";
    }


		$gxmlFile->add(\%detector);
	}
}

 my $nPMTS  = 0 ;

sub build_PMTs{
	my $PMT_rows = 23;
	for(my $irow=0; $irow<$PMT_rows; $irow++){
		my $nPMTInARow = 6 + $irow;

		for(my $ipmt=0; $ipmt<$nPMTInARow; $ipmt++){
			my $vname = sprintf("MAPMT_${irow}_${ipmt}");
			my %detector = init_det();
      
      $nPMTS++;
			
      %detector = init_det();
			$detector{"name"}        = "$vname";
			$detector{"mother"}      = $mothers->{$vname};
			$detector{"description"} = "PMT mother volume";
			$detector{"pos"}         = $positions->{$vname};
			$detector{"rotation"}    = $rotations->{$vname};
			$detector{"color"}       = "444444";
			$detector{"type"}        = $types->{$vname};
			$detector{"dimensions"}  = $dimensions->{$vname};
			$detector{"material"}    = "Air_Opt";

			print_det(\%main::configuration, \%detector);

			my @Case = ("Top","Bottom","Left","Right");
			foreach my $section (@Case){
				my $AlCase = sprintf("Al${section}_${vname}");
				my %detector = init_det();
	
				$detector{"name"}        = "$AlCase";
				$detector{"mother"}      = $mothers->{$AlCase};
				$detector{"description"} = "PMT mother volume";
				$detector{"pos"}         = $positions->{$AlCase};
				$detector{"rotation"}    = $rotations->{$AlCase};
				$detector{"type"}        = $types->{$AlCase};
				$detector{"dimensions"}  = $dimensions->{$AlCase};
        $detector{"material"}    = "G4_Al";
				$detector{"style"}    = "0";
				print_det(\%main::configuration, \%detector);
			}
			
			my $Socket = sprintf("Socket_${vname}");
			
			%detector = init_det();
			$detector{"name"}        = "$Socket";
			$detector{"mother"}      = $mothers->{$Socket};
			$detector{"description"} = "PMT mother volume";
			$detector{"pos"}         = $positions->{$Socket};
			$detector{"rotation"}    = $rotations->{$Socket};
			$detector{"color"}       = "ff9900";
			$detector{"type"}        = $types->{$Socket};
			$detector{"dimensions"}  = $dimensions->{$Socket};
      $detector{"material"}    = "G4_Cu";
    

			print_det(\%main::configuration, \%detector);
			
			my $Window = sprintf("Window_${vname}");
			
			%detector = init_det();
			$detector{"name"}        = "$Window";
			$detector{"mother"}      = $mothers->{$Window};
			$detector{"description"} = "PMT mother volume";
			$detector{"pos"}         = $positions->{$Window};
			$detector{"rotation"}    = $rotations->{$Window};
			$detector{"color"}       = "99bbff";
			$detector{"type"}        = $types->{$Window};
			$detector{"dimensions"}  = $dimensions->{$Window};
      $detector{"material"}    = "Glass_H8500";
			print_det(\%main::configuration, \%detector);
			
			my $Photocathode = sprintf("Photocathode_${vname}");
			
			%detector = init_det();
			$detector{"name"}        = "$Photocathode";
			$detector{"mother"}      = $mothers->{$Photocathode};
			$detector{"description"} = "PMT mother volume";
			$detector{"pos"}         = $positions->{$Photocathode};
			$detector{"rotation"}    = $rotations->{$Photocathode};
			$detector{"color"}       = "999966";
			$detector{"type"}        = $types->{$Photocathode};
			$detector{"dimensions"}  = $dimensions->{$Photocathode};
			$detector{"material"}    = "Air_Opt";
      $detector{"sensitivity"} = "rich";
      $detector{"hit_type"}    = "rich";
      $detector{"identifiers"} = "sector manual 4 pad manual $nPMTS pixel manual 1";
			print_det(\%main::configuration, \%detector);
			
		}
	}
   print "Produced $nPMTS pmt  " ;
}


sub build_fake_mother
{
	my $microgap = 0.1;

	my $TorusLength = 2158.4/2.0;  # 1/2 length of torus
	my $TorusZpos   = 3833;        # center of the torus position (include its semilengt). Value from M. Zarecky, R. Miller PDF file on 1/13/16

	my $torusZstart = $TorusZpos - $TorusLength - $microgap;
	my $torusZEnd   = $TorusZpos + $TorusLength + $microgap;

	my $nplanes_Cone = 8;

	my @z_plane_Cone = ( 1206.0,  1556.0, 2406.0, $torusZstart,  $torusZstart, $torusZEnd, $torusZEnd, 8500.0 );
	my @iradius_Cone = ( 2575.0,  2000.0,  132.0,        132.0,          61.5,       61.5,      197.0,  197.0 );
	my @oradius_Cone = ( 2575.0,  3500.0, 4800.0,       5000.0,        5000.0,     5000.0,     5000.0, 5000.0 );

		my %detector = init_det();
	
		$detector{"name"}        = "fc";
		$detector{"mother"}      = "root";
		$detector{"description"} = "Forward Carriage (FC) detector envelope to hold the torus magnet and the FC detectors";
		$detector{"pos"}         = "0*mm 0.0*mm 0*mm";
		$detector{"rotation"}    = "0*deg 0*deg 0*deg";
		$detector{"color"}       = "88aa88";
		$detector{"type"}        = "Polycone";
	
		my $dimen = "0.0*deg 360*deg $nplanes_Cone*counts";
		for(my $i = 0; $i <$nplanes_Cone; $i++) {$dimen = $dimen ." $iradius_Cone[$i]*mm";}
		for(my $i = 0; $i <$nplanes_Cone; $i++) {$dimen = $dimen ." $oradius_Cone[$i]*mm";}
		for(my $i = 0; $i <$nplanes_Cone; $i++) {$dimen = $dimen ." $z_plane_Cone[$i]*mm";}
		$detector{"dimensions"}  = $dimen;

		$detector{"material"}    = "Air_Opt";
		#$detector{"mfield"}      = "clas12-torus-big";
		$detector{"visible"}     = 0;
		$detector{"style"}       = 0;
		print_det(\%main::configuration, \%detector);
}

1;
