package Keenship::Route::Test;
use Mojo::Base -base;

sub register {
    my ( $self, $app ) = @_;

    my $r = $app->routes->get( '/info', sub { shift->render("pages/index") } )
        ;    #adding /info route

}

1;
