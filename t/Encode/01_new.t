use strict;
use Test::More tests => 2;

use CGI ();
use CGI::Param::Filter::Encode;

ok my $cgi = CGI::Param::Filter::Encode->new({query => CGI->new});
isa_ok $cgi, 'CGI::Param::Filter::Encode';
