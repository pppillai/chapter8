-module(mph_drop).
-export([mph_drop/0]).

mph_drop()->
    process_flag(trap_exit, true),
    Drop = spawn_link(drop, drop, []),
    convert(Drop).

convert(Drop) ->
    receive 
        {PlanetName, Distance} ->
            Drop ! {self(), PlanetName, Distance},
            convert(Drop);
        {'EXIT', Pid, Reason} ->
            io:format("FAILURE: ~p died because of ~p~n", [Pid, Reason]),
            convert(spawn_link(drop, drop, []));
        {PlanetName, Distance, Velocity} ->
            Mph_Velocity = 2.23 * Velocity,
            io:format("On ~p a fall of ~p yields a velocity of ~p mph~n",
                [PlanetName, Distance, Mph_Velocity]),
            convert(Drop)
    end.
