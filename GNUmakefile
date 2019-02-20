# This is a makefile for GNU make.

# 1. Compiler-dependent part

netcdf95_dir = 
jumble_dir = 
nr_util_dir =
netcdf_dir = 

FFLAGS = -I${jumble_dir} -I${netcdf_dir}/include -I${netcdf95_dir} -O2 -free

LDLIBS = -L${jumble_dir} -L${netcdf_dir}/lib -L${netcdf95_dir} -L${nr_util_dir} -lnetcdf95 -ljumble -lnetcdff -lnr_util

# 2. Rules

.PHONY: all clean
execut = max_diff_nc
all: ${execut}

clean:
	-rm ${execut}
