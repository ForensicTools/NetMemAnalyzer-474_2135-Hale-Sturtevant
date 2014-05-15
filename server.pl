#/usr/bin/perl

use strict;
use Tk;
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 3084ad445cf165ae4dd79a1652850076ae9429e8

my $imageFile = "image.dd";

system "nc -w60 -l -p 31 >> image.dd &";

my $mw = MainWindow->new;
$mw->geometry("380x300");
$mw->title("NetMemAnalyzer");

$mw->Label( -text => "Welcome to NetMemAnalyzer \nPlease wait for the image to completly transfer before analyzing!", -foreground=>'blue')
   ->grid(
	-row => 1,
	-column => 1,
	-columnspan =>2);

$mw->Label( -text => "What would you like to analyze?" )
   ->grid(
	-row => 2,
	-column => 1,
	-columnspan =>2);
       
$mw->Button(
     -text => "View Strings",
     -command => sub{

			system ("strings " . $imageFile . " | more");
		
		      })
      ->grid(
	-row => 3,
	-column => 1,
	-columnspan => 2);

$mw->Button(
     -text => "Carve JPG Files",
     -command => sub{

<<<<<<< HEAD
MainLoop;
=======
     print "Checksum == ";
     system "md5sum memoryImage.dd";
	 
print "Select an Option to perform Analysis on the acquired memory image\n";
print " 1) View Strings\n\n";
=======
use Digest::SHA qw(sha256_hex);

my $imageFile = "image.dd";
my %fileList;
my $listeningPort = "3000";
my $saveLocallyStatus = 0;
>>>>>>> a42f7cee96f92ded567da30c0525679b2e9a83bc

# Timeout connection after 45 seconds
system "nc -w45 -l -p $listeningPort >> $imageFile &";

my $mw = MainWindow->new;
$mw->geometry("620x390");
$mw->title("NetMemAnalyzer");

$mw->Label( -text => "Welcome to NetMemAnalyzer \nPlease wait for the image to completly transfer before analyzing!", -foreground=>'blue')
   ->grid(
	-row => 1,
	-column => 1,
	-columnspan =>3);

$mw->Label( -text => "Options" )
   ->grid(
	-row => 3,
=======
			carveJPG();
		
		      })
      ->grid(
	-row => 4,
>>>>>>> 3084ad445cf165ae4dd79a1652850076ae9429e8
	-column => 1,
	-columnspan => 2);

$mw->Button(
     -text => "Carve GIF Files",
     -command => sub{

<<<<<<< HEAD
		system ("strings " . $imageFile . " | more");
		
	})
      ->grid(
	-row => 4,
=======
			carveGIF();
		
		      })
      ->grid(
	-row => 5,
>>>>>>> 3084ad445cf165ae4dd79a1652850076ae9429e8
	-column => 1,
	-columnspan => 2);

$mw->Button(
<<<<<<< HEAD
     -text => "Carve JPG Files",
     -command => sub {

		carveJPG();
		
	})
      ->grid(
	-row => 5,
=======
     -text => "Carve PNG Files",
     -command => sub{

			carvePNG();
		
		      })
      ->grid(
	-row => 6,
>>>>>>> 3084ad445cf165ae4dd79a1652850076ae9429e8
	-column => 1,
	-columnspan => 2);

$mw->Button(
<<<<<<< HEAD
     -text => "Carve GIF Files",
     -command => sub {

		carveGIF();
		
	})
      ->grid(
	-row => 6,
	-column => 1,
	-columnspan => 2);

$mw->Button(
     -text => "Carve PNG Files",
     -command => sub {
		
		carvePNG();
		compareFileList();
		
	})
=======
     -text => "Exit",
     -command => sub{

			system ("strings " . $imageFile . " | more");
		
		      })
>>>>>>> 3084ad445cf165ae4dd79a1652850076ae9429e8
      ->grid(
	-row => 7,
	-column => 1,
	-columnspan => 2);

<<<<<<< HEAD
$mw->Checkbutton(
	-variable => \$saveLocallyStatus,
	-text => "Save Carved Files Locally"
	)
	  ->grid(
	-row => 8,
	-column => 1,
	-columnspan => 2);

$mw->Label( -text => "Listening on port: $listeningPort", -foreground=>'dark green')
   ->grid(
	-row => 9,
	-column => 1,
	-columnspan =>2);

$mw->Button(
     -text => "Exit",
     -command => sub {
			
		exit;
		
	})
      ->grid(
	-row => 10,
	-column => 3,
	-columnspan => 3);

my $statusWindow = $mw->Text(
     -width => 60,
     -height => 20)
      ->grid(
	-row => 3,
	-column => 3,
	-rowspan => 6);

MainLoop;

sub carveJPG()
{
	open (IMAGE, "<", $imageFile) or die "Error opening image. \n";

	# Open file in binary mode
	binmode (IMAGE);

	my $fileNumber = 0;
	my $hex;
	my $fileBuffer;
	my $fileChecksum;

		#Read jpg files in 65k blocks
		while ( (read (IMAGE, $fileBuffer, 65000)) > 0 ) 
		{

			# Convert input buffer to hex
			$hex = unpack('H*', $fileBuffer);

			# Search for jpg header and trailer
			if ($hex =~ m/(ffd8ffe0(?:(?!ffd8).)*ffd9)/i)
			{                 
				# Trim any leading hex and trailing zeros off of the buffer
				$hex =~ s/^.*(?=ffd8ffe0)//g;
				$hex =~ s/(0*)$//g;

				$fileChecksum = sha256_hex(pack('H*', $hex));
				$fileList{$fileChecksum} = $fileNumber . ".png";

				# If box is checked, save carved jpg to the local machine
				if ($saveLocallyStatus == 1)
				{
					open (MYFILE, '>' . $fileNumber . '.jpeg');
					print (MYFILE pack('H*', $hex));
					close (MYFILE);
				}

				$fileNumber++;
			}

	
		}

	$statusWindow->insert("1.0", "*** JPG CARVE STATUS ***\n" . $fileNumber . " jpg images were carved from memory image\n\n");

}


sub carvePNG()
{
<<<<<<< HEAD
    system ("strings memoryImage.dd | more");
}
>>>>>>> c8c0fac828fdcc0418f27cd5d7c828bf72e2c808
=======
	open (IMAGE, "<", $imageFile) or die "Error opening image. \n";

	# Open file in binary mode
	binmode (IMAGE);

	my $fileNumber = 0;
	my $hex;
	my $fileBuffer;
	my $fileChecksum;
=======
MainLoop;

sub carveJPG()
{
open (IMAGE, "<", $imageFile) or die "Error opening image. \n";
>>>>>>> 3084ad445cf165ae4dd79a1652850076ae9429e8

		#Read jpg files in 65k blocks
		while ( (read (IMAGE, $fileBuffer, 65000)) > 0 ) 
		{

<<<<<<< HEAD
			# Convert input buffer to hex
			$hex = unpack('H*', $fileBuffer);
=======
my $fileNumber = 0;
my $hex;
my $fileBuffer;
>>>>>>> 3084ad445cf165ae4dd79a1652850076ae9429e8

			# Search for png header and trailer
			if ($hex =~ m/(89504e470d0a1a0a(?:(?!89504e470d0a1a0a).)*ae426082)/i)
			{                 
				# Trim any leading hex and trailing zeros off of the buffer
				$hex =~ s/^.*(?=89504e470d0a1a0a)//g;
				$hex =~ s/(0*)$//g;

<<<<<<< HEAD
				$fileChecksum = sha256_hex(pack('H*', $hex));
				$fileList{$fileChecksum} = $fileNumber . ".png";		
=======
                    # Convert input buffer to hex
                    $hex = unpack('H*', $fileBuffer);
>>>>>>> 3084ad445cf165ae4dd79a1652850076ae9429e8

				# If box is checked, save carved png to the local machine
				if ($saveLocallyStatus == 1)
				{
					open (MYFILE, '>' . $fileNumber . '.png');
					print (MYFILE pack('H*', $hex));
					close (MYFILE);
				}

<<<<<<< HEAD
				$fileNumber++;
			}
=======
					print $hex . "\n\n";

                                        # Save carved jpg to a file
                                        open (MYFILE, '>' . $fileNumber . '.jpeg');
                                        print (MYFILE pack('H*', $hex));
                                        close (MYFILE);
>>>>>>> 3084ad445cf165ae4dd79a1652850076ae9429e8

	
		}

<<<<<<< HEAD
	$statusWindow->insert("1.0", "*** PNG CARVE STATUS ***\n" . $fileNumber . " png images were carved from memory image\n\n");
=======
}

sub carveGIF()
{
open (IMAGE, "<", $imageFile) or die "Error opening image. \n";

# Open file in binary mode
binmode (IMAGE);

my $fileNumber = 0;
my $hex;
my $fileBuffer;

#Read jpg files in 65k blocks
while ( (read (IMAGE, $fileBuffer, 65000)) > 0 ) {

                    # Convert input buffer to hex
                    $hex = unpack('H*', $fileBuffer);

                    # Search for jpg header and trailer
                    if ($hex =~ m/(47494638(?:(?!47494638).)*1110003b)/i)
                    {                 
                                        # Trim any leading hex and trailing zeros off of the buffer
					$hex =~ s/^.*(?=47494638)//g;
                                        $hex =~ s/(0*)$//g;

                                        # Save carved jpg to a file
                                        open (MYFILE, '>' . $fileNumber . '.gif');
                                        print (MYFILE pack('H*', $hex));
                                        close (MYFILE);

                                        $fileNumber++;
                    }
>>>>>>> 3084ad445cf165ae4dd79a1652850076ae9429e8

	}  
}

<<<<<<< HEAD
sub carveGIF()
{
	open (IMAGE, "<", $imageFile) or die "Error opening image. \n";

	# Open file in binary mode
	binmode (IMAGE);

	my $fileNumber = 0;
	my $hex;
	my $fileBuffer;
	my $fileChecksum;

		#Read jpg files in 65k blocks
		while ( (read (IMAGE, $fileBuffer, 65000)) > 0 ) 
		{

			# Convert input buffer to hex
			$hex = unpack('H*', $fileBuffer);

			# Search for gif header and trailer
			if ($hex =~ m/(47494638(?:(?!47494638).)*1110003b)/i)
			{                 
				# Trim any leading hex and trailing zeros off of the buffer
				$hex =~ s/^.*(?=47494638)//g;
				$hex =~ s/(0*)$//g;

				$fileChecksum = sha256_hex(pack('H*', $hex));
				$fileList{$fileChecksum} = $fileNumber . ".gif";		

				# If box is checked, save carved gif to the local machine
				if ($saveLocallyStatus == 1)
				{
					open (MYFILE, '>' . $fileNumber . '.gif');
					print (MYFILE pack('H*', $hex));
					close (MYFILE);
				}

				$fileNumber++;
			}

	
		}

	$statusWindow->insert("1.0", "*** GIF CARVE STATUS ***\n" . $fileNumber . " gif images were carved from memory image\n\n");

}

sub compareFileList()
{
	open CHECKSUMFILE, "file_list.txt" or die $!;

	while (defined (my $checkSum = <CHECKSUMFILE>)) {
		chomp $checkSum;

		if (exists ($fileList{$checkSum}))
		{			
			$statusWindow->insert("1.0", "*** File Checksum Match ***\nFile Name: " . $fileList{$checkSum} . " -> " . $checkSum . "\n\n");
		}

	}

	close (CHECKSUMFILE);	

}
>>>>>>> a42f7cee96f92ded567da30c0525679b2e9a83bc
=======
sub carvePNG()
{
open (IMAGE, "<", $imageFile) or die "Error opening image. \n";

# Open file in binary mode
binmode (IMAGE);

my $fileNumber = 0;
my $hex;
my $fileBuffer;

#Read jpg files in 65k blocks
while ( (read (IMAGE, $fileBuffer, 65000)) > 0 ) {

                    # Convert input buffer to hex
                    $hex = unpack('H*', $fileBuffer);

                    # Search for jpg header and trailer
                    if ($hex =~ m/(89504e470d0a1a0a(?:(?!89504e470d0a1a0a).)*ae426082)/i)
                    {                 
                                        # Trim any leading hex and trailing zeros off of the buffer
					$hex =~ s/^.*(?=89504e470d0a1a0a)//g;
                                        $hex =~ s/(0*)$//g;

                                        # Save carved jpg to a file
                                        open (MYFILE, '>' . $fileNumber . '.png');
                                        print (MYFILE pack('H*', $hex));
                                        close (MYFILE);
	
                                        $fileNumber++;
                    }

}
}
}
>>>>>>> 3084ad445cf165ae4dd79a1652850076ae9429e8
