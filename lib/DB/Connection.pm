use strict;
use warnings;

use MooseX::Declare;

use DB::CouchDB;

use Exception::Class ( 'CouchDBError', );

role DB::Connection (Str :$name, Str :$connection_type, HashRef|ArrayRef|RegexpRef :$connection_delegation)  {

    use version; our $VERSION = qv('0.0.1');

    has "host_${name}" => (
        is       => 'ro',
        isa      => 'Str',
        required => 1,
    );
    has "port_${name}" => (
        is       => 'ro',
        isa      => 'Int',
        required => 1,
    );
    has "dbname_${name}" => (
        is       => 'ro',
        isa      => 'Str',
        required => 1,
    );
    has "username_${name}" => (
        is       => 'ro',
        isa      => 'Str',
        required => 1,
    );
    has "password_${name}" => (
        is       => 'ro',
        isa      => 'Str',
        required => 1,
    );
    has "_connection_${name}" => (
        is         => 'ro',
        isa        => $connection_type,
        lazy_build => 1,
        handles    => $connection_delegation,
    );

    requires "_build__connection_${name}";

}

1;    # Magic true value required at end of module
__END__

=head1 NAME

DB::Connection - [One line description of module's purpose here]


=head1 VERSION

This document describes DB::Connection version 0.0.1


=head1 SYNOPSIS

    use DB::Connection;

=head1 DESCRIPTION


=head1 SUBROUTINES/METHODS


=head1 DIAGNOSTICS


=head1 CONFIGURATION AND ENVIRONMENT

DB::Connection requires no configuration files or environment variables.


=head1 DEPENDENCIES

None.

=head1 INCOMPATIBILITIES

None reported.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-db-connection@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.  Or email them to me, as it is likely this will
never get posted to CPAN.


=head1 AUTHOR

James E. Marca  C<< <jmarca@translab.its.uci.edu> >>


=head1 LICENSE AND COPYRIGHT

Copyright (c) 2009, James E. Marca C<< <jmarca@translab.its.uci.edu> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
