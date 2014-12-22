package Keenship::Command::install;
use Mojo::Base 'Mojolicious::Command';
use Keenship::Util qw(git_repo_name info notice);
use Git::Repository;
use File::Copy::Recursive qw(dircopy);
has description => 'Install a Keenship cartridge.';
has usage       => "Usage: install /path/to/cartridge\n";

sub run {
    my ( $self, $dir ) = @_;
    die("That's not a directory!") if !-d $dir;
    my $app
        = ( $dir =~ /\// ) ? ( split( /\//, $dir ) )[-1]
        : ( $dir =~ /\\/ ) ? ( split( /\\/, $dir ) )[-1]
        :                    $dir;
    die("Error, you supplied an invalid directory") if !-d $app;
    dircopy( $dir, $self->app->keenship_home->rel_dir($app) ) or die("$!\n");
    info "Copied $dir to " . $self->app->keenship_home->rel_dir($app);
}

1;
