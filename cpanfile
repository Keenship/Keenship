requires 'CHI';
requires 'Git::Repository';
requires 'Mojo::Base';
requires 'Mojo::HelloWorld';
requires 'Mojo::Home';
requires 'Mojo::Loader';
requires 'Mojo::Server::PSGI';
requires 'Mojo::Util';
requires 'Mojolicious::Commands';
requires 'Mojolicious::Plugin::AssetPack';
requires 'Mojolicious::Plugin::Bootstrap3';
requires 'Mojolicious::Plugin::Config';
requires 'Mojolicious::Plugin::FontAwesome4';
requires 'Mojolicious::Plugin::JQuery';
requires 'Net::SSH::Perl';
requires 'Plack::Builder';
requires 'feature';

on configure => sub {
    requires 'Module::Build::Tiny', '0.035';
    requires 'perl', '5.008_001';
};

on test => sub {
    requires 'Test::Mojo';
    requires 'Test::More', '0.98';
};
