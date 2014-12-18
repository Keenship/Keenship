use strict;
use lib './t/lib';
use Helpers qw(search_modules);
use Test::More 0.98;

use_ok(
    qw(
        Keenship
        Keenship::Command::clone
        Keenship::Command::depinstall
        Keenship::Command::list
        Keenship::Command::plack
        Keenship::Command::preview
        Keenship::Command::stop

        Keenship::Constants
        Keenship::Util

        )
);

done_testing;

