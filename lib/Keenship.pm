package Keenship;
use Mojo::Base 'Mojolicious';
use lib './lib';
use Keenship::Util;
use Mojo::Home;
use Cwd;

=encoding utf-8

=head1 NAME

Keenship - Mojolicious on Cloud with steroids!

=head1 SYNOPSIS

    $ keenship deploy <host> <keenship_url>
    $ keenship clone <keenship_url>
    $ keenship test <app>
    $ keenship start [host] <app>
    $ keenship stop [host] <app>
    $ keenship debug <app>

=head1 DESCRIPTION

Plack + Mojolicious + Pinto = <3 for cloud

Pinto: Plugin + Extension repository

Mojolicious + Plackup + Plackup Middleware = Websserver + web framework

Keenship = Administration of ssh boxes to run plack with Keenship framework

Login on ssh boxes witouth passwords, scalable, create clusters, status check, automatic pull and hot deployment from git repos...

=cut

has 'keenship_home' =>
    sub { Mojo::Home->new( join( '/', $ENV{HOME}, '.keenship' ) ) };

sub startup {
    my $self = shift;
    mkdir( $self->keenship_home )
        unless -d $self->keenship_home;    #ensure home is existing
    $self->plugin('Config');
    $self->plugin("ViewBuilder");

    # Push Keenship::* namespace
    push @{ $self->plugins->namespaces },  'Keenship::Plugin';
    push @{ $self->routes->namespaces },   'Keenship::Controller';
    push @{ $self->commands->namespaces }, 'Keenship::Command';
    push @{ $self->static->paths },        cwd . '/public';
    push @{ $self->renderer->paths },       cwd . '/templates';

    #custom plugin
    $self->plugin("Test");

    $self->plugin("Bootstrap");    #JQuery, Bootstrap, etc.

    # Documentation browser under "/perldoc"
    $self->plugin('PODRenderer') if DEBUG;
}

1;

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
