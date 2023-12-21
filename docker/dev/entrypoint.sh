#!/bin/bash

set -e

bundle check || bundle

rm -rf tmp/pids/server.pid

exec "$@"