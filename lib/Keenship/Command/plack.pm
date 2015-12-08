package Keenship::Command::plack;
use Mojo::Base 'Mojolicious::Command';
use Plack::Builder;
use Mojo::Server::PSGI;
use Keenship::Util qw(_fork safe_chdir _clean_pidfile info error notice);
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
        my $appname=shift;
        if(-d $self->app->keenship_home->rel_dir($appname)) {
            chomp $cartridge;
            $cartridge .= "/";
        } else {
            $cartridge=$appname."/";
        }
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
            notice "=" x 32;
            _clean_pidfile(PIDFILE)
                if ( -e PIDFILE );    #delete pid if server is not running
            notice "Plackup is already running"
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
            my $pid = ( defined $plack_middleware_string )
                ? _fork "plackup", @args,
                "-l",
                join( ":", $host, $port ),
                "-I", "lib/", "-M", "Keenship", "-e",
                $plack_middleware_string . 'Keenship->new->app->start'
                : _fork "plackup", @args,
                "-l",
                join( ":", $host, $port ),
                "-I", "lib/", "-M", "Keenship", "-e",
                'Keenship->new->app->start';
            spurt( $pid, PIDFILE );
        },
        @args
    );
}

1;
