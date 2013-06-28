-module(auth_helper).
-compile(export_all).

generate_salt() ->
	binary_to_list(base64:encode(crypto:strong_rand_bytes(10))).