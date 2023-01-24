# `rsplitargs`

An OTP library for parsing Redis command the way `redis-cli` does.

There is the only function `rsplitargs:split/1` that reimplements the one used
by Redis itself: https://github.com/redis/redis/blob/unstable/src/sds.c#L1095.

For usage, see [rsplitargs_SUITE](test/rsplitargs_SUITE.erl).

