requires 'Encode';
requires 'File::Copy::Recursive';
requires 'File::Path';
requires 'Git::Repository';
requires 'Mojo::Base';
requires 'Mojo::HelloWorld';
requires 'Mojo::Home';
requires 'Mojo::Loader';
requires 'Mojo::Server::PSGI';
requires 'Mojo::Util';
requires 'Mojolicious::Commands';
requires 'Mojolicious::Plugin::Config';
requires 'Mojolicious::Plugin::ViewBuilder';
requires 'Plack::Builder';
requires 'Term::ANSIColor';
requires 'feature';

on configure => sub {
    requires 'Module::Build::Tiny', '0.035';
    requires 'perl', '5.008_001';
};

on test => sub {
    requires 'Test::Mojo';
    requires 'Test::More', '0.98';
};
