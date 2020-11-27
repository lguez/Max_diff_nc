---
date: '2014-04-22'
title: Example run without -m
---

Example run without -m
===

The command line is:

    $ max_diff_nc.sh 111/histrac.nc 113/histrac.nc

In this example, `max_diff_nc` is invoked without the options `-s`, `-m`
or `-i`. Here is the output:

<table>
<tr>
<th>standard output</th>
<th>comment</th>
</tr>

<tr>
<td>
<pre>
 Found  25  variable(s) in the first file.

</pre>
</td>
<td>The program found 25 variables in the first file, but 23 of those are
identical. As the option <code>-s</code> was not used, those 23
identical variables do not appear below. Only two variables for which
differences were found appear.</td>
</tr>

<tr>
<td>
<pre>
-------------------------------------------
Variable "zmasse":

 Relative difference for non-zero values:

Maximum difference: 3.3E-03
 Occurring at:
data_old(19 13 3 1) =  1522.2444
data_new(19 13 3 1) =  1527.2977
</pre>
</td>

<td><code>zmasse</code> is a 4-dimensional array. The location of the
maximum is given by the set of 4 indices: 19 13 3 1. These are the
Fortran indices:

<ul>
<li>the list of dimensions is reversed
from the list given by <code>ncdump -h</code>;</li>
<li>the indices start at 1 in each dimension</li>
</ul>

(The location of the maximum is repeated for the two arrays but, of
course, it is by definition the same location.) You can see that
1527.2977 / 1522.2444 - 1 ~= 3.3E-03 </td> </tr>

<tr>
<td>
<pre>

 Absolute difference:

Maximum difference:  7.
 Occurring at:
data_old(18 13 4 1) =  2297.566
data_new(18 13 4 1) =  2304.862

</pre>
</td>

<td>There is no zero value in <code>data_old</code> or
<code>data_new</code> so the program only prints the maximum absolute
difference for the whole arrays.</td>

</tr>
<tr>
<td>
<pre>
-------------------------------------------
Variable "d_tr_cv_RN":

 Relative difference for non-zero values:

Maximum difference: 1.6E+07
 Occurring at:
data_old(3 16 1 1) =  1.6982631E-24
data_new(3 16 1 1) =  2.7377417E-17

</pre>
</td>
</tr>
<tr>
<td>
<pre>
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

<td>There are zero values at some locations in <code>data_old</code> or
<code>data_new</code> so the program prints two results: for locations
where there is a zero value and for the whole arrays.</td>

</tr>
</table>
