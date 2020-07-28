-module(bounce).
-export([report/0, report_state/1, report_state_v2/1]).

report() ->
    receive 
        X -> io:format("Received ~p~n", [X]),
        report()
    end.

report_state(State) ->
    receive
        Message -> io:format("Current Message is ~p~n Current State is ~p~n", [Message, State]),
        report_state(State + 1)
    end.


report_state_v2(State) ->
    New_State = receive 
        Message -> io:format("Current Msg is ~p~nCurrent State is ~p~n", [Message, State]),
        State + 1
    end,
    report_state_v2(New_State).

