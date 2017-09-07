! Copyright 2017 Derek Slaughter. All rights reserved.
! Use of this source code is governed by a BSD-style
! license that can be found in the LICENSE file.

program fossil_test
    use fossil, only: &
        change_dir, &
        get_executable_path, &
        get_working_dir, &
        get_hostname, &
        make_dir_all, &
        remove_all, &
        rename

    implicit none

    character(len=256)::path
    character(len=128)::host
    integer::status

    ! Get the path to the executable
    call get_executable_path(path, status)
    if (status /= 0) stop 1
    print *, 'get_executable_path(path): ', trim(path)

    ! Get the system's host name
    call get_hostname(host, status)
    if (status /= 0) stop 2
    print *, 'get_hostname(host): ', trim(host)

    ! Create the directory even if it already exists
    call make_dir_all('testDir', status)
    if (status /= 0) stop 3

    ! Get the working directory
    call get_working_dir(path, status)
    if (status /= 0) stop 4
    print *, 'get_working_dir(path): ', trim(path)

    ! Change to the test directory
    call change_dir('testDir', status)
    if (status /= 0) stop 5

    ! Get the working path which should include 'testDir'
    call get_working_dir(path, status)
    if (status /= 0) stop 6
    print *, 'get_working_dir(path): ', trim(path)

    ! Change back to parent directory
    call change_dir('..', status)
    if (status /= 0) stop 7

    ! Get the working directory which should be the original directory
    call get_working_dir(path, status)
    if (status /= 0) stop 8
    print *, 'get_working_dir(path): ', trim(path)

    ! Rename 'testDir' to 'newDir'
    call rename('testDir', 'newDir', status)
    if (status /= 0) stop 9

    ! Delete 'newDir'
    call remove_all('newDir', status)
    if (status /= 0) stop 10

end program
