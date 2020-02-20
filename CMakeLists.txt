cmake_minimum_required(VERSION 3.14)
project(max_diff_nc_project Fortran)
add_executable(max_diff_nc max_diff_nc.f90)

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})
include(ConfigureCompilerFlags)

find_package(NetCDF REQUIRED)
find_package(NR_util REQUIRED CONFIG)
find_package(Jumble REQUIRED CONFIG)
find_package(NetCDF95 REQUIRED CONFIG)

find_path(netcdff_INCLUDE_DIR netcdf.mod)
find_library(netcdff_LIBRARY netcdff)

target_include_directories(max_diff_nc PRIVATE ${netcdff_INCLUDE_DIR})
target_link_libraries(max_diff_nc netcdf95 ${netcdff_LIBRARY} jumble)
