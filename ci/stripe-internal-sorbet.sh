#!/bin/bash
set -eux

# This is the easiest (only?) way to tell bazel not to recurse into
# this subdirectory.
echo '
local_repository(
    name = "stripe_pay_server",
    path = "pay-server",
)
' >> WORKSPACE

./tools/scripts/ci_checks.sh

err=0

# Disable leak sanatizer. Does not work in docker
# https://github.com/google/sanitizers/issues/764

bazel test --config=ci --config=dbg --config=sanitize //... --test_output=errors --test_env="ASAN_OPTIONS=detect_leaks=0" --test_env="UBSAN_OPTIONS=print_stacktrace=1" || err=$?

mkdir -p /log/junit
bazel query 'tests(//...) except attr("tags", "manual", //...)' | while read -r line; do
    path="${line/://}"
    path="${path#//}"
    cp "bazel-testlogs/$path/test.xml" /log/junit/"${path//\//_}.xml"
done

if [ "$err" -ne 0 ]; then
    exit "$err"
fi
