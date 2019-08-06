# This is a makefile for GNU make.

# 1. Executable file

execut = max_diff_nc

# 2. Compiler-dependent part

FFLAGS = -free -I${WORKDIR}/build/Libraries_ifort_debug/modules -I/smplocal/pub/NetCDF/4.3.3.1/seq/include

LDLIBS = -L${WORKDIR}/build/Libraries_ifort_debug/Jumble -L${WORKDIR}/build/Libraries_ifort_debug/NetCDF95 -L${WORKDIR}/build/Libraries_ifort_debug/NR_util -L/smplocal/pub/NetCDF/4.3.3.1/seq/lib) -ljumble -lnetcdf95 -lnetcdff -lnr_util

# 2. Rules

%: %.f90
	$(LINK.f) $^ $(LOADLIBES) $(LDLIBS) -o $@

all: ${execut}

clean:
	-rm ${execut}
