package Keenship::Command::remove;
use Mojo::Base 'Mojolicious::Command';
use Keenship::Util qw(git_repo_name info notice);
use Git::Repository;
use File::Copy::Recursive qw(dircopy);
use File::Path qw(remove_tree);

has description => 'remove a Keenship cartridge.';
has usage       => "Usage: remove APPLICATION\n";

sub run {
    my ( $self, $app ) = @_;
    notice("Cartridge not present") and return 0
        if !$app or !-d $self->app->keenship_home->rel_dir($app);
    remove_tree( $self->app->keenship_home->rel_dir($app) );
    info "Removed " . $self->app->keenship_home->rel_dir($app);
    return 0;
}

1;
