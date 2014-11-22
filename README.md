# NAME

Keenship - Mojolicious on Cloud with steroids!

# SYNOPSIS

    $ keenship deploy <host> <keenship_url>
    $ keenship clone <keenship_url>
    $ keenship test <app>
    $ keenship start [host] <app>
    $ keenship stop [host] <app>
    $ keenship debug <app>

# DESCRIPTION

Plack + Mojolicious + Pinto = <3 for cloud

Pinto: Plugin + Extension repository

Mojolicious + Plackup + Plackup Middleware = Websserver + web framework

Keenship = Administration of ssh boxes to run plack with Keenship framework

Login on ssh boxes witouth passwords, scalable, create clusters, status check, automatic pull and hot deployment from git repos...

# AUTHOR

mudler <mudler@dark-lab.net>

# COPYRIGHT

Copyright 2014- mudler

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO
[App::Witchcraft](https://metacpan.org/pod/App::Witchcraft), [App::witchcraft::Command::Sync](https://metacpan.org/pod/App::witchcraft::Command::Sync)
