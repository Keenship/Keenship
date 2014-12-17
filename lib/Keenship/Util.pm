package Keenship::Util;
use base 'Exporter';
use Mojo::Loader;
use feature 'say';
use Cwd;
use Keenship::Constants qw(DEBUG);
use Mojo::Util qw(slurp);

#use Keenship::Constants qw(SIGTERM SIG)
our @EXPORT = qw();
our @EXPORT_OK
    = qw(git_repo_name _register _fork _clean_pidfile safe_chdir);


sub safe_chdir($$@) {
    my $p = cwd;
    chdir(shift);
    shift->();
    chdir($p);
}

sub _clean_pidfile {
    my $pidfile = shift;
    my $PID     = slurp $pidfile;
    my $running = kill 0, $PID;
    unlink("$pidfile") if ( !$running );
}

sub git_repo_name {
    my $name = ( split( /\//, shift ) )[-1];
    $name =~ s/\.git//;
    return $name;
}

sub _fork (@) {
    my @cmd = @_;
    say "[DEBUG] @cmd" if DEBUG;
    my $pid = fork();
    die "fork failed $!" unless defined $pid;
    if ( $pid == 0 ) {    # child
        require POSIX;
        POSIX::setsid;
        exec @cmd;
        die "Could not exec '@cmd': $!";
    }
    return $pid;
}

sub _register {
    my $app       = shift;
    my $namespace = shift;

    #Load routes from Keenship::Routes::*
    my $loader = Mojo::Loader->new;
    for my $module ( @{ $loader->search($namespace) } ) {
        my $e = $loader->load($module);
        warn qq{Loading route "$module" failed: $e} and next if ref $e;
        $module->new->register($app);
    }
}
!!42;
