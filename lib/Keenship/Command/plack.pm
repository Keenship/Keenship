package Keenship::Command::plack;
use Mojo::Base 'Mojolicious::Command';
use Plack::Builder;
use Mojo::Server::PSGI;

has description => 'start apps using plack';
has usage       => "Usage: APPLICATION plack <appname> [opts]\n";

sub run {
    my $self = shift;
    my $app  = $self->app;
    say "Executing "."plackup -MKeenship -Ilib/ -e '"
            . $app->config->{middleware}
            . "Keenship->new->app->start' @_";
    exec(     "plackup -Ilib/ -MKeenship -e '"
            . $app->config->{middleware}
            . "Keenship->new->app->start' @_" );
}

1;
