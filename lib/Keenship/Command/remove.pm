package Keenship::Command::remove;
use Mojo::Base 'Mojolicious::Command';
use feature 'say';
use Keenship::Util qw(git_repo_name);
use Git::Repository;
use File::Copy::Recursive qw(dircopy);
use File::Path qw(remove_tree);

has description => 'remove a Keenship cartridge.';
has usage       => "Usage: remove APPLICATION\n";

sub run {
    my ( $self, $app ) = @_;
    say("Cartridge not present") and return 0
        if !-d $self->app->keenship_home->rel_dir($app);
    remove_tree( $self->app->keenship_home->rel_dir($app) );
    say "[*] Removed " . $self->app->keenship_home->rel_dir($app);
    return 0;
}

1;
