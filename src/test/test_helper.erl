-module(test_helper).
-compile(export_all).
%-export([generate_string/1]).

generate_string(N) when N > 0 ->
    generate_string(N, []).
generate_string(0, Acc) ->
    lists:concat(Acc);
generate_string(N, Acc) ->
    generate_string(N-1, ["a"|Acc]).