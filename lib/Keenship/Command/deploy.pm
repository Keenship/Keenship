package Keenship::Command::deploy;
use Mojo::Base 'Mojolicious::Command';
use Keenship::Util qw(git_repo_name _ssh);
use Carp qw(croak);

has description => 'Deploy an app to a remote host.';
has usage       => "Usage: APPLICATION deploy [HOST] [GIT_URL]\n";

sub run {
    my ( $self, $host, $git_url ) = @_;
    croak
        "Fatal error: you must supply an host and a valid git url: user\@sshbox https://bite.my.ass/repo.git"
        if !$host or !$git_url;
    system("keenship update $host") == 0 or die "Error updating Keenship";
    my $name = git_repo_name($git_url);
    $self->{_ssh} = _ssh($host);
    my $output;

    $output .= $self->cmd("keenship clone $git_url");  #clone the keenship app

    $output .= $self->cmd("keenship depinstall $name")
        ;    #ensure that deps are satisfied

    say "All seems to be fine:";
    say $output;
}

sub cmd {
    my ( $stdout, $stderr, $exit ) = shift->{_ssh}->cmd( $_[0] );
    $stdout = $stderr if !$stdout;
    croak "command <$_[0]> : $stdout ($exit) " if $exit != 0;
    return $stderr ? $stderr : $stdout;
}

!!42;
