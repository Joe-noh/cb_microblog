-module(cb_microblog_base_controller, [Req]).
-compile(export_all).

index('GET', []) ->
    case auth_helper:is_logged_in(Req) of
        false   -> ok;
        Blogger -> {redirect, "/blogger/"++Blogger:name()}
    end.

missing('GET', [Code]) ->
    case auth_helper:is_logged_in(Req) of
        false   -> {ok, [{code, Code}]};
        Blogger -> {ok, [{code, Code}, {loggedin, Blogger}]}
    end.

signin('GET',  []) ->
    case auth_helper:is_logged_in(Req) of
        false   -> ok;
        Blogger -> {redirect, "/blogger/"++Blogger:name()}
    end;
signin('POST', []) ->
    Name = Req:post_param("name"),
    GivenPass = Req:post_param("password"),
    case boss_db:find_first(blogger, [name, equals, Name]) of
        undefined ->
            {ok, [{error, my_util:string_format("'~p' does not exist.", [Name])}]};
        Blogger ->
            case Blogger:authenticate(GivenPass) of
                true ->
                    {redirect, proplists:get_value("redirect", Req:post_params(), "/"), Blogger:bake_cookies()};
                false ->
                    {ok, [{error, "Authentication failed."}]}
            end
    end.

signout('GET', []) ->
    {redirect, "/", auth_helper:discard_cookies()}.

signup('GET',  []) ->
    case auth_helper:is_logged_in(Req) of
        false   -> ok;
        Blogger -> {redirect, "/blogger/"++Blogger:name()}
    end;
signup('POST', []) ->
    Name = Req:post_param("name"),
    Password = Req:post_param("password"),
    Confirm  = Req:post_param("confirmation"),
    case Password =:= Confirm of
        true ->
            Salt = auth_helper:generate_salt(),
            Digest = mochihex:to_hex(crypto:sha(Password ++ Salt)),
            Blogger = blogger:new(id, Name, Digest, Salt),
            {ok, [Blogger:save()]};
        false ->
            {ok, [{error, "Password Confirmation must match Password."}]}
    end.
