use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'DB::Connection',
    license             => 'perl',
    dist_author         => 'James E. Marca <jmarca@translab.its.uci.edu>',
    dist_version_from   => 'lib/DB/Connection.pm',
    requires => {
        'Test::More' => 0,
        'version'    => 0,
    },
    add_to_cleanup      => [ 'DB-Connection-*' ],
);

$builder->create_build_script();
