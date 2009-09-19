package CGI::Param::Filter::Base;

use strict;
use warnings;
use Carp ();

our $VERSION = '0.01';

sub new {
	my $class = shift;
	$class = ref $class || $class;
	my $args = shift || {};
	
	Carp::croak "Usage: $class->new({query => \$q})" unless $args->{query} or ref $args->{query};
	Carp::croak "query is not defined param method" unless $args->{query}->can('param');
	
	bless $args, $class;
}

sub DESTORY {}

sub AUTOLOAD {
	my $method = our $AUTOLOAD;
	$method =~ s/.*:://o;
	
	no strict 'refs';
	*{$AUTOLOAD} = sub {
		my $self = shift;
		return $self->{query}->$method(@_);
	};
	
	goto &$AUTOLOAD;
}

1;
__END__
=head1 NAME

CGI::Param::Base is a base class of CGI::Param::*

=head1 SYNOPSIS

  package CGI::Param::Filter::XXX;
  use base qw(CGI::Param::Filter::Base);
  
  sub new {
      $self = shift->SUPER::new(@_);
      # it's work
      return $self;
  }
  
  sub param {
      # hogehoge
  }

=head1 DESCRIPTION

CGI::Param::Base is a base class of CGI::Param::*

=head1 AUTHOR

xaicron E<lt>xaicron {at} gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
