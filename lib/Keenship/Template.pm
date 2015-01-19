package Keenship::Template;
use Mojo::Base 'Mojolicious::Plugin';
use Cwd;

sub asset_path {
    my ($class) = @_;
    my $path = Cwd::abs_path(__FILE__);
    $path =~ s!\.pm$!!;
    return $path;
}

sub register {
    my ( $self, $app, $config ) = @_;
    my $local_public   = $self->asset_path . '/public';
    my $local_template = $self->asset_path . '/templates';
    $app->plugin('AssetPack') unless eval { $app->asset };
    push @{ $self->static->paths }, $local_public
        if -d $local_public;
    push @{ $self->renderer->paths }, $local_template
        if -d $local_template;
}

1;
