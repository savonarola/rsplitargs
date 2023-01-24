-module(rsplitargs_SUITE).

-compile(nowarn_export_all).
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").

all() ->
    [t_split].

t_split(_Config) ->
    ?assertEqual(
        {ok, [<<"ab">>, <<"cd">>, <<"ef">>]},
        rsplitargs:split(<<" ab\tcd ef">>)
    ),
    ?assertEqual(
        {ok, [<<"abc'd">>, <<"ef">>]},
        rsplitargs:split(<<"ab\"c'd\" ef">>)
    ),
    ?assertEqual(
        {ok, [<<"abc\"d">>, <<"ef">>]},
        rsplitargs:split(<<"ab'c\"d' ef">>)
    ),
    ?assertEqual(
        {ok, [<<"IJK">>, <<"\\x49\\x4a\\x4B">>]},
        rsplitargs:split(<<"\"\\x49\\x4a\\x4B\" \\x49\\x4a\\x4B">>)
    ),
    ?assertEqual(
        {ok, [<<"x\t\n\r\b\v">>]},
        rsplitargs:split(<<"\"\\x\\t\\n\\r\\b\\a\"">>)
    ),
    ?assertEqual(
        {error, trailing_after_quote},
        rsplitargs:split(<<"\"a\"b">>)
    ),
    ?assertEqual(
        {error, unterminated_quote},
        rsplitargs:split(<<"\"ab">>)
    ),
    ?assertEqual(
        {ok, [<<"abc\'d">>, <<"ef">>]},
        rsplitargs:split(<<"'abc\\'d' ef">>)
    ),
    ?assertEqual(
        {error, trailing_after_single_quote},
        rsplitargs:split(<<"'a'b'c">>)
    ),
    ?assertEqual(
        {error, unterminated_single_quote},
        rsplitargs:split(<<"'ab">>)
    ),
    ok.
