
=pod[-2-]
[-3-]Attribution-Share Alike 3.0 License, copyright (c) 2010 Pieter Hintjens, modified @alpaca-tc
[-4-]Hello World server
[-5-]
[-6-]Connects REP socket to tcp://*:5560
[-7-]
[-8-]Expects "Hello" from client, replies with "World"
[-9-]
[-10-]Author: Daisuke Maki (lestrrat)
[-11-]Original version Author: Alexander D'Archangel (darksuji) <darksuji(at)gmail(dot)com>
[-12-]
=cut

use strict;
use warnings;
use 5.10.0;

use ZMQ::LibZMQ3;
use ZMQ::Constants qw(ZMQ_REP);
use zhelpers;

my $context = zmq_init();

#[-25-] Socket to talk to clients
my $responder = zmq_socket($context, ZMQ_REP);
zmq_connect($responder, 'tcp://localhost:5560');

while (1) {
    my $string = s_recv($responder); #[-30-] Wait for next request from client
    say "Received request: [$string]";

    sleep (1);

    s_send($responder, 'World');
}
