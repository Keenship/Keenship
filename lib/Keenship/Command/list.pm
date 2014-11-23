package Keenship::Command::list;
use Mojo::Base 'Mojolicious::Command';
use Keenship::Util qw(git_repo_name);
use Git::Repository;
has description => 'List available applications to start.';
has usage       => "Usage: APPLICATION list\n";

sub run {
    my ( $self, $url ) = @_;
    my $d    = $self->app->keenship_home;
    my @Apps = <$d/*>;
    return say "No apps cloned" if @Apps<=0;
    say "List of the available apps: " if @Apps>0;
    say "*\t$_" for map{my $path=$_;s/$d\///g;$_="$_ ($path)";} grep {-d} @Apps;

}

1;
