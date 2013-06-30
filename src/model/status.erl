-module(status, [Id, BloggerId::string(), Text::string(), Timestamp]).
-compile(export_all).

-belongs_to(blogger).

validation_tests() ->
    [
    {fun() -> my_util:is_match(BloggerId, "^blogger\\-\\d+$") end, "Correct ID must be used."},
    {fun() -> my_util:cleaned_length(Text) =< 140 end, "Length of status text must be =< 140 characters."},
    {fun() -> my_util:cleaned_length(Text)  >   0 end, "Status Text must not be empty."}
    ].

before_create() ->
    {M, S, U} = os:timestamp(),
    Status = THIS:set([{text, my_util:clean_text(Text)}, {timestamp, 1000000000000*M + 1000000*S + U}]),
    {ok, Status}.
