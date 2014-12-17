package Keenship::Command::update;
use Mojo::Base 'Mojolicious::Command';
use Keenship::Util qw(git_repo_name _ssh);
use Carp qw(croak);

has description => 'Keep keenship and cpanm up-to-date to the machine.';
has usage       => "Usage: APPLICATION update HOST\n";

sub run {
    my ( $self, $host, $git_url, @args ) = @_;
    croak
        "Fatal error: you must supply an host and a valid git url: user\@sshbox"
        if !$host;
    $self->{_ssh} = _ssh($host);
    my $output;
    $output
        .= $self->cmd("curl -L https://cpanmin.us | perl - App::cpanminus")
        ;    #ensure to have the latest version of cpanminus

    $output .= $self->cmd(
        $ENV{PINTO_MIRROR}
        ? "cpanm --mirror '"
            . $ENV{PINTO_MIRROR}
            . "' --mirror-only Keenship @args"
        : "cpanm Keenship @args"
    );       #ensure to have the latest version of Keenship

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
