# FOSSIL - Fortran Operating System Simple Interface Library

## Motivation

The goal of FOSSIL is to provide a library of subroutines which allow Fortran programs to interact with the operating system in a cross-platform way. For example, creating a directory requires calling an OS specific function which must be changed depending on the platform.

## Methodology

FOSSIL makes functions written in the [Go Programming Language](http://www.golang.org) available for use by Fortran programs. Go can be used to create C compatible static or shared libraries on the Windows, Linux, and Mac operating systems for a variety of platforms. FOSSIL then wraps the Go generated C library in a Fortran 2008 compatible module which uses standard fortran types and conventions.

## Building

The first step is to clone this repository to your local system.

The FOSSIL library (*libfossil*) and accompanying Go based library (*libfossil_c*) are created via the [CMake](https://cmake.org/) build system. If your project is already using CMake, just add `add_subdirectory(${FOSSIL_DIR})` to your `CMakeLists.txt` where `${FOSSIL_DIR}` is the path to the cloned directory.

## Example

The following example demonstrates some of the subroutines included in the FOSSIL library.

```fortran
program fossil_test

    use fossil, only: get_executable_path, get_working_dir, make_dir, rename

    implicit none

    character(len=256)::path
    integer::status

    ! Get the path to the executable
    call get_executable_path(path, status)
    if (status /= 0) stop 1
    print *, 'get_executable_path(path): ', trim(path)

    ! Get the working directory
    call get_working_dir(path, status)
    if (status /= 0) stop 2
    print *, 'get_working_dir(path): ', trim(path)

	! Create directory
    call make_dir('testDir', status)
    if (status /= 0) stop 3

    ! Rename 'testDir' to 'newDir'
    call rename('testDir', 'newDir', status)
    if (status /= 0) stop 4

end program fossil_test
```

## TODO

Currently only a small subset of the Go standard library has been made available in FOSSIL. However, there are many additional functions that would be useful to call from Fortran. If there is a specific feature that you would like to be added, please open an issue.

There is always a need for more documentation. I plan on using [Doxygen](http://www.stack.nl/~dimitri/doxygen/) to generate documentation for all available functions once the appropriate descriptions have been added.