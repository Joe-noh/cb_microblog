-module(blogger, [Id, Name, PassDigest, Salt]).
-compile(export_all).

-has({statuses, many, [{order_by, timestamp}, {descending, true}]}).

validation_tests() ->
    [
    {fun() -> my_util:is_match(Name, "^[\\w]+$") end, "You can use A-Z, a-z, 0-9 and underscore."}
    ].