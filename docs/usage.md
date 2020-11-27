---
date: Oct 28 2014
title: Usage
---

Usage
===

If you type `max_diff_nc.sh` without argument, you will get a short
usage message:
```
$ max_diff_nc.sh 
usage: max_diff_nc.sh [-s] [-m] [-i] [-q] [-v <var>] file file
   -s: report identical variables
   -m: compute average order of magnitude
   -i: compare variables with same varid, regardless of variable name
   -q: only report names of variables which differ, without maximum difference
   -v <var>: only compare variable 
```
`max_diff_nc.sh` requires two arguments: the files to compare. The order
of the files is important. The first file is taken as the reference file
in order to compute relative differences. If you permute the files, the
absolute differences will not change but, in general, the relative
differences will change.

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
