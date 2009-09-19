use inc::Module::Install;
name 'CGI-Param-Filter';
all_from 'lib/CGI/Param/Filter.pm';

requires 'UNIVERSAL::require';

tests 't/*.t t/*/*.t t/*/*/*.t t/*/*/*/*.t t/*/*/*/*/*.t';
author_tests 'xt';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
