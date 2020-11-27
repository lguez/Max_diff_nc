---
date: Sep 7 2011
title: Example run with -m
---

Example run with -m
===

Here is an example illustrating the `-m` option. We examine the same two
files as in the [example without `-m`](example_1.md).
The command line is:

    $ max_diff_nc.sh -s 111/histrac.nc 113/histrac.nc

and here is the output:

<table>
<tr>
<th>standard output</th>
<th>comment</th>
</tr>
<tr>
<td>
<pre>
 Found  25  variable(s) in the first file.

---------------------------------------------
Variable "zmasse":
</pre>
</td>

<td></td>

</tr>
<tr>
<td>
<pre>

Average value of log10(abs(data_old)):   3.

</pre>
</td>

<td>This is the additional information provided for each variable by
the <code>-m</code> option. The average is computed over non-zero
values of <code>data_old</code>, and the number of values used is the
number of non-zero values.</td>

</tr>
<tr>
<td>
<pre>
 Relative difference for non-zero values:

Maximum difference: 3.3E-03
 Occurring at:
data_old(19 13 3 1) =  1522.2444
data_new(19 13 3 1) =  1527.2977

 Absolute difference:

Maximum difference:  7.
 Occurring at:
data_old(18 13 4 1) =  2297.566
data_new(18 13 4 1) =  2304.862

---------------------------------------------
Variable "d_tr_cv_RN":

Average value of log10(abs(data_old)):  -6.

 Relative difference for non-zero values:

Maximum difference: 1.6E+07
 Occurring at:
data_old(3 16 1 1) =  1.6982631E-24
data_new(3 16 1 1) =  2.7377417E-17

 Absolute difference when there is a zero:

Maximum difference: 5.9E+03
 Occurring at:
data_old(19 15 1 1) =  -5863.641
data_new(19 15 1 1) =  0.

 Absolute difference:

Maximum difference: 6.6E+03
 Occurring at:
data_old(11 12 1 1) =  -8759.474
data_new(11 12 1 1) =  -2166.5264
</pre>
</td>

<td></td>

</tr>
</table>
