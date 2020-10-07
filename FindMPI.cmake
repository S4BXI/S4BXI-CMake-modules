# CMake find module to search for the MPI library. 

cmake_minimum_required(VERSION 2.8)

find_path(MPI_INCLUDE_DIR
	NAMES mpi.h
	PATHS ${MPI_PATH}/include /opt/ompi_bull/include
	)
find_library(MPI_LIBRARY
	NAMES mpi
	PATHS ${MPI_PATH}/lib /opt/ompi_bull/lib
	)
mark_as_advanced(MPI_INCLUDE_DIR)
mark_as_advanced(MPI_LIBRARY)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(MPI
	FOUND_VAR MPI_FOUND
	REQUIRED_VARS MPI_INCLUDE_DIR MPI_LIBRARY
	VERSION_VAR MPI_VERSION
	)

