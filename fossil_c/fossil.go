// Copyright 2017 Derek Slaughter. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package main

import "C"
import (
	"os"
	"unsafe"
)

//export change_dir_c
func change_dir_c(buffer *C.char, size *C.int) C.int {
	err := os.Chdir(C.GoStringN(buffer, *size))
	if err != nil {
		return 1
	}
	return 0
}

//export get_executable_path_c
func get_executable_path_c(buffer *C.char, size *C.int) C.int {
	path, err := os.Executable()
	if err != nil {
		return 1
	}
	b := (*[1 << 30]byte)(unsafe.Pointer(buffer))[:*size:*size]
	for i := copy(b, path); i < len(b); i++ {
		b[i] = ' '
	}
	if len(path) > int(*size) {
		return 2
	}
	return 0
}

//export get_hostname_c
func get_hostname_c(buffer *C.char, size *C.int) C.int {
	hostname, err := os.Hostname()
	if err != nil {
		return 1
	}
	b := (*[1 << 30]byte)(unsafe.Pointer(buffer))[:*size:*size]
	for i := copy(b, hostname); i < len(b); i++ {
		b[i] = ' '
	}
	if len(hostname) > int(*size) {
		return 2
	}
	return 0
}

//export get_working_dir_c
func get_working_dir_c(buffer *C.char, size *C.int) C.int {
	path, err := os.Getwd()
	if err != nil {
		return 1
	}
	b := (*[1 << 30]byte)(unsafe.Pointer(buffer))[:*size:*size]
	for i := copy(b, path); i < len(b); i++ {
		b[i] = ' '
	}
	if len(path) > int(*size) {
		return 2
	}
	return 0
}

//export make_dir_c
func make_dir_c(path *C.char, size *C.int) C.int {
	err := os.Mkdir(C.GoStringN(path, *size), os.ModePerm)
	if err != nil {
		return 1
	}
	return 0
}

//export make_dir_all_c
func make_dir_all_c(path *C.char, size *C.int) C.int {
	err := os.MkdirAll(C.GoStringN(path, *size), os.ModePerm)
	if err != nil {
		return 1
	}
	return 0
}

//export remove_c
func remove_c(path *C.char, size *C.int) C.int {
	err := os.Remove(C.GoStringN(path, *size))
	if err != nil {
		return 1
	}
	return 0
}

//export remove_all_c
func remove_all_c(path *C.char, size *C.int) C.int {
	err := os.RemoveAll(C.GoStringN(path, *size))
	if err != nil {
		return 1
	}
	return 0
}

//export rename_c
func rename_c(oldPath *C.char, oldSize *C.int, newPath *C.char, newSize *C.int) C.int {
	err := os.Rename(C.GoStringN(oldPath, *oldSize), C.GoStringN(newPath, *newSize))
	if err != nil {
		return 1
	}
	return 0
}

func main() {
}
