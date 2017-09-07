! Copyright 2017 Derek Slaughter. All rights reserved.
! Use of this source code is governed by a BSD-style
! license that can be found in the LICENSE file.

module fossil

    implicit none

    interface
        function change_dir_c(path, size) result(err) bind(C)
            use iso_c_binding, only:c_int, c_char
            character(kind=c_char), intent(in) :: path(*)
            integer(kind=c_int), intent(in) :: size
            integer(kind=c_int) :: err
        end function
        function get_executable_path_c(path, size) result(err) bind(C)
            use iso_c_binding, only:c_int, c_char
            character(kind=c_char), intent(inout) :: path(*)
            integer(kind=c_int), intent(in) :: size
            integer(kind=c_int) :: err
        end function
        function get_hostname_c(host, size) result(err) bind(C)
            use iso_c_binding, only:c_int, c_char
            character(kind=c_char), intent(inout) :: host(*)
            integer(kind=c_int), intent(in) :: size
            integer(kind=c_int) :: err
        end function
        function get_working_dir_c(path, size) result(err) bind(C)
            use iso_c_binding, only:c_int, c_char
            character(kind=c_char), intent(inout) :: path(*)
            integer(kind=c_int), intent(in) :: size
            integer(kind=c_int) :: err
        end function
        function make_dir_c(path, size) result(err) bind(C)
            use iso_c_binding, only:c_int, c_char
            character(kind=c_char), intent(in) :: path(*)
            integer(kind=c_int), intent(in) :: size
            integer(kind=c_int) :: err
        end function
        function make_dir_all_c(path, size) result(err) bind(C)
            use iso_c_binding, only:c_int, c_char
            character(kind=c_char), intent(in) :: path(*)
            integer(kind=c_int), intent(in) :: size
            integer(kind=c_int) :: err
        end function
        function remove_c(path, size) result(err) bind(C)
            use iso_c_binding, only:c_int, c_char
            character(kind=c_char), intent(in) :: path(*)
            integer(kind=c_int), intent(in) :: size
            integer(kind=c_int) :: err
        end function
        function remove_all_c(path, size) result(err) bind(C)
            use iso_c_binding, only:c_int, c_char
            character(kind=c_char), intent(in) :: path(*)
            integer(kind=c_int), intent(in) :: size
            integer(kind=c_int) :: err
        end function
        function rename_c(old_path, old_size, &
                          new_path, new_size) result(err) bind(C)
            use iso_c_binding, only:c_int, c_char
            character(kind=c_char), intent(in) :: old_path(*)
            character(kind=c_char), intent(in) :: new_path(*)
            integer(kind=c_int), intent(in) :: old_size, new_size
            integer(kind=c_int) :: err
        end function
    end interface

contains

    subroutine change_dir(path, status)
        implicit none
        character(len=*), intent(in) :: path
        integer, optional, intent(out) :: status
        integer :: err
        err = change_dir_c(path, len_trim(path))
        if (present(status)) status = err
    end subroutine

    subroutine get_executable_path(path, status)
        implicit none
        character(len=*), intent(inout) :: path
        integer, optional, intent(out) :: status
        integer :: err
        err = get_executable_path_c(path, len(path))
        if (present(status)) status = err
    end subroutine

    subroutine get_hostname(host, status)
        implicit none
        character(len=*), intent(inout) :: host
        integer, optional, intent(out) :: status
        integer :: err
        err = get_hostname_c(host, len(host))
        if (present(status)) status = err
    end subroutine

    subroutine get_working_dir(path, status)
        implicit none
        character(len=*), intent(inout) :: path
        integer, optional, intent(out) :: status
        integer :: err
        err = get_working_dir_c(path, len(path))
        if (present(status)) status = err
    end subroutine

    subroutine make_dir(path, status)
        implicit none
        character(len=*), intent(in) :: path
        integer, optional, intent(out) :: status
        integer :: err
        err = make_dir_c(path, len_trim(path))
        if (present(status)) status = err
    end subroutine

    subroutine make_dir_all(path, status)
        implicit none
        character(len=*), intent(in) :: path
        integer, optional, intent(out) :: status
        integer :: err
        err = make_dir_all_c(path, len_trim(path))
        if (present(status)) status = err
    end subroutine

    subroutine remove(path, status)
        implicit none
        character(len=*), intent(in) :: path
        integer, optional, intent(out) :: status
        integer :: err
        err = remove_c(path, len_trim(path))
        if (present(status)) status = err
    end subroutine

    subroutine remove_all(path, status)
        implicit none
        character(len=*), intent(in) :: path
        integer, optional, intent(out) :: status
        integer :: err
        err = remove_all_c(path, len_trim(path))
        if (present(status)) status = err
    end subroutine

    subroutine rename(old_path, new_path, status)
        implicit none
        character(len=*), intent(in) :: old_path, new_path
        integer, optional, intent(out) :: status
        integer :: err
        err = rename_c(old_path, len_trim(old_path), &
                       new_path, len_trim(new_path))
        if (present(status)) status = err
    end subroutine
end module fossil
