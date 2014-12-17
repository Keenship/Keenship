package Keenship::Command::clone;
use Mojo::Base 'Mojolicious::Command';
use Keenship::Util qw(git_repo_name);
use Git::Repository;
has description => 'Clone a remote Keenship repository.';
has usage       => "Usage: APPLICATION clone [GIT_URL]\n";

sub run {
    my ( $self, $url ) = @_;
    my $name        = git_repo_name($url);
    my $destination = $self->app->keenship_home->rel_dir($name);
    say "Cloning/Pulling $url into " . $destination;
    return Git::Repository->new( work_tree => $destination )->run("pull")
        if -d $destination;
    Git::Repository->run( clone => $url, $destination );

}

1;
