Changes before version control
==============================

(See [Github page](https://github.com/lguez/Max_diff_nc) for more recent
changes.)

-   April 8th, 2014. `max_diff_nc` now reads NetCDF float variables into
    real Fortran variables and NetCDF double variables into double
    precision Fortran variables. (For the sake of lower memory usage.)
-   May 10th, 2013. The default behaviour of `max_diff_nc` is now to
    read NetCDF variables into double precision Fortran variables. It is
    now easy to switch to another real precision (just modify the
    definition of `wp` in `max_diff_nc.f90`).
-   June 12th, 2012. When comparing variables with the same name, if a
    name is not found in the second file, the program now just skips the
    comparison, instead of stopping.
-   September 8th, 2011. Added option `-v` for comparison of a given
    variable. Generalized installation process to accomodate version 4
    of NetCDF.
-   April 28th, 2010. Added comparison by variable name. Comparison by
    variable ID, which was the only choice before, is now selected by
    option `-i`.

