cmake_minimum_required(VERSION 3.16)
list(APPEND CMAKE_MESSAGE_CONTEXT Max_diff_nc)
set(CMAKE_BUILD_TYPE Release CACHE STRING
  "Choose the type of build: Debug,Release...")
project(Max_diff_nc LANGUAGES Fortran)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)
find_package(NetCDF_Fortran REQUIRED)
option(FETCH "Download and build required libraries")

if(FETCH)
  include(FetchContent)
  FetchContent_Declare(Jumble GIT_REPOSITORY
    https://github.com/lguez/Jumble.git)
  FetchContent_Declare(NetCDF95 GIT_REPOSITORY
    https://github.com/lguez/NetCDF95.git)
  FetchContent_MakeAvailable(Jumble NetCDF95)
else()
  find_package(Jumble CONFIG)
  find_package(NetCDF95 CONFIG)
  
  if (NOT Jumble_FOUND OR NOT NetCDF95_FOUND)
    message(FATAL_ERROR [[
      Jumble or NetCDF95 not found, consider the option of cmake:
      -DFETCH=True
      ]])
  endif()
endif()

add_executable(max_diff_nc max_diff_nc.f90)
target_link_libraries(max_diff_nc PRIVATE NetCDF95::netcdf95
  NetCDF_Fortran::netcdff Jumble::jumble)

# Installation part:
include(GNUInstallDirs)
install(TARGETS max_diff_nc DESTINATION ${CMAKE_INSTALL_LIBEXECDIR})
configure_file(max_diff_nc_in.sh max_diff_nc.sh @ONLY)
install(PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/max_diff_nc.sh TYPE BIN)
