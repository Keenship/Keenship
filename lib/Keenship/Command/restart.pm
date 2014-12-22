package Keenship::Command::restart;
use Mojo::Base 'Mojolicious::Command';
use Keenship::Command::stop;
use Keenship::Command::plack;

has description => 'restart plackup';
has usage       => "Usage: restart <appname> [opts]\n";

sub run {
    my $self = shift;
    Keenship::Command::stop->new->app($self->app)->run(@_);
    Keenship::Command::plack->new->app($self->app)->run(@_);
}

1;
