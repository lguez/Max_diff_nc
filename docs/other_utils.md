---
date: Feb 20 2017
title: Alternatives
---

How does it compare with other similar utilities?
===

You can obtain similar information with other tools:
[nccmp](https://gitlab.com/remikz/nccmp),
[cdo](https://code.zmaw.de/projects/cdo) `diff`,
[ncdiff](http://nco.sourceforge.net/nco.html#ncbo-netCDF-Binary-Operator),
[Ferret](http://ferret.wrc.noaa.gov/Ferret)... The information you get
with these other tools is similar but not identical.

`nccmp` tells you whether the contents of the two files are different.
You can give `nccmp` a "tolerance", so that if the difference
(absolute or relative) between two variables is below the tolerance
value, the variables are considered as identical. But `nccmp` does not
tell you how much the difference is.

`cdo diff` applies to climate data, while `max_diff_nc` is as general as
NetCDF. Moreover, `cdo diff` splits each variable into slabs, one slab
for each vertical level and each date. `cdo diff` gives you the
difference slab by slab. As it outputs much more information than
`max_diff_nc`, `cdo diff` has to output variable codes, rather than
variable names. `max_diff_nc` is more synthetic, it gives the difference
for a whole variable. Also `max_diff_nc` tells you at what location (the
subscript list of the array) the maximum difference is reached.

`ncdiff` is part of NCO. With `ncdiff`, you create a new NetCDF file.
Each variable in the output NetCDF file is the difference of
corresponding variables in the input files, and has the same shape. It
is useful if you want to visualize the difference as a function as
position. `ncdiff` by itself does not give you the relative difference,
nor the maximum of the difference. Even with other NCO operators, it
seems difficult to obtain the relative difference and the maximum of the
difference for all variables.

You can write a Ferret script which opens two NetCDF files and gives you
statistics on the difference between two variables. However, it seems
difficult to tell the script to loop over all variables. Also Ferret
will not tell you at what location (the subscript list of the array) the
maximum difference is reached.
