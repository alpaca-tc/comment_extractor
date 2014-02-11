%%[-1-]Attribution-Share Alike 3.0 License, copyright (c) 2010 Pieter Hintjens, modified @alpaca-tc
%%[-2-] Reading from multiple sockets
%%[-3-] This version uses active sockets
%[-4-]

main(_) ->
    {ok,Context} = erlzmq:context(),

    %%[-9-] Connect to task ventilator
    {ok, Receiver} = erlzmq:socket(Context, [pull, {active, true}]),
    ok = erlzmq:connect(Receiver, "tcp://localhost:5557"),

    %%[-13-] Connect to weather server
    {ok, Subscriber} = erlzmq:socket(Context, [sub, {active, true}]),
    ok = erlzmq:connect(Subscriber, "tcp://localhost:5556"),
    ok = erlzmq:setsockopt(Subscriber, subscribe, <<"10001">>),

    %%[-18-] Process messages from both sockets
    loop(Receiver, Subscriber),

    %%[-21-] We never get here
    ok = erlzmq:close(Receiver), %%[-22-] we never get here
    ok = erlzmq:close(Subscriber),
    ok = erlzmq:term(Context).

loop(Tasks, Weather) ->
    receive
        {zmq, Tasks, Msg, _Flags} ->
            io:format("Processing task: ~s~n",[Msg]),
            loop(Tasks, Weather);
        {zmq, Weather, Msg, _Flags} ->
            io:format("Processing weather update: ~s~n",[Msg]),
            loop(Tasks, Weather)
    end.
