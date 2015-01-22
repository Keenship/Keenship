package Keenship::Command::restart;
use Mojo::Base 'Mojolicious::Command';
use Plack::Builder;
use Mojo::Server::PSGI;
use Keenship::Constants qw(SIGHUP PIDFILE);
use Keenship::Util qw(_fork safe_chdir info error);
use Mojo::Util qw(slurp);
has description => 'restart plackup - hot deployment';
has usage       => "Usage: restart <appname> [opts]\n";

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
            info "sending SIGHUP to $PID";
            kill SIGHUP() => $PID;
            unlink(PIDFILE);
        },
        @_
    );

    #"-s", "Starman",

}


# sub run {
#     my $self = shift;
#     Keenship::Command::stop->new->app($self->app)->run(@_);
#     Keenship::Command::plack->new->app($self->app)->run(@_);
# }

1;
