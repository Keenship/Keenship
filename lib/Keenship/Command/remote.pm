#remotely start/stop plackup (calls keenship plack <app>
#or stop <app>)

package Keenship::Command::remote;
use Mojo::Base 'Mojolicious::Command';
use Keenship::Util qw(git_repo_name _ssh);
use Carp qw(croak);
has description => 'Deploy an app to a remote host.';
has usage       => "Usage: APPLICATION deploy [HOST] [GIT_URL]\n";

use Net::SSH::Perl;

sub run {
    my ( $self, $host, @args ) = @_;
    croak
        "Fatal error: you must supply an host and a valid keenship command user\@sshbox commands"
        if !$host;
    $self->{_ssh} = _ssh($host);

   my $output
        = $self->cmd("keenship @args")
        ;    #ensure to have the latest version of cpanminus
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
