
use strict;
use warnings;

use Module::Build 0.3601;

my %module_build_args = (
    'build_requires'     => { 'Module::Build' => '0.3601' },
    'configure_requires' => { 'Module::Build' => '0.3601' },
    'dist_abstract' =>
        'Module and scripts for generating image galleries for dictybase conference',
    'dist_author'  => ['Siddhartha Basu <siddhartha-basu@northwestern.edu>'],
    'dist_name'    => 'Dicty-Image',
    'dist_version' => '0.0010',
    'license'      => 'perl',
    'module_name'  => 'Dicty::Image',
    'recommends'   => {},
    'recursive_test_files' => 1,
    'requires'             => {
        'File::Find::Rule'       => '0.32',
        'Mojolicious'            => '1.97',
        'Imager'                 => '0.85',
        'Image::Math::Constrain' => '1.02',
        'Time::Piece'            => '1.20'
    },
    'script_files' => []
);

my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
