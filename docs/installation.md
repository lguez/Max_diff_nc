# Installation

See [note](French_centers.md) for users of French supercomputing
centers.

## Dependencies

- `max_diff_nc` is written in Fortran (2003) and Bash so you need a
Fortran 2003 compiler and Bash on your machine.

- Install the library
[NetCDF-Fortran](https://www.unidata.ucar.edu/downloads/netcdf/index.jsp),
with the same Fortran compiler than the one you want to use for
`Max_diff_nc`.

- [CMake](https://cmake.org/download) (version ≥ 3.17)[^1].

## Instructions

1.  Get [max\_diff\_nc from
    Github](https://github.com/lguez/Max_diff_nc). As the Git
    repository contains a submodule, the easiest way is to type:

		git clone --recurse-submodules https://github.com/lguez/Max_diff_nc.git

	If you prefer to download a ZIP file then you will also have to
    download the [cmake subdirectory](https://github.com/lguez/cmake).

2.  Create a build subdirectory in the directory you have just downloaded:

        cd Max_diff_nc
        mkdir build
        cd build

3.  Choose the installation directory `CMAKE_INSTALL_PREFIX` and type
    the command below with your choice after `-DCMAKE_INSTALL_PREFIX=`
    (enter an absolute path). The installation process will
    install a shell script, `max_diff_nc.sh`, in
    `$CMAKE_INSTALL_PREFIX/bin`. It is convenient for
    `$CMAKE_INSTALL_PREFIX/bin` to be in your `PATH` environment
    variable. For example:

        cmake .. -DFETCH=ON -DCMAKE_INSTALL_PREFIX=~/.local

4.  Type:

        make install

You do not need to keep the downloaded directory `Max_diff_nc` (nor
the build directory) after installation. Note that the installation
process also installs a Fortran executable file, `max_diff_nc`, in
`$CMAKE_INSTALL_PREFIX/libexec`. Do not remove this file.

## Advanced instructions

- You can choose any name and any location for the build
   directory. You have to refer to the source directory when you run
   cmake from the build directory:

		mkdir /wherever/any/name
		cd /wherever/any/name
		cmake /where/I/downloaded/Max_diff_nc -DFETCH=ON -DCMAKE_INSTALL_PREFIX=~/.local

- The option `-DFETCH=ON` instructs CMake to download, compile and
   install the libraries [NetCDF95](https://lguez.github.io/NetCDF95)
   and
   [Jumble](https://www.lmd.jussieu.fr/~lguez/Jumble_site/index.html). If
   you have already installed these libraries, you can omit the FETCH
   option.

## Troubleshooting

If your installation of NetCDF-Fortran is in a non-standard
location, and CMake does not find it, then re-run cmake setting the
variable `CMAKE_PREFIX_PATH` to the directory containing it. CMake
will then search `${CMAKE_PREFIX_PATH}/lib`,
`${CMAKE_PREFIX_PATH}/include`, etc. For example:

	cmake . -DCMAKE_PREFIX_PATH:PATH=/path/to/my/favorite/installation

[^1]: On Mac OS, after downloading the application from the CMake web
    site, run it, then click on "How to Install For Command Line Use"
    in the Tools menu.
