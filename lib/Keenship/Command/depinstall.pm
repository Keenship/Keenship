package Keenship::Command::depinstall;
use Mojo::Base 'Mojolicious::Command';
use Carp qw(croak);
has description => 'Install the deps of the application with cpanm.';
has usage       => "Usage: APPLICATION depinstall [APP] [MIRROR]\n";

sub run {
    my ( $self, $application, $mirror ) = @_;
    croak "Fatal error: you must supply an applicaiton name"
        if !$application;
    exec(
              "cd '"
            . $self->app->keenship_home->rel_dir($application) . "';"
            . (
            ( defined $mirror )
            ? "cpanm --mirror '$mirror' --installdeps . @_"
            : "cpanm --installdeps . @_"
            )
    );
}

!!42;
