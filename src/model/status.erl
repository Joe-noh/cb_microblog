-module(status, [Id, BloggerId, Text, Timestamp]).
-compile(export_all).

-belongs_to(blogger).

validation_tests() ->
    [
    { fun() -> length(Text) =< 140 end, "Length of status text =< 140 characters." },
    { fun() -> length(Text)  >   0 end, "Status Text must not be empty." }
    ].

before_create() ->
    {M, S, U} = os:timestamp(),
    Status = set(timestamp, 1000000000000*M + 1000000*S + U),
    {ok, Status}.
