use strict;
use lib './t/lib';
use Test::More 0.98;

use_ok(
"Keenship::Util"
);
use Keenship::Util qw(is_git_repo);

is(is_git_repo("ssh://something"),1,"is_git_repo()");
done_testing;

