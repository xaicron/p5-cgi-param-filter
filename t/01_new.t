use strict;
use warnings;
use Test::More tests => 5;

use CGI::Param::Filter;
use CGI;

ok my $q = CGI::Param::Filter->new({
	query => CGI->new,
	filter => [
		Encode       => {encode => 'euc-jp'},
		'DBIC::Page' => {},
	],
});

isa_ok $q, 'CGI::Param::Filter::DBIC::Page';
isa_ok $q, 'CGI::Param::Filter::Base';
isa_ok $q->{query}, 'CGI::Param::Filter::Encode';
isa_ok $q->{query}->{query}, 'CGI';
