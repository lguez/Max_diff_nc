---
date: '2020-04-03'
title: Installation
---

Installation
===

See [note](French_centers.md) for users of French supercomputing
centers.

Installation with CMake
---

This is the recommended way.

Dependencies: you must first install [CMake](https://cmake.org/download)
(version ≥ 3.17) and the libraries
[NetCDF-C](https://www.unidata.ucar.edu/downloads/netcdf/index.jsp) and
[NetCDF-Fortran](https://www.unidata.ucar.edu/downloads/netcdf/index.jsp).

`max_diff_nc` is written in Fortran 2003 and Bash so you need a Fortran
2003 compiler and Bash on your machine. Moreover, you need to use the
same Fortran compiler than used for NetCDF-Fortran.

1.  Get [max\_diff\_nc from
    Github](https://github.com/lguez/Max_diff_nc). The directory you
    get could be called max\_diff\_nc or max\_diff\_nc-master
    (depending on whether you cloned or downloaded a ZIP file).
2.  Type:

        cd the-directory-you-just-downloaded
        mkdir build
        cd build
            

3.  Choose the installation directory `CMAKE_INSTALL_PREFIX` and type
    the command below with your choice after `-DCMAKE_INSTALL_PREFIX=`
    (enter an absolute path). For example, you could choose
    `-DCMAKE_INSTALL_PREFIX=~/.local`. The installation process will
    install a shell script, `max_diff_nc.sh`, in
    `$CMAKE_INSTALL_PREFIX/bin`. It is convenient for
    `$CMAKE_INSTALL_PREFIX/bin` to be in your `PATH` environment
    variable.

        cmake .. -DCMAKE_BUILD_TYPE=Release -DFETCH=ON -DCMAKE_INSTALL_PREFIX=/wherever
            

4.  Type:

        make install
            

Note that the installation process also installs a Fortran executable
file, `max_diff_nc`, in `$CMAKE_INSTALL_PREFIX/libexec`. Do not remove
this file.

Installation directly with make
---

This is the (old) less automated way, not recommended.

Dependencies: you must first install the libraries
[NetCDF-C](https://www.unidata.ucar.edu/downloads/netcdf/index.jsp),
[NetCDF-Fortran](https://www.unidata.ucar.edu/downloads/netcdf/index.jsp),
[NetCDF95](https://www.lmd.jussieu.fr/~lguez/NetCDF95_site/index.html),
[NR\_util](https://www.lmd.jussieu.fr/~lguez/NR_util_site/index.html)
and [Jumble](https://www.lmd.jussieu.fr/~lguez/Jumble_site/index.html).
The four Fortran libraries, NetCDF-Fortran, NetCDF95, NR\_util and
Jumble, must be compiled with the same compiler.

`max_diff_nc` is written in Fortran 2003 and Bash so you need a Fortran
2003 compiler and Bash on your machine. Moreover, you need to use the
same Fortran compiler than used for the four Fortran libraries.

1.  Get [max\_diff\_nc from
    Github](https://github.com/lguez/Max_diff_nc). The directory you get
    could be called max\_diff\_nc or max\_diff\_nc-master (depending on
    whether you cloned or downloaded a ZIP file).
2.  In the file GNUmakefile, locate the line:

        FC = gfortran

    If the compiler you are going to use is not GNU Fortran, replace
    gfortran by the command name for your compiler.

3.  In GNUmakefile, locate the line defining the variable FFLAGS:

        FFLAGS = -O2 -I...

    Replace the ellipsis by the path to the compiled NetCDF-Fortran,
    NetCDF95 and Jumble module interfaces (usually `netcdf.mod`,
    `netcdf95.mod` and `jumble.mod`). If there are several paths, type
    each path after `-I`:

        -Ipath1 -Ipath2 -Ipath3

    (the order does not matter).

4.  In GNUmakefile, locate the line defining the variable LDLIBS:

        LDLIBS = -L... -ljumble -lnr_util -lnetcdf95 -lnetcdff -lnetcdf

    Replace the ellipsis by the path to the NetCDF-C, NetCDF-Fortran,
    NetCDF95, `NR_util` and Jumble libraries (NetCDF-Fortran depends on
    NetCDF-C and Jumble depends on `NR_util`), if they are not in
    standard locations. If there are several paths, type each path after
    `-L`:

        -Lpath1 -Lpath2 -Lpath3

    (the order does not matter). You may need additional options in
    LDLIBS required by your NetCDF-C installation. See for example
    [nc-config](https://www.unidata.ucar.edu/software/netcdf/workshops/most-recent/utilities/Nc-config.html)
    or [Compiling and Linking with the NetCDF
    Library](https://www.unidata.ucar.edu/software/netcdf/fortran/docs/f90-use-of-the-netcdf-library.html#f90-compiling-and-linking-with-the-netcdf-library).

5.  The makefiles are written for GNU make. The command invoking GNU
    make is usually just:

        make
            

    After compilation, the executable binary file `max_diff_nc` should
    be created in the directory `Max_diff_nc`. There is also a Bash
    script `max_diff_nc_in.sh` in the directory `Max_diff_nc`.

6.  Decide where you want to keep the executable binary file
    `max_diff_nc` and move it there. (Or you can just leave it where it
    is, if you want.) We advise *not* to put it into a directory
    appearing in your environment variable `PATH`. This would not be
    convenient because you will not run `max_diff_nc` directly.
7.  In the script `max_diff_nc.sh`, locate the line:

        max_diff_nc=...
            

    Replace the ellipsis by the *absolute* path to the executable binary
    file `max_diff_nc`. For example:

        max_diff_nc=~/.local/libexec/max_diff_nc
            

8.  It is convenient to save the script `max_diff_nc_in.sh` to somewhere
    in your `PATH`, renaming it to `max_diff_nc.sh`.

`max_diff_nc` and `max_diff_nc.sh` are the only files you will need. So
you can trash everything else if you want. (Be careful that if you type
`make clean` in the top directory and `max_diff_nc` is still there then
it will be deleted.)
