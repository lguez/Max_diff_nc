# Usage

If you run `max_diff_nc.sh` with argument `-h`, you will get a short
usage message:

```
$ max_diff_nc.sh -h
Usage: max_diff_nc.sh [OPTION]... file file-or-directory

Compute and locate difference between NetCDF files.

Options:
   -h: this help message
   -s: report identical variables
   -m: compute average order of magnitude
   -i: compare variables with same varid, regardless of variable name
   -q: only report names of variables which differ, without maximum difference
   -v <var>: only compare variable with name <var>
```

`max_diff_nc.sh` requires two arguments: the files to compare. If the
second argument is a directory then `max_diff_nc.sh` will look in this
directory for a file with the same basename as the first argument. The
order of the files is important. The first file is taken as the
reference file in order to compute relative differences. If you
permute the files, the absolute differences will not change but, in
general, the relative differences will change.

Consider a particular variable name (or variable ID, for option `-i`).
The program reads one array of values from each input file,
corresponding to that variable name (or variable ID, for option `-i`).
Let us call `data_old` the array from the first input file and
`data_new` the array from the second input file. We assume the arrays
have the same shape (the program will stop if they do not). The program
computes the "absolute difference":

$$|\mathrm{data\_old} - \mathrm{data\_new}|$$

and the "relative difference":

$$\left|\frac{\mathrm{data\_old} - \mathrm{data\_new}}{\mathrm{data\_old}} \right|$$

The program takes special care of zero values. We construct a mask that
tells us, for each position (set of indices in each dimension), whether
there is a zero value at that position in either array. That is, in the
Fortran program, we define the logical array `zero`:
```
zero = data_old == 0. .or. data_new == 0
```
The program only computes the relative difference where `zero` is false.
For the absolute difference, the program gives two results: a global
result, for the whole arrays, and a result for the portions of the
arrays where `zero` is true.
