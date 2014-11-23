package Keenship::Util;
use base 'Exporter';
use Mojo::Loader;
use constant DEBUG => $ENV{DEBUG} || 0;
our @EXPORT    = qw(DEBUG);
our @EXPORT_OK = qw(git_repo_name _register);

sub git_repo_name {
    my $name = ( split( /\//, shift ) )[-1];
    $name =~ s/\.git//;
    return $name;
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
