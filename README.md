# DB::Connection

A super basic role for Moose classes, that forces a parameterized
approach to having db connections.  I use it to give a class a
connection to CouchDB and to PostgreSQL, because these things have so
much in common but also their own quirks.

# Usage

There are three parameters for this role:

* name
* connection_type
* connection_delegation

The `name` parameter names the connection, for example, `psql` or
`couch` or `redis`.

The `connection_type` parameter gives the perl module that the db
connection is.  For example, I have a DBIx::Class package
`Testbed::Spatial::VDS::Schema`, so I'll pass that as this parameter.

The `connection_delegation` parameter is a regular expression sort of
thing that tells the role what methods from the base class (the
connection type, I mean) to delegate to this role.  So for the
DBIx::Class stuff, I usually just pass a regex that says "use all the
methods!"

Finally, roles or classes that use this role need to implement their
own method `_build_connection_$name`.

# Example

## A DBIx::Class connection to PostgreSQL

For the first example, this sub-role has a connection to postgresql, and the
`$name` parameter is `psql`, and the regex delegates all the methods.

```perl

role Spatialvds::CopyIn {
    use Testbed::Spatial::VDS::Schema;

    my $param = 'psql';
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

```

## A connection to CouchDB

This is another example, using an ancient CPAN couchdb package.

```perl

role CouchDB::Trackable {

    method _build__connection_couchdb {
        my $conn = DB::CouchDB->new(
            host     => $self->host_couchdb,
            port     => $self->port_couchdb,
            db       => $self->dbname_couchdb,
            user     => $self->username_couchdb,
            password => $self->password_couchdb,
        );

        # create or not
        my $dbinfo = $conn->db_info();

        #returns a DB::CouchDB::Result with the db info if it exists
        if ( $dbinfo->err && $self->create ) {
            $dbinfo = $conn->create_db();
        }
        if ( $dbinfo->err ) {
            my $info_string =
              $self->dbname_couchdb . ' on host ' . $self->host_couchdb . ':' . $self->port_couchdb;
            CouchDBError->throw( error =>
                  "cannot find or create couchdb database $info_string " );
            return;
        }
        $conn->handle_blessed(1);
        return $conn;
    }


    with 'DB::Connection' => {
       'name'            => 'couchdb',
       'connection_type' => 'DB::CouchDB',
       'connection_delegation' =>
         qr/^(.*)/sxm,
    };

    ...

}

```
