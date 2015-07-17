#!/usr/bin/env perl
use strict;
use warnings;
use Plack::Request;

sub {
    my $req = Plack::Request->new(shift);
    my $res = $req->new_response(200);
    $res->body($req->address);
    return $res->finalize;
};
