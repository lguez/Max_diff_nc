program max_diff_nc

  ! This is a program in Fortran 2003.
  ! Author: Lionel GUEZ
  ! See description in wrapper script.

  ! This program is meant to be used with a wrapper script so input
  ! statements do not have prompts.

  ! Libraries:
  use jumble, only: get_command_arg_dyn
  use netcdf, only: nf90_nowrite, nf90_max_name
  use netcdf95, only: nf95_close, nf95_open

  use compare_groups_m, only: compare_groups

  implicit none

  integer ncid1, ncid2
  character(len = nf90_max_name) name1
  logical same_varid ! compare variables with same varid
  logical report_id ! report identical variables
  logical comp_mag ! compute avergage order of magnitude
  logical quiet
  character(len = :), allocatable:: filename

  !----------------------

  read *, same_varid
  read *, report_id
  read *, quiet
  read *, comp_mag
  read "(a)", name1

  call get_command_arg_dyn(1, filename)
  call nf95_open(filename, nf90_nowrite, ncid1)
  call get_command_arg_dyn(2, filename)
  call nf95_open(filename, nf90_nowrite, ncid2)
  call compare_groups(same_varid, report_id, quiet, comp_mag, name1, ncid1, &
       ncid2, group_name = "/")
  call nf95_close(ncid1)
  call nf95_close(ncid2)

end program max_diff_nc
