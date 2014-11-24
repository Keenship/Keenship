package Keenship::Command::plack;
use Mojo::Base 'Mojolicious::Command';
use Plack::Builder;
use Mojo::Server::PSGI;
use Keenship::Util qw(_fork safe_chdir);
use Keenship::Constants qw(PIDFILE);
use Mojo::Util qw(slurp spurt);

has description => 'start apps using plackup';
has usage       => "Usage: APPLICATION plack <appname> [opts]\n";

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
            say "Executing "
                . "plackup -MKeenship -Ilib/ -e '"
                . $app->config->{middleware}
                . "Keenship->new->app->start' @_ inside '$cartridge'";

            _clean_pidfile(PIDFILE)
                if ( -e PIDFILE );    #delete pid if server is not running
            say "Plackup is already running"
                and return 0
                unless ( !-e PIDFILE );

            my $pid = _fork
                "plackup",
                "-I", "lib/", "-M", "Keenship", "-e",
                'Keenship->new->app->start', @_;
            spurt( $pid, PIDFILE );
        },
        @_
    );

    #"-s", "Starman",

}

1;
