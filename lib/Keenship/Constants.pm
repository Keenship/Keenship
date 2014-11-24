package Keenship::Constants;
use base 'Exporter';
use Config;
use constant DEBUG => $ENV{DEBUG} || 0;
use constant PIDFILE => "daemon.pid";
our @EXPORT    = qw(DEBUG);
our @EXPORT_OK = qw(SIGTERM SIGKILL SIGINT PIDFILE);

BEGIN {
    my ( $signum, $sigkill, $sigterm, $sigint );
    $signum = 0;
    foreach my $sig ( split( / /, $Config{sig_name} ) ) {
        if ( $sig eq 'KILL' ) {
            $sigkill = $signum;
        }
        elsif ( $sig eq 'TERM' ) {
            $sigterm = $signum;
        }
        elsif ( $sig eq 'INT' ) {
            $sigint = $signum;
        }
        $signum++;
    }

    {
        no strict 'refs';
        *SIGKILL = sub {$sigkill};
        *SIGTERM = sub {$sigterm};
        *SIGINT  = sub {$sigint};
    }
}

!!42;
