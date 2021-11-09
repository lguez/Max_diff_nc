# This is a makefile for GNU make.

execut = max_diff_nc

FC = gfortran
FFLAGS = -O2 -I${HOME}/.local/include
LDLIBS = -L${HOME}/.local/lib -ljumble -lnr_util -lnetcdf95 -lnetcdff -lnetcdf

%: %.f90
	$(LINK.f) $^ $(LOADLIBES) $(LDLIBS) -o $@

.PHONY: all clean
all: ${execut}

clean:
	-rm ${execut}
