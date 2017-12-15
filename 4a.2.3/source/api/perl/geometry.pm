package geometry;
require Exporter;

#use lib ("$ENV{GEMC}/io");
use utils;
use 5.010;

@ISA = qw(Exporter);
@EXPORT = qw(print_det init_det);


# Initialize hash maps with default
sub init_det
{
	my %detector = ();
	
	# These default value can be left off on the API
	$detector{"description"} = "no description";

	$detector{"parameters"}   = "na";
	
	$detector{"visible"}     = 1;
	$detector{"style"}       = 0;
	$detector{"color"}       = "999999";

	$detector{"emfield"}     = "inherit";

	$detector{"pos"} = "0*cm 0*cm 0*cm";
	$detector{"rot"} = "0*deg 0*deg 0*deg";
	
	$detector{"sensitivity"} = "na";
	$detector{"touchableID"} = "na";

	$detector{"copyOf"}     = "na";
	$detector{"replicaOf"}  = "na";
	$detector{"pCopyNo"}    = 0;
	$detector{"solidsOpr"}  = "na";

	$detector{"mirror"}     = "na";

	return %detector;
}


# Print detector to TEXT file or upload it onto the DB
sub print_det
{
	my %configuration = %{+shift};
	my %det           = %{+shift};
	
	my $table = $configuration{"detector_name"}."__geometry";
	my $varia = $configuration{"variation"};
	
	# converting the hash maps in local variables - trimming leading and trainling spaces
	
	my $name        = trim($det{"name"});
	my $mother      = trim($det{"mother"});
	my $description = trim($det{"description"});
	
	my $type        = trim($det{"type"});
	my $parameters  = trim($det{"parameters"});
	
	my $visible     = trim($det{"visible"});
	my $style       = trim($det{"style"});
	my $color       = trim($det{"color"});

	my $material    = trim($det{"material"});
	my $emfield     = trim($det{"emfield"});

	my $pos         = trim($det{"pos"});
	my $rot         = trim($det{"rot"});
	
	my $sensitivity = trim($det{"sensitivity"});
	my $touchableID = trim($det{"touchableID"});

	my $copyOf       = trim($det{"copyOf"});
	my $replicaOf    = trim($det{"replicaOf"});
	my $pCopyNo      = trim($det{"pCopyNo"});
	my $solidsOpr    = trim($det{"solidsOpr"});
	
	my $mirror       = trim($det{"mirror"});

	# "state" is a static variable`
	state $counter = 0;
	state $this_variation = "";
	
	# TEXT Factory
	if($configuration{"factory"} eq "TEXT")
	{
		my $file = $configuration{"detector_name"}."__geometry_".$varia.".txt";
		if($counter == 0 || $this_variation ne  $varia)
		{
			`rm -f $file`;
			print "Overwriting if existing: ",  $file, "\n";
			$counter = 1;
			$this_variation = $varia;
		}

		open(INFO, ">>$file");
		printf INFO ("%20s  |", $name);
		printf INFO ("%20s  |", $mother);
		printf INFO ("%30s  |", $description);
		
		printf INFO ("%20s  |", $type);
		printf INFO ("%60s  |", $parameters);

		printf INFO ("%4s   |", $visible);
		printf INFO ("%4s   |", $style);
		printf INFO ("%7s   |", $color);
		
		printf INFO ("%20s  |", $material);
		printf INFO ("%20s  |", $emfield);

		printf INFO ("%50s  |", $pos);
		printf INFO ("%40s  |", $rot);
		
		printf INFO ("%20s  |", $sensitivity);
		printf INFO ("%40s  |", $touchableID);
		
		printf INFO ("%20s  |", $copyOf);
		printf INFO ("%20s  |", $replicaOf);
		printf INFO ("%6s   |", $pCopyNo);
		printf INFO ("%30s  |", $solidsOpr);

		printf INFO ("%20s   \n", $mirror);

		close(INFO);
	}
}


1;





