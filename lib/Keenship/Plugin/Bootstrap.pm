package Keenship::Plugin::Bootstrap;
use Mojo::Base 'Mojolicious::Plugin';

sub register {
    my ( $self, $app ) = @_;

    # Load basilar must-have plugin
    $app->plugin("AssetPack");
    $app->plugin("Bootstrap3");
    $app->plugin("FontAwesome4");
    $app->plugin("JQuery");

    return unless ( exists $app->config->{Plugins} );

    $app->plugin( $_, $app->config->{Plugins}->{$_} )
        for (keys  %{ $app->config->{Plugins} } );
}

!!42;
