package CGI::Param::Filter;

use strict;
use warnings;
use Carp ();
use UNIVERSAL::require;

our $VERSION = '0.01';

sub new {
	my $class = shift;
	$class = ref $class || $class;
	my $args = shift || {};
	
	Carp::croak "Usage: $class->new({query => \$q, filter => [...]})" unless $args->{query} and $args->{filter};
	
	while (@{$args->{filter}}) {
		my $module = 'CGI::Param::Filter::' . shift @{$args->{filter}};
		my $arg = shift @{$args->{filter}};
		
		Carp::croak "Usage: filter => [ xxx => {} ]" unless ref $arg eq 'HASH';
		
		$module->require || Carp::croak "Can't locate $module\.pm \@INC (\@INC contains: @INC).";
		$arg->{query} = $args->{query};
		$args->{query} = $module->new($arg);
	}
	
	return $args->{query};
}

1;
__END__
=head1 NAME

CGI::Param::Filter - cgi param filter

=head1 SYNOPSIS

  use CGI::Param::Filter;
  use CGI;
  
  my $q = CGI::Param::Filter->new({
      query => CGI->new,
      filter => [
          Encode => {encode => 'euc-jp'},
          ...
      ],
  });

=head1 DESCRIPTION

CGI::Param::Filter is filtering (cgi) param

=head1 METHODS

=over

=item new({query => $q, filter => [ module => {@args} ] )

=back

=head1 AUTHOR

Yuji Shimada E<lt>xaicron {at} gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
