# CMake find module to search for the S4BXI library. 

cmake_minimum_required(VERSION 2.8)

find_path(S4BXI_INCLUDE_DIR
	NAMES s4bxi/s4bxi.hpp
	PATHS ${S4BXI_PATH}/include /opt/s4bxi/include
	)
find_library(S4BXI_LIBRARY
	NAMES s4bxi
	PATHS ${S4BXI_PATH}/lib /opt/s4bxi/lib
	)
mark_as_advanced(S4BXI_INCLUDE_DIR)
mark_as_advanced(S4BXI_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(S4BXI
	FOUND_VAR S4BXI_FOUND
	REQUIRED_VARS S4BXI_INCLUDE_DIR S4BXI_LIBRARY
	VERSION_VAR S4BXI_VERSION
	)

