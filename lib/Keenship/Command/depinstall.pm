package Keenship::Command::depinstall;
use Mojo::Base 'Mojolicious::Command';
use Carp qw(croak);
has description => 'Install the deps of the application with cpanm.';
has usage       => "Usage: APPLICATION depinstall [APP]\n";

sub run {
    my ( $self, $application, @args ) = @_;
    croak "Fatal error: you must supply an applicaiton name"
        if !$application;
    $self->app->keenship_home->rel_dir($application);
    exec(     "cd "
            . $self->app->keenship_home->rel_dir($application)
            . ";cpanm --installdeps . @args" );
}

!!42;
