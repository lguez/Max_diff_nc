# Example run without -m

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
Found  25  variable(s) in group /
in the first file.
</pre>
</td>

<td>The program found 25 variables in the root group of
the first file. In this example, there are no subgroups.  23 of the
variables are identical to the variables with same name in the second
file. As the option <code>-s</code> was not used, those 23 identical
variables do not appear below. Only two variables for which
differences were found appear.</td>
</tr>

<tr>
<td>
<pre>
---------------------------------------------
Variable "masse":

 Relative difference for non-zero values:

Maximum difference:  2.7E-03
 Occurring at:
data_old(14 7 4 1) =    6.97899061E+15
data_new(14 7 4 1) =    6.95995316E+15
</pre>
</td>

<td><code>masse</code> is a 4-dimensional array. The location of the
maximum is given by the set of 4 indices: 14 7 4 1. These are the
Fortran indices:

<ul>
<li>the list of dimensions is reversed
from the list given by <code>ncdump -h</code>;</li>
<li>the indices start at 1 in each dimension</li>
</ul>

(The location of the maximum is repeated for the two arrays but, of
course, it is by definition the same location.) You can see that
6.97899061E+15 / 6.95995316E+15 - 1 ~= 2.7E-03</td>

</tr>

<tr>
<td>
<pre>
 Absolute difference:

Maximum difference:  2.3E+13
 Occurring at:
data_old(14 7 5 1) =    8.52667026E+15
data_new(14 7 5 1) =    8.50399659E+15
</pre>
</td>

<td>There is no zero value in <code>data_old</code> or
<code>data_new</code> so the program only prints the maximum absolute
difference for the whole arrays.</td>

</tr>
<tr>
<td>
<pre>
||data_new - data_old||_infinite
/ ||data_old||_infinite =  2.6E-03</pre>
</td>

<td>This is the infinite norm (that is, maximum of absolue value) of
the difference divided by the infinite norm of
<code>data_old</code>. Note that you had the infinite norm of the
difference just above (2.3E+13 in this example) so this also gives you
the infinite norm of <code>data_old</code>.</td>

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
