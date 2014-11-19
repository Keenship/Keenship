package Keenship::Plugin::Cache;

use Mojo::Base 'Mojolicious::Plugin';
use CHI;

sub register {

    my ( $self, $app ) = ( shift, shift );
    $self->{_cache}
        = exists $self->config->{cache}
        ? CHI->new( %{ $self->config->{cache} } )
        : CHI->new( driver => 'Memory', global => 1 );

    $app->helper(
        cache => sub {
            $self->{_cache};
        }
    );
}

1;
