package Keenship::Util;
use base 'Exporter';
use constant DEBUG => $ENV{DEBUG} || 0;
our @EXPORT    = qw(DEBUG);
our @EXPORT_OK = qw(git_repo_name);

sub git_repo_name {
    my $name = ( split( /\//, shift ) )[-1];
    $name =~ s/\.git//;
    return $name;
}
!!42;
