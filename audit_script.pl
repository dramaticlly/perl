#!usr/bin/perl
# create by Jgambhir
# $DB2PATH/admin_scripts/sample/*
# Read all files in test and current dir. Read some common folders as well
my @files = glob("*.rxa");
my $input_scalar;
my @input_array;
my $holdTerminator = $/;

# Multiline search. Can use instead: undef $*=1;
undef $/;

#Process each file in the dir
foreach $file (@files) { # Process each file

#Skip the file for now. # Recursive testcase conversion to be supported later.
#if Dir, Binary, not a plain file
if ((-d $file) || (-B $file)) {
print "Skipping file/directory $file \n";
next;
}

#Skip the file for now. # Recursive testcase conversion to be supported later.
#if Dir, Binary, not a plain file
if ((-d $file) || (-B $file)) {
print "Skipping file/directory $file \n";
next;
}

# Read the file
open(INPUT,"$file") or die;
@input_array=<INPUT>;
close(INPUT);
$input_scalar=join("",@input_array);

# Read file extension
my $ext = ($file_name =~ m/([^.]+)$/)[0];

# Replace empty lines with DELIM
$input_scalar =~ s/^\s*$/DELIM/gism;
# Add instance name and host name to each audit record (identified by lines ending with a semicolon then DEL>
$input_scalar =~ s/((;$)+)\nDELIM/$1\ninstance name=\*\*\*;\nhostname=\*\*\*;\n/gism;
# Remove any leftover DELIMs.
$input_scalar =~ s/DELIM/\n/gis;

# Write to file

open(OUTPUT,">$file") or die;
print(OUTPUT $input_scalar);
close(OUTPUT);

} #End foreach

$/ = $holdTerminator; #Restore
print "modifications complete \n";


