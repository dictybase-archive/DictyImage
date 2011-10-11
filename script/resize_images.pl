#!/usr/bin/perl -w

use strict;
use Pod::Usage;
use Getopt::Long;
use File::Spec::Functions;
use File::Find::Rule;
use File::Basename;
use Imager;
use Image::Math::Constrain;

my $thumb_folder;
GetOptions( 'h|help' => sub { pod2usage(1); } );

die "no folder given\n" if !$ARGV[0];
my $rule = File::Find::Rule->new;
$rule->maxdepth(1);
$rule->file;
$rule->name(qr/jp(e)?g|png|gif|tiff/i);
$rule->not( File::Find::Rule->new->name(qr/medium|thumbnail/) );
my @files = $rule->in( $ARGV[0] );
die "no image files found\n" if !@files;

my $thumb_cons  = Image::Math::Constrain->new( 100, 75 );
my $medium_cons = Image::Math::Constrain->new( 800, 600 );
my $imager      = Imager->new;
for my $path (@files) {
    $imager->read( file => $path,  type => 'jpeg' )
        or die "cannot read file ", $imager->errstr, "\n";
    my ( $file, $ext ) = split /\./, basename($path);
    my $thumb_file  = catfile( $ARGV[0], $file . '_thumb.' . $ext );
    my $medium_file = catfile( $ARGV[0], $file . '_medium.' . $ext );

    my $copy   = $imager->copy;
    my $thumb  = $copy->scale( constrain => $thumb_cons );
    my $medium = $copy->scale( constrain => $medium_cons );

    $thumb->write( file => $thumb_file ,  type => 'jpeg')
        or die "cannot write ", $thumb->errstr, "\n";
    $medium->write( file => $medium_file ,  type => 'jpeg')
        or die "cannot write ", $medium->errstr, "\n";
}



=head1 NAME

B<resize_images.pl> - [Script to resize images to thumbnail (100 x 75) and medium (800 x 600) sizes]


=head1 SYNOPSIS

perl resize_images.pl <folder_with_images>

=head1 REQUIRED ARGUMENTS

folder - Folder with images that need to be resized

=head1 OPTIONS

B<[-h|-help]> - display this documentation.

=head1 DESCRIPTION

This script uses B<Imager> module to resize images in thumbnail and medium sizes in the
same folder. Given a path with images,  it generates two versions of images by 
appending I<_thumb> and I<_medium> to the image name. So,  for example B<hello.png> will
produce ...
  B<hello_thumb.png> and B<hello_medium.png> files.


=head1 DEPENDENCIES

Imager

File::Find::Rule

Image::Math::Constraint

=head1 AUTHOR

I<Siddhartha Basu>  B<siddhartha-basu@northwestern.edu>

=head1 LICENCE AND COPYRIGHT

Copyright (c) B<2011>, Siddhartha Basu C<<siddhartha-basu@northwestern.edu>>. All rights reserved.
This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.



