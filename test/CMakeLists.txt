# Copyright 2017 Derek Slaughter. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# fossil test program
add_executable(
    fossil_test
    fossil_test.f90
)
target_link_libraries(fossil_test fossil)

add_test(NAME fossil_test COMMAND fossil_test)