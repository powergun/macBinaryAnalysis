#!/usr/bin/env bash

# to change the shared library search mechanism after the binary 
# is built

# see
# https://stackoverflow.com/questions/33991581/install-name-tool-to-update-a-executable-to-search-for-dylib-in-mac-os-x

# the test subject is FB infer 0.17.0 (can be downloaded from its
# release page)
# it has a problem that it's linked against the system's sqlite3
# instead of the version managed by brew (which is newer)

# before change, verify the linkage:
# /usr/lib/libsqlite3.dylib (compatibility version 9.0.0, current version 274.26.0)

install_name_tool -change /usr/lib/libsqlite3.dylib /usr/local/Cellar/sqlite/3.29.0/lib/libsqlite3.0.dylib $infer17

# after change, check that linkage has been updated:
# /usr/local/Cellar/sqlite/3.29.0/lib/libsqlite3.0.dylib (compatibility version 9.0.0, current version 274.26.0)

# this fixes infer's segfault issue
# see:
# https://github.com/facebook/infer/issues/1081
# 