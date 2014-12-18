use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('Keenship');
$t->get_ok('/info')->status_is(200)->content_like(qr/Welcome/i);

done_testing();
