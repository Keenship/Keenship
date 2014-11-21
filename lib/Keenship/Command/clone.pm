package Keenship::Command::clone;
use Mojo::Base 'Mojolicious::Command';
use Keenship::Util qw(git_repo_name);
use Git::Repository;
use feature 'say';
has description => 'Clone a remote Keenship repository.';
has usage       => "Usage: APPLICATION clone [GIT_URL]\n";

sub run {
    my ( $self, $url ) = @_;
    my $name = git_repo_name($url);
    say "Cloning $url into " . $self->app->keenship_home->rel_dir($name);

    Git::Repository->run( clone => $url, $self->rel_dir($name) );

}

1;
