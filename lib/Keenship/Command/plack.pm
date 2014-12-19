package Keenship::Command::plack;
use Mojo::Base 'Mojolicious::Command';
use Plack::Builder;
use Mojo::Server::PSGI;
use Keenship::Util qw(_fork safe_chdir _clean_pidfile);
use Keenship::Constants qw(PIDFILE);
use Mojo::Util qw(slurp spurt);
use Mojo::HelloWorld;
use Data::Dumper;

use Mojolicious::Plugin::Config;
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

    my $config = Mojo::HelloWorld->new->plugin(
        "Config" => {
            file => join( "/", $cartridge, $self->app->moniker . ".conf" )
            }

    );
    my @args = @_;

    safe_chdir(
        $cartridge,
        sub {
            say "=" x 32;
            _clean_pidfile(PIDFILE)
                if ( -e PIDFILE );    #delete pid if server is not running
            say "Plackup is already running"
                and return 0
                unless ( !-e PIDFILE );

            my $host = $config->{host} // 0;
            my $port = $config->{port} // 8080;

            my $plack_middleware_string;

            do {
                local $Data::Dumper::Purity = 1;
                local $Data::Dumper::Indent = 0;
                local $Data::Dumper::Terse  = 1;

                $plack_middleware_string
                    .= "enable '$_', "
                    . Data::Dumper->Dump( [ $config->{middleware}->{$_} ] )
                    for ( keys %{ $config->{middleware} } );
            } if ( exists $config->{middleware} );
            my $pid = _fork "plackup", @args,
                "-l",
                join( ":", $host, $port ),
                "-I", "lib/", "-M", "Keenship", "-e",
                ($plack_middleware_string)
                ? $plack_middleware_string
                : () . 'Keenship->new->app->start';
            spurt( $pid, PIDFILE );
        },
        @args
    );
}

1;
