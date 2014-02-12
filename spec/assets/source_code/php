<?php
/*[-2-]Attribution-Share Alike 3.0 License, copyright (c) 2010 Pieter Hintjens, modified @alpaca-tc
[-3-]Lazy Pirate client
[-4-]Use zmq_poll to do a safe request-reply
[-5-]To run, start lpserver and then randomly kill/restart it
[-6-]
[-7-]@author Ian Barber <ian(dot)barber(at)gmail(dot)com>
[-8-][-end-]*/

define("REQUEST_TIMEOUT", 2500); //[-10-]  msecs, (> 1000!)
define("REQUEST_RETRIES", 3); //[-11-]  Before we abandon

function client_socket(ZMQContext $context)
{
    echo "I: connecting to server...", PHP_EOL;
    $client = new ZMQSocket($context,ZMQ::SOCKET_REQ);
    $client->connect("tcp://localhost:5555");

    //[-19-]  Configure socket to not wait at close time
    $client->setSockOpt(ZMQ::SOCKOPT_LINGER, 0);
    /*[-21-] [-end-]*/

    return $client;
}

$context = new ZMQContext();
$client = client_socket($context);

$sequence = 0;
$retries_left = REQUEST_RETRIES;
$read = $write = array();
