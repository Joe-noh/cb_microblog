-module(cb_microblog_custom_filters).
-export([timestamp2date/1]).

% put custom filters in here, e.g.
%
% my_reverse(Value) ->
%     lists:reverse(binary_to_list(Value)).
%
% "foo"|my_reverse   => "oof"

timestamp2date(Timestamp) ->
    Base = calendar:datetime_to_gregorian_seconds({{1970, 1, 1}, {0, 0, 0}}),
    {{Year, Mon, Day}, {Hour, Min, Sec}} = calendar:gregorian_seconds_to_datetime(Base + (Timestamp div 1000000)),

    lists:concat([Day, " ", convert_month(Mon), " ", Year, ", " , Hour, ":", Min, ":", Sec]).

convert_month(Month) ->
	Months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
	lists:nth(Month, Months).