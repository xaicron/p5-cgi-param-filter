package CGI::Param::Filter::Encode;

use strict;
use warnings;
use base qw/CGI::Param::Filter::Base/;
use Encode qw/find_encoding/;

our $VERSION = '0.01';

my $enc = find_encoding 'utf8';

sub new {
	my $self = shift->SUPER::new(@_);
	$self->{encode} = $self->{encode} ? &_encoder($self->{encode}) : $enc;
	
	return $self;
}

sub param {
	my $self = shift;
	my $name = shift;
	Carp::croak "Usage: $self->param('field')" unless defined $name;
	
	return $self->{query}->param(@_) if (@_);
	my @params;
	for ($self->{query}->param($name)) {
		push @params, $self->_decode(sprintf '%s', $_);
	}
	
	return wantarray ? @params: $params[0];
}

sub _decode {
	my $self = shift;
	my $param = shift;
	return if not defined $param or $param eq '';
	
	$param = $self->{encode}->decode($param) unless Encode::is_utf8 $param;
	return $self->_trim($param);
}

sub _trim {
	my $self = shift;
	my $sum = shift;
	return unless defined $sum;
	$sum =~ s/^\s+//;
	$sum =~ s/\s+$//;
	return $sum;
}

sub _encoder {
	my $enc = shift;
	$enc = ref $enc ? $enc : find_encoding $enc;
	return $enc;
}

1;
__END__
=head1 NAME

CGI::Param::Filter::Encode - get CGI->param() value Encode

=head1 SYNOPSIS

  use CGI::Param::Filter::Encode;
  use CGI ();
  
  my $q = CGI::Param::Filter::Encode->new({query => CGI->new});
  
  my $hoge = $q->param('hoge') # decoded utf8 value.
  my @hoge = $q->param('hoge') # decoded utf8 values.

=head1 DESCRIPTION

CGI::Param::Filter::Encode is get CGI->param() value Encode

=head1 METHODS

=over

=item new

  use CGI::Param::Filter::Encode;
  use CGI ();
  
  my $q = CGI::Param::Filter::Encode->new({query => CGI->new});
  my $q = CGI::Param::Filter::Encode->new({query => CGI->new, encode => 'cp932'}); # encode is Encode type or Encode::* Object

=item param

  my $hoge = $q->param('hoge');
  my @hoge = $q->param('hoge');

=back

=head1 AUTHOR

Yuji Shimada E<lt>xaicron {at} gmail.comE<gt>

=head1 SEE ALSO

L<CGI>
L<Encode>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
