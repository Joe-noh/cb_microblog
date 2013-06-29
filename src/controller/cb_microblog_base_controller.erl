-module(cb_microblog_base_controller, [Req]).
-compile(export_all).

index('GET', []) -> ok.

missing('GET', [Code]) -> {ok, [{code, Code}]}.

