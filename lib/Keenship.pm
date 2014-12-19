package Keenship;
use Mojo::Base 'Mojolicious';
use Keenship::Constants qw(DEBUG);
use Keenship::Util qw(_register);
use Mojolicious::Plugin::ViewBuilder;
use Mojo::Home;
use Cwd;

BEGIN {
    $ENV{MOJO_CONFIG} = cwd . "/keenship.conf";
    unshift @INC, cwd . "/lib";
}

our $VERSION  = "0.30";
our $CODENAME = "Rosetta";

has 'keenship_home' =>
    sub { Mojo::Home->new( join( '/', $ENV{HOME}, '.keenship' ) ) };
has 'db';

sub startup {
    my $self = shift;
    mkdir( $self->keenship_home )
        unless -d $self->keenship_home;    #ensure home is existing
   # tie my %db, 'DBM::Deep', $self->keenship_home->rel_file('posted.db');
    #$self->db(\%db);

    $self->plugin('Config') if ( -e $self->moniker . ".conf" );
    $self->plugin("ViewBuilder");

    # Push Keenship::* namespaces
    push @{ $self->plugins->namespaces }, 'Keenship::Plugin', 'Plugin';
    push @{ $self->routes->namespaces }, 'Keenship::Controller', 'Controller';
    push @{ $self->commands->namespaces }, 'Keenship::Command', 'Command';
    push @{ $self->static->paths },        cwd . '/public';
    push @{ $self->renderer->paths },      cwd . '/templates';

    #Load routes from Keenship::Route::* and Route::*
    _register( $self, 'Keenship::Route' );
    _register( $self, 'Route' );

    #custom plugin
    $self->plugin("Test");

    # Documentation browser under "/perldoc" if DEBUG flag is activated
    $self->plugin('PODRenderer') if DEBUG;

    #loading plugins from config file

    #Supports list
    if (    $self->config
        and exists $self->config->{plugins}
        and ref $self->config->{plugins} eq "ARRAY" )
    {
        $self->plugin($_) for ( @{ $self->config->{plugins} } );
    }
    elsif ( $self->config
        and exists $self->config->{plugins}
        and ref $self->config->{plugins} eq "HASH" )
    {
        #and hash with options
        $self->plugin( $_, $self->config->{plugins}->{$_} )
            for ( keys %{ $self->config->{plugins} } );
    }

}

1;

=encoding utf-8

=head1 NAME

Keenship - Mojolicious on Cloud with steroids!

=head1 SYNOPSIS

    $ keenship deploy <host> <keenship_url>
    $ keenship clone <keenship_url>
    $ keenship test <app>
    $ keenship list
    $ keenship start [host] <app>
    $ keenship stop [host] <app>
    $ keenship debug <app>

=head1 DESCRIPTION

Plack + Mojolicious + Pinto = <3 for cloud

Pinto: Plugin + Extension repository

Mojolicious + Plackup + Plackup Middleware = Websserver + web framework

Keenship = Administration of ssh boxes to run plack with Keenship framework

Login on ssh boxes witouth passwords, scalable, create clusters, status check, automatic pull and hot deployment from git repos...

=head1 AUTHOR

mudler E<lt>mudler@dark-lab.netE<gt>

=head1 COPYRIGHT

Copyright 2014- mudler

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO
L<App::Witchcraft>, L<App::witchcraft::Command::Sync>

=cut
