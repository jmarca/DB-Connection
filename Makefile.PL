use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'DB::Connection',
    AUTHOR              => 'James E. Marca <jmarca@translab.its.uci.edu>',
    VERSION_FROM        => 'lib/DB/Connection.pm',
    ABSTRACT_FROM       => 'lib/DB/Connection.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'version'    => 0,
        'MooseX::Declare' => 0,
        'Test::Perl::Critic' => 0,

    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'DB-Connection-*' },
);
