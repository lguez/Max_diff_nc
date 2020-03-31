cmake_minimum_required(VERSION 3.17)
project(Max_diff_nc Fortran)
set(FETCH OFF CACHE BOOL "Download")

if(FETCH)
  include(FetchContent)
  
  FetchContent_Declare(NR_util GIT_REPOSITORY
    https://github.com/lguez/NR_util.git)

  FetchContent_Declare(Jumble GIT_REPOSITORY
    https://github.com/lguez/Jumble.git)

  FetchContent_Declare(NetCDF95 GIT_REPOSITORY
    https://github.com/lguez/NetCDF95.git)

  FetchContent_MakeAvailable(NR_util Jumble NetCDF95)
else()
  find_package(NR_util REQUIRED CONFIG)
  find_package(Jumble CONFIG REQUIRED)
  find_package(NetCDF95 REQUIRED CONFIG)
endif()

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})
include(ConfigureCompilerFlags)
find_package(NetCDF REQUIRED)
find_path(netcdff_INCLUDE_DIR netcdf.mod)
find_library(netcdff_LIBRARY netcdff)

add_executable(max_diff_nc max_diff_nc.f90)
target_include_directories(max_diff_nc PRIVATE ${netcdff_INCLUDE_DIR})
target_link_libraries(max_diff_nc netcdf95 ${netcdff_LIBRARY} jumble)
