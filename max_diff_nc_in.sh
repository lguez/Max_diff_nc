#!/usr/bin/bash

# Author: Lionel GUEZ

# This script is a wrapper for a Fortran program. It may be necessary
# to set up the environment with module (see at the end of the
# script).

USAGE="Usage: `basename $0` [OPTION]... file file-or-directory

Compute and locate difference between NetCDF files.

Options:
   -s: report identical variables
   -m: compute average order of magnitude
   -i: compare variables with same varid, regardless of variable name
   -q: only report names of variables which differ, without maximum difference
   -v <var>: only compare variable with name <var>

For further documentation, see:
https://lguez.github.io/Max_diff_nc"

# Default values:
report_id=False
comp_mag=False
same_varid=False
quiet=False

while getopts smiqv: name
  do
  case $name in
      s) report_id=True;;
      m) comp_mag=True;;
      i) same_varid=True;;
      q) quiet=True;;
      v) name1=$OPTARG;;
      \?) echo "$USAGE"
      exit 1;;
  esac
done

shift $((OPTIND - 1))

if (($# != 2))
    then
    echo "$USAGE" >&2
    exit 1
fi

if [[ -d $2 ]]
then
    # Assume that basename is the same:
    my_file=`basename $1`
    set $1 $2/$my_file
fi

for argument in $*
  do
  if [[ ! -f $argument ]]
      then
      echo "$argument not found" >&2
      exit 1
  fi
done

max_diff_nc=@CMAKE_INSTALL_FULL_LIBEXECDIR@/max_diff_nc

if [[ ! -f $max_diff_nc || ! -x $max_diff_nc ]]
    then
    echo "Fortran executable not found" >&2
    exit 1
fi

# No set -e because module purge could fail

# Set up the necessary environment:
##module purge --silent
##module load --silent ...

# Run the Fortran program:
$max_diff_nc $* <<EOF
$same_varid
$report_id
$quiet
$comp_mag
$name1
EOF
