-module(auth_helper).
-compile(export_all).

generate_salt() ->
	binary_to_list(base64:encode(crypto:strong_rand_bytes(10))).

require_login(Req) ->
    case Req:cookie("blogger_id") of
        undefined -> {redirect, "/signin"};
        Id ->
            case boss_db:find(Id) of
                undefined -> {redirect, "/signin"};
                Blogger ->
                    case Blogger:session_id() =:= Req:cookie("session_id") of
                        true  -> {ok, Blogger};
                        false -> {redirect, "/signin"}
                    end
            end
     end.