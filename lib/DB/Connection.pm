# PODNAME:  DB::Connection
# ABSTRACT: a role for connecting to a database

package DB::Connection;

use strict;
use warnings;


use MooseX::Role::Parameterized;

    parameter name => (
        isa      => 'Str',
        required => 1,
    );

    parameter connection_type => (
        isa      => 'Str',
        required => 1,
    );

    parameter connection_delegation => (
        isa      => 'HashRef|ArrayRef|RegexpRef',
        required => 1,
    );

role {
    my $p = shift;
    my $name = $p->name;
    my $connection_type = $p->connection_type;
    my $connection_delegation = $p->connection_delegation;

    use version; our $VERSION = qv('0.2.0');

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
    );
    has "_connection_${name}" => (
        is         => 'ro',
        isa        => $connection_type,
        lazy_build => 1,
        handles    => $connection_delegation,
    );

    requires "_build__connection_${name}";

}


__END__


=head1 SYNOPSIS


    role Spatialvds::CopyIn {
        method _build__connection_psql {

            my ( $host, $port, $dbname, $username, $password ) =
              map { $self->$_ }
              map { join q{_}, $_, $param }
              qw/ host port dbname username password /;
            my $vdb = Testbed::Spatial::VDS::Schema->connect(
                "dbi:Pg:dbname=$dbname;host=$host;port=$port",
                $username, $password, {}, { 'disable_sth_caching' => 1 } );
            return $vdb;
        }

        with 'DB::Connection' => {
            'name'                  => 'psql',
            'connection_type'       => 'Testbed::Spatial::VDS::Schema',
            'connection_delegation' => qr/^(.*)/sxm,
        };
        ...
    };


=head1 DESCRIPTION

    This role is a shell for connecting to databases.  I made it
    because I wanted to modularize my code.
