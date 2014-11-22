package Keenship::Route::Test;
use Mojo::Base -base;

sub register {
    my ( $self, $app ) = @_;

    my $r = $app->routes;

    # Normal route to controller
    $r->get( '/info', sub { shift->render("pages/index") } )
        ;    #adding /info route

}

!!42;
