cmake_minimum_required(VERSION 3.17)
list(APPEND CMAKE_MESSAGE_CONTEXT Max_diff_nc)
project(Max_diff_nc LANGUAGES Fortran)
option(FETCH "Download")

if(FETCH)
  include(FetchContent)
  
  function(MakeAvailable)
    # The only difference with FetchContent_MakeAvailable is the
    # option EXCLUDE_FROM_ALL.
    
    foreach(NAME IN LISTS ARGN)
      FetchContent_GetProperties(${NAME})
      string(TOLOWER ${NAME} lcName)
      
      if(NOT ${lcName}_POPULATED)
	FetchContent_Populate(${NAME})

	add_subdirectory(${${lcName}_SOURCE_DIR} ${${lcName}_BINARY_DIR}
	  EXCLUDE_FROM_ALL)
      endif()
    endforeach()
  endfunction()

  FetchContent_Declare(NR_util GIT_REPOSITORY
    https://github.com/lguez/NR_util.git)

  FetchContent_Declare(Jumble GIT_REPOSITORY
    https://github.com/lguez/Jumble.git)

  FetchContent_Declare(NetCDF95 GIT_REPOSITORY
    https://github.com/lguez/NetCDF95.git)

  MakeAvailable(NR_util Jumble NetCDF95)
else()
  set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})
  find_package(Jumble CONFIG REQUIRED)
  find_package(NetCDF95 REQUIRED CONFIG)
  find_package(NetCDF_Fortran REQUIRED)
endif()

add_executable(max_diff_nc max_diff_nc.f90)

target_link_libraries(max_diff_nc PRIVATE NetCDF95::netcdf95
  NetCDF_Fortran::netcdff Jumble::jumble)

include(GNUInstallDirs)
install(TARGETS max_diff_nc DESTINATION ${CMAKE_INSTALL_LIBEXECDIR})
configure_file(max_diff_nc_in.sh max_diff_nc.sh @ONLY)
install(PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/max_diff_nc.sh TYPE BIN)
