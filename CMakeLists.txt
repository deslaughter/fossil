# Copyright 2017 Derek Slaughter. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

set(FOSSIL_C_PATH "${CMAKE_CURRENT_BINARY_DIR}/fossil_c.a")

# Build fossil - C compatible library
add_custom_command(
    OUTPUT ${FOSSIL_C_PATH}
    COMMAND go build -buildmode=c-archive -o ${FOSSIL_C_PATH}
        fossil.go
    DEPENDS fossil_c/fossil.go
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/fossil_c
)

add_custom_target(libfossil_c DEPENDS ${FOSSIL_C_PATH})

# Import fossil_c
add_library(fossil_c STATIC IMPORTED)
set_target_properties(fossil_c PROPERTIES
    IMPORTED_LOCATION ${FOSSIL_C_PATH})
add_dependencies(fossil_c libfossil_c)

# fossil library
add_library(
    fossil STATIC
    fossil.f90
)
target_link_libraries(fossil fossil_c ws2_32 winmm)
target_include_directories(fossil PUBLIC ${CMAKE_CURRENT_BINARY_DIR})

add_subdirectory(test)