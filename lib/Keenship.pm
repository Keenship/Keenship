package Keenship;
use Mojo::Base 'Mojolicious';
use Keenship::Util;
# This method will run once at server start
sub startup {
    my $self = shift;

    $self->plugin('Config');
    $self->plugin("ViewBuilder");

    # Push Keenship::Plugin namespace
    push @{ $self->plugins->namespaces }, 'Keenship::Plugin';
    push @{ $self->routes->namespaces },  'Keenship::Controller';

    #custom plugin
    $self->plugin("Test");

    $self->plugin("Bootstrap");    #JQuery, Bootstrap, etc.

    # Documentation browser under "/perldoc"
    $self->plugin('PODRenderer') if DEBUG;
}

1;
