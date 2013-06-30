-module(my_util).
-compile(export_all).

is_match(String, Regexp) ->
    case re:run(String, Regexp) of
        {match, _} -> true;
        nomatch    -> false
    end.

clean_text(Text) ->
    Half = re:replace(Text, "^\\s+", "", [{return, list}]),
    re:replace(Half, "\\s+$", "", [{return, list}]).

cleaned_length(Text) ->
    length(clean_text(Text)).