# This is a makefile for GNU make.

netcdf95_dir = ${HOME}/Compil_prod/NetCDF95_${FC}_debug
jumble_dir = ${HOME}/Compil_prod/Jumble_${FC}_debug
nr_util_dir = ${HOME}/Compil_prod/NR_util_${FC}_debug

include ${general_compiler_options_dir}/settings.mk

# 1. Executable file and libraries

execut = max_diff_nc
lib_list = netcdf95 jumble netcdff nr_util

# 2. Rules

all: ${execut} log

clean:
	-rm ${execut} log
