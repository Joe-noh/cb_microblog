-module(blogger, [Id, Name::string(), Digest::string(), Salt::string()]).
-compile(export_all).

-has({statuses, many, [{order_by, timestamp}, {descending, true}]}).

validation_tests() ->
    [
    {fun() -> my_util:is_match(Name, "^[\\w]+$") end, "Name can contain A-Z, a-z, 0-9 and underscore."},
    {fun() -> boss_db:count(blogger, [{name, equals, Name}]) =:= 0 end,
              my_util:format_string("The name ~p is already registered.", [Name])}
    ].

authenticate(Password) ->
    Digest =:= mochihex:to_hex(erlang:md5(Password ++ Salt)).

session_id() ->
    mochihex:to_hex(crypto:sha(Salt ++ Id)).

bake_cookies() ->
    [mochiweb_cookies:cookie("blogger_id", Id, [{path, "/"}]),
     mochiweb_cookies:cookie("session_id", session_id(), [{path, "/"}])].

discard_cookies() ->
    [mochiweb_cookies:cookie("blogger_id", "", [{path, "/"}]),
     mochiweb_cookies:cookie("session_id", "", [{path, "/"}])].