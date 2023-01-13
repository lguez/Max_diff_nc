---
date: '2019-10-23'
title: What is it?
---

# What is it?

This is a program which compares two
[NetCDF](http://www.unidata.ucar.edu/software/netcdf) files. Only
NetCDF variables with type `NC_FLOAT` or `NC_DOUBLE` are compared. The
program either compares variables with the same NetCDF ID (`varid`) or
variables with the same name. Compared variables are assumed to have
the same type and the program checks that they have the same
shape. For each such couple of variables, the program computes the
maximum of the absolute value of the difference, and the maximum of
the absolute value of the relative difference. The program also tells
you at what location (the subscript list of the array) the maximum
difference is reached.

Author: [Lionel GUEZ](https://www.lmd.jussieu.fr/~lguez)
