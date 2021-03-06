package Keenship::Constants;
use base 'Exporter';
use Config;
use constant DEBUG => $ENV{DEBUG} || 0;
use constant PIDFILE => "daemon.pid";
use constant KEENSHIP_PREFIX_CMD =>
    'cpanm --local-lib=~/perl5 local::lib && eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib);';
our @EXPORT = qw(DEBUG);
our @EXPORT_OK
    = qw( KEENSHIP_PREFIX_CMD SIGTERM SIGKILL SIGINT SIGHUP PIDFILE);

BEGIN {
    my ( $signum, $sigkill, $sigterm, $sighup, $sigint );
    $signum = 0;
    foreach my $sig ( split( / /, $Config{sig_name} ) ) {
        if ( $sig eq 'HUP' ) {
            $sighup = $signum;
        }
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
        *SIGHUP  = sub {$sighup};
        *SIGINT  = sub {$sigint};
    }
}

!!42;
