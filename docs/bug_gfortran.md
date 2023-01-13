# Known bug of old Gfortran

There is a known problem in older versions of Gfortran, fixed in version
`4.4.5` of Gfortran. The program `max_diff_nc` prints differences with
the Fortran format `1pg7.1`. Older versions of Gfortran produce wrong
results with this format. For example, according to the Fortran 95
standard, printing the number 0.96 with the format `1pg7.1` should give
the same result than with format `f3.0`. Thus, the result should be
`1.`, but Gfortran produces the surprising result `0.` If you cannot use
another compiler, a work-around is to change `1pg7.1` to `1pg8.2` in the
file `compare.f90` of library Jumble.
