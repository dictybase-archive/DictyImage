use inc::Module::Install;
name 'Dicty-Image';
all_from 'lib/Dicty/Image.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
