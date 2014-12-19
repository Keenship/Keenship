package Keenship::Command::pull;
use Mojo::Base 'Mojolicious::Command';
use Keenship::Util qw(git_repo_name);
use Git::Repository;
has description => 'Update a Keenship cartridge.';
has usage       => "Usage: APPLICATION pull [APP]\n";

sub run {
    my ( $self, $name ) = @_;
    my $destination = $self->app->keenship_home->rel_dir($name);
    say "Cloning/Pulling $name into " . $destination;
    return Git::Repository->new( work_tree => $destination )->run("pull")
        if -d $destination;
    say "[!] I couldn't find the cartridge";

}

1;
