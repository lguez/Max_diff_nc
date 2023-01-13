# Main memory used

At run-time, `max_diff_nc` allocates main memory for each new NetCDF
variable it compares, then deallocates memory when it finishes comparing
this variable. So main memory use will vary during execution of
`max_diff_nc`, depending on the size of the currently compared NetCDF
variable. Let us call v the memory occupied by a given NetCDF variable.
v = 4 bytes times its number of elements if it is `NC_FLOAT`, 8 bytes
times its number of elements if it is `NC_DOUBLE`. For a given NetCDF
variable, main memory use will normally be:

-   without computation of average order of magnitude: about 8 v if the
    variable is of type `NC_FLOAT`, 6.5 v if it is `NC_DOUBLE`;
-   with computation of average order of magnitude: about 11 v if the
    variable is of type `NC_FLOAT`, 7.5 v if it is `NC_DOUBLE`.

