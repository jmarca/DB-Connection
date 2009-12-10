use Test::More tests => 1;

BEGIN {
use_ok( 'DB::Connection' );
}

diag( "Testing DB::Connection $DB::Connection::VERSION" );
