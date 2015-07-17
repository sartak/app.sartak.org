#!/usr/bin/env plackup
use strict;
use warnings;
use Plack::Util;
use Plack::Request;

sub {
    my $env = shift;
    my $req = Plack::Request->new($env);
    my ($path) = $req->path_info =~ m{^/(\w+)$};

    return $req->new_response(404)->finalize
        if !$path;

    my $file = "$path.app";

    if (-e $file && -x $file) {
        my $app = Plack::Util::load_psgi($file);
        return $app->($env);
    }

    return $req->new_response(404)->finalize;
}
