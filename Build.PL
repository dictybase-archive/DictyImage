
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  'build_requires' => {
    'Module::Build' => '0.3601'
  },
  'configure_requires' => {
    'Module::Build' => '0.3601'
  },
  'dist_abstract' => 'Template module for generating image gallery html',
  'dist_author' => [
    'Siddhartha Basu <siddhartha-basu@northwestern.edu>'
  ],
  'dist_name' => 'Dicty-Image',
  'dist_version' => '0.0010',
  'license' => 'perl',
  'module_name' => 'Dicty::Image',
  'recommends' => {},
  'recursive_test_files' => 1,
  'requires' => {
    'Template::Declare' => '',
    'File::Find::Rule' => ''
  },
  'script_files' => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
