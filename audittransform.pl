#!usr/bin/perl

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

$input_scalar =~ s/(timestamp([ a-zA-Z0-9\$\.\_\-\*\=\;]+\n?)+)/$1instance_name=\*\*\*;\nhostname=\*\*\*;\n/gis;

# Write to file
open(OUTPUT,">$file") or die;
print(OUTPUT $input_scalar);
close(OUTPUT);

#print $file . "\n";
} #End foreach

$/ = $holdTerminator; #Restore
print "modifications complete \n";






