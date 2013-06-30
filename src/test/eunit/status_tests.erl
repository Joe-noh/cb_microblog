-module(status_tests).
-include_lib("eunit/include/eunit.hrl").

text_test() ->
    String140 = test_helper:generate_string(140),

    Equal140 = status:new(id, "blogger-1", String140, timestamp),
    Strip    = status:new(id, "blogger-1", lists:concat([" ", String140, " "]), timestamp),
    Over140  = status:new(id, "blogger-1", string:concat(String140, "a"), timestamp),
    Blank    = status:new(id, "blogger-1", " \t \n   ", timestamp),
    Empty    = status:new(id, "blogger-1", "", timestamp),

    {ok,    _} = Equal140:save(),
    {ok,    _} =    Strip:save(),
    {error, _} =  Over140:save(),
    {error, _} =    Blank:save(),
    {error, _} =    Empty:save().