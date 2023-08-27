#!/usr/bin/env escript

solve(List) ->
    lists:reverse(
      lists:sublist(
        lists:sort(fun (A,B) -> A>B end,List),3)).

main(_) ->
    Input = [141, 1, 17, -7, -17, -27, 18, 541, 8, 7, 7],
    io:format("~p", [solve(Input)]).
