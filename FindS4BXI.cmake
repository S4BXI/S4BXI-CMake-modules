# CMake find module to search for the S4BXI library. 

cmake_minimum_required(VERSION 2.8)

find_path(S4BXI_INCLUDE_DIR
	NAMES s4bxi/s4bxi.hpp
	PATHS ${S4BXI_PATH}/include /opt/s4bxi/include
	)
find_library(S4BXI_LIBRARY
	NAMES s4bxi portals
	PATHS ${S4BXI_PATH}/lib /opt/s4bxi/lib
	)
mark_as_advanced(S4BXI_INCLUDE_DIR)
mark_as_advanced(S4BXI_LIBRARY)

set(S4BXI_VERSION "10000") # < Not great but it will do

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(S4BXI
	FOUND_VAR S4BXI_FOUND
	REQUIRED_VARS S4BXI_INCLUDE_DIR S4BXI_LIBRARY
	VERSION_VAR S4BXI_VERSION
	)

# All the following is shamelessly stolen from SimGrid itself (actually the beginning is stolen too I guess)

if (S4BXI_FOUND AND NOT CMAKE_VERSION VERSION_LESS 2.8.12)
  add_library(S4BXI::S4BXI SHARED IMPORTED)
  set_target_properties(S4BXI::S4BXI PROPERTIES
    INTERFACE_SYSTEM_INCLUDE_DIRECTORIES ${S4BXI_INCLUDE_DIR}
    INTERFACE_COMPILE_FEATURES cxx_alias_templates
    IMPORTED_LOCATION ${S4BXI_LIBRARY}
  )
  # We need C++14, so check for it just in case the user removed it since compiling S4BXI
  if (NOT CMAKE_VERSION VERSION_LESS 3.8)
    # 3.8+ allows us to simply require C++14 (or higher)
    set_property(TARGET S4BXI::S4BXI PROPERTY INTERFACE_COMPILE_FEATURES cxx_std_14)
  elseif (NOT CMAKE_VERSION VERSION_LESS 3.1)
    # 3.1+ is similar but for certain features. We pick just one
    set_property(TARGET S4BXI::S4BXI PROPERTY INTERFACE_COMPILE_FEATURES cxx_attribute_deprecated)
  else ()
    # Old CMake can't do much. Just check the CXX_FLAGS and inform the user when a C++14 feature does not work
    include(CheckCXXSourceCompiles)
    set(CMAKE_REQUIRED_FLAGS "${CMAKE_CXX_FLAGS}")
    check_cxx_source_compiles("
#if __cplusplus < 201402L
#error
#else
int main(){}
#endif
" _S4BXI_CXX14_ENABLED)
    if (NOT _S4BXI_CXX14_ENABLED)
        message(WARNING "C++14 is required to use S4BXI. Enable it with e.g. -std=c++14")
    endif ()
    unset(_S4BXI_CXX14_ENABLED CACHE)
  endif ()
endif ()

