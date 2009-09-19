use strict;
use utf8;
use Test::More tests => 3 * 3;

use Encode qw/encode_utf8 encode find_encoding/;
use CGI ();
use CGI::Param::Filter::Encode;

for my $data ((
	{ i => 'q=あいうえお', e => 'あいうえお' },
	{ i => 'q=小飼弾',     e => '小飼弾' },
	{ i => 'q= 1 2 3 4 5 ',      e => '1 2 3 4 5' },
)) {
	is ( CGI::Param::Filter::Encode->new({
		query => CGI->new(encode_utf8 $data->{i})
	})->param('q'), $data->{e}, 'utf8' );
	
	is ( CGI::Param::Filter::Encode->new({
		query  => CGI->new(encode cp932 => $data->{i}),
		encode => 'cp932',
	})->param('q'), $data->{e}, 'cp932' );
	
	is ( CGI::Param::Filter::Encode->new({
		query  => CGI->new(encode 'euc-jp' => $data->{i}),
		encode => find_encoding('euc-jp'),
	})->param('q'), $data->{e}, 'find euc-jp' );
}
