program max_diff_nc

  ! This is a program in Fortran 2003.
  ! Author: Lionel GUEZ
  ! See description in wrapper script.

  ! This program is meant to be used with a wrapper script so input
  ! statements do not have prompts.

  use netcdf95, only: nf95_close, nf95_gw_var, nf95_inq_varid, nf95_inquire, &
       nf95_inquire_variable, nf95_open
  use netcdf, only: nf90_noerr, nf90_nowrite, nf90_max_name, NF90_FLOAT, &
       NF90_double
  use jumble, only: compare, get_command_arg_dyn

  implicit none

  integer ncid1, ncid2, ncerr, xtype1, ndims
  integer nvariables ! number of variables in the first file
  integer nvar_comp ! number of variables which will be compared
  integer, allocatable:: varid1(:), varid2(:)

  real, allocatable:: v1_1d(:), v2_1d(:)
  real, allocatable:: v1_2d(:, :), v2_2d(:, :)
  real, allocatable:: v1_3d(:, :, :), v2_3d(:, :, :)
  real, allocatable:: v1_4d(:, :, :, :), v2_4d(:, :, :, :)

  double precision, allocatable:: v1_dble_1d(:), v2_dble_1d(:)
  double precision, allocatable:: v1_dble_2d(:, :), v2_dble_2d(:, :)
  double precision, allocatable:: v1_dble_3d(:, :, :), v2_dble_3d(:, :, :)
  double precision, allocatable:: v1_dble_4d(:, :, :, :), v2_dble_4d(:, :, :, :)

  character(len=nf90_max_name) name1
  logical same_varid ! compare variables with same varid
  logical report_id ! report identical variables
  logical comp_mag ! compute avergage order of magnitude
  logical quiet
  character(len=30+nf90_max_name), allocatable:: tag(:)
  integer i
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

  ! Define "nvar_comp", "varid1(:nvar_comp)", "varid2(:nvar_comp)" and
  ! "tag(:nvar_comp)":
  if (name1 == "") then
     ! We want to compare all the variables
     call nf95_inquire(ncid1, nvariables=nvariables)
     print *, "Found ", nvariables, " variable(s) in the first file."
     allocate(varid1(nvariables), varid2(nvariables), tag(nvariables))
     
     if (same_varid) then
        nvar_comp = nvariables
        varid1 = [(i, i = 1, nvariables)]
        varid2 = varid1

        do i = 1, nvariables
           call nf95_inquire_variable(ncid1, varid1(i), name1)
           tag(i) = 'Variable "' // trim(name1) // '" (name in the first file)'
        end do
     else
        nvar_comp = 0
        
        do i = 1, nvariables
           call nf95_inquire_variable(ncid1, i, name1)
           call nf95_inq_varid(ncid2, trim(name1), varid2(nvar_comp + 1), &
                ncerr)

           if (ncerr == nf90_noerr) then
              varid1(nvar_comp + 1) = i
              tag(nvar_comp + 1) = 'Variable "' // trim(name1) // '"'
              nvar_comp = nvar_comp + 1
           else
              print *, 'Could not find "' // trim(name1) &
                   // '" in the second file. Comparison will be skipped.'
           end if
        end do
     end if
  else
     nvar_comp = 1
     allocate(varid1(1), varid2(1), tag(1))
     call nf95_inq_varid(ncid1, trim(name1), varid1(1))
     call nf95_inq_varid(ncid2, trim(name1), varid2(1))
     tag(1) = 'Variable "' // trim(name1) // '"'
  end if

  do i = 1, nvar_comp
     call nf95_inquire_variable(ncid1, varid1(i), xtype=xtype1, ndims=ndims)
     if (ndims == 0 .or. ndims >= 5) then
        print *
        print *, "******************"
        print *, trim(tag(i)) // ":"
        print *, "Rank not supported."
        print *, "ndims = ", ndims
     else
        if (xtype1 == nf90_float) then
           select case (ndims)
           case (1)
              call nf95_gw_var(ncid1, varid1(i), v1_1d)
              call nf95_gw_var(ncid2, varid2(i), v2_1d)
              call compare(v1_1d, v2_1d, trim(tag(i)), comp_mag, report_id, &
                   quiet)
           case (2)
              call nf95_gw_var(ncid1, varid1(i), v1_2d)
              call nf95_gw_var(ncid2, varid2(i), v2_2d)
              call compare(v1_2d, v2_2d, trim(tag(i)), comp_mag, report_id, &
                   quiet)
           case (3)
              call nf95_gw_var(ncid1, varid1(i), v1_3d)
              call nf95_gw_var(ncid2, varid2(i), v2_3d)
              call compare(v1_3d, v2_3d, trim(tag(i)), comp_mag, report_id, &
                   quiet)
           case (4)
              call nf95_gw_var(ncid1, varid1(i), v1_4d)
              call nf95_gw_var(ncid2, varid2(i), v2_4d)
              call compare(v1_4d, v2_4d, trim(tag(i)), comp_mag, report_id, &
                   quiet)
           end select
        else if (xtype1 == nf90_double) then
           select case (ndims)
           case (1)
              call nf95_gw_var(ncid1, varid1(i), v1_dble_1d)
              call nf95_gw_var(ncid2, varid2(i), v2_dble_1d)
              call compare(v1_dble_1d, v2_dble_1d, trim(tag(i)), comp_mag, &
                   report_id, quiet)
           case (2)
              call nf95_gw_var(ncid1, varid1(i), v1_dble_2d)
              call nf95_gw_var(ncid2, varid2(i), v2_dble_2d)
              call compare(v1_dble_2d, v2_dble_2d, trim(tag(i)), comp_mag, &
                   report_id, quiet)
           case (3)
              call nf95_gw_var(ncid1, varid1(i), v1_dble_3d)
              call nf95_gw_var(ncid2, varid2(i), v2_dble_3d)
              call compare(v1_dble_3d, v2_dble_3d, trim(tag(i)), comp_mag, &
                   report_id, quiet)
           case (4)
              call nf95_gw_var(ncid1, varid1(i), v1_dble_4d)
              call nf95_gw_var(ncid2, varid2(i), v2_dble_4d)
              call compare(v1_dble_4d, v2_dble_4d, trim(tag(i)), comp_mag, &
                   report_id, quiet)
           end select
        else
           print *
           print *, "******************"
           print *, trim(tag(i)) // ":"
           print *, 'Not of type "nf90_float or "nf90_double".'
        end if
     end if
  end do

  call nf95_close(ncid1)
  call nf95_close(ncid2)

end program max_diff_nc
