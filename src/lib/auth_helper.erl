-module(auth_helper).
-compile(export_all).

generate_salt() ->
	binary_to_list(base64:encode(crypto:strong_rand_bytes(40))).

require_login(Req) ->
    case is_logged_in(Req) of
        false -> {redirect, "/signin"};
        Blogger -> {ok, Blogger}
    end.

is_logged_in(Req) ->
    case Req:cookie("blogger_id") of
        undefined -> false;
        Id ->
            case boss_db:find(Id) of
                undefined -> false;
                Blogger ->
                    case Blogger:session_id() =:= Req:cookie("session_id") of
                        true  -> Blogger;
                        false -> false
                    end
            end
     end.

