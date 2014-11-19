requires 'CHI';
requires 'Mojo::Base';
requires 'Mojolicious::Commands';

on configure => sub {
    requires 'Module::Build::Tiny', '0.035';
    requires 'perl', '5.008_001';
};

on test => sub {
    requires 'Test::Mojo';
    requires 'Test::More', '0.98';
};
