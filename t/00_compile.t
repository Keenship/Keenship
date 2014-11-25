use strict;
use lib './t/lib';
use Helpers qw(search_modules);
use Test::More 0.98;

use_ok $_ for search_modules(
    "Keenship"
);

done_testing;

