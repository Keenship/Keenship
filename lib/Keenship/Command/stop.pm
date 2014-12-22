package Keenship::Command::stop;
use Mojo::Base 'Mojolicious::Command';
use Plack::Builder;
use Mojo::Server::PSGI;
use Keenship::Constants qw(SIGTERM PIDFILE);
use Keenship::Util qw(_fork safe_chdir info error);
use Mojo::Util qw(slurp);
has description => 'stop plackup';
has usage       => "Usage: stop <appname> [opts]\n";

sub run {
    my $self      = shift;
    my $app       = $self->app;
    my $cartridge = "./";
    if ( @_ > 0 ) {
        $cartridge = $self->app->keenship_home->rel_dir(shift);
        chomp $cartridge;
        $cartridge .= "/";
    }
    safe_chdir(
        $cartridge,
        sub {
            error "No running instance found"
                and return 0
                unless ( -e PIDFILE );
            my $PID = slurp PIDFILE;
            info "Killing $PID";
            kill SIGTERM() => $PID;
            unlink(PIDFILE);
        },
        @_
    );

    #"-s", "Starman",

}

1;
