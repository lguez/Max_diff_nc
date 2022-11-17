module compare_groups_m

  implicit none

contains

  recursive subroutine compare_groups(same_varid, report_id, quiet, comp_mag, &
       name1_in, ncid1, ncid2, group_name)

    ! Libraries:
    use jumble, only: compare
    use netcdf95, only: nf95_gw_var, nf95_inq_varid, nf95_inquire, &
         nf95_inquire_variable, nf95_get_missing, nf95_inq_grps, &
         nf95_inq_grpname_full, nf95_inq_grp_full_ncid, nf95_inq_grpname, &
         nf95_noerr, nf95_max_name, NF95_FLOAT, NF95_double

    logical, intent(in):: same_varid ! compare variables with same varid
    logical, intent(in):: report_id ! report identical variables
    logical, intent(in):: quiet
    logical, intent(in):: comp_mag ! compute avergage order of magnitude
    character(len = *), intent(in):: name1_in
    integer, intent(in):: ncid1, ncid2
    character(len = *), intent(in):: group_name

    ! Local:
    character(len = nf95_max_name) name1
    integer ncerr, xtype1, ndims
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
    double precision, allocatable:: v1_dble_4d(:, :, :, :), &
         v2_dble_4d(:, :, :, :)

    logical, allocatable:: valid1_1d(:), valid2_1d(:)
    logical, allocatable:: valid1_2d(:, :), valid2_2d(:, :)
    logical, allocatable:: valid1_3d(:, :, :), valid2_3d(:, :, :)
    logical, allocatable:: valid1_4d(:, :, :, :), valid2_4d(:, :, :, :)

    logical different_domains
    character(len = 30+nf95_max_name), allocatable:: tag(:)
    integer i
    real miss1, miss2
    double precision miss1_dble, miss2_dble
    integer, allocatable:: ncids(:)
    integer n_groups, grpid
    character(len = :), allocatable:: child_group_name, abs_child_group_name

    !--------------------------------------------------------------------

    ! Define "nvar_comp", "varid1(:nvar_comp)", "varid2(:nvar_comp)" and
    ! "tag(:nvar_comp)":
    if (name1_in == "") then
       ! We want to compare all the variables
       call nf95_inquire(ncid1, nvariables = nvariables)
       print *, "Found ", nvariables, " variable(s) in group ", group_name, &
            " in the first file."
       allocate(varid1(nvariables), varid2(nvariables), tag(nvariables))

       if (same_varid) then
          nvar_comp = nvariables
          varid1 = [(i, i = 1, nvariables)]
          varid2 = varid1

          do i = 1, nvariables
             call nf95_inquire_variable(ncid1, varid1(i), name1)
             tag(i) = 'Variable "' // trim(name1) &
                  // '" (name in the first file)'
          end do
       else
          nvar_comp = 0

          do i = 1, nvariables
             call nf95_inquire_variable(ncid1, i, name1)
             call nf95_inq_varid(ncid2, trim(name1), varid2(nvar_comp + 1), &
                  ncerr)

             if (ncerr == nf95_noerr) then
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
       call nf95_inq_varid(ncid1, trim(name1_in), varid1(1))
       call nf95_inq_varid(ncid2, trim(name1_in), varid2(1))
       tag(1) = 'Variable "' // trim(name1_in) // '"'
    end if

    loop_var: do i = 1, nvar_comp
       call nf95_inquire_variable(ncid1, varid1(i), xtype = xtype1, &
            ndims = ndims)

       test_dim: if (ndims == 0 .or. ndims >= 5) then
          print *
          print *, "******************"
          print *, trim(tag(i)) // ":"
          print *, "Rank not supported."
          print *, "ndims = ", ndims
       else test_dim
          test_type: if (xtype1 == nf95_float) then
             call nf95_get_missing(ncid1, varid1(i), miss1)
             call nf95_get_missing(ncid2, varid2(i), miss2)

             float_select_ndims: select case (ndims)
             case (1) float_select_ndims
                call nf95_gw_var(ncid1, varid1(i), v1_1d)
                call nf95_gw_var(ncid2, varid2(i), v2_1d)
                valid1_1d = v1_1d /= miss1
                valid2_1d = v2_1d /= miss2

                different_domains = any(valid1_1d .neqv. valid2_1d)
                if (different_domains) valid1_1d = valid1_1d .and. valid2_1d
                deallocate(valid2_1d)
                call compare(v1_1d, v2_1d, trim(tag(i)), comp_mag, report_id, &
                     quiet, valid1_1d, different_domains)
                deallocate(v1_1d, v2_1d, valid1_1d)
             case (2) float_select_ndims
                call nf95_gw_var(ncid1, varid1(i), v1_2d)
                call nf95_gw_var(ncid2, varid2(i), v2_2d)
                valid1_2d = v1_2d /= miss1
                valid2_2d = v2_2d /= miss2

                different_domains = any(valid1_2d .neqv. valid2_2d)
                if (different_domains) valid1_2d = valid1_2d .and. valid2_2d
                deallocate(valid2_2d)
                call compare(v1_2d, v2_2d, trim(tag(i)), comp_mag, report_id, &
                     quiet, valid1_2d, different_domains)
                deallocate(v1_2d, v2_2d, valid1_2d)
             case (3) float_select_ndims
                call nf95_gw_var(ncid1, varid1(i), v1_3d)
                call nf95_gw_var(ncid2, varid2(i), v2_3d)
                valid1_3d = v1_3d /= miss1
                valid2_3d = v2_3d /= miss2

                different_domains = any(valid1_3d .neqv. valid2_3d)
                if (different_domains) valid1_3d = valid1_3d .and. valid2_3d
                deallocate(valid2_3d)
                call compare(v1_3d, v2_3d, trim(tag(i)), comp_mag, report_id, &
                     quiet, valid1_3d, different_domains)
                deallocate(v1_3d, v2_3d, valid1_3d)
             case (4) float_select_ndims
                call nf95_gw_var(ncid1, varid1(i), v1_4d)
                call nf95_gw_var(ncid2, varid2(i), v2_4d)
                valid1_4d = v1_4d /= miss1
                valid2_4d = v2_4d /= miss2

                different_domains = any(valid1_4d .neqv. valid2_4d)
                if (different_domains) valid1_4d = valid1_4d .and. valid2_4d
                deallocate(valid2_4d)
                call compare(v1_4d, v2_4d, trim(tag(i)), comp_mag, report_id, &
                     quiet, valid1_4d, different_domains)
                deallocate(v1_4d, v2_4d, valid1_4d)
             end select float_select_ndims
          else if (xtype1 == nf95_double) then test_type
             call nf95_get_missing(ncid1, varid1(i), miss1_dble)
             call nf95_get_missing(ncid2, varid2(i), miss2_dble)

             double_select_ndims: select case (ndims)
             case (1) double_select_ndims
                call nf95_gw_var(ncid1, varid1(i), v1_dble_1d)
                call nf95_gw_var(ncid2, varid2(i), v2_dble_1d)
                valid1_1d = v1_dble_1d /= miss1_dble
                valid2_1d = v2_dble_1d /= miss2_dble

                different_domains = any(valid1_1d .neqv. valid2_1d)
                if (different_domains) valid1_1d = valid1_1d .and. valid2_1d
                deallocate(valid2_1d)
                call compare(v1_dble_1d, v2_dble_1d, trim(tag(i)), comp_mag, &
                     report_id, quiet, valid1_1d, different_domains)
                deallocate(v1_dble_1d, v2_dble_1d, valid1_1d)
             case (2) double_select_ndims
                call nf95_gw_var(ncid1, varid1(i), v1_dble_2d)
                call nf95_gw_var(ncid2, varid2(i), v2_dble_2d)
                valid1_2d = v1_dble_2d /= miss1_dble
                valid2_2d = v2_dble_2d /= miss2_dble

                different_domains = any(valid1_2d .neqv. valid2_2d)
                if (different_domains) valid1_2d = valid1_2d .and. valid2_2d
                deallocate(valid2_2d)
                call compare(v1_dble_2d, v2_dble_2d, trim(tag(i)), comp_mag, &
                     report_id, quiet, valid1_2d, different_domains)
                deallocate(v1_dble_2d, v2_dble_2d, valid1_2d)
             case (3) double_select_ndims
                call nf95_gw_var(ncid1, varid1(i), v1_dble_3d)
                call nf95_gw_var(ncid2, varid2(i), v2_dble_3d)
                valid1_3d = v1_dble_3d /= miss1_dble
                valid2_3d = v2_dble_3d /= miss2_dble

                different_domains = any(valid1_3d .neqv. valid2_3d)
                if (different_domains) valid1_3d = valid1_3d .and. valid2_3d
                deallocate(valid2_3d)
                call compare(v1_dble_3d, v2_dble_3d, trim(tag(i)), comp_mag, &
                     report_id, quiet, valid1_3d, different_domains)
                deallocate(v1_dble_3d, v2_dble_3d, valid1_3d)
             case (4) double_select_ndims
                call nf95_gw_var(ncid1, varid1(i), v1_dble_4d)
                call nf95_gw_var(ncid2, varid2(i), v2_dble_4d)
                valid1_4d = v1_dble_4d /= miss1_dble
                valid2_4d = v2_dble_4d /= miss2_dble

                different_domains = any(valid1_4d .neqv. valid2_4d)
                if (different_domains) valid1_4d = valid1_4d .and. valid2_4d
                deallocate(valid2_4d)
                call compare(v1_dble_4d, v2_dble_4d, trim(tag(i)), comp_mag, &
                     report_id, quiet, valid1_4d, different_domains)
                deallocate(v1_dble_4d, v2_dble_4d, valid1_4d)
             end select double_select_ndims
          else test_type
             print *
             print *, "******************"
             print *, trim(tag(i)) // ":"
             print *, 'Not of type "nf95_float or "nf95_double".'
          end if test_type
       end if test_dim
    end do loop_var

    call nf95_inq_grps(ncid1, ncids)
    n_groups = size(ncids)

    if (n_groups /= 0) then
       print '(/, "*************", /)'
       print *, "Found ", n_groups, " group(s) immediately under ", &
            group_name, " in the first file."

       do i = 1, n_groups
          call nf95_inq_grpname(ncids(i), child_group_name)
          call nf95_inq_grp_full_ncid(ncid2, child_group_name, grpid, ncerr)

          if (ncerr == nf95_noerr) then
             if (group_name == "/") then
                abs_child_group_name = "/" // child_group_name
             else
                abs_child_group_name = group_name // "/" // child_group_name
             end if

             call compare_groups(same_varid, report_id, quiet, comp_mag, &
                  name1_in, ncids(i), grpid, abs_child_group_name)
          else
             print *, 'Could not find ', child_group_name, ' under ', &
                  group_name, ' in the second file. Comparison will be skipped.'
          end if
       end do
    end if

  end subroutine compare_groups

end module compare_groups_m
