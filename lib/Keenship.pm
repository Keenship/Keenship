package Keenship;
use Mojo::Base 'Mojolicious';
use constant DEBUG => $ENV{DEBUG} || 0;

# This method will run once at server start
sub startup {
    my $self = shift;

    $self->plugin('Config');
    $self->plugin("ViewBuilder");

    # Push Keenship::Plugin namespace
    push @{ $self->plugins->namespaces }, 'Keenship::Plugin';
    push @{ $self->routes->namespaces }, 'Keenship::Controller';

    #custom plugin
    $self->plugin("Test");

    # Documentation browser under "/perldoc"
    $self->plugin('PODRenderer') if DEBUG;
}

1;
