use strict;
use warnings;
use Test::More tests => 4;

use CGI::Param::Filter;
use CGI;

ok my $q = CGI::Param::Filter->new({
	query => CGI->new,
	filter => [
		Encode       => {encode => 'euc-jp'},
	],
});

isa_ok $q, 'CGI::Param::Filter::Encode';
isa_ok $q, 'CGI::Param::Filter::Base';
isa_ok $q->{query}, 'CGI';
