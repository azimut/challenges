#!/usr/bin/env escript

product_sum([H|T], Depth, Sum) when is_number(H) ->
    product_sum(T, Depth, (Sum+H));
product_sum([H|T], Depth, Sum) when is_list(H) ->
    product_sum(H, (Depth+1), 0) + product_sum(T, Depth, Sum);
product_sum([], Depth, Sum) ->
    Sum * Depth.

product_sum(List) -> product_sum(List, 1, 0).

main(_) ->
    List = [1, 2, 3, [1, 3], 3],
    io:format("product sum is: ~p", [product_sum(List)]).
