#!/usr/bin/perl -w

use strict;
use Pod::Usage;
use Getopt::Long;
use File::Find::Rule;
use Mojo::Template;
use File::Spec::Functions;
use FindBin qw/$Bin/;
use File::Basename;
use Time::Piece;
use IO::File;

my $t            = localtime;
my $year         = $t->year;
my $output       = 'output.html';
my $asset_folder = '/assets';

GetOptions(
    'h|help'          => sub { pod2usage(1); },
    'af|asset-folder:s' => \$asset_folder,
    'o|out:s'         => \$output,
    'y|year:i'        => \$year
);
pod2usage("no image folder given") if !$ARGV[0];

# -- web server path for images
my $image_path = '/images/conference/' . $year;

my $css_folder   = catfile( $asset_folder, 'stylesheets' );
my $js_folder    = catfile( $asset_folder, 'javascripts');

my $writer = IO::File->new($output,  'w') or die "cannot open file for writing:$!";

my $rule = File::Find::Rule->new;
$rule->maxdepth(1);
$rule->file;
$rule->name(qr/jp(e)?g|png|gif|tiff/i);
my @files = grep { !/thumb|medium/ } $rule->in( $ARGV[0] );
die "no image files found\n" if !@files;

my $images;
for my $img (@files) {
    my ( $name, $ext ) = split /\./, basename($img);
    push @$images,
        {
        large  => $img,
        thumb  => catfile( $image_path, $name . '_thumb.' . $ext ),
        medium => catfile( $image_path, $name . '_medium.' . $ext )
        };
}

my $mt     = Mojo::Template->new;
my $header = $mt->render_file(
    catfile( $Bin, updir, 'template', 'dicty_header.html' ),
    { css_folder => $css_folder, js_folder => $js_folder,  title => 'dicty'.$t->year }
);

my $body
    = $mt->render_file(
    catfile( $Bin, updir, 'template', 'dicty_adgallery_body.html' ),
    { images => $images } );

my $footer = $mt->render_file(
    catfile( $Bin, updir, 'template', 'dicty_footer.html' ),
);
$writer->print("$header\n$body\n$footer\n");
$writer->close;

=head1 NAME

B<Application name> - [One line description of application purpose]


=head1 SYNOPSIS

=for author to fill in:
Brief code example(s) here showing commonest usage(s).
This section will be as far as many users bother reading
so make it as educational and exeplary as possible.


=head1 REQUIRED ARGUMENTS

=for author to fill in:
A complete list of every argument that must appear on the command line.
when the application  is invoked, explaining what each of them does, any
restrictions on where each one may appear (i.e., flags that must appear
		before or after filenames), and how the various arguments and options
may interact (e.g., mutual exclusions, required combinations, etc.)
	If all of the application's arguments are optional, this section
	may be omitted entirely.


	=head1 OPTIONS

	B<[-h|-help]> - display this documentation.

	=for author to fill in:
	A complete list of every available option with which the application
	can be invoked, explaining what each does, and listing any restrictions,
	or interactions.
	If the application has no options, this section may be omitted entirely.


	=head1 DESCRIPTION

	=for author to fill in:
	Write a full description of the module and its features here.
	Use subsections (=head2, =head3) as appropriate.


	=head1 DIAGNOSTICS

	=head1 CONFIGURATION AND ENVIRONMENT

	=head1 DEPENDENCIES

	=head1 BUGS AND LIMITATIONS

	=for author to fill in:
	A list of known problems with the module, together with some
	indication Whether they are likely to be fixed in an upcoming
	release. Also a list of restrictions on the features the module
	does provide: data types that cannot be handled, performance issues
	and the circumstances in which they may arise, practical
	limitations on the size of data sets, special cases that are not
	(yet) handled, etc.

	No bugs have been reported.Please report any bugs or feature requests to

	B<Siddhartha Basu>


	=head1 AUTHOR

	I<Siddhartha Basu>  B<siddhartha-basu@northwestern.edu>

	=head1 LICENCE AND COPYRIGHT

	Copyright (c) B<2011>, Siddhartha Basu C<<siddhartha-basu@northwestern.edu>>. All rights reserved.

	This module is free software; you can redistribute it and/or
	modify it under the same terms as Perl itself. See L<perlartistic>.



