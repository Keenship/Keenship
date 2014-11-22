package Keenship::Plugin::Test;
use Mojo::Base 'Mojolicious::Plugin';

sub register {
    my ( $self, $app ) = @_;
    push @{ $app->renderer->classes }, __PACKAGE__;

    # Router
    my $r = $app->routes;

    # Normal route to controller
   # $r->get( '/info', sub { shift->render("pages/index") } )
     #   ;    #adding /info route

    $app->add_view(
        index => sub {
            shift->render_to_string(
                template => "test",
                format   => "html"
            );
        }
    );       #associating the view with the content

}

!!42;
__DATA__
@@ test.html.ep
huuuray!aa
% if( stash("forum") and stash("forum")==1){
 double it!
% }
