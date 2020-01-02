cmake_minimum_required(VERSION 3.14)
project(max_diff_nc_project Fortran)
add_executable(max_diff_nc max_diff_nc.f90)
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})
include(ConfigureCompilerFlags)

find_package(NetCDF REQUIRED)

find_path(jumble_INCLUDE_DIR jumble.mod)
find_library(jumble_LIBRARY jumble)

find_path(nr_util_INCLUDE_DIR nr_util.mod)
find_library(nr_util_LIBRARY nr_util)

find_path(netcdf95_INCLUDE_DIR netcdf95.mod)
find_library(netcdf95_LIBRARY netcdf95)

find_path(netcdff_INCLUDE_DIR netcdf.mod)
find_library(netcdff_LIBRARY netcdff)

target_include_directories(max_diff_nc PRIVATE ${jumble_INCLUDE_DIR}
  ${nr_util_INCLUDE_DIR} ${netcdf95_INCLUDE_DIR} ${netcdff_INCLUDE_DIR})

target_link_libraries(max_diff_nc ${netcdf95_LIBRARY}
  ${netcdff_LIBRARY} ${NetCDF_LIBRARY} ${jumble_LIBRARY} ${nr_util_LIBRARY})
