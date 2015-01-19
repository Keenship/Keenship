package Keenship::Template;
use Mojo::Base 'Mojolicious::Plugin';
use Cwd;

has 'path' => __FILE__;

sub asset_path {
    my ($class) = @_;
    my $path = Cwd::abs_path( $class->path );
    $path =~ s!\.pm$!!;
    return $path;
}

sub register {
    my ( $self, $app, $config ) = @_;
    my $local_public   = $self->asset_path . '/public';
    my $local_template = $self->asset_path . '/templates';
    $app->plugin('AssetPack') unless eval { $app->asset };
    push @{ $app->static->paths }, $local_public;
     #   if -d $local_public;
    push @{ $app->renderer->paths }, $local_template;
     #   if -d $local_template;
}

1;
