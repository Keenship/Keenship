package Keenship::Command::preview;
use Mojo::Base 'Mojolicious::Command';
use Carp qw(croak);
has description => 'runs a preview of your app';
has usage       => "Usage: APPLICATION preview [APP] <morbo options>\n";

sub run {
    my ( $self, $application, @args ) = @_;
    croak "Fatal error: you must supply an applicaiton name"
        if !$application;
    exec(     "cd "
            . $self->app->keenship_home->rel_dir($application)
            . ";keenship daemon @args" );
}

!!42;
