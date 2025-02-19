! $Id$
!
! Earth System Modeling Framework
! Copyright (c) 2002-2025, University Corporation for Atmospheric Research,
! Massachusetts Institute of Technology, Geophysical Fluid Dynamics
! Laboratory, University of Michigan, National Centers for Environmental
! Prediction, Los Alamos National Laboratory, Argonne National Laboratory,
! NASA Goddard Space Flight Center.
! Licensed under the University of Illinois-NCSA License.
!
!==============================================================================
!
      program ESMF_XGridUTest

!------------------------------------------------------------------------------

#include "ESMF.h"

!==============================================================================
!BOPI
! !PROGRAM: ESMF_XGridUTest - Unit tests for Field Create and Get methods
!
! !DESCRIPTION:
!
! The code in this file drives F90 Field Create and Get unit tests.
! The companion folder Fieldsrc contains the definitions for the
! Field methods.
!EOPI
!-----------------------------------------------------------------------------
! !USES:
    use ESMF_TestMod     ! test methods
    use ESMF
    implicit none

!------------------------------------------------------------------------------
! The following line turns the CVS identifier string into a printable variable.
    character(*), parameter :: version = &
      '$Id$'

    type(ESMF_XGrid)                    :: xgrid

    ! cumulative result: count failures; no failures equals "all pass"
    integer :: result = 0

    ! individual test result code
    integer :: rc = 1

    ! individual test failure message
    character(ESMF_MAXSTR) :: failMsg
    character(512) :: name

    logical :: isCreated

    call ESMF_TestStart(ESMF_SRCLINE, rc=rc)
    if (rc /= ESMF_SUCCESS) call ESMF_Finalize(endflag=ESMF_END_ABORT)
 
    !------------------------------------------------------------------------

#if 1
  !------------------------------------------------------------------------
  !NEX_UTest
  ! Don't know if I should keep this turned on as an actual unit test, but it's useful for debugging
  write(name, *) "Testing XGrid side and elem info."
  write(failMsg, *) "Did not return ESMF_SUCCESS"
  call test_side_and_elem_info(rc)  
  call ESMF_Test((rc .eq. ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE)
  !------------------------------------------------------------------------

  !------------------------------------------------------------------------
  !NEX_UTest
  write(name, *) "Testing XGrid IsCreated for uncreated object"
  write(failMsg, *) "Did not return .false."
  isCreated = ESMF_XGridIsCreated(xgrid)
  call ESMF_Test((isCreated .eqv. .false.), name, failMsg, result, ESMF_SRCLINE)
  !------------------------------------------------------------------------

  !------------------------------------------------------------------------
  !NEX_UTest
  write(name, *) "Testing XGrid IsCreated for uncreated object"
  write(failMsg, *) "Did not return ESMF_SUCCESS"
  isCreated = ESMF_XGridIsCreated(xgrid, rc=rc)
  call ESMF_Test((rc.eq.ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE)
  !------------------------------------------------------------------------

  !------------------------------------------------------------------------
  !NEX_UTest
  write(name, *) "Create test XGrid for IsCreated"
  write(failMsg, *) "Did not return ESMF_SUCCESS"
  xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid(4,8,1.,1.,0.,0.,rc=rc)/), &
                           sideBGrid=(/make_grid(4,8,0.7,0.7,0.,0.,rc=rc)/), &
                           rc=rc)
  call ESMF_Test((rc.eq.ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE)
  !------------------------------------------------------------------------

  !------------------------------------------------------------------------
  !NEX_UTest
  write(name, *) "Testing XGrid IsCreated for created object"
  write(failMsg, *) "Did not return .true."
  isCreated = ESMF_XGridIsCreated(xgrid)
  call ESMF_Test((isCreated .eqv. .true.), name, failMsg, result, ESMF_SRCLINE)
  !------------------------------------------------------------------------

  !------------------------------------------------------------------------
  !NEX_UTest
  write(name, *) "Testing XGrid IsCreated for created object"
  write(failMsg, *) "Did not return ESMF_SUCCESS"
  isCreated = ESMF_XGridIsCreated(xgrid, rc=rc)
  call ESMF_Test((rc.eq.ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE)
  !------------------------------------------------------------------------

  !------------------------------------------------------------------------
  !NEX_UTest
  write(name, *) "Destroy test XGrid for IsCreated"
  write(failMsg, *) "Did not return ESMF_SUCCESS"
  call ESMF_XGridDestroy(xgrid, rc=rc)
  call ESMF_Test((rc.eq.ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE)
  !------------------------------------------------------------------------

  !------------------------------------------------------------------------
  !NEX_UTest
  write(name, *) "Testing XGrid IsCreated for destroyed object"
  write(failMsg, *) "Did not return .false."
  isCreated = ESMF_XGridIsCreated(xgrid)
  call ESMF_Test((isCreated .eqv. .false.), name, failMsg, result, ESMF_SRCLINE)
  !------------------------------------------------------------------------

  !------------------------------------------------------------------------
  !NEX_UTest
  write(name, *) "Testing XGrid IsCreated for destroyed object"
  write(failMsg, *) "Did not return ESMF_SUCCESS"
  isCreated = ESMF_XGridIsCreated(xgrid, rc=rc)
  call ESMF_Test((rc.eq.ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE)
  !------------------------------------------------------------------------

    !------------------------------------------------------------------------
    !NEX_UTest
    ! Create an empty XGrid with area/centroid, sparseMatA2X
    print *, 'Starting test3'
    call test3(rc)
    write(failMsg, *) ""
    write(name, *) "Creating an XGrid with area/centroid, sparseMatA2X"
    call ESMF_Test((rc.eq.ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE)
 
    !------------------------------------------------------------------------
    !NEX_UTest
    ! Create an XGrid in 2D
    print *, 'Starting test4'
    call test4(rc)
    write(failMsg, *) ""
    write(name, *) "Creating an XGrid from 2 adjacent Grids"
    call ESMF_Test((rc.eq.ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE)

    !------------------------------------------------------------------------
    !NEX_UTest
    ! Create an XGrid in 2D
    print *, 'Starting test5'
    call test5(rc)
    write(failMsg, *) ""
    write(name, *) "Creating an XGrid in 2D with Grid merging"
    call ESMF_Test((rc.eq.ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE)

    !------------------------------------------------------------------------
    !NEX_UTest
    ! Create an XGrid in 2D from Meshes
    print *, 'Starting test6'
    call test6(rc)
    write(failMsg, *) ""
    write(name, *) "Creating an XGrid in 2D with Mesh merging"
    call ESMF_Test((rc.eq.ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE)

    !------------------------------------------------------------------------
    !NEX_UTest
    ! Create an XGrid in 2D from Meshes
    call test_xgrid_w_ngon_mesh(rc)
    write(failMsg, *) ""
    write(name, *) "Creating an XGrid in 2D from Meshes contain elements with >4 sides"
    call ESMF_Test((rc.eq.ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE)
    
    !------------------------------------------------------------------------
    !NEX_UTest
    ! Create an XGrid in 2D from Meshes with user supplied area
    print *, 'Starting test7'
    call test7(rc)
    write(failMsg, *) ""
    write(name, *) "Creating an XGrid in 2D with user supplied area"
    call ESMF_Test((rc.eq.ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE)

    !------------------------------------------------------------------------
    !NEX_UTest
    ! Create an XGrid in 2D from Meshes with user supplied area
    print *, 'Starting test8'
    call test8(rc)
    write(failMsg, *) ""
    write(name, *) "Creating an XGrid with Mesh easy element create interface"
    call ESMF_Test((rc.eq.ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE)



    !------------------------------------------------------------------------
    !NEX_UTest
    ! Create an XGrid in 2D from Meshes
    call test_MeshToMesh_2nd(rc)
    write(failMsg, *) ""
    write(name, *) "Test 2nd order on an XGrid between Meshes"
    call ESMF_Test((rc.eq.ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE)

    !------------------------------------------------------------------------
    !NEX_UTest
    ! Create an XGrid in 2D from Cartesian Meshes
    call test_CartMeshToMesh_2nd(rc)
    write(failMsg, *) ""
    write(name, *) "Test 2nd order on an XGrid between Cartesian Meshes"
    call ESMF_Test((rc.eq.ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE)

    !------------------------------------------------------------------------
    !NEX_UTest
    ! Create an XGrid in 2D from Meshes
    call test_CSGridToGrid_2nd(rc)
    write(failMsg, *) ""
    write(name, *) "Test 2nd order on an XGrid with a cubed sphere Grid"
    call ESMF_Test((rc.eq.ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE)
#endif

 call ESMF_TestEnd(ESMF_SRCLINE)
  
contains 
#define ESMF_METHOD "ESMF_TESTS"

!------------------------------------------------------------------------
    subroutine test3(rc)
        integer, intent(out)                :: rc
        integer                             :: localrc, i
        type(ESMF_XGrid)                    :: xgrid
        type(ESMF_Grid)                     :: sideA(2), sideB(1)
        type(ESMF_DistGrid)                 :: sideAdg(2), sideBdg(1), distgrid
        real(ESMF_KIND_R8)                  :: centroid(12,2), area(12)
        type(ESMF_XGridSpec)                :: sparseMatA2X(2), sparseMatX2B(1)

        type(ESMF_Grid)                     :: l_sideA(2), l_sideB(1)
        type(ESMF_DistGrid)                 :: l_sideAdg(2), l_sideBdg(1)
        real(ESMF_KIND_R8)                  :: l_centroid(12,2), l_area(12)
        type(ESMF_XGridSpec)                :: l_sparseMatA2X(2), l_sparseMatX2B(1)
        type(ESMF_Field)                    :: field, srcField(2), dstField(1)

        type(ESMF_Field)                    :: areaField
        real(ESMF_KIND_R8), pointer         :: areaFptr(:)

        type(ESMF_VM)                       :: vm
        integer                             :: lpet, eleCount,ndim
        integer                             :: sideAGC, sideBGC, sideAMC, sideBMC
        integer                             :: elb, eub, ec

        real(ESMF_KIND_R8), pointer         :: fptr(:,:), xfptr(:)
        real(ESMF_KIND_R8)                  :: xgrid_area(12), B_area(2,2)
        integer                             :: xlb(1), xub(1)
        type(ESMF_RouteHandle)              :: rh_src2xgrid(2), rh_xgrid2dst(1)

        type(ESMF_XGrid)                    :: xgridAlias
        logical                             :: xgridBool
        
        type(ESMF_CoordSys_Flag)            :: coordSys

        rc = ESMF_SUCCESS
        localrc = ESMF_SUCCESS

        call ESMF_VMGetCurrent(vm=vm, rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return

        call ESMF_VMGet(vm, localPet=lpet, rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return

        sideAdg(1) = ESMF_DistGridCreate(minIndex=(/1,1/), maxIndex=(/2,2/), rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return

        sideAdg(2) = ESMF_DistGridCreate(minIndex=(/1,1/), maxIndex=(/1,2/), rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return

        sideBdg = ESMF_DistGridCreate(minIndex=(/1,1/), maxIndex=(/2,2/), rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return

        do i = 1, 2
            sideA(i) = ESMF_GridCreate(distgrid=sideAdg(i), rc=localrc)
            if (ESMF_LogFoundError(localrc, &
                ESMF_ERR_PASSTHRU, &
                ESMF_CONTEXT, rcToReturn=rc)) return
        enddo
        do i = 1, 1
            sideB(i) = ESMF_GridCreate(distgrid=sideBdg(i), rc=localrc)
            if (ESMF_LogFoundError(localrc, &
                ESMF_ERR_PASSTHRU, &
                ESMF_CONTEXT, rcToReturn=rc)) return
        enddo

        allocate(sparseMatA2X(1)%factorIndexList(2,9), sparseMatA2X(1)%factorList(9))
        allocate(sparseMatA2X(2)%factorIndexList(2,3), sparseMatA2X(2)%factorList(3))
        allocate(sparseMatX2B(1)%factorIndexList(2,12), sparseMatX2B(1)%factorList(12))
    
        ! factorIndexList
        ! setting up mapping between A1 -> X
        sparseMatA2X(1)%factorIndexList(1,1)=1
        sparseMatA2X(1)%factorIndexList(1,2)=2
        sparseMatA2X(1)%factorIndexList(1,3)=2
        sparseMatA2X(1)%factorIndexList(1,4)=3
        sparseMatA2X(1)%factorIndexList(1,5)=4
        sparseMatA2X(1)%factorIndexList(1,6)=4
        sparseMatA2X(1)%factorIndexList(1,7)=3
        sparseMatA2X(1)%factorIndexList(1,8)=4
        sparseMatA2X(1)%factorIndexList(1,9)=4
        sparseMatA2X(1)%factorIndexList(2,1)=1
        sparseMatA2X(1)%factorIndexList(2,2)=2
        sparseMatA2X(1)%factorIndexList(2,3)=3
        sparseMatA2X(1)%factorIndexList(2,4)=4
        sparseMatA2X(1)%factorIndexList(2,5)=5
        sparseMatA2X(1)%factorIndexList(2,6)=6
        sparseMatA2X(1)%factorIndexList(2,7)=7
        sparseMatA2X(1)%factorIndexList(2,8)=8
        sparseMatA2X(1)%factorIndexList(2,9)=9
        ! setting up mapping between A2 -> X
        sparseMatA2X(2)%factorIndexList(1,1)=1
        sparseMatA2X(2)%factorIndexList(1,2)=2
        sparseMatA2X(2)%factorIndexList(1,3)=2
        sparseMatA2X(2)%factorIndexList(2,1)=10
        sparseMatA2X(2)%factorIndexList(2,2)=11
        sparseMatA2X(2)%factorIndexList(2,3)=12

        ! Note that the weights are dest area weighted
        ! factorList
        ! setting up mapping between A1 -> X
        sparseMatA2X(1)%factorList(1)=1
        sparseMatA2X(1)%factorList(2)=1
        sparseMatA2X(1)%factorList(3)=1
        sparseMatA2X(1)%factorList(4)=1
        sparseMatA2X(1)%factorList(5)=1
        sparseMatA2X(1)%factorList(6)=1
        sparseMatA2X(1)%factorList(7)=1
        sparseMatA2X(1)%factorList(8)=1
        sparseMatA2X(1)%factorList(9)=1
        ! setting up mapping between A2 -> X
        sparseMatA2X(2)%factorList(1)=1
        sparseMatA2X(2)%factorList(2)=1
        sparseMatA2X(2)%factorList(3)=1
    
        ! factorIndexList
        ! setting up mapping between X -> B
        sparseMatX2B(1)%factorIndexList(1,1)=1
        sparseMatX2B(1)%factorIndexList(1,2)=2
        sparseMatX2B(1)%factorIndexList(1,3)=3
        sparseMatX2B(1)%factorIndexList(1,4)=4
        sparseMatX2B(1)%factorIndexList(1,5)=5
        sparseMatX2B(1)%factorIndexList(1,6)=6
        sparseMatX2B(1)%factorIndexList(1,7)=7
        sparseMatX2B(1)%factorIndexList(1,8)=8
        sparseMatX2B(1)%factorIndexList(1,9)=9
        sparseMatX2B(1)%factorIndexList(1,10)=10
        sparseMatX2B(1)%factorIndexList(1,11)=11
        sparseMatX2B(1)%factorIndexList(1,12)=12
        sparseMatX2B(1)%factorIndexList(2,1)=1
        sparseMatX2B(1)%factorIndexList(2,2)=1
        sparseMatX2B(1)%factorIndexList(2,3)=2
        sparseMatX2B(1)%factorIndexList(2,4)=1
        sparseMatX2B(1)%factorIndexList(2,5)=1
        sparseMatX2B(1)%factorIndexList(2,6)=2
        sparseMatX2B(1)%factorIndexList(2,7)=3
        sparseMatX2B(1)%factorIndexList(2,8)=3
        sparseMatX2B(1)%factorIndexList(2,9)=4
        sparseMatX2B(1)%factorIndexList(2,10)=3
        sparseMatX2B(1)%factorIndexList(2,11)=3
        sparseMatX2B(1)%factorIndexList(2,12)=4

        ! factorList
        ! setting up mapping between X -> B
        sparseMatX2B(1)%factorList(1)=4./9
        sparseMatX2B(1)%factorList(2)=2./9
        sparseMatX2B(1)%factorList(3)=2./3
        sparseMatX2B(1)%factorList(4)=2./9
        sparseMatX2B(1)%factorList(5)=1./9
        sparseMatX2B(1)%factorList(6)=1./3
        sparseMatX2B(1)%factorList(7)=2./9
        sparseMatX2B(1)%factorList(8)=1./9
        sparseMatX2B(1)%factorList(9)=1./3
        sparseMatX2B(1)%factorList(10)=4./9
        sparseMatX2B(1)%factorList(11)=2./9
        sparseMatX2B(1)%factorList(12)=2./3

        ! set up destination areas to adjust weighted flux
        xgrid_area(1) = 1.
        xgrid_area(2) = 0.5
        xgrid_area(3) = 0.5
        xgrid_area(4) = 0.5
        xgrid_area(5) = 0.25
        xgrid_area(6) = 0.25
        xgrid_area(7) = 0.5
        xgrid_area(8) = 0.25
        xgrid_area(9) = 0.25
        xgrid_area(10) = 1.
        xgrid_area(11) = 0.5
        xgrid_area(12) = 0.5

        B_area(1,1) = 9./4
        B_area(2,1) = 3./4
        B_area(1,2) = 9./4
        B_area(2,2) = 3./4

        ! Finally ready to do an flux exchange from A side to B side
        xgrid = ESMF_XGridCreateFromSparseMat(sideAGrid=sideA, sideBGrid=sideB, &
            area=xgrid_area, centroid=centroid, &
            sparseMatA2X=sparseMatA2X, sparseMatX2B=sparseMatX2B, rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return

        !------------------------------------------------------------------------
        !NEX_UTest
        write(name, *) "XGrid equality before assignment Test"
        write(failMsg, *) "Did not return ESMF_SUCCESS"
        xgridBool = (xgridAlias.eq.xgrid)
        call ESMF_Test(.not.xgridBool, name, failMsg, result, ESMF_SRCLINE)

        !------------------------------------------------------------------------
        !NEX_UTest
        ! Testing ESMF_XGridAssignment(=)()
        write(name, *) "XGrid assignment and equality Test"
        write(failMsg, *) "Did not return ESMF_SUCCESS"
        xgridAlias = xgrid
        xgridBool = (xgridAlias.eq.xgrid)
        call ESMF_Test(xgridBool, name, failMsg, result, ESMF_SRCLINE)


        call ESMF_XGridGet(xgrid, &
            sideAGridCount=sideAGC, sideBGridCount=sideBGC, &
            sideAMeshCount=sideAMC, sideBMeshCount=sideBMC, &
            sideAGrid=l_sideA, sideBGrid=l_sideB, area=l_area, &
            coordSys=coordSys, &
            elementCount=eleCount, &
            centroid=l_centroid, distgridA=l_sideAdg, &
            distgridM = distgrid, sparseMatA2X=l_sparseMatA2X, &
            sparseMatX2B=l_sparseMatX2B, &
            rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return

        call ESMF_XGridGet(xgrid, localDe=0, elementCount=eleCount, &
            exclusiveCount=ec, exclusiveLBound=elb, exclusiveUBound=eub, &
            rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return

        !print *, lpet, eleCount, ec, elb, eub

        !call ESMF_DistGridPrint(distgrid, rc=localrc)
        !if (ESMF_LogFoundError(localrc, &
        !    ESMF_ERR_PASSTHRU, &
        !    ESMF_CONTEXT, rcToReturn=rc)) return

        !do i = 1, 2
        !    call ESMF_DistGridPrint(l_sideAdg(i), rc=localrc)
        !    if (ESMF_LogFoundError(localrc, &
        !        ESMF_ERR_PASSTHRU, &
        !        ESMF_CONTEXT, rcToReturn=rc)) return
        !enddo

        call ESMF_XGridGet(xgrid, xgridSide=ESMF_XGRIDSIDE_A, gridIndex=1, &
            distgrid=distgrid, rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
        call ESMF_XGridGet(xgrid, xgridSide=ESMF_XGRIDSIDE_A, gridIndex=2, &
            distgrid=distgrid, rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
        call ESMF_XGridGet(xgrid, xgridSide=ESMF_XGRIDSIDE_B, gridIndex=1, &
            distgrid=distgrid, rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return

        field = ESMF_FieldCreate(xgrid, typekind=ESMF_TYPEKIND_R8, rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
        call ESMF_XGridGetFieldBounds(xgrid, totalLBound=xlb, totalUBound=xub, rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
        call ESMF_FieldGet(field, farrayPtr=xfptr, &
            exclusiveLBound=xlb, exclusiveUBound=xub, rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return

        xfptr = 0.0

        !call ESMF_FieldPrint(field, rc=localrc)
        !if (ESMF_LogFoundError(localrc, &
        !    ESMF_ERR_PASSTHRU, &
        !    ESMF_CONTEXT, rcToReturn=rc)) return

        call ESMF_FieldDestroy(field, rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return


        !! Test ESMF_FieldRegridGetArea()

        ! Create Field
        areaField = ESMF_FieldCreate(xgrid, typekind=ESMF_TYPEKIND_R8, rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return

        ! Get area
        call ESMF_FieldRegridGetArea(areaField, rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return

        ! Get area Field
        call ESMF_FieldGet(areaField, farrayPtr=areaFptr, rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return

        ! If the areas don't match, then complain
        do i=lbound(areaFptr,1),ubound(areaFptr,1)
           if (areaFptr(i) /= xgrid_area(i)) then
              call ESMF_LogSetError(rcToCheck=ESMF_RC_ARG_WRONG, & 
                   msg="creation area and retrieved area don't match.", &
                   ESMF_CONTEXT, rcToReturn=rc) 
              return
           endif
        enddo

        ! Get rid of area Field
        call ESMF_FieldDestroy(areaField, rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return


        !------------------------------------------------------------------------
        !NEX_UTest
        write(name, *) "XGridDestroy Test"
        write(failMsg, *) "Did not return ESMF_SUCCESS"
        call ESMF_XGridDestroy(xgrid, rc=rc)
        call ESMF_Test((rc.eq.ESMF_SUCCESS), name, failMsg, result, ESMF_SRCLINE)

        !------------------------------------------------------------------------
        !NEX_UTest
        ! Testing ESMF_XGridOperator(==)()
        write(name, *) "XGrid equality after destroy Test"
        write(failMsg, *) "Did not return ESMF_SUCCESS"
        xgridBool = (xgridAlias==xgrid)
        call ESMF_Test(.not.xgridBool, name, failMsg, result, ESMF_SRCLINE)

        !------------------------------------------------------------------------
        !NEX_UTest
        ! Testing ESMF_XGridOperator(/=)()
        write(name, *) "XGrid non-equality after destroy Test"
        write(failMsg, *) "Did not return ESMF_SUCCESS"
        xgridBool = (xgridAlias/=xgrid)
        call ESMF_Test(xgridBool, name, failMsg, result, ESMF_SRCLINE)

        !------------------------------------------------------------------------
        !NEX_UTest
        ! Testing coordSys
        write(name, *) "XGrid coordSys test"
        write(failMsg, *) "Did not return ESMF_SUCCESS"
        call ESMF_Test((coordSys .eq. ESMF_COORDSYS_SPH_DEG), name, failMsg, result, ESMF_SRCLINE)

        do i = 1, 2
            call ESMF_GridDestroy(sideA(i), rc = localrc)
            if (ESMF_LogFoundError(localrc, &
                ESMF_ERR_PASSTHRU, &
                ESMF_CONTEXT, rcToReturn=rc)) return
        enddo

        do i = 1, 1
            call ESMF_GridDestroy(sideB(i), rc = localrc)
            if (ESMF_LogFoundError(localrc, &
                ESMF_ERR_PASSTHRU, &
                ESMF_CONTEXT, rcToReturn=rc)) return
        enddo

        deallocate(sparseMatA2X(1)%factorIndexList, sparseMatA2X(1)%factorList)
        deallocate(sparseMatA2X(2)%factorIndexList, sparseMatA2X(2)%factorList)
        deallocate(sparseMatX2B(1)%factorIndexList, sparseMatX2B(1)%factorList)

    end subroutine test3

!------------------------------------------------------------------------
  subroutine test4(rc)
    integer, intent(out)                :: rc
    integer                             :: localrc, i, npet, lpet
    type(ESMF_XGrid)                    :: xgrid
    type(ESMF_Grid)                     :: sideA(2), sideB(1)

    type(ESMF_VM)                       :: vm
    real(ESMF_KIND_R8)                  :: xgrid_area(12), B_area(2,2)
    type(ESMF_RouteHandle)              :: rh_src2xgrid(2), rh_xgrid2dst(1)

    type(ESMF_Mesh)                     :: mesh
    type(ESMF_Field)                    :: srcField(3), dstField(3)
    type(ESMF_RouteHandle)              :: rh

    rc = ESMF_SUCCESS
    localrc = ESMF_SUCCESS

    call ESMF_VMGetCurrent(vm=vm, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    call ESMF_VMGet(vm, localpet=lpet, petcount=npet, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Global identical Grids in index space
    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid(4,8,1.,1.,0.,0.,rc=localrc)/), &
      sideBGrid=(/make_grid(4,8,0.7,0.7,0.,0.,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_XGridDestroy(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Global identical Grids
    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid(4,8,1.,1.,0.,0.,rc=localrc)/), &
      sideBGrid=(/make_grid(4,8,1.0,1.0,0.,0.,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_XGridDestroy(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Sew mesh
    ! right, left
    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid(4,2,1.,1.,0.,0.,rc=localrc), &
        make_grid(4,2,0.5,1.,4.,0.,rc=localrc)/), &
      sideBGrid=(/make_grid(8,8,0.7,0.7,0.,0.,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_XGridDestroy(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Bigger Grids
    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid(4,4,1.,1.,0.,0.,rc=localrc), &
        make_grid(4,4,0.5,1.,4.,0.,rc=localrc)/), &
      sideBGrid=(/make_grid(8,8,1.,1.,0.,0.,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_XGridDestroy(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! right, left
    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid(4,4,0.5,1.,4.,0.,rc=localrc), &
        make_grid(4,4,1.,1.,0.,0.,rc=localrc)/), &
      sideBGrid=(/make_grid(8,8,1.,1.,0.,0.,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_XGridDestroy(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
  
    ! down, up
    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid(4,4,0.5,1.,0.,-4.,rc=localrc), &
        make_grid(4,4,1.,1.,0.,0.,rc=localrc)/), &
      sideBGrid=(/make_grid(8,8,1.,1.,0.,-4.,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_XGridDestroy(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! up, down
    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid(4,4,0.5,1.,0.,0.,rc=localrc), &
        make_grid(4,4,1.,1.,0.,-4.,rc=localrc)/), &
      sideBGrid=(/make_grid(8,8,1.,1.,0.,-4.,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_XGridDestroy(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! partially overlap
    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid(4,4,1.,1.,0.,0.,field=srcField(1),rc=localrc), &
                               make_grid(4,4,0.5,1.,3.5,3.5,field=srcField(2),rc=localrc)/), &
      sideBGrid=(/make_grid(32,32,0.25,0.25,0.,0.,field=dstField(1),rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call flux_exchange(xgrid, srcField(1:2), dstField(1:1), rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid(4,4,1.,1.,0.,0.,field=srcField(1),rc=localrc), &
                               make_grid(4,4,0.5,1.,3.5,3.5,field=srcField(2),rc=localrc)/), &
      sideBGrid=(/make_grid(16,16,0.5,0.5,0.,0.,field=dstField(1),rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call flux_exchange(xgrid, srcField(1:2), dstField(1:1), rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid(4,4,1.,1.,0.,0.,field=srcField(1),rc=localrc), &
                               make_grid(4,4,0.5,1.,3.5,3.5,field=srcField(2),rc=localrc)/), &
      sideBGrid=(/make_grid(8,8,1.,1.,0.,0.,field=dstField(1),rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call flux_exchange(xgrid, srcField(1:2), dstField(1:1), rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! partially overlap
    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid(4,4,1.,1.,0.,0.,field=srcField(1),rc=localrc), &
                               make_grid(4,4,0.5,1.,3.3,3.4,field=srcField(2),rc=localrc)/), &
      sideBGrid=(/make_grid(8,8,1.,1.,0.,0.,field=dstField(1),rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call flux_exchange(xgrid, srcField(1:2), dstField(1:1), rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! partially overlap
    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid(4,4,1.,1.,0.,0.,   field=srcField(1),rc=localrc), &
                               make_grid(4,4,0.5,1.,3.3,2.4,field=srcField(2),rc=localrc)/), &
      sideBGrid=(/make_grid(30,30,0.3,0.3,0.,0.,field=dstField(1),rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call flux_exchange(xgrid, srcField(1:2), dstField(1:1), rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! partially overlap
    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid(4,4,1.,1.,0.,0.,   field=srcField(1),rc=localrc), &
                               make_grid(4,4,0.5,1.,3.3,2.4,field=srcField(2),rc=localrc)/), &
      sideBGrid=(/make_grid(8,8,1.,1.,0.,0.,field=dstField(1),rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call flux_exchange(xgrid, srcField(1:2), dstField(1:1), rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! partially overlap subject smaller cell
    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid(4,4,1.,1.,0.,0.,rc=localrc), &
        make_grid(4,4,0.5,1.,2.8,1.4,rc=localrc)/), &
      sideBGrid=(/make_grid(30,30,0.3,0.3,0.,0.,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_XGridDestroy(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    !! partially overlap subject bigger cell
    ! although identical to previous test, the next 2 tests seem to trigger a strange condition on bluefire in 32g mode
    !xgrid = ESMF_XGridCreate((/ &
    !    make_grid(4,4,0.5,1.,2.8,1.4,rc=localrc), &
    !    make_grid(4,4,1.,1.,0.,0.,rc=localrc) &
    !  /), &
    !  (/ &
    !    make_grid(30,30,0.3,0.3,0.,0.,rc=localrc) &
    !  /), &
    !  rc=localrc)
    !if (ESMF_LogFoundError(localrc, &
    !  ESMF_ERR_PASSTHRU, &
    !  ESMF_CONTEXT, rcToReturn=rc)) return

    !xgrid = ESMF_XGridCreate( &
    !  (/ &
    !    make_grid(30,30,0.3,0.3,0.,0.,rc=localrc) &
    !  /), &
    !  (/ &
    !    make_grid(4,4,0.5,1.,2.8,1.4,rc=localrc), &
    !    make_grid(4,4,1.,1.,0.,0.,rc=localrc) &
    !  /), &
    !  rc=localrc)
    !if (ESMF_LogFoundError(localrc, &
    !  ESMF_ERR_PASSTHRU, &
    !  ESMF_CONTEXT, rcToReturn=rc)) return

    if(npet == 1) then
    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid(2,2,1.,1.,0.,0.,field=srcField(1),rc=localrc), &
                               make_grid(2,2,0.5,1.,1.5,1.5,field=srcField(2),rc=localrc)/), &
      sideBGrid=(/make_grid(3,3,1.,1.,0.,0.,field=dstField(1),rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call flux_exchange(xgrid, srcField(1:2), dstField(1:1), rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! complicated merging, these triggers a condition in rend mesh that currently does not support two distant Grids
    ! for multi-pet
    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid(4,2,1.,1.,0.,0.,rc=localrc), &
        make_grid(4,2,0.5,1.,4.,0.,rc=localrc), &
        make_grid(4,2,1.,1.,6.,0.,rc=localrc)/), &
      sideBGrid=(/make_grid(8,8,0.7,0.7,0.,0.,rc=localrc), &
        make_grid(8,8,0.7,0.7,0.,5.6,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_XGridDestroy(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid(4,2,1.,1.,0.,0.,rc=localrc), &
        make_grid(4,2,0.5,1.,3.,0.3,rc=localrc), &
                               make_grid(4,4,1.,1.,-2.,-2.,rc=localrc)/), &
      sideBGrid=(/make_grid(8,8,0.7,0.7,0.,0.,rc=localrc), &
        make_grid(8,8,0.7,0.7,0.,5.6,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_XGridDestroy(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    xgrid = ESMF_XGridCreate(&
      sideAGrid=(/make_grid(8,8,0.7,0.7,0.,0.,rc=localrc), &
        make_grid(8,8,0.7,0.7,0.,5.6,rc=localrc)/), &
      sideBGrid=(/make_grid(4,2,1.,1.,0.,0.,rc=localrc), &
        make_grid(4,2,0.5,1.,3.,0.3,rc=localrc), &
                               make_grid(4,4,1.,1.,-2.,-2.,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_XGridDestroy(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid(4,2,1.,1.,0.,0.,rc=localrc), &
        make_grid(4,2,0.5,1.,3.,0.3,rc=localrc), &
                               make_grid(4,4,1.,1.,-2.,-2.,rc=localrc)/), &
      sideBGrid=(/make_grid(8,8,0.7,0.7,0.,0.,rc=localrc), &
        make_grid(8,8,0.5,0.7,0.9,3.6,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_XGridDestroy(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    endif

  end subroutine test4

  subroutine test5(rc)
    integer, intent(out)                :: rc
    integer                             :: localrc, i, npet
    type(ESMF_XGrid)                    :: xgrid
    type(ESMF_Grid)                     :: sideA(2), sideB(1)

    type(ESMF_VM)                       :: vm
    real(ESMF_KIND_R8)                  :: xgrid_area(12), B_area(2,2)
    type(ESMF_RouteHandle)              :: rh_src2xgrid(2), rh_xgrid2dst(1)

    type(ESMF_Mesh)                     :: mesh
    type(ESMF_Field)                    :: field1, field2
    type(ESMF_RouteHandle)              :: rh

    rc = ESMF_SUCCESS
    localrc = ESMF_SUCCESS

    call ESMF_VMGetCurrent(vm=vm, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    call ESMF_VMGet(vm, petcount=npet, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Sew mesh
    ! right, left
    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid_sph(4,2,1.,1.,0.,0.,rc=localrc), &
        make_grid_sph(4,2,0.5,1.,4.,0.,rc=localrc)/), &
      sideBGrid=(/make_grid_sph(8,8,0.7,0.7,0.,0.,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_XGridDestroy(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! up, down
    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid_sph(4,4,0.5,1.,0.,0.,rc=localrc), &
        make_grid_sph(4,4,1.,1.,0.,-4.,rc=localrc)/), &
      sideBGrid=(/make_grid_sph(8,8,1.,1.,0.,-4.,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_XGridDestroy(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! partially overlap
    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid_sph(4,4,1.,1.,0.,0.,rc=localrc), &
        make_grid_sph(4,4,0.6,1.,3.5,3.5,rc=localrc)/), &
      sideBGrid=(/make_grid_sph(8,8,1.,1.,0.,0.,rc=localrc)/), &
      storeOverlay = .true., &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    call flux_exchange_sph(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid_sph(4,4,1.,1.,0.,0.,rc=localrc), &
        make_grid_sph(4,4,0.6,1.,2.9,3.5,rc=localrc)/), &
      sideBGrid=(/make_grid_sph(8,8,1.,1.,0.,0.,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    call flux_exchange_sph(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid_sph(4,4,1.,1.,0.,0.,rc=localrc), &
        make_grid_sph(4,4,0.6,1.,2.9,2.5,rc=localrc)/), &
      sideBGrid=(/make_grid_sph(8,8,1.,1.,0.,0.,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    call flux_exchange_sph(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid_sph(4,4,1.,1.,0.,0.,rc=localrc), &
        make_grid_sph(8,4,0.6,1.,1.9,1.5,rc=localrc)/), &
      sideBGrid=(/make_grid_sph(8,8,1.,1.,0.,0.,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_XGridDestroy(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! partially overlap subject bigger cell
    xgrid = ESMF_XGridCreate(sideAGrid=(/ &
        make_grid_sph(4,4,0.5,1.,2.8,1.4,rc=localrc), &
        make_grid_sph(4,4,1.,1.,0.,0.,rc=localrc) &
      /), &
      sideBGrid=(/make_grid_sph(30,30,0.3,0.3,0.,0.,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    call flux_exchange_sph(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    xgrid = ESMF_XGridCreate(sideAGrid= &
      (/make_grid_sph(30,30,0.3,0.3,0.,0.,rc=localrc)/), &
      sideBGrid=(/ &
        make_grid_sph(4,4,0.5,1.,2.8,1.4,rc=localrc), &
        make_grid_sph(4,4,1.,1.,0.,0.,rc=localrc) &
      /), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call flux_exchange_sph(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    if(npet == 1) then
    ! complicated merging
    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid_sph(4,2,1.,1.,0.,0.,rc=localrc), &
        make_grid_sph(4,2,0.5,1.,4.,0.,rc=localrc), &
                               make_grid_sph(4,2,1.,1.,6.,0.,rc=localrc)/), &
      sideBGrid=(/make_grid_sph(8,8,0.7,0.7,0.,0.,rc=localrc), &
        make_grid_sph(8,8,0.7,0.7,0.,5.6,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_XGridDestroy(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid_sph(4,2,1.,1.,0.,0.,rc=localrc), &
        make_grid_sph(4,2,0.5,1.,3.,0.3,rc=localrc), &
                               make_grid_sph(4,4,1.,1.,-2.,-2.,rc=localrc)/), &
      sideBGrid=(/make_grid_sph(8,8,0.7,0.7,0.,0.,rc=localrc), &
        make_grid_sph(8,8,0.7,0.7,0.,5.6,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_XGridDestroy(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    xgrid = ESMF_XGridCreate(sideAGrid=&
      (/make_grid_sph(8,8,0.7,0.7,0.,0.,rc=localrc), &
        make_grid_sph(8,8,0.7,0.7,0.,5.6,rc=localrc)/), &
      sideBGrid=(/make_grid_sph(4,2,1.,1.,0.,0.,rc=localrc), &
        make_grid_sph(4,2,0.5,1.,3.,0.3,rc=localrc), &
                               make_grid_sph(4,4,1.,1.,-2.,-2.,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_XGridDestroy(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid_sph(4,2,1.,1.,0.,0.,rc=localrc), &
        make_grid_sph(4,2,0.5,1.,3.,0.3,rc=localrc), &
                               make_grid_sph(4,4,1.,1.,-2.,-2.,rc=localrc)/), &
      sideBGrid=(/make_grid_sph(8,8,0.7,0.7,0.,0.,rc=localrc), &
        make_grid_sph(8,8,0.5,0.7,0.9,3.6,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_XGridDestroy(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    endif

  end subroutine test5

  subroutine test6(rc)
    integer, intent(out)                :: rc
    integer                             :: localrc, i, npet
    type(ESMF_XGrid)                    :: xgrid
    !type(ESMF_Field)                    :: field

    type(ESMF_VM)                       :: vm
    real(ESMF_KIND_R8)                  :: xgrid_area(12), B_area(2,2)

    rc = ESMF_SUCCESS
    localrc = ESMF_SUCCESS

    call ESMF_VMGetCurrent(vm=vm, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    call ESMF_VMGet(vm, petcount=npet, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Sew mesh
    ! right, left
    xgrid = ESMF_XGridCreate(sideAMesh=(/make_mesh_sph(4,2,1.,1.,0.,0.,rc=localrc), &
        make_mesh_sph(4,2,0.5,1.,4.,0.,rc=localrc)/), &
      sideBMesh=(/make_mesh_sph(8,8,0.7,0.7,0.,0.,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_XGridDestroy(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! up, down
    xgrid = ESMF_XGridCreate(sideAMesh=(/make_mesh_sph(4,4,0.5,1.,0.,0.,rc=localrc), &
        make_mesh_sph(4,4,1.,1.,0.,-4.,rc=localrc)/), &
      sideBMesh=(/make_mesh_sph(8,8,1.,1.,0.,-4.,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_XGridDestroy(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! mix mesh and grid together
    xgrid = ESMF_XGridCreate(sideAMesh=(/make_mesh_sph(4,4,1.,1.,0.,0.,rc=localrc), &
        make_mesh_sph(4,4,0.6,1.,3.5,3.5,rc=localrc)/), &
      sideAGrid=(/make_grid_sph(4,4,1.,1.,-3.,0.,rc=localrc), &
                  make_grid_sph(4,4,1.,1.,-6.,0.,rc=localrc), &
                  make_grid_sph(4,4,1.,1.,-9.,0.,rc=localrc) /), &

      sideBGrid=(/make_grid_sph(8,8,1.,1.,-7.,0.,rc=localrc)/), &
      sideBMesh=(/make_mesh_sph(8,8,1.,1.,0.,0.,rc=localrc)/), &
      storeOverlay = .true., &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_XGridDestroy(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    xgrid = ESMF_XGridCreate(sideAMesh=(/make_mesh_sph(4,4,1.,1.,0.,0.,rc=localrc), &
        make_mesh_sph(4,4,0.6,1.,3.5,3.5,rc=localrc)/), &
      sideAGrid=(/make_grid_sph(16,4,1.,1.,-3.,0.,rc=localrc), &
                  make_grid_sph(16,4,1.,1.,-6.,0.,rc=localrc), &
                  make_grid_sph(16,4,1.,1.,-9.,0.,rc=localrc) /), &

      sideBGrid=(/make_grid_sph(8,8,1.,1.,-7.,0.,rc=localrc)/), &
      sideBMesh=(/make_mesh_sph(8,8,1.,1.,0.,0.,rc=localrc)/), &
      sideAGridPriority=(/5,1,3/), &
      sideAMeshPriority=(/4,2/), &
      storeOverlay = .true., &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_XGridDestroy(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! partially overlap
    xgrid = ESMF_XGridCreate(sideAMesh=(/make_mesh_sph(4,4,1.,1.,0.,0.,rc=localrc), &
        make_mesh_sph(4,4,0.6,1.,3.5,3.5,rc=localrc)/), &
      sideBMesh=(/make_mesh_sph(8,8,1.,1.,0.,0.,rc=localrc)/), &
      storeOverlay = .true., &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    !field=ESMF_FieldCreate(xgrid%xgtypep%sideA(1)%gbcp%mesh, meshloc=ESMF_MESHLOC_ELEMENT, &
    !  typekind=ESMF_TYPEKIND_R8, rc=localrc)
    !if (ESMF_LogFoundError(localrc, &
    !  ESMF_ERR_PASSTHRU, &
    !  ESMF_CONTEXT, rcToReturn=rc)) return

    call flux_exchange_sph_mesh(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    xgrid = ESMF_XGridCreate(sideAMesh=(/make_mesh_sph(4,4,1.,1.,0.,0.,rc=localrc), &
        make_mesh_sph(4,4,0.6,1.,2.9,3.5,rc=localrc)/), &
      sideBMesh=(/make_mesh_sph(8,8,1.,1.,0.,0.,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    call flux_exchange_sph_mesh(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    xgrid = ESMF_XGridCreate(sideAMesh=(/make_mesh_sph(4,4,1.,1.,0.,0.,rc=localrc), &
        make_mesh_sph(4,4,0.6,1.,2.9,2.5,rc=localrc)/), &
      sideBMesh=(/make_mesh_sph(8,8,1.,1.,0.,0.,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    call flux_exchange_sph_mesh(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    xgrid = ESMF_XGridCreate(sideAMesh=(/make_mesh_sph(4,4,1.,1.,0.,0.,rc=localrc), &
        make_mesh_sph(8,4,0.6,1.,1.9,1.5,rc=localrc)/), &
      sideBMesh=(/make_mesh_sph(8,8,1.,1.,0.,0.,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! partially overlap subject bigger cell
    xgrid = ESMF_XGridCreate(sideAMesh=(/ &
        make_mesh_sph(4,4,0.5,1.,2.8,1.4,rc=localrc), &
        make_mesh_sph(4,4,1.,1.,0.,0.,rc=localrc) &
      /), &
      sideBMesh=(/make_mesh_sph(30,30,0.3,0.3,0.,0.,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    call flux_exchange_sph_mesh(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    xgrid = ESMF_XGridCreate(sideAMesh= &
      (/make_mesh_sph(30,30,0.3,0.3,0.,0.,rc=localrc)/), &
      sideBMesh=(/ &
        make_mesh_sph(4,4,0.5,1.,2.8,1.4,rc=localrc), &
        make_mesh_sph(4,4,1.,1.,0.,0.,rc=localrc) &
      /), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call flux_exchange_sph_mesh(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    if(npet == 1) then
    ! complicated merging
    xgrid = ESMF_XGridCreate(sideAMesh=(/make_mesh_sph(4,2,1.,1.,0.,0.,rc=localrc), &
        make_mesh_sph(4,2,0.5,1.,4.,0.,rc=localrc), &
                               make_mesh_sph(4,2,1.,1.,6.,0.,rc=localrc)/), &
      sideBMesh=(/make_mesh_sph(8,8,0.7,0.7,0.,0.,rc=localrc), &
        make_mesh_sph(8,8,0.7,0.7,0.,5.6,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    xgrid = ESMF_XGridCreate(sideAMesh=(/make_mesh_sph(4,2,1.,1.,0.,0.,rc=localrc), &
        make_mesh_sph(4,2,0.5,1.,3.,0.3,rc=localrc), &
                               make_mesh_sph(4,4,1.,1.,-2.,-2.,rc=localrc)/), &
      sideBMesh=(/make_mesh_sph(8,8,0.7,0.7,0.,0.,rc=localrc), &
        make_mesh_sph(8,8,0.7,0.7,0.,5.6,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    xgrid = ESMF_XGridCreate(sideAMesh=&
      (/make_mesh_sph(8,8,0.7,0.7,0.,0.,rc=localrc), &
        make_mesh_sph(8,8,0.7,0.7,0.,5.6,rc=localrc)/), &
      sideBMesh=(/make_mesh_sph(4,2,1.,1.,0.,0.,rc=localrc), &
        make_mesh_sph(4,2,0.5,1.,3.,0.3,rc=localrc), &
                               make_mesh_sph(4,4,1.,1.,-2.,-2.,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    xgrid = ESMF_XGridCreate(sideAMesh=(/make_mesh_sph(4,2,1.,1.,0.,0.,rc=localrc), &
        make_mesh_sph(4,2,0.5,1.,3.,0.3,rc=localrc), &
                               make_mesh_sph(4,4,1.,1.,-2.,-2.,rc=localrc)/), &
      sideBMesh=(/make_mesh_sph(8,8,0.7,0.7,0.,0.,rc=localrc), &
        make_mesh_sph(8,8,0.5,0.7,0.9,3.6,rc=localrc)/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    endif

  end subroutine test6

  subroutine test7(rc)
    integer, intent(out)                :: rc
    integer                             :: localrc, i, npet
    type(ESMF_XGrid)                    :: xgrid

    type(ESMF_VM)                       :: vm
    real(ESMF_KIND_R8)                  :: xgrid_area(12), B_area(2,2)

    rc = ESMF_SUCCESS
    localrc = ESMF_SUCCESS

    call ESMF_VMGetCurrent(vm=vm, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    call ESMF_VMGet(vm, petcount=npet, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! partially overlap
    xgrid = ESMF_XGridCreate(sideAGrid=(/make_grid_sph(4,4,1.,1.,0.,0.,area_adj=0.95, rc=localrc), &
                               make_grid_sph(4,4,0.6,1.,3.5,3.5,area_adj=0.95, rc=localrc)/), &
      sideBGrid=(/make_grid_sph(8,8,1.,1.,0.,0.,area_adj=0.95, rc=localrc)/), &
      storeOverlay = .true., &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    call flux_exchange_sph(xgrid, area_adj=0.95, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

  end subroutine test7


  ! Create a spherical mesh containing >4 sided elements
  ! on 1 or 2 PETS
  
  !
  !  2.5        8        10 --------11
  !          /     \   /            |
  !  2.1   7         9              12
  !        |         |      5       /
  !        |    4    |            /
  !        |         |          /
  !  1.0   4 ------- 5 ------- 6
  !        |         |  \   3  |
  !        |    1    |    \    |
  !        |         |  2   \  |
  ! -0.1   1 ------- 2 ------- 3
  !
  !      -0.1       1.0       2.1   2.5
  !
  !        Node Id labels at corners
  !       Element Id labels in centers
  subroutine createTestMeshPH(mesh, rc)
  type(ESMF_Mesh), intent(out) :: mesh
  integer :: rc

  integer, pointer :: nodeIds(:),nodeOwners(:)
  real(ESMF_KIND_R8), pointer :: nodeCoords(:)
  real(ESMF_KIND_R8), pointer :: ownedNodeCoords(:)
   integer :: numNodes, numOwnedNodes, numOwnedNodesTst
  integer :: numElems,numOwnedElemsTst
  integer, pointer :: elemIds(:),elemTypes(:),elemConn(:)
  real(ESMF_KIND_R8), pointer :: elemCoords(:)
  integer :: petCount, localPet
  type(ESMF_VM) :: vm
  integer :: numQuadElems,numTriElems
  integer :: numPentElems,numHexElems,numTotElems
  integer :: numElemConn

  ! get global VM
  call ESMF_VMGetGlobal(vm, rc=rc)
  if (rc /= ESMF_SUCCESS) return
  call ESMF_VMGet(vm, localPet=localPet, petCount=petCount, rc=rc)
  if (rc /= ESMF_SUCCESS) return

  ! return with an error if not 1 or 2 PETs
  if ((petCount /= 1) .and. (petCount /=2)) then
     rc=ESMF_FAILURE
     return
  endif

  if (petCount .eq. 1) then
      ! Set number of nodes
     numNodes=12

     ! Allocate and fill the node id array.
     allocate(nodeIds(numNodes))
     nodeIds=(/1,2,3,4,5,6,7,8,9,10,11,12/)

     ! Allocate and fill node coordinate array.
     ! Since this is a 2D Mesh the size is 2x the
     ! number of nodes.
     allocate(nodeCoords(2*numNodes))
     nodeCoords=(/0.0,0.0, & ! node id 1
                   1.0,0.0, & ! node id 2
                   2.1,0.0, & ! node id 3
                  0.0, 1.0, & ! node id 4
                   1.0, 1.0, & ! node id 5
                   2.1, 1.0, & ! node id 6
                  0.0, 2.1, & ! node id 7
                   0.5, 2.5, & ! node id 8
                   1.0, 2.1, & ! node id 9
                   1.5, 2.5, & ! node id 10
                   2.5, 2.5, & ! node id 11
                   2.5, 2.1/)  ! node id 12

      ! Allocate and fill the node owner array.
      ! Since this Mesh is all on PET 0, it's just set to all 0.
     allocate(nodeOwners(numNodes))
     nodeOwners=0 ! everything on PET 0

     ! Set the number of each type of element, plus tot and num conn.
     numQuadElems=1
     numTriElems=2
     numPentElems=1
     numHexElems=1
     numTotElems=numTriElems+numQuadElems+numPentElems+numHexElems
     numElemConn=3*numTriElems+4*numQuadElems+ &
                 5*numPentElems+6*numHexElems

     ! Allocate and fill the element id array.
     allocate(elemIds(numTotElems))
     elemIds=(/1,2,3,4,5/)


     ! Allocate and fill the element topology type array.
     allocate(elemTypes(numTotElems))
     elemTypes=(/ESMF_MESHELEMTYPE_QUAD, & ! elem id 1
                 ESMF_MESHELEMTYPE_TRI,  & ! elem id 2
                 ESMF_MESHELEMTYPE_TRI,  & ! elem id 3
                  5, &                      ! elem id 4
                 6/)                       ! elem id 5


     ! Allocate and fill elem coordinate array.
     ! Since this is a 2D Mesh the size is 2x the
     ! number of nodes.
     allocate(elemCoords(2*numTotElems))
     elemCoords=(/ 0.45, 0.45, & ! elem id 1
                   1.37, 0.27, & ! elem id 2
                   1.73, 0.63, & ! elem id 3
                   0.46, 1.74, & ! elem id 4
                   1.76, 1.87/)  ! elem id 5



     ! Allocate and fill the element connection type array.
     ! Note that entries in this array refer to the
      ! positions in the nodeIds, etc. arrays and that
      ! the order and number of entries for each element
     ! reflects that given in the Mesh options
     ! section for the corresponding entry
     ! in the elemTypes array.
     allocate(elemConn(numElemConn))
     elemConn=(/1,2,5,4, &       ! elem id 1
                2,3,5,   &       ! elem id 2
                3,6,5,   &       ! elem id 3
                4,5,9,8,7, &     ! elem id 4
                5,6,12,11,10,9/) ! elem id 5

     
 else if (petCount .eq. 2) then
     ! Setup mesh data depending on PET
    if (localPET .eq. 0) then !!! This part only for PET 0
       ! Set number of nodes
       numNodes=6

       ! Allocate and fill the node id array.
       allocate(nodeIds(numNodes))
       nodeIds=(/1,2,3,4,5,6/)

       ! Allocate and fill node coordinate array.
       ! Since this is a 2D Mesh the size is 2x the
       ! number of nodes.
       allocate(nodeCoords(2*numNodes))
       nodeCoords=(/0.0, 0.0, & ! node id 1
                     1.0, 0.0, & ! node id 2
                     2.1, 0.0, & ! node id 3
                    0.0,  1.0, & ! node id 4
                     1.0,  1.0,  & ! node id 5
                     2.1,  1.0/)  ! node id 6
            
       ! Allocate and fill the node owner array.
       allocate(nodeOwners(numNodes))
       nodeOwners=(/0, & ! node id 1
                    0, & ! node id 2
                    0, & ! node id 3
                    0, & ! node id 4
                    0, & ! node id 5
                    0/)  ! node id 6

       ! Set the number of each type of element, plus tot and num conn.
       numQuadElems=1
       numTriElems=2
       numPentElems=0
       numHexElems=0
       numTotElems=numTriElems+numQuadElems+numPentElems+numHexElems
       numElemConn=3*numTriElems+4*numQuadElems+ &
            5*numPentElems+6*numHexElems

       ! Allocate and fill the element id array.
        allocate(elemIds(numTotElems))
        elemIds=(/1,2,3/)

       ! Allocate and fill the element topology type array.
       allocate(elemTypes(numTotElems))
       elemTypes=(/ESMF_MESHELEMTYPE_QUAD, & ! elem id 1
                   ESMF_MESHELEMTYPE_TRI,  & ! elem id 2
                   ESMF_MESHELEMTYPE_TRI/)   ! elem id 3

     ! Allocate and fill elem coordinate array.
     ! Since this is a 2D Mesh the size is 2x the
     ! number of nodes.
     allocate(elemCoords(2*numTotElems))
     elemCoords=(/0.45, 0.45, & ! elem id 1
                  1.37, 0.27, & ! elem id 2
                  1.73, 0.63/)  ! elem id 3

       ! Allocate and fill the element connection type array.
       ! Note that entry are local indices
       allocate(elemConn(numElemConn))
       elemConn=(/1,2,5,4, & ! elem id 1
                  2,3,5,   & ! elem id 2
                  3,6,5/)    ! elem id 3 
                  
     else if (localPET .eq. 1) then !!! This part only for PET 1
       ! Set number of nodes
       numNodes=9

       ! Allocate and fill the node id array.
       allocate(nodeIds(numNodes))
       nodeIds=(/4,5,6,7,8,9,10,11,12/)

       ! Allocate and fill node coordinate array.
       ! Since this is a 2D Mesh the size is 2x the
       ! number of nodes.
       allocate(nodeCoords(2*numNodes))
       nodeCoords=(/0.0, 1.0, & ! node id 4
                     1.0, 1.0, & ! node id 5
                     2.1, 1.0, & ! node id 6
                    0.0, 2.1, & ! node id 7
                     0.5, 2.5, & ! node id 8
                     1.0, 2.1, & ! node id 9
                     1.5, 2.5, & ! node id 10
                     2.5, 2.5, & ! node id 11
                     2.5, 2.1/)  ! node id 12

       
       ! Allocate and fill the node owner array.
       allocate(nodeOwners(numNodes))
       nodeOwners=(/0, & ! node id 4
                    0, & ! node id 5
                    0, & ! node id 6
                    1, & ! node id 7
                    1, & ! node id 8
                    1, & ! node id 9
                    1, & ! node id 10
                    1, & ! node id 11                    
                    1/)  ! node id 12

       ! Set the number of each type of element, plus tot and num conn.
       numQuadElems=0
       numTriElems=0
       numPentElems=1
       numHexElems=1
       numTotElems=numTriElems+numQuadElems+numPentElems+numHexElems
       numElemConn=3*numTriElems+4*numQuadElems+ &
            5*numPentElems+6*numHexElems

       ! Allocate and fill the element id array.
       allocate(elemIds(numTotElems))
       elemIds=(/4,5/)

        ! Allocate and fill the element topology type array.
       allocate(elemTypes(numTotElems))
       elemTypes=(/5, & ! elem id 4
                   6/)  ! elem id 5

       ! Allocate and fill elem coordinate array.
       ! Since this is a 2D Mesh the size is 2x the
       ! number of nodes.
       allocate(elemCoords(2*numTotElems))
       elemCoords=(/0.46, 1.74, & ! elem id 4
                    1.76, 1.87/)  ! elem id 5

       ! Allocate and fill the element connection type array.
       allocate(elemConn(numElemConn))
       elemConn=(/1,2,6,5,4, & ! elem id 4
                  2,3,9,8,7,6/)  ! elem id 5

      endif
    endif

   ! Create Mesh structure in 1 step
   mesh=ESMF_MeshCreate(parametricDim=2,spatialDim=2, &
        coordSys=ESMF_COORDSYS_SPH_DEG, &
        nodeIds=nodeIds, nodeCoords=nodeCoords, &
        nodeOwners=nodeOwners, elementIds=elemIds,&
        elementTypes=elemTypes, elementConn=elemConn, &
        elementCoords=elemCoords, &
        rc=rc)
   if (rc /= ESMF_SUCCESS) return

   ! deallocate node data
   deallocate(nodeIds)
   deallocate(nodeCoords)
   deallocate(nodeOwners)

   ! deallocate elem data
   deallocate(elemIds)
   deallocate(elemTypes)
   deallocate(elemConn)

end subroutine createTestMeshPH


! Test XGrid when created from a mesh containing
! an elem with >4 sides
  subroutine test_xgrid_w_ngon_mesh(rc)
    integer, intent(out) :: rc
    integer              :: localrc, i, npet
    type(ESMF_XGrid)     :: xgrid
    type(ESMF_Mesh)      :: mesh_ngon, mesh_qt 
    type(ESMF_VM)        :: vm
    real(ESMF_KIND_R8)   :: xgrid_area(12), B_area(2,2)

    rc = ESMF_SUCCESS
    localrc = ESMF_SUCCESS

    call ESMF_VMGetCurrent(vm=vm, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    call ESMF_VMGet(vm, petcount=npet, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Create ngon mesh
    call createTestMeshPH(mesh_ngon, localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Create mesh containing quads and triangles
    call CreateTestMesh2x2_1(mesh_qt, localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Create XGrid from meshes
    xgrid = ESMF_XGridCreate(sideAMesh=(/mesh_ngon/), &
                             sideBMesh=(/mesh_qt/), &
                             storeOverlay = .true., &
                             rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Test flux exchange through xgrid
    call flux_exchange_sph_mesh(xgrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Get rid of meshes
    call ESMF_MeshDestroy(mesh_ngon, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    call ESMF_MeshDestroy(mesh_qt, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
  end subroutine test_xgrid_w_ngon_mesh


  
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  ! 
  ! Creates the following mesh on 
  ! 1 or 2 PETs. Returns an error 
  ! if run on other than 1 or 2 PETs
  ! 
  !                     Mesh Ids
  !
  !   3.0   * ------------ * -------------  *
  !         |              |              / |
  !   2.5   |              |   10       /   |
  !         |      7       |         /      |
  !   2.0   |              |      /     9   |
  !         |              |  /             |
  !   1.5   * ------------ * -------------  *
  !         |              |                |
  !   1.0   |              |                |
  !         |      1       |       3        |
  !   0.5   |              |                |
  !         |              |                |
  !   0.0   * ------------ * -------------- *
  !            
  !        0.0  0.5  1.0  1.5   2.0  2.5   3.0
  !
  !               Node Ids at corners
  !              Element Ids in centers
  ! 
   !!!!! 
  ! 
  ! The owners for 1 PET are all Pet 0.
  ! The owners for 2 PETs are as follows:
  !
  !                   Mesh Owners
  !
  !   3.0   * ------------ * -------------  *
  !         |              |              / |
  !   2.5   |              |   1       /    |
  !         |      1       |         /      |
  !   2.0   |              |      /     1   |
  !         |              |  /             |
  !   1.5   * ------------ * -------------  *
  !         |              |                |
  !   1.0   |              |                |
  !         |      0       |       0        |
  !   0.5   |              |                |
  !         |              |                |
  !   0.0   * ------------ * -------------- *
  !            
  !        0.0  0.5  1.0  1.5   2.0  2.5   3.0
  !
  !              Element Owners in centers
  ! 

subroutine CreateTestMesh2x2EE_1(mesh, rc)
  type(ESMF_Mesh), intent(out) :: mesh
  integer :: rc
  integer :: numElems,numOwnedElemsTst
  integer :: numElemCorners, numTriElems, numQuadElems
  real(ESMF_KIND_R8), pointer :: elemCoords(:,:)
  real(ESMF_KIND_R8), pointer :: elemCornerCoords(:,:)
  integer, pointer :: elemIds(:),elemTypes(:)
  integer :: petCount, localPet
  type(ESMF_VM) :: vm

  ! get global VM
  call ESMF_VMGetGlobal(vm, rc=rc)
  if (rc /= ESMF_SUCCESS) return
  call ESMF_VMGet(vm, localPet=localPet, petCount=petCount, rc=rc)
  if (rc /= ESMF_SUCCESS) return

  ! return with an error if not 1 or 2 PETs
  if ((petCount /= 1) .and. (petCount /=2)) then
     rc=ESMF_FAILURE
     return
  endif

  ! Setup mesh info depending on the 
  ! number of PETs
  if (petCount .eq. 1) then

      ! Fill in elem data
      numTriElems=2
      numQuadElems=3
      numElems=numTriElems+numQuadElems
      numElemCorners=3*numTriElems+4*numQuadElems

      !! elem ids
      allocate(elemIds(numElems))
      elemIds=(/1,3,7,9,10/) 

      !! elem types
      allocate(elemTypes(numElems))
      elemTypes=(/ESMF_MESHELEMTYPE_QUAD, & ! 1
                  ESMF_MESHELEMTYPE_QUAD, & ! 3
                  ESMF_MESHELEMTYPE_QUAD, & ! 7
                  ESMF_MESHELEMTYPE_TRI,  & ! 9
                  ESMF_MESHELEMTYPE_TRI/)   ! 10

      !! elem coords
      allocate(elemCoords(2,numElems))
      elemCoords(:,1)=(/0.75,0.75/)   ! 1
      elemCoords(:,2)=(/2.25,0.75/)   ! 3
      elemCoords(:,3)=(/0.75,2.25/)   ! 7
      elemCoords(:,4)=(/2.50,2.00/) ! 9
      elemCoords(:,5)=(/2.00,2.50/) ! 10
     
     !! elem corner Coords
     allocate(elemCornerCoords(2,numElemCorners))
     elemCornerCoords(:,1)=(/0.0,0.0/) ! 1
     elemCornerCoords(:,2)=(/1.5,0.0/) ! 1
     elemCornerCoords(:,3)=(/1.5,1.5/)  ! 1
     elemCornerCoords(:,4)=(/0.0,1.5/)  ! 1
     elemCornerCoords(:,5)=(/1.5,0.0/)  ! 3
     elemCornerCoords(:,6)=(/3.0,0.0/)  ! 3
     elemCornerCoords(:,7)=(/3.0,1.5/)  ! 3
     elemCornerCoords(:,8)=(/1.5,1.5/)  ! 3
     elemCornerCoords(:,9)=(/0.0,1.5/)  ! 7
     elemCornerCoords(:,10)=(/1.5,1.5/)  ! 7
     elemCornerCoords(:,11)=(/1.5,3.0/)  ! 7
     elemCornerCoords(:,12)=(/0.0,3.0/)  ! 7
     elemCornerCoords(:,13)=(/1.5,1.5/)  ! 9
     elemCornerCoords(:,14)=(/3.0,1.5/)  ! 9
     elemCornerCoords(:,15)=(/3.0,3.0/)  ! 9
     elemCornerCoords(:,16)=(/1.5,1.5/)  ! 10
     elemCornerCoords(:,17)=(/3.0,3.0/)  ! 10
     elemCornerCoords(:,18)=(/1.5,3.0 /)  ! 10
 
   else if (petCount .eq. 2) then
     ! Setup mesh data depending on PET
     if (localPet .eq. 0) then

      ! Fill in elem data
      numTriElems=0
      numQuadElems=2
      numElems=numTriElems+numQuadElems
      numElemCorners=3*numTriElems+4*numQuadElems

      !! elem ids
      allocate(elemIds(numElems))
      elemIds=(/1,3/) 

      !! elem types
      allocate(elemTypes(numElems))
      elemTypes=(/ESMF_MESHELEMTYPE_QUAD, &! 1
                  ESMF_MESHELEMTYPE_QUAD/) ! 3
 
      !! elem coords
      allocate(elemCoords(2,numElems))
      elemCoords(:,1)=(/0.75,0.75/) ! 1
      elemCoords(:,2)=(/2.25,0.75/) ! 3

     
     !! elem corner Coords
     allocate(elemCornerCoords(2,numElemCorners))
     elemCornerCoords(:,1)=(/0.0,0.0/)  ! 1
     elemCornerCoords(:,2)=(/1.5,0.0/)  ! 1
     elemCornerCoords(:,3)=(/1.5,1.5/)  ! 1
     elemCornerCoords(:,4)=(/0.0,1.5/)  ! 1
     elemCornerCoords(:,5)=(/1.5,0.0/)  ! 3
     elemCornerCoords(:,6)=(/3.0,0.0/)  ! 3
     elemCornerCoords(:,7)=(/3.0,1.5/)  ! 3
     elemCornerCoords(:,8)=(/1.5,1.5/)  ! 3

     else if (localPet .eq. 1) then

      ! Fill in elem data
      numTriElems=2
      numQuadElems=1
      numElems=numTriElems+numQuadElems
      numElemCorners=3*numTriElems+4*numQuadElems

      !! elem ids
      allocate(elemIds(numElems))
      elemIds=(/7,9,10/) 

      !! elem types
      allocate(elemTypes(numElems))
      elemTypes=(/ESMF_MESHELEMTYPE_QUAD, & ! 7
                  ESMF_MESHELEMTYPE_TRI,  & ! 9
                  ESMF_MESHELEMTYPE_TRI/)   ! 10

      !! elem coords
      allocate(elemCoords(2,numElems))
      elemCoords(:,1)=(/0.75,2.25/) ! 7
      elemCoords(:,2)=(/2.50,2.00/) ! 9
      elemCoords(:,3)=(/2.00,2.50/) ! 10

     !! elem corner Coords
     allocate(elemCornerCoords(2,numElemCorners))
     elemCornerCoords(:,1)=(/0.0,1.5/)  ! 7
     elemCornerCoords(:,2)=(/1.5,1.5/)  ! 7
     elemCornerCoords(:,3)=(/1.5,3.0/)  ! 7
     elemCornerCoords(:,4)=(/0.0,3.0/)  ! 7
     elemCornerCoords(:,5)=(/1.5,1.5/)  ! 9
     elemCornerCoords(:,6)=(/3.0,1.5/)  ! 9
     elemCornerCoords(:,7)=(/3.0,3.0/)  ! 9
     elemCornerCoords(:,8)=(/1.5,1.5/)  ! 10
     elemCornerCoords(:,9)=(/3.0,3.0/)  ! 10
     elemCornerCoords(:,10)=(/1.5,3.0 /) ! 10
   endif
  endif

   ! Create Mesh structure in 1 step
   mesh=ESMF_MeshCreate(parametricDim=2, &
        coordSys=ESMF_COORDSYS_SPH_DEG, &
        elementIds=elemIds,&
        elementTypes=elemTypes,&
        elementCoords=elemCoords,&
        elementCornerCoords=elemCornerCoords, &
        rc=rc)
   if (rc /= ESMF_SUCCESS) return
   
   ! deallocate elem data
   deallocate(elemIds)
   deallocate(elemTypes)
   deallocate(elemCoords)
   deallocate(elemCornerCoords)

   ! Output Mesh for debugging
   !call ESMF_MeshWrite(mesh,"meshee1",rc=rc)
   !if (rc /= ESMF_SUCCESS) return

   ! Return success
   rc=ESMF_SUCCESS

end subroutine CreateTestMesh2x2EE_1


  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  ! 
  ! Creates the following mesh on 
  ! 1 or 2 PETs. Returns an error 
  ! if run on other than 1 or 2 PETs
  ! 
  !                     Mesh Ids
  !
  !   3.0   7 ------------ 8 -------------  9
  !         |              |              / |
  !   2.5   |              |   10       /   |
  !         |      7       |         /      |
  !   2.0   |              |      /     9   |
  !         |              |  /             |
  !   1.5   4 ------------ 5 -------------  6
  !         |              |                |
  !   1.0   |              |                |
  !         |      1       |       3        |
  !   0.5   |              |                |
  !         |              |                |
  !   0.0   1 ------------ 2 -------------- 3
  !            
  !        0.0  0.5  1.0  1.5   2.0  2.5   3.0
  !
  !               Node Ids at corners
  !              Element Ids in centers
  ! 
   !!!!! 
  ! 
  ! The owners for 1 PET are all Pet 0.
  ! The owners for 2 PETs are as follows:
  !
  !                   Mesh Owners
  !
  !   3.0   1 ------------ 1 -------------  1
  !         |              |              / |
  !   2.5   |              |   1       /    |
  !         |      1       |         /      |
  !   2.0   |              |      /     1   |
  !         |              |  /             |
  !   1.5   0 ------------ 0 -------------  0
  !         |              |                |
  !   1.0   |              |                |
  !         |      0       |       0        |
  !   0.5   |              |                |
  !         |              |                |
  !   0.0   0 ------------ 0 -------------- 0
  !            
  !        0.0  0.5  1.0  1.5   2.0  2.5   3.0
  !
  !              Element Owners in centers
  ! 

subroutine CreateTestMesh2x2_1(mesh, rc)
  type(ESMF_Mesh), intent(out) :: mesh
  integer :: rc
  integer :: petCount, localPet
  type(ESMF_VM) :: vm
  integer :: numNodes, numElems, numTriElems, numQuadElems
  integer :: numElemCorners
  integer, allocatable :: nodeIds(:)
  real(ESMF_KIND_R8), allocatable :: nodeCoords(:)
  real(ESMF_KIND_R8), allocatable :: elemCoords(:)
  integer, allocatable :: nodeOwners(:)
  integer, allocatable :: elemIds(:)
  integer, allocatable :: elemTypes(:)
  integer, allocatable :: elemConn(:)


  ! get global VM
  call ESMF_VMGetGlobal(vm, rc=rc)
  if (rc /= ESMF_SUCCESS) return
  call ESMF_VMGet(vm, localPet=localPet, petCount=petCount, rc=rc)
  if (rc /= ESMF_SUCCESS) return

  ! return with an error if not 1 or 2 PETs
  if ((petCount /= 1) .and. (petCount /=2)) then
     rc=ESMF_FAILURE
     return
  endif

  ! Setup mesh info depending on the 
  ! number of PETs
  if (petCount .eq. 1) then

     ! Set number of nodes
     numNodes=9

     ! Allocate and fill the node id array.
     allocate(nodeIds(numNodes))
     nodeIds=(/1,2,3,4,5,6,7,8,9/) 
     
     ! Allocate and fill node coordinate array.
     ! Since this is a 2D Mesh the size is 2x the
     ! number of nodes.
     allocate(nodeCoords(2*numNodes))
     nodeCoords=(/0.0,0.0, & ! node id 1
               1.5,0.0, & ! node id 2
               3.0,0.0, & ! node id 3
               0.0,1.5, & ! node id 4
               1.5,1.5, & ! node id 5
               3.0,1.5, & ! node id 6
               0.0,3.0, & ! node id 7
               1.5,3.0, & ! node id 8
               3.0,3.0 /) ! node id 9

     ! Allocate and fill the node owner array.
     ! Since this Mesh is all on PET 0, it's just set to all 0.
     allocate(nodeOwners(numNodes))
     nodeOwners=0 ! everything on PET 0

      ! Fill in elem data
      numTriElems=2
      numQuadElems=3
      numElems=numTriElems+numQuadElems
      numElemCorners=3*numTriElems+4*numQuadElems

      !! elem ids
      allocate(elemIds(numElems))
      elemIds=(/1,3,7,9,10/) 

      !! elem types
      allocate(elemTypes(numElems))
      elemTypes=(/ESMF_MESHELEMTYPE_QUAD, & ! 1
                  ESMF_MESHELEMTYPE_QUAD, & ! 3
                  ESMF_MESHELEMTYPE_QUAD, & ! 7
                  ESMF_MESHELEMTYPE_TRI,  & ! 9
                  ESMF_MESHELEMTYPE_TRI/)   ! 10

      !! elem coords
      allocate(elemCoords(2*numElems))
      elemCoords=(/0.75,0.75, & ! 1
                   2.25,0.75, & ! 3
                   0.75,2.25, & ! 7
                   2.50,2.00, & ! 9
                   2.00,2.50/)  ! 10
     
     !! elem corner Coords
     allocate(elemConn(numElemCorners))
     elemConn=(/1,2,5,4, & ! 1
                2,3,6,5, & ! 3
                4,5,8,7, & ! 7
                5,6,9,   & ! 9
                5,9,8/)    ! 10

   else if (petCount .eq. 2) then
     ! Setup mesh data depending on PET
     if (localPet .eq. 0) then

        ! Set number of nodes
        numNodes=6

        ! Allocate and fill the node id array.
        allocate(nodeIds(numNodes))
        nodeIds=(/1,2,3,4,5,6/) 
     
        ! Allocate and fill node coordinate array.
        ! Since this is a 2D Mesh the size is 2x the
        ! number of nodes.
        allocate(nodeCoords(2*numNodes))
        nodeCoords=(/0.0,0.0, & ! node id 1
             1.5,0.0, & ! node id 2
             3.0,0.0, & ! node id 3
             0.0,1.5, & ! node id 4
             1.5,1.5, & ! node id 5
             3.0,1.5 /) ! node id 6

        
        ! Allocate and fill the node owner array.
        ! Since this Mesh is all on PET 0, it's just set to all 0.
        allocate(nodeOwners(numNodes))
        nodeOwners=0 ! everything on PET 0
        

      ! Fill in elem data
      numTriElems=0
      numQuadElems=2
      numElems=numTriElems+numQuadElems
      numElemCorners=3*numTriElems+4*numQuadElems

      !! elem ids
      allocate(elemIds(numElems))
      elemIds=(/1,3/) 

      !! elem types
      allocate(elemTypes(numElems))
      elemTypes=(/ESMF_MESHELEMTYPE_QUAD, &! 1
                  ESMF_MESHELEMTYPE_QUAD/) ! 3
 

      !! elem coords
      allocate(elemCoords(2*numElems))
      elemCoords=(/0.75,0.75, & ! 1
                   2.25,0.75/)  ! 3

     !! elem corner Coords
     allocate(elemConn(numElemCorners))
     elemConn=(/1,2,5,4, & ! 1
                2,3,6,5/)  ! 3

     else if (localPet .eq. 1) then

     ! Set number of nodes
     numNodes=6

     ! Allocate and fill the node id array.
     allocate(nodeIds(numNodes))
     nodeIds=(/4,5,6,7,8,9/) 
     
     ! Allocate and fill node coordinate array.
     ! Since this is a 2D Mesh the size is 2x the
     ! number of nodes.
     allocate(nodeCoords(2*numNodes))
     nodeCoords=(/ &
               0.0,1.5, & ! node id 4
               1.5,1.5, & ! node id 5
               3.0,1.5, & ! node id 6
               0.0,3.0, & ! node id 7
               1.5,3.0, & ! node id 8
               3.0,3.0 /) ! node id 9

     ! Allocate and fill the node owner array.
     ! Since this Mesh is all on PET 0, it's just set to all 0.
     allocate(nodeOwners(numNodes))
     nodeOwners=(/ 0, &  ! 4
                   0, &  ! 5
                   0, &  ! 6
                   1, &  ! 7
                   1, &  ! 8
                   1/)   ! 9

      ! Fill in elem data
      numTriElems=2
      numQuadElems=1
      numElems=numTriElems+numQuadElems
      numElemCorners=3*numTriElems+4*numQuadElems

      !! elem ids
      allocate(elemIds(numElems))
      elemIds=(/7,9,10/) 

      !! elem coords
      allocate(elemCoords(2*numElems))
      elemCoords=(/0.75,2.25, & ! 7
                   2.50,2.00, & ! 9
                   2.00,2.50/) ! 10

      !! elem types
      allocate(elemTypes(numElems))
      elemTypes=(/ESMF_MESHELEMTYPE_QUAD, & ! 7
                  ESMF_MESHELEMTYPE_TRI,  & ! 9
                  ESMF_MESHELEMTYPE_TRI/)   ! 10
     !! elem corner Coords
     allocate(elemConn(numElemCorners))
     elemConn=(/1,2,5,4, & ! 7
                2,3,6, &   ! 9
                2,6,5/)    ! 10

   endif
  endif


  ! Create Mesh structure in 1 step
  mesh=ESMF_MeshCreate(parametricDim=2, spatialDim=2, &
         coordSys=ESMF_COORDSYS_SPH_DEG, &
         nodeIds=nodeIds, nodeCoords=nodeCoords, &
         nodeOwners=nodeOwners, elementIds=elemIds,&
         elementTypes=elemTypes, elementConn=elemConn, &
         elementCoords=elemCoords, &
         rc=rc)
  if (rc /= ESMF_SUCCESS) return

  ! After the creation we are through with the arrays, so they may be
  ! deallocated.
  deallocate(nodeIds)
  deallocate(nodeCoords)
  deallocate(nodeOwners)
  deallocate(elemIds)
  deallocate(elemTypes)
  deallocate(elemCoords)
  deallocate(elemConn)

  ! Output Mesh for debugging
  !call ESMF_MeshWrite(mesh,"mesh1",rc=rc)
  !if (rc /= ESMF_SUCCESS) return

  ! Return success
  rc=ESMF_SUCCESS

end subroutine CreateTestMesh2x2_1


 
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  ! 
  ! Creates the following mesh on 
  ! 1 or 2 PETs. Returns an error 
  ! if run on other than 1 or 2 PETs
  ! 
  !                     Mesh Ids
  !
  !   3.0   * ------------ * -------------  *
  !         |              |              / |
  !   2.5   |              |   10       /   |
  !         |      7       |         /      |
  !   2.0   |              |      /     9   |
  !         |              |  /             |
  !   1.0   * ------------ * -------------  *
  !         |              |                |
  !         |              |                |
  !         |      1       |       3        |
  !   0.5   |              |                |
  !         |              |                |
  !   0.0   * ------------ * -------------- *
  !            
  !        0.0  0.5       1.0   2.0  2.5   3.0
  !
  !               Node Ids at corners
  !              Element Ids in centers
  ! 
   !!!!! 
  ! 
  ! The owners for 1 PET are all Pet 0.
  ! The owners for 2 PETs are as follows:
  !
  !                   Mesh Owners
  !
  !   3.0   * ------------ * -------------  *
  !         |              |              / |
  !   2.5   |              |   1       /    |
  !         |      1       |         /      |
  !   2.0   |              |      /     1   |
  !         |              |  /             |
  !   1.0   * ------------ * -------------  *
  !         |              |                |
  !         |              |                |
  !         |      0       |       0        |
  !   0.5   |              |                |
  !         |              |                |
  !   0.0   * ------------ * -------------- *
  !            
  !        0.0  0.5       1.0   2.0  2.5   3.0
  !
  !              Element Owners in centers
  ! 

subroutine CreateTestMesh2x2EE_2(mesh, rc)
  type(ESMF_Mesh), intent(out) :: mesh
  integer :: rc
  integer :: numElems,numOwnedElemsTst
  integer :: numElemCorners, numTriElems, numQuadElems
  real(ESMF_KIND_R8), pointer :: elemCoords(:,:)
  real(ESMF_KIND_R8), pointer :: elemCornerCoords(:,:)
  integer, pointer :: elemIds(:),elemTypes(:)
  integer :: petCount, localPet
  type(ESMF_VM) :: vm

  ! get global VM
  call ESMF_VMGetGlobal(vm, rc=rc)
  if (rc /= ESMF_SUCCESS) return
  call ESMF_VMGet(vm, localPet=localPet, petCount=petCount, rc=rc)
  if (rc /= ESMF_SUCCESS) return

  ! return with an error if not 1 or 2 PETs
  if ((petCount /= 1) .and. (petCount /=2)) then
     rc=ESMF_FAILURE
     return
  endif
  

  ! Setup mesh info depending on the 
  ! number of PETs
  if (petCount .eq. 1) then

      ! Fill in elem data
      numTriElems=2
      numQuadElems=3
      numElems=numTriElems+numQuadElems
      numElemCorners=3*numTriElems+4*numQuadElems

      !! elem ids
      allocate(elemIds(numElems))
      elemIds=(/1,3,7,9,10/) 

      !! elem types
      allocate(elemTypes(numElems))
      elemTypes=(/ESMF_MESHELEMTYPE_QUAD, & ! 1
                  ESMF_MESHELEMTYPE_QUAD, & ! 3
                  ESMF_MESHELEMTYPE_QUAD, & ! 7
                  ESMF_MESHELEMTYPE_TRI,  & ! 9
                  ESMF_MESHELEMTYPE_TRI/)   ! 10

     !! elem corner Coords
     allocate(elemCornerCoords(2,numElemCorners))
     elemCornerCoords(:,1)=(/0.0,0.0/) ! 1
     elemCornerCoords(:,2)=(/1.0,0.0/) ! 1
     elemCornerCoords(:,3)=(/1.0,1.0/)  ! 1
     elemCornerCoords(:,4)=(/0.0,1.0/)  ! 1
     elemCornerCoords(:,5)=(/1.0,0.0/)  ! 3
     elemCornerCoords(:,6)=(/3.0,0.0/)  ! 3
     elemCornerCoords(:,7)=(/3.0,1.0/)  ! 3
     elemCornerCoords(:,8)=(/1.0,1.0/)  ! 3
     elemCornerCoords(:,9)=(/0.0,1.0/)  ! 7
     elemCornerCoords(:,10)=(/1.0,1.0/)  ! 7
     elemCornerCoords(:,11)=(/1.0,3.0/)  ! 7
     elemCornerCoords(:,12)=(/0.0,3.0/)  ! 7
     elemCornerCoords(:,13)=(/1.0,1.0/)  ! 9
     elemCornerCoords(:,14)=(/3.0,1.0/)  ! 9
     elemCornerCoords(:,15)=(/3.0,3.0/)  ! 9
     elemCornerCoords(:,16)=(/1.0,1.0/)  ! 10
     elemCornerCoords(:,17)=(/3.0,3.0/)  ! 10
     elemCornerCoords(:,18)=(/1.0,3.0 /)  ! 10
 
   else if (petCount .eq. 2) then
     ! Setup mesh data depending on PET
     if (localPet .eq. 0) then

      ! Fill in elem data
      numTriElems=0
      numQuadElems=2
      numElems=numTriElems+numQuadElems
      numElemCorners=3*numTriElems+4*numQuadElems

      !! elem ids
      allocate(elemIds(numElems))
      elemIds=(/1,3/) 

      !! elem types
      allocate(elemTypes(numElems))
      elemTypes=(/ESMF_MESHELEMTYPE_QUAD, &! 1
                  ESMF_MESHELEMTYPE_QUAD/) ! 3
 
     !! elem corner Coords
     allocate(elemCornerCoords(2,numElemCorners))
     elemCornerCoords(:,1)=(/0.0,0.0/)  ! 1
     elemCornerCoords(:,2)=(/1.0,0.0/)  ! 1
     elemCornerCoords(:,3)=(/1.0,1.0/)  ! 1
     elemCornerCoords(:,4)=(/0.0,1.0/)  ! 1
     elemCornerCoords(:,5)=(/1.0,0.0/)  ! 3
     elemCornerCoords(:,6)=(/3.0,0.0/)  ! 3
     elemCornerCoords(:,7)=(/3.0,1.0/)  ! 3
     elemCornerCoords(:,8)=(/1.0,1.0/)  ! 3

     else if (localPet .eq. 1) then

      ! Fill in elem data
      numTriElems=2
      numQuadElems=1
      numElems=numTriElems+numQuadElems
      numElemCorners=3*numTriElems+4*numQuadElems

      !! elem ids
      allocate(elemIds(numElems))
      elemIds=(/7,9,10/) 

      !! elem types
      allocate(elemTypes(numElems))
      elemTypes=(/ESMF_MESHELEMTYPE_QUAD, & ! 7
                  ESMF_MESHELEMTYPE_TRI,  & ! 9
                  ESMF_MESHELEMTYPE_TRI/)   ! 10

     !! elem corner Coords
     allocate(elemCornerCoords(2,numElemCorners))
     elemCornerCoords(:,1)=(/0.0,1.0/)  ! 7
     elemCornerCoords(:,2)=(/1.0,1.0/)  ! 7
     elemCornerCoords(:,3)=(/1.0,3.0/)  ! 7
     elemCornerCoords(:,4)=(/0.0,3.0/)  ! 7
     elemCornerCoords(:,5)=(/1.0,1.0/)  ! 9
     elemCornerCoords(:,6)=(/3.0,1.0/)  ! 9
     elemCornerCoords(:,7)=(/3.0,3.0/)  ! 9
     elemCornerCoords(:,8)=(/1.0,1.0/)  ! 10
     elemCornerCoords(:,9)=(/3.0,3.0/)  ! 10
     elemCornerCoords(:,10)=(/1.0,3.0 /) ! 10
   endif
  endif

   ! Create Mesh structure in 1 step
   mesh=ESMF_MeshCreate(parametricDim=2, &
        coordSys=ESMF_COORDSYS_SPH_DEG, &
        elementIds=elemIds,&
        elementTypes=elemTypes,&
        elementCornerCoords=elemCornerCoords, &
        rc=rc)
   if (rc /= ESMF_SUCCESS) return
   
   ! deallocate elem data
   deallocate(elemIds)
   deallocate(elemTypes)
   deallocate(elemCornerCoords)

   ! Output Mesh for debugging
   !call ESMF_MeshWrite(mesh,"meshee2",rc=rc)
   !if (rc .ne. ESMF_SUCCESS) rc=ESMF_FAILURE

   ! Return success
   rc=ESMF_SUCCESS

end subroutine CreateTestMesh2x2EE_2


  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  ! 
  ! Creates the following mesh on 
  ! 1 or 2 PETs. Returns an error 
  ! if run on other than 1 or 2 PETs
  ! 
  !                     Mesh Ids
  !
  !   3.0   7 ------------ 8 -------------  9
  !         |              |              / |
  !   2.5   |              |   10       /   |
  !         |      7       |         /      |
  !   2.0   |              |      /     9   |
  !         |              |  /             |
  !   1.0   4 ------------ 5 -------------  6
  !         |              |                |
  !         |              |                |
  !         |      1       |       3        |
  !   0.5   |              |                |
  !         |              |                |
  !   0.0   1 ------------ 2 -------------- 3
  !            
  !        0.0  0.5       1.0   2.0  2.5   3.0
  !
  !               Node Ids at corners
  !              Element Ids in centers
  ! 
   !!!!! 
  ! 
  ! The owners for 1 PET are all Pet 0.
  ! The owners for 2 PETs are as follows:
  !
  !                   Mesh Owners
  !
  !   3.0   1 ------------ 1 -------------  1
  !         |              |              / |
  !   2.5   |              |   1       /    |
  !         |      1       |         /      |
  !   2.0   |              |      /     1   |
  !         |              |  /             |
  !   1.0   0 ------------ 0 -------------  0
  !         |              |                |
  !         |              |                |
  !         |      0       |       0        |
  !   0.5   |              |                |
  !         |              |                |
  !   0.0   0 ------------ 0 -------------- 0
  !            
  !        0.0  0.5       1.0   2.0  2.5   3.0
  !
  !              Element Owners in centers
  ! 

subroutine CreateTestMesh2x2_2(mesh, rc)
  type(ESMF_Mesh), intent(out) :: mesh
  integer :: rc
  integer :: petCount, localPet
  type(ESMF_VM) :: vm
  integer :: numNodes, numElems, numTriElems, numQuadElems
  integer :: numElemCorners
  integer, allocatable :: nodeIds(:)
  real(ESMF_KIND_R8), allocatable :: nodeCoords(:)
  integer, allocatable :: nodeOwners(:)
  integer, allocatable :: elemIds(:)
  integer, allocatable :: elemTypes(:)
  integer, allocatable :: elemConn(:)
  real(ESMF_KIND_R8), pointer :: elemCoords(:)


  ! get global VM
  call ESMF_VMGetGlobal(vm, rc=rc)
  if (rc /= ESMF_SUCCESS) return
  call ESMF_VMGet(vm, localPet=localPet, petCount=petCount, rc=rc)
  if (rc /= ESMF_SUCCESS) return

  ! return with an error if not 1 or 2 PETs
  if ((petCount /= 1) .and. (petCount /=2)) then
     rc=ESMF_FAILURE
     return
  endif

  ! Setup mesh info depending on the 
  ! number of PETs
  if (petCount .eq. 1) then

     ! Set number of nodes
     numNodes=9

     ! Allocate and fill the node id array.
     allocate(nodeIds(numNodes))
     nodeIds=(/1,2,3,4,5,6,7,8,9/) 
     
     ! Allocate and fill node coordinate array.
     ! Since this is a 2D Mesh the size is 2x the
     ! number of nodes.
     allocate(nodeCoords(2*numNodes))
     nodeCoords=(/0.0,0.0, & ! node id 1
               1.0,0.0, & ! node id 2
               3.0,0.0, & ! node id 3
               0.0,1.0, & ! node id 4
               1.0,1.0, & ! node id 5
               3.0,1.0, & ! node id 6
               0.0,3.0, & ! node id 7
               1.0,3.0, & ! node id 8
               3.0,3.0 /) ! node id 9

     ! Allocate and fill the node owner array.
     ! Since this Mesh is all on PET 0, it's just set to all 0.
     allocate(nodeOwners(numNodes))
     nodeOwners=0 ! everything on PET 0

      ! Fill in elem data
      numTriElems=2
      numQuadElems=3
      numElems=numTriElems+numQuadElems
      numElemCorners=3*numTriElems+4*numQuadElems

      !! elem ids
      allocate(elemIds(numElems))
      elemIds=(/1,3,7,9,10/) 

      !! elem types
      allocate(elemTypes(numElems))
      elemTypes=(/ESMF_MESHELEMTYPE_QUAD, & ! 1
                  ESMF_MESHELEMTYPE_QUAD, & ! 3
                  ESMF_MESHELEMTYPE_QUAD, & ! 7
                  ESMF_MESHELEMTYPE_TRI,  & ! 9
                  ESMF_MESHELEMTYPE_TRI/)   ! 10

     
      !! elem coords
      allocate(elemCoords(2*numElems))
      elemCoords=(/0.50,0.50, &   ! 1
                   2.00,0.50, &   ! 3
                   0.50,2.00, &   ! 7
                   2.50,2.00, &   ! 9
                   2.00,2.50/)   ! 10


     !! elem connections
     allocate(elemConn(numElemCorners))
     elemConn=(/1,2,5,4, & ! 1
                2,3,6,5, & ! 3
                4,5,8,7, & ! 7
                5,6,9,   & ! 9
                5,9,8/)    ! 10

   else if (petCount .eq. 2) then
     ! Setup mesh data depending on PET
     if (localPet .eq. 0) then

        ! Set number of nodes
        numNodes=6

        ! Allocate and fill the node id array.
        allocate(nodeIds(numNodes))
        nodeIds=(/1,2,3,4,5,6/) 
     
        ! Allocate and fill node coordinate array.
        ! Since this is a 2D Mesh the size is 2x the
        ! number of nodes.
        allocate(nodeCoords(2*numNodes))
        nodeCoords=(/0.0,0.0, & ! node id 1
             1.0,0.0, & ! node id 2
             3.0,0.0, & ! node id 3
             0.0,1.0, & ! node id 4
             1.0,1.0, & ! node id 5
             3.0,1.0 /) ! node id 6

        
        ! Allocate and fill the node owner array.
        ! Since this Mesh is all on PET 0, it's just set to all 0.
        allocate(nodeOwners(numNodes))
        nodeOwners=0 ! everything on PET 0
        

      ! Fill in elem data
      numTriElems=0
      numQuadElems=2
      numElems=numTriElems+numQuadElems
      numElemCorners=3*numTriElems+4*numQuadElems

      !! elem ids
      allocate(elemIds(numElems))
      elemIds=(/1,3/) 

      !! elem types
      allocate(elemTypes(numElems))
      elemTypes=(/ESMF_MESHELEMTYPE_QUAD, &! 1
                  ESMF_MESHELEMTYPE_QUAD/) ! 3

      !! elem coords
      allocate(elemCoords(2*numElems))
      elemCoords=(/0.50,0.50, &   ! 1
                   2.00,0.50/)    ! 3
 
     !! elem corner Coords
     allocate(elemConn(numElemCorners))
     elemConn=(/1,2,5,4, & ! 1
                2,3,6,5/)  ! 3

     else if (localPet .eq. 1) then

     ! Set number of nodes
     numNodes=6

     ! Allocate and fill the node id array.
     allocate(nodeIds(numNodes))
     nodeIds=(/4,5,6,7,8,9/) 
     
     ! Allocate and fill node coordinate array.
     ! Since this is a 2D Mesh the size is 2x the
     ! number of nodes.
     allocate(nodeCoords(2*numNodes))
     nodeCoords=(/ &
               0.0,1.0, & ! node id 4
               1.0,1.0, & ! node id 5
               3.0,1.0, & ! node id 6
               0.0,3.0, & ! node id 7
               1.0,3.0, & ! node id 8
               3.0,3.0 /) ! node id 9

     ! Allocate and fill the node owner array.
     ! Since this Mesh is all on PET 0, it's just set to all 0.
     allocate(nodeOwners(numNodes))
     nodeOwners=(/ 0, &  ! 4
                   0, &  ! 5
                   0, &  ! 6
                   1, &  ! 7
                   1, &  ! 8
                   1/)   ! 9

      ! Fill in elem data
      numTriElems=2
      numQuadElems=1
      numElems=numTriElems+numQuadElems
      numElemCorners=3*numTriElems+4*numQuadElems

      !! elem ids
      allocate(elemIds(numElems))
      elemIds=(/7,9,10/) 

      !! elem coords
      allocate(elemCoords(2*numElems))
      elemCoords=(/0.50,2.00, &  ! 7
                   2.50,2.00, &  ! 9
                   2.00,2.50/)   ! 10

      !! elem types
      allocate(elemTypes(numElems))
      elemTypes=(/ESMF_MESHELEMTYPE_QUAD, & ! 7
                  ESMF_MESHELEMTYPE_TRI,  & ! 9
                  ESMF_MESHELEMTYPE_TRI/)   ! 10

     !! elem corner Coords
     allocate(elemConn(numElemCorners))
     elemConn=(/1,2,5,4, & ! 7
                2,3,6, &   ! 9
                2,6,5/)    ! 10

   endif
  endif


  ! Create Mesh structure in 1 step
  mesh=ESMF_MeshCreate(parametricDim=2, spatialDim=2, &
         coordSys=ESMF_COORDSYS_SPH_DEG, &
         nodeIds=nodeIds, nodeCoords=nodeCoords, &
         nodeOwners=nodeOwners, elementIds=elemIds,&
         elementTypes=elemTypes, elementConn=elemConn, &
         elementCoords=elemCoords, &
         rc=rc)
  if (rc /= ESMF_SUCCESS) return

  ! After the creation we are through with the arrays, so they may be
  ! deallocated.
  deallocate(nodeIds)
  deallocate(nodeCoords)
  deallocate(nodeOwners)
  deallocate(elemIds)
  deallocate(elemTypes)
  deallocate(elemConn)
  deallocate(elemCoords)

  ! Output Mesh for debugging
 ! call ESMF_MeshWrite(mesh,"mesh2",rc=rc)
 ! if (rc /= ESMF_SUCCESS) return

  ! Return success
  rc=ESMF_SUCCESS

end subroutine CreateTestMesh2x2_2



  ! Test creating an XGrid using easy mesh create
  subroutine test8(rc)
    integer, intent(out)                :: rc
    integer                             :: localrc, i, npet
    type(ESMF_XGrid)                    :: xgrid
    type(ESMF_Mesh)                     :: mesh1, mesh2, smesh
    type(ESMF_VM)                       :: vm
    real(ESMF_KIND_R8)                  :: xgrid_area(12), B_area(2,2)

    rc = ESMF_SUCCESS
    localrc = ESMF_SUCCESS

    call ESMF_VMGetCurrent(vm=vm, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    call ESMF_VMGet(vm, petcount=npet, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Create Mesh using easy mesh create
    call CreateTestMesh2x2EE_1(mesh1, rc=localrc) ! Easy element create
  ! call CreateTestMesh2x2_1(mesh1, rc=localrc) ! Non-easy element create
    if (ESMF_LogFoundError(localrc, &
         ESMF_ERR_PASSTHRU, &
         ESMF_CONTEXT, rcToReturn=rc)) return   

    ! Create Mesh using normal mesh create
     call CreateTestMesh2x2EE_2(mesh2, rc=localrc) ! Easy element create
   ! call CreateTestMesh2x2_2(mesh2, rc=localrc) ! Non-easy element create
    if (ESMF_LogFoundError(localrc, &
         ESMF_ERR_PASSTHRU, &
         ESMF_CONTEXT, rcToReturn=rc)) return

    ! Create XGrid
    xgrid = ESMF_XGridCreate(sideAMesh=(/mesh1/), &
         sideBMesh=(/mesh2/), &
      storeOverlay = .true., &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Get super mesh
    call ESMF_XGridGet(xgrid, mesh=smesh, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Write super mesh for debugging
   ! call ESMF_MeshWrite(smesh,"smesh",rc=localrc)
   ! if (ESMF_LogFoundError(localrc, &
   !   ESMF_ERR_PASSTHRU, &
   !   ESMF_CONTEXT, rcToReturn=rc)) return

    ! Free the XGrid
    call ESMF_XGridDestroy(xgrid,rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Free the meshes
    call ESMF_MeshDestroy(mesh1, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Free the meshes
    call ESMF_MeshDestroy(mesh2, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

  end subroutine test8


  ! Test 2nd order regridding using an XGrid
  subroutine test_MeshToMesh_2nd(rc)
#undef ESMF_METHOD 
#define ESMF_METHOD "test_MeshToMesh_2nd"
    integer, intent(out)                :: rc
    logical :: itrp
    logical :: csrv
    integer :: localrc
  type(ESMF_Mesh) :: srcMesh
  type(ESMF_Mesh) :: dstMesh
  type(ESMF_Mesh) :: xgridMesh
  type(ESMF_XGrid) :: xgrid
  type(ESMF_Field) :: srcField
  type(ESMF_Field) :: dstField
  type(ESMF_Field) :: xdstField
  type(ESMF_Field) :: xField
  type(ESMF_Field) :: srcAreaField, dstAreaField
  type(ESMF_Field) :: srcFracField, dstFracField
  type(ESMF_RouteHandle) :: StoXrouteHandle
  type(ESMF_RouteHandle) :: XtoDrouteHandle
  type(ESMF_RouteHandle) :: routeHandle
  type(ESMF_ArraySpec) :: arrayspec
   type(ESMF_VM) :: vm
  real(ESMF_KIND_R8), pointer :: srcFarrayPtr(:), dstFarrayPtr(:), xdstFarrayPtr(:)
  real(ESMF_KIND_R8), pointer :: srcAreaPtr(:), dstAreaPtr(:)
 real(ESMF_KIND_R8), pointer :: srcFracPtr(:), dstFracPtr(:)
  integer :: clbnd(1),cubnd(1)
   integer :: i1,i2,i3
  real(ESMF_KIND_R8) :: x,y,z
  real(ESMF_KIND_R8) :: lat, lon, phi, theta
  real(ESMF_KIND_R8),parameter :: &
                    DEG2RAD = 3.141592653589793_ESMF_KIND_R8/180.0_ESMF_KIND_R8
  integer :: localPet, petCount
  real(ESMF_KIND_R8) :: srcmass(1), dstmass(1), srcmassg(1), dstmassg(1)
  real(ESMF_KIND_R8) :: maxerror(1), minerror(1), error
  real(ESMF_KIND_R8) :: maxerrorg(1), minerrorg(1), errorg
 
  real(ESMF_KIND_R8) :: errorTot, errorTotG, dstVal

  integer :: num_errorTot
  real(ESMF_KIND_R8) :: l_errorTot(1),g_errorTot(1)
  integer :: l_num_errorTot(1), g_num_errorTot(1)
   
  integer :: numOwnedElems
  real(ESMF_KIND_R8), pointer :: ownedElemCoords(:)
  character(len=255) :: filename

  ! result code
  integer :: finalrc
  
  ! Init to success
  rc=ESMF_SUCCESS
  itrp=.true.
  csrv=.true.

  ! get pet info
  call ESMF_VMGetGlobal(vm, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_VMGet(vm, petCount=petCount, localPet=localpet, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return
 

  ! If we don't have 1 or 2 PETS then exit unsuccessfully
  if ((petCount .ne. 1) .and. (petCount .ne. 2)) then
     rc=ESMF_FAILURE
     return
  endif

! 11/25/2024 
  

  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !!!!!!!!!!!!!!!! Setup Source !!!!!!!!!!!!!
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 
  ! Create Source Mesh
  call CreateTestMesh2x2_1(srcMesh, rc=localrc) ! Non-easy element create
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return
  
   
   ! Array spec for fields
  call ESMF_ArraySpecSet(arrayspec, 1, ESMF_TYPEKIND_R8, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! Create source field
  srcField = ESMF_FieldCreate(srcMesh, arrayspec, meshloc=ESMF_MESHLOC_ELEMENT, &
       name="source", rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! Create source area field
  srcAreaField = ESMF_FieldCreate(srcMesh, arrayspec, meshloc=ESMF_MESHLOC_ELEMENT, &
       name="source_area", rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! Create source frac field
  srcFracField = ESMF_FieldCreate(srcMesh, arrayspec, meshloc=ESMF_MESHLOC_ELEMENT, &
       name="source_frac", rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  ! Load test data into the source Field
  ! Should only be 1 localDE
  call ESMF_FieldGet(srcField, 0, srcFarrayPtr,  rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! Set interpolated function
  call ESMF_MeshGet(srcMesh, numOwnedElements=numOwnedElems, &
       rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

   ! Allocate space for coordinates
   allocate(ownedElemCoords(2*numOwnedElems))

    ! Set interpolated function
  call ESMF_MeshGet(srcMesh, ownedElemCoords=ownedElemCoords, &
       rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  ! loop through and set field
  do i1=1,numOwnedElems

      ! Get coords
     lon=ownedElemCoords(2*i1-1)
     lat=ownedElemCoords(2*i1)

     ! Set source function
     theta = DEG2RAD*(lon)
     phi = DEG2RAD*(90.-lat)

     x = cos(theta)*sin(phi)
     y = sin(theta)*sin(phi)
     z = cos(phi)

     srcFarrayPtr(i1) = x+y+z
     !srcFarrayPtr(i1) = 1.0

  enddo

   ! Deallocate space for coordinates
   deallocate(ownedElemCoords)


  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !!!!!!!!!!! Setup Destination !!!!!!!!!!!!!
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  ! Create Destination Mesh
  call CreateTestMesh2x2_2(dstMesh, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  ! Array spec
  call ESMF_ArraySpecSet(arrayspec, 1, ESMF_TYPEKIND_R8, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return
   
   ! Create dest. field
   dstField = ESMF_FieldCreate(dstMesh, arrayspec, meshloc=ESMF_MESHLOC_ELEMENT, &
         name="dest", rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return
   
   ! Create dest. area field
   dstAreaField = ESMF_FieldCreate(dstMesh, arrayspec, meshloc=ESMF_MESHLOC_ELEMENT, &
        name="dest_area", rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

   ! Create dest. frac field
   dstFracField = ESMF_FieldCreate(dstMesh, arrayspec, meshloc=ESMF_MESHLOC_ELEMENT, &
        name="dest_frac", rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

   ! Create exact dest. field
   xdstField = ESMF_FieldCreate(dstMesh, arrayspec, meshloc=ESMF_MESHLOC_ELEMENT, &
        name="xdest", rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


   ! Init destination field to 0.0
   ! Should only be 1 localDE
   call ESMF_FieldGet(dstField, 0, dstFarrayPtr,  rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

   
   ! Init exact destination field
   ! Should only be 1 localDE
   call ESMF_FieldGet(xdstField, 0, xdstFarrayPtr,  rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  ! Set number of points in destination mesh
  call ESMF_MeshGet(dstMesh, numOwnedElements=numOwnedElems, &
       rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

   ! Allocate space for coordinates
   allocate(ownedElemCoords(2*numOwnedElems))

   ! Set exact destination field
   call ESMF_MeshGet(dstMesh, ownedElemCoords=ownedElemCoords, &
       rc=localrc)
   if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

   ! loop through and set xfield
   do i1=1,numOwnedElems

      ! Get coords
     lon=ownedElemCoords(2*i1-1)
     lat=ownedElemCoords(2*i1)

     ! Set exact dest function
     theta = DEG2RAD*(lon)
     phi = DEG2RAD*(90.-lat)

     x = cos(theta)*sin(phi)
     y = sin(theta)*sin(phi)
     z = cos(phi)

     xdstFarrayPtr(i1) = x+y+z
     ! xdstFarrayPtr(i1) = 1.0

     ! Init destination field to 0.0
     dstFarrayPtr(i1)=0.0
   
   enddo

   ! Deallocate space for coordinates
   deallocate(ownedElemCoords)


#if 0
   call ESMF_MeshWrite(srcMesh,"srcMesh")
   call ESMF_MeshWrite(dstMesh,"dstMesh")
#endif

#define USE_XGRID
#ifdef USE_XGRID

!write(*,*) "Using XGrid"


   ! Create XGrid
   xgrid = ESMF_XGridCreate(sideAMesh=(/srcMesh/), &
        sideBMesh=(/dstMesh/), &
        storeOverlay = .true., &
        rc=localrc)
   if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

#if 0
   call ESMF_XGridGet(xgrid, mesh=xgridMesh, rc=localrc)
   if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

   call ESMF_MeshWrite(xgridMesh,"xgridMesh")
#endif   
   
   ! Field on XGrid
   xField = ESMF_FieldCreate(xgrid, arrayspec, &
        name="xfield", rc=localrc)
   if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

  ! Regrid store
  call ESMF_FieldRegridStore( &
          xgrid, &
          srcField, &
          dstField=xField, &
          routeHandle=StoXrouteHandle, &
          regridmethod=ESMF_REGRIDMETHOD_CONSERVE_2ND, &
          srcFracField=srcFracField, &
          rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  
  call ESMF_FieldRegridStore( &
       xgrid, &
       xField, &
          dstField=dstField, &
          routeHandle=XToDrouteHandle, &
          regridmethod=ESMF_REGRIDMETHOD_CONSERVE_2ND, &
          dstFracField=dstFracField, &
          rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return
  
  ! Do regrid
  call ESMF_FieldRegrid(srcField, xField, StoXrouteHandle, &
       rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_FieldRegrid(xField, dstField, XToDrouteHandle, &
       rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! Release routehandles
  call ESMF_FieldRegridrelease(StoXrouteHandle, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_FieldRegridRelease(XtoDrouteHandle, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

#else

!write(*,*) "NOT Using XGrid"

  !!! Regrid forward from the A grid to the B grid
  ! Regrid store
  call ESMF_FieldRegridStore( &
          srcField, &
          dstField=dstField, &
          routeHandle=routeHandle, &
          regridmethod=ESMF_REGRIDMETHOD_CONSERVE_2ND, &
          dstFracField=dstFracField, &
          srcFracField=srcFracField, &
          unmappedaction=ESMF_UNMAPPEDACTION_IGNORE, &
          rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  ! Do regrid
  call ESMF_FieldRegrid(srcField, dstField, routeHandle, &
       rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  call ESMF_FieldRegridRelease(routeHandle, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return
#endif



  ! Get the integration weights
  call ESMF_FieldRegridGetArea(srcAreaField, &
          rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! Get the integration weights
  call ESMF_FieldRegridGetArea(dstAreaField, &
          rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  ! Check if the values are close
  minerror(1) = 100000.
  maxerror(1) = 0.
  error = 0.
  errorTot=0.0
  num_errorTot=0
  dstmass = 0.

  ! get dst Field
  call ESMF_FieldGet(dstField, 0, dstFarrayPtr, computationalLBound=clbnd, &
                             computationalUBound=cubnd,  rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! get exact destination Field
  call ESMF_FieldGet(xdstField, 0, xdstFarrayPtr,  rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  ! get dst area Field
  call ESMF_FieldGet(dstAreaField, 0, dstAreaPtr,  rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! get frac Field
  call ESMF_FieldGet(dstFracField, 0, dstFracptr,  rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! destination grid
  !! check relative error
  do i1=clbnd(1),cubnd(1)

     ! This is WRONG, shouldn't include Frac
     ! dstmass = dstmass + dstFracptr(i1,i2)*dstAreaptr(i1)*fptr(i1)
     
     ! Instead do this
     dstmass = dstmass + dstAreaptr(i1)*dstFarrayPtr(i1)

     ! If this destination cell isn't covered by a sig. amount of source, then don't compute error on it.
     if (dstFracPtr(i1) .lt. 0.1) cycle

     ! write(*,*) i1,"::",dstFarrayPtr(i1),xdstFarrayPtr(i1)

     ! Since fraction isn't included in weights in this case, use it to modify dstField value, so 
     ! that it's correct for partial cells
     if (dstFracPtr(i1) .ne. 0.0) then
        dstVal=dstFarrayPtr(i1)/dstFracptr(i1)
     else 
        dstVal=dstFarrayPtr(i1)
     endif

     if (xdstFarrayPtr(i1) .ne. 0.0) then
        error=ABS(dstVal - xdstFarrayPtr(i1))/ABS(xdstFarrayPtr(i1))
     else
        error=ABS(dstVal - xdstFarrayPtr(i1))
     endif

     ! total error 
     errorTot=errorTot+error
     num_errorTot=num_errorTot+1           

     ! min max error
     if (error > maxerror(1)) then
        maxerror(1) = error
     endif
     if (error < minerror(1)) then
        minerror(1) = error
     endif

  enddo

  srcmass(1) = 0.

  ! get src pointer
  call ESMF_FieldGet(srcField, 0, srcFarrayPtr, computationalLBound=clbnd, &
       computationalUBound=cubnd,  rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

     ! get src Field
  call ESMF_FieldGet(srcAreaField, 0, srcAreaptr,  rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! get frac Field
  call ESMF_FieldGet(srcFracField, 0, srcFracptr,  rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  do i1=clbnd(1),cubnd(1)
     srcmass(1) = srcmass(1) + srcFracptr(i1)*srcAreaptr(i1)*srcFarrayPtr(i1)
  enddo

  ! Init integrals
  srcmassg(1) = 0.
  dstmassg(1) = 0.
  
  call ESMF_VMAllReduce(vm, srcmass, srcmassg, 1, ESMF_REDUCE_SUM, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_VMAllReduce(vm, dstmass, dstmassg, 1, ESMF_REDUCE_SUM, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_VMAllReduce(vm, maxerror, maxerrorg, 1, ESMF_REDUCE_MAX, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_VMAllReduce(vm, minerror, minerrorg, 1, ESMF_REDUCE_MIN, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return
  
  l_errorTot(1)=errorTot
  call ESMF_VMAllReduce(vm, l_errorTot, g_errorTot, 1, ESMF_REDUCE_SUM, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  l_num_errorTot(1)=num_errorTot
  call ESMF_VMAllReduce(vm, l_num_errorTot, g_num_errorTot, 1, ESMF_REDUCE_SUM, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! return answer based on correct flags
  csrv = .false.
  if (ABS(dstmassg(1)-srcmassg(1))/srcmassg(1) < 1.0E-14)  csrv = .true.

  itrp = .false.
  if (maxerrorg(1) < 1.5E-2) itrp = .true.

  ! Uncomment these calls to see some actual regrid results
  if (localPet == 0) then
    write(*,*) 
    write(*,*) "=== Second Order Conservative between Spherical Meshes via XGrid ==="
    write(*,*) "Conservation:"
    write(*,*) "Rel Error = ", ABS(dstmassg(1)-srcmassg(1))/srcmassg(1)
    write(*,*) "SRC mass = ", srcmassg(1)
    write(*,*) "DST mass = ", dstmassg(1)
    write(*,*) " "
    write(*,*) "Interpolation:"
    write(*,*) "Max Error = ", maxerrorg(1)
    write(*,*) "Min Error = ", minerrorg(1)
    write(*,*) "Avg Error = ", g_errorTot(1)/g_num_errorTot(1)
    write(*,*) " "
  endif


  ! Destroy the Fields
  call ESMF_FieldDestroy(srcField, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_FieldDestroy(dstField, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_FieldDestroy(srcAreaField, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_FieldDestroy(dstAreaField, rc=localrc)
   if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
   
   call ESMF_FieldDestroy(srcFracField, rc=localrc)
   if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

   call ESMF_FieldDestroy(dstFracField, rc=localrc)
   if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
   

   call ESMF_FieldDestroy(xdstField, rc=localrc)
   if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

  ! Free the meshes
  call ESMF_MeshDestroy(srcMesh, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_MeshDestroy(dstMesh, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! If either interpolation or conservation errors
  ! are too large, then return failure
  if (.not. itrp .or. .not. csrv) then
     rc=ESMF_FAILURE
  endif

  end subroutine test_MeshToMesh_2nd



  
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  ! 
  ! Creates the following mesh on 
  ! 1 or 4 PETs. Returns an error 
  ! if run on other than 1 or 4 PETs
  ! 
  !                     Mesh Ids
  !
  !   3.0   13 ------ 14 ------- 15 ------- 16
  !         |         |          |  10    / |
  !   2.5   |    7    |    8     |     /    |
  !         |         |          |  /    9  |
  !   2.0   9 ------- 10 ------- 11 ------- 12
  !         |         |          |          |
  !   1.5   |    4    |    5     |    6     |
  !         |         |          |          |
  !   1.0   5 ------- 6 -------- 7 -------- 8
  !         |         |          |          |
  !   0.5   |    1    |    2     |    3     |
  !         |         |          |          |
  !   0.0   1 ------- 2 -------- 3 -------- 4
  !            
  !        0.0  0.5  1.0  1.5   2.0  2.5   3.0
  !
  !               Node Ids at corners
  !              Element Ids in centers
  ! 
  !!!!! 
  ! 
  ! The owners for 1 PET are all Pet 0.
  ! The owners for 4 PETs are as follows:
  !
  !                   Mesh Owners
  !
  !   3.0   1 ------- 1 -------- 1 -------- 1
  !         |         |          |  1    /  |
  !         |    1    |    1     |     /    |
  !         |         |          |  /    1  |
  !   2.0   1 ------- 1 -------- 1 -------- 1
  !         |         |          |          |
  !         |    1    |    1     |    1     |
  !         |         |          |          |
  !   1.0   0 ------- 0 -------- 0 -------- 0
  !         |         |          |          |
  !         |    0    |    0     |    0     |
  !         |         |          |          |
  !   0.0   0 ------- 0 -------- 0 -------- 0
  !
  !        0.0       1.0        2.0        3.0
  !
  !               Node Owners at corners
  !              Element Owners in centers
  ! 

subroutine createTestMesh3x3Cart_1(mesh, rc)
  type(ESMF_Mesh), intent(out) :: mesh
  integer :: rc

  integer, pointer :: nodeIds(:),nodeOwners(:)
  real(ESMF_KIND_R8), pointer :: nodeCoords(:)
  real(ESMF_KIND_R8), pointer :: ownedNodeCoords(:)
  integer :: numNodes, numOwnedNodes, numOwnedNodesTst
   integer :: numElems,numOwnedElemsTst
  integer :: numElemConns, numTriElems, numQuadElems
  real(ESMF_KIND_R8), pointer :: elemCoords(:)
  integer, pointer :: elemIds(:),elemTypes(:),elemConn(:)
  integer, pointer :: elemMask(:)
  integer :: petCount, localPet
  type(ESMF_VM) :: vm


  ! get global VM
  call ESMF_VMGetGlobal(vm, rc=rc)
  if (rc /= ESMF_SUCCESS) return
  call ESMF_VMGet(vm, localPet=localPet, petCount=petCount, rc=rc)
  if (rc /= ESMF_SUCCESS) return

   ! return with an error if not 1 or 2 PETs
  if ((petCount /= 1) .and. (petCount /=2)) then
     rc=ESMF_FAILURE
     return
   endif


  ! Setup mesh info depending on the 
  ! number of PETs
  if (petCount .eq. 1) then

     ! Fill in node data
     numNodes=16

     !! node ids
     allocate(nodeIds(numNodes))
     nodeIds=(/1,2,3,4,5,6,7,8, &
                9,10,11,12,13,14,&
               15,16/) 
     
     !! node Coords
     allocate(nodeCoords(numNodes*2))
     nodeCoords=(/0.0,0.0, & ! 1
                 1.0,0.0, &  ! 2
                 2.0,0.0, &  ! 3
                 3.0,0.0, &  ! 4
                 0.0,1.0, &  ! 5
                 1.0,1.0, &  ! 6
                 2.0,1.0, &  ! 7
                 3.0,1.0, &  ! 8
                  0.0,2.0, &  ! 9
                 1.0,2.0, &  ! 10
                 2.0,2.0, &  ! 11
                 3.0,2.0, &  ! 12
                 0.0,3.0, &  ! 13
                  1.0,3.0, &  ! 14
                 2.0,3.0, &  ! 15
                 3.0,3.0 /)  ! 16
 

      !! node owners
      allocate(nodeOwners(numNodes))
      nodeOwners=0 ! everything on proc 0


      ! Fill in elem data
      numTriElems=2
      numQuadElems=8
       numElems=numTriElems+numQuadElems
      numElemConns=3*numTriElems+4*numQuadElems

      !! elem ids
      allocate(elemIds(numElems))
      elemIds=(/1,2,3,4,5,6,7,8,9,10/) 


      !! elem types
      allocate(elemTypes(numElems))
      elemTypes=(/ESMF_MESHELEMTYPE_QUAD, & ! 1
                  ESMF_MESHELEMTYPE_QUAD, & ! 2
                  ESMF_MESHELEMTYPE_QUAD, & ! 3
                  ESMF_MESHELEMTYPE_QUAD, & ! 4
                  ESMF_MESHELEMTYPE_QUAD, & ! 5
                  ESMF_MESHELEMTYPE_QUAD, & ! 6
                  ESMF_MESHELEMTYPE_QUAD, & ! 7
                  ESMF_MESHELEMTYPE_QUAD, & ! 8
                  ESMF_MESHELEMTYPE_TRI,  & ! 9
                  ESMF_MESHELEMTYPE_TRI/)   ! 10

      !! elem coords
      allocate(elemCoords(2*numElems))
      elemCoords=(/0.5,0.5, & ! 1
                   1.5,0.5, & ! 2
                   2.5,0.5, & ! 3
                   0.5,1.5, & ! 4
                   1.5,1.5, & ! 5
                   2.5,1.5, & ! 6
                   0.5,2.5, & ! 7
                   1.5,2.5, & ! 8
                   2.75,2.25,& ! 9
                    2.25,2.75/)  ! 10

      !! elem conn
      allocate(elemConn(numElemConns))
      elemConn=(/1,2,6,5,   & ! 1
                 2,3,7,6,   & ! 2
                 3,4,8,7,   & ! 3
                 5,6,10,9,  & ! 4
                 6,7,11,10, & ! 5
                 7,8,12,11, & ! 6
                 9,10,14,13, & ! 7
                 10,11,15,14, & ! 8
                 11,12,16, & ! 9
                  11,16,15/) ! 10

   else if (petCount .eq. 2) then
     ! Setup mesh data depending on PET
     if (localPet .eq. 0) then
 
     ! Fill in node data
     numNodes=8

     !! node ids
     allocate(nodeIds(numNodes))
     nodeIds=(/1,2,3,4,5,6,7,8/)
     
     !! node Coords
     allocate(nodeCoords(numNodes*2))
     nodeCoords=(/0.0,0.0, &  ! 1
                  1.0,0.0, &  ! 2
                  2.0,0.0, &  ! 3
                  3.0,0.0, &  ! 4
                  0.0,1.0, &  ! 5
                  1.0,1.0, &  ! 6
                  2.0,1.0, &  ! 7
                  3.0,1.0/)   ! 8 

      !! node owners
      allocate(nodeOwners(numNodes))
      nodeOwners=0 ! everything on proc 0

      ! Fill in elem data
      numTriElems=0
      numQuadElems=3
      numElems=numTriElems+numQuadElems
      numElemConns=3*numTriElems+4*numQuadElems

      !! elem ids
       allocate(elemIds(numElems))
      elemIds=(/1,2,3/) 


      !! elem types
      allocate(elemTypes(numElems))
      elemTypes=(/ESMF_MESHELEMTYPE_QUAD, & ! 1
                  ESMF_MESHELEMTYPE_QUAD, & ! 2
                  ESMF_MESHELEMTYPE_QUAD/)  ! 3

      !! elem coords
      allocate(elemCoords(2*numElems))
      elemCoords=(/0.5,0.5, & ! 1
                   1.5,0.5, & ! 2
                   2.5,0.5/)  ! 3

      !! elem conn
      allocate(elemConn(numElemConns))
      elemConn=(/1,2,6,5, & ! 1
                 2,3,7,6, & ! 2
                 3,4,8,7/)  ! 2
           

     else if (localPet .eq. 1) then

     ! Fill in node data
      numNodes=12

     !! node ids
     allocate(nodeIds(numNodes))
     nodeIds=(/5,6,7,8,9,10,11,12,13,14,15,16/)
     
     !! node Coords
     allocate(nodeCoords(numNodes*2))
     nodeCoords=(/0.0,1.0, &  ! 5
                 1.0,1.0, &  ! 6
                 2.0,1.0, &  ! 7
                 3.0 ,1.0, &  ! 8
                 0.0,2.0, &  ! 9
                 1.0,2.0, &  ! 10
                 2.0,2.0, &  ! 11
                 3.0,2.0, &  ! 12
                 0.0,3.0, &  ! 13
                 1.0,3.0, &  ! 14
                 2.0,3.0, &  ! 15
                 3.0,3.0 /)  ! 16


 

      !! node owners
       allocate(nodeOwners(numNodes))
      nodeOwners=(/0, & ! 5
                   0, & ! 6
                   0, & ! 7
                   0, & ! 8
                   1, & ! 9
                   1, & ! 10
                   1, & ! 11                  
                   1, & ! 12
                   1, & ! 13
                   1, & ! 14
                   1, & ! 15
                   1/)  ! 16 

      ! Fill in elem data
      numTriElems=2
      numQuadElems=5
      numElems=numTriElems+numQuadElems
      numElemConns=3*numTriElems+4*numQuadElems
 
      !! elem ids
      allocate(elemIds(numElems))
      elemIds=(/4,5,6,7,8,9,10/)

      !! elem types
      allocate(elemTypes(numElems))
      elemTypes=(/ESMF_MESHELEMTYPE_QUAD, & ! 4
                  ESMF_MESHELEMTYPE_QUAD, & ! 5
                  ESMF_MESHELEMTYPE_QUAD, & ! 6
                  ESMF_MESHELEMTYPE_QUAD, & ! 7 
                  ESMF_MESHELEMTYPE_QUAD, & ! 8
                  ESMF_MESHELEMTYPE_TRI, & ! 9
                  ESMF_MESHELEMTYPE_TRI/)  ! 10

      !! elem coords
      allocate(elemCoords(2*numElems))
      elemCoords=(/0.5,1.5, & ! 4
                  1.5,1.5, & ! 5
                  2.5,1.5, & ! 6
                  0.5,2.5, & ! 7
                  1.5,2.5, & ! 8
                  2.75,2.25,& ! 9
                  2.25,2.75/)  ! 10


      !! elem conn
      allocate(elemConn(numElemConns))
      elemConn=(/1,2,6,5,  & ! 4
                 2,3,7,6,  & ! 5
                 3,4,8,7,  & ! 6
                 5,6,10,9, & ! 7
                 6,7,11,10, & ! 8
                 7,8,12,    & ! 9
                 7,12,11/)    ! 10
      endif
   endif

   ! Create Mesh structure in 1 step
   mesh=ESMF_MeshCreate(parametricDim=2,spatialDim=2, &
        coordSys=ESMF_COORDSYS_CART, &
        nodeIds=nodeIds, nodeCoords=nodeCoords, &
        nodeOwners=nodeOwners, elementIds=elemIds, &
        elementTypes=elemTypes, elementConn=elemConn, &
         elementCoords=elemCoords, rc=rc)
   if (rc /= ESMF_SUCCESS) return

   ! deallocate node data
   deallocate(nodeIds)
   deallocate(nodeCoords)
   deallocate(nodeOwners)
   
   ! deallocate elem data
   deallocate(elemIds)
   deallocate(elemTypes)
   deallocate(elemCoords)
   deallocate(elemConn)

end subroutine createTestMesh3x3Cart_1


  
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  ! 
  ! Creates the following mesh on 
  ! 1 or 4 PETs. Returns an error 
  ! if run on other than 1 or 4 PETs
  ! 
  !                     Mesh Ids
  !
  !   3.0   13 ------ 14 ------- 15 ------- 16
  !         |         |          |  10    / |
  !   2.5   |    7    |    8     |     /    |
  !         |         |          |  /    9  |
  !   2.0   9 ------- 10 ------- 11 ------- 12
  !         |         |          |          |
  !   1.5   |    4    |    5     |    6     |
  !         |         |          |          |
  !   1.0   5 ------- 6 -------- 7 -------- 8
  !         |         |          |          |
  !   0.5   |    1    |    2     |    3     |
  !         |         |          |          |
  !   0.0   1 ------- 2 -------- 3 -------- 4
  !            
  !        0.0  0.5  1.0  1.5   2.0  2.5   3.0
  !
  !               Node Ids at corners
  !              Element Ids in centers
  ! 
  !!!!! 
  ! 
  ! The owners for 1 PET are all Pet 0.
  ! The owners for 4 PETs are as follows:
  !
  !                   Mesh Owners
  !
  !   3.0   1 ------- 1 -------- 1 -------- 1
  !         |         |          |  1    /  |
  !         |    1    |    1     |     /    |
  !         |         |          |  /    1  |
  !   2.0   1 ------- 1 -------- 1 -------- 1
  !         |         |          |          |
  !         |    1    |    1     |    1     |
  !         |         |          |          |
  !   1.0   0 ------- 0 -------- 0 -------- 0
  !         |         |          |          |
  !         |    0    |    0     |    0     |
  !         |         |          |          |
  !   0.0   0 ------- 0 -------- 0 -------- 0
  !
  !        0.0       1.0        2.0        3.0
  !
  !               Node Owners at corners
  !              Element Owners in centers
  ! 

subroutine createTestMesh3x3Cart_2(mesh, rc)
  type(ESMF_Mesh), intent(out) :: mesh
  integer :: rc

  integer, pointer :: nodeIds(:),nodeOwners(:)
  real(ESMF_KIND_R8), pointer :: nodeCoords(:)
  real(ESMF_KIND_R8), pointer :: ownedNodeCoords(:)
  integer :: numNodes, numOwnedNodes, numOwnedNodesTst
   integer :: numElems,numOwnedElemsTst
  integer :: numElemConns, numTriElems, numQuadElems
  real(ESMF_KIND_R8), pointer :: elemCoords(:)
  integer, pointer :: elemIds(:),elemTypes(:),elemConn(:)
  integer, pointer :: elemMask(:)
  integer :: petCount, localPet
  type(ESMF_VM) :: vm


  ! get global VM
  call ESMF_VMGetGlobal(vm, rc=rc)
  if (rc /= ESMF_SUCCESS) return
  call ESMF_VMGet(vm, localPet=localPet, petCount=petCount, rc=rc)
  if (rc /= ESMF_SUCCESS) return

   ! return with an error if not 1 or 2 PETs
  if ((petCount /= 1) .and. (petCount /=2)) then
     rc=ESMF_FAILURE
     return
   endif


  ! Setup mesh info depending on the 
  ! number of PETs
  if (petCount .eq. 1) then

     ! Fill in node data
     numNodes=16

     !! node ids
     allocate(nodeIds(numNodes))
     nodeIds=(/1,2,3,4,5,6,7,8, &
                9,10,11,12,13,14,&
               15,16/) 
     
     !! node Coords
     allocate(nodeCoords(numNodes*2))
     nodeCoords=(/0.0,0.0, & ! 1
                 1.0,0.0, &  ! 2
                 2.0,0.0, &  ! 3
                 3.0,0.0, &  ! 4
                 0.0,1.0, &  ! 5
                 1.25,1.25, &  ! 6
                 1.75,1.25, &  ! 7
                 3.0,1.0, &  ! 8
                  0.0,2.0, &  ! 9
                 1.25,1.75, &  ! 10
                 1.75,1.75, &  ! 11
                 3.0,2.0, &  ! 12
                 0.0,3.0, &  ! 13
                  1.0,3.0, &  ! 14
                 2.0,3.0, &  ! 15
                 3.0,3.0 /)  ! 16
 

      !! node owners
      allocate(nodeOwners(numNodes))
      nodeOwners=0 ! everything on proc 0


      ! Fill in elem data
      numTriElems=2
      numQuadElems=8
       numElems=numTriElems+numQuadElems
      numElemConns=3*numTriElems+4*numQuadElems

      !! elem ids
      allocate(elemIds(numElems))
      elemIds=(/1,2,3,4,5,6,7,8,9,10/) 


      !! elem types
      allocate(elemTypes(numElems))
      elemTypes=(/ESMF_MESHELEMTYPE_QUAD, & ! 1
                  ESMF_MESHELEMTYPE_QUAD, & ! 2
                  ESMF_MESHELEMTYPE_QUAD, & ! 3
                  ESMF_MESHELEMTYPE_QUAD, & ! 4
                  ESMF_MESHELEMTYPE_QUAD, & ! 5
                  ESMF_MESHELEMTYPE_QUAD, & ! 6
                  ESMF_MESHELEMTYPE_QUAD, & ! 7
                  ESMF_MESHELEMTYPE_QUAD, & ! 8
                  ESMF_MESHELEMTYPE_TRI,  & ! 9
                  ESMF_MESHELEMTYPE_TRI/)   ! 10

      !! elem coords
      allocate(elemCoords(2*numElems))
      elemCoords=(/0.5,0.5, & ! 1
                   1.5,0.5, & ! 2
                   2.5,0.5, & ! 3
                   0.5,1.5, & ! 4
                   1.5,1.5, & ! 5
                   2.5,1.5, & ! 6
                   0.5,2.5, & ! 7
                   1.5,2.5, & ! 8
                   2.75,2.25,& ! 9
                    2.25,2.75/)  ! 10

      !! elem conn
      allocate(elemConn(numElemConns))
      elemConn=(/1,2,6,5,   & ! 1
                 2,3,7,6,   & ! 2
                 3,4,8,7,   & ! 3
                 5,6,10,9,  & ! 4
                 6,7,11,10, & ! 5
                 7,8,12,11, & ! 6
                 9,10,14,13, & ! 7
                 10,11,15,14, & ! 8
                 11,12,16, & ! 9
                  11,16,15/) ! 10

   else if (petCount .eq. 2) then
     ! Setup mesh data depending on PET
     if (localPet .eq. 0) then
 
     ! Fill in node data
     numNodes=8

     !! node ids
     allocate(nodeIds(numNodes))
     nodeIds=(/1,2,3,4,5,6,7,8/)
     
     !! node Coords
     allocate(nodeCoords(numNodes*2))
     nodeCoords=(/0.0,0.0, &  ! 1
                  1.0,0.0, &  ! 2
                  2.0,0.0, &  ! 3
                  3.0,0.0, &  ! 4
                  0.0,1.0, &  ! 5
                  1.25,1.25, &  ! 6
                  1.75,1.25, &  ! 7
                  3.0,1.0/)   ! 8 

      !! node owners
      allocate(nodeOwners(numNodes))
      nodeOwners=0 ! everything on proc 0

      ! Fill in elem data
      numTriElems=0
      numQuadElems=3
      numElems=numTriElems+numQuadElems
      numElemConns=3*numTriElems+4*numQuadElems

      !! elem ids
       allocate(elemIds(numElems))
      elemIds=(/1,2,3/) 


      !! elem types
      allocate(elemTypes(numElems))
      elemTypes=(/ESMF_MESHELEMTYPE_QUAD, & ! 1
                  ESMF_MESHELEMTYPE_QUAD, & ! 2
                  ESMF_MESHELEMTYPE_QUAD/)  ! 3

      !! elem coords
      allocate(elemCoords(2*numElems))
      elemCoords=(/0.5,0.5, & ! 1
                   1.5,0.5, & ! 2
                   2.5,0.5/)  ! 3

      !! elem conn
      allocate(elemConn(numElemConns))
      elemConn=(/1,2,6,5, & ! 1
                 2,3,7,6, & ! 2
                 3,4,8,7/)  ! 2
           

     else if (localPet .eq. 1) then

     ! Fill in node data
      numNodes=12

     !! node ids
     allocate(nodeIds(numNodes))
     nodeIds=(/5,6,7,8,9,10,11,12,13,14,15,16/)
     
     !! node Coords
     allocate(nodeCoords(numNodes*2))
     nodeCoords=(/0.0,1.0, &  ! 5
                 1.25,1.25, &  ! 6
                 1.75,1.25, &  ! 7
                 3.0 ,1.0, &  ! 8
                 0.0,2.0, &  ! 9
                 1.25,1.75, &  ! 10
                 1.75,1.75, &  ! 11
                 3.0,2.0, &  ! 12
                 0.0,3.0, &  ! 13
                 1.0,3.0, &  ! 14
                 2.0,3.0, &  ! 15
                 3.0,3.0 /)  ! 16


 

      !! node owners
       allocate(nodeOwners(numNodes))
      nodeOwners=(/0, & ! 5
                   0, & ! 6
                   0, & ! 7
                   0, & ! 8
                   1, & ! 9
                   1, & ! 10
                   1, & ! 11                  
                   1, & ! 12
                   1, & ! 13
                   1, & ! 14
                   1, & ! 15
                   1/)  ! 16 

      ! Fill in elem data
      numTriElems=2
      numQuadElems=5
      numElems=numTriElems+numQuadElems
      numElemConns=3*numTriElems+4*numQuadElems
 
      !! elem ids
      allocate(elemIds(numElems))
      elemIds=(/4,5,6,7,8,9,10/)

      !! elem types
      allocate(elemTypes(numElems))
      elemTypes=(/ESMF_MESHELEMTYPE_QUAD, & ! 4
                  ESMF_MESHELEMTYPE_QUAD, & ! 5
                  ESMF_MESHELEMTYPE_QUAD, & ! 6
                  ESMF_MESHELEMTYPE_QUAD, & ! 7 
                  ESMF_MESHELEMTYPE_QUAD, & ! 8
                  ESMF_MESHELEMTYPE_TRI, & ! 9
                  ESMF_MESHELEMTYPE_TRI/)  ! 10

      !! elem coords
      allocate(elemCoords(2*numElems))
      elemCoords=(/0.5,1.5, & ! 4
                  1.5,1.5, & ! 5
                  2.5,1.5, & ! 6
                  0.5,2.5, & ! 7
                  1.5,2.5, & ! 8
                  2.75,2.25,& ! 9
                  2.25,2.75/)  ! 10


      !! elem conn
      allocate(elemConn(numElemConns))
      elemConn=(/1,2,6,5,  & ! 4
                 2,3,7,6,  & ! 5
                 3,4,8,7,  & ! 6
                 5,6,10,9, & ! 7
                 6,7,11,10, & ! 8
                 7,8,12,    & ! 9
                 7,12,11/)    ! 10
      endif
   endif

   ! Create Mesh structure in 1 step
   mesh=ESMF_MeshCreate(parametricDim=2,spatialDim=2, &
        coordSys=ESMF_COORDSYS_CART, &
        nodeIds=nodeIds, nodeCoords=nodeCoords, &
        nodeOwners=nodeOwners, elementIds=elemIds, &
        elementTypes=elemTypes, elementConn=elemConn, &
         elementCoords=elemCoords, rc=rc)
   if (rc /= ESMF_SUCCESS) return

   ! deallocate node data
   deallocate(nodeIds)
   deallocate(nodeCoords)
   deallocate(nodeOwners)
   
   ! deallocate elem data
   deallocate(elemIds)
   deallocate(elemTypes)
   deallocate(elemCoords)
   deallocate(elemConn)

end subroutine createTestMesh3x3Cart_2



  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  ! 
  ! Creates the following mesh on 
  ! 1 or 4 PETs. Returns an error 
  ! if run on other than 1 or 4 PETs
  ! 
  !                     Mesh Ids
  !
  !   3.0   13 ------ 14 ------- 15 ------- 16
  !         |         |          |  10    / |
  !   2.5   |    7    |    8     |     /    |
  !         |         |          |  /    9  |
  !   2.0   9 ------- 10 ------- 11 ------- 12
  !         |         |          |          |
  !   1.5   |    4    |    5     |    6     |
  !         |         |          |          |
  !   1.0   5 ------- 6 -------- 7 -------- 8
  !         |         |          |          |
  !   0.5   |    1    |    2     |    3     |
  !         |         |          |          |
  !   0.0   1 ------- 2 -------- 3 -------- 4
  !            
  !        0.0  0.5  1.0  1.5   2.0  2.5   3.0
  !
  !               Node Ids at corners
  !              Element Ids in centers
  ! 
  !!!!! 
  ! 
  ! The owners for 1 PET are all Pet 0.
  ! The owners for 4 PETs are as follows:
  !
  !                   Mesh Owners
  !
  !   3.0   2 ------- 2 -------- 3 -------- 3
  !         |         |          |  3    /  |
  !         |    2    |    2     |     /    |
  !         |         |          |  /    3  |
  !   2.0   2 ------- 2 -------- 3 -------- 3
  !         |         |          |          |
  !         |    2    |    2     |    3     |
  !         |         |          |          |
  !   1.0   0 ------- 0 -------- 1 -------- 1
  !         |         |          |          |
  !         |    0    |    1     |    1     |
  !         |         |          |          |
  !   0.0   0 ------- 0 -------- 1 -------- 1
  !
  !        0.0       1.0        2.0        3.0
  !
  !               Node Owners at corners
  !              Element Owners in centers
  ! 

subroutine createTestMesh3x3Cart_T(mesh, rc)
  type(ESMF_Mesh), intent(out) :: mesh
  integer :: rc

  integer, pointer :: nodeIds(:),nodeOwners(:)
  real(ESMF_KIND_R8), pointer :: nodeCoords(:)
  real(ESMF_KIND_R8), pointer :: ownedNodeCoords(:)
  integer :: numNodes, numOwnedNodes, numOwnedNodesTst
   integer :: numElems,numOwnedElemsTst
  integer :: numElemConns, numTriElems, numQuadElems
  real(ESMF_KIND_R8), pointer :: elemCoords(:)
  integer, pointer :: elemIds(:),elemTypes(:),elemConn(:)
  integer, pointer :: elemMask(:)
  integer :: petCount, localPet
  type(ESMF_VM) :: vm


  ! get global VM
  call ESMF_VMGetGlobal(vm, rc=rc)
  if (rc /= ESMF_SUCCESS) return
  call ESMF_VMGet(vm, localPet=localPet, petCount=petCount, rc=rc)
  if (rc /= ESMF_SUCCESS) return

   ! return with an error if not 1 or 4 PETs
  if ((petCount /= 1) .and. (petCount /=4)) then
     rc=ESMF_FAILURE
     return
   endif


  ! Setup mesh info depending on the 
  ! number of PETs
  if (petCount .eq. 1) then

     ! Fill in node data
     numNodes=16

     !! node ids
     allocate(nodeIds(numNodes))
     nodeIds=(/1,2,3,4,5,6,7,8, &
                9,10,11,12,13,14,&
               15,16/) 
     
     !! node Coords
     allocate(nodeCoords(numNodes*2))
     nodeCoords=(/0.0,0.0, & ! 1
                 1.0,0.0, &  ! 2
                 2.0,0.0, &  ! 3
                 3.0,0.0, &  ! 4
                 0.0,1.0, &  ! 5
                 1.25,1.25, &  ! 6
                 1.75,1.25, &  ! 7
                 3.0,1.0, &  ! 8
                  0.0,2.0, &  ! 9
                 1.25,1.75, &  ! 10
                 1.75,1.75, &  ! 11
                 3.0,2.0, &  ! 12
                 0.0,3.0, &  ! 13
                  1.0,3.0, &  ! 14
                 2.0,3.0, &  ! 15
                 3.0,3.0 /)  ! 16
 

      !! node owners
      allocate(nodeOwners(numNodes))
      nodeOwners=0 ! everything on proc 0


      ! Fill in elem data
      numTriElems=2
      numQuadElems=8
       numElems=numTriElems+numQuadElems
      numElemConns=3*numTriElems+4*numQuadElems

      !! elem ids
      allocate(elemIds(numElems))
      elemIds=(/1,2,3,4,5,6,7,8,9,10/) 

      !! elem mask
      allocate(elemMask(numElems))
      elemMask=(/1,0,0,0,0,0,0,0,0,0/) 

      !! elem types
      allocate(elemTypes(numElems))
      elemTypes=(/ESMF_MESHELEMTYPE_QUAD, & ! 1
                  ESMF_MESHELEMTYPE_QUAD, & ! 2
                  ESMF_MESHELEMTYPE_QUAD, & ! 3
                  ESMF_MESHELEMTYPE_QUAD, & ! 4
                   ESMF_MESHELEMTYPE_QUAD, & ! 5
                  ESMF_MESHELEMTYPE_QUAD, & ! 6
                  ESMF_MESHELEMTYPE_QUAD, & ! 7
                  ESMF_MESHELEMTYPE_QUAD, & ! 8
                  ESMF_MESHELEMTYPE_TRI,  & ! 9
                   ESMF_MESHELEMTYPE_TRI/)   ! 10

      !! elem coords
      allocate(elemCoords(2*numElems))
      elemCoords=(/0.5,0.5, & ! 1
                   1.5,0.5, & ! 2
                   2.5,0.5, & ! 3
                   0.5,1.5, & ! 4
                   1.5,1.5, & ! 5
                   2.5,1.5, & ! 6
                   0.5,2.5, & ! 7
                   1.5,2.5, & ! 8
                   2.75,2.25,& ! 9
                    2.25,2.75/)  ! 10

      !! elem conn
      allocate(elemConn(numElemConns))
      elemConn=(/1,2,6,5,   & ! 1
                 2,3,7,6,   & ! 2
                 3,4,8,7,   & ! 3
                 5,6,10,9,  & ! 4
                 6,7,11,10, & ! 5
                 7,8,12,11, & ! 6
                 9,10,14,13, & ! 7
                 10,11,15,14, & ! 8
                 11,12,16, & ! 9
                  11,16,15/) ! 10

   else if (petCount .eq. 4) then
     ! Setup mesh data depending on PET
     if (localPet .eq. 0) then
 
     ! Fill in node data
     numNodes=4

     !! node ids
     allocate(nodeIds(numNodes))
     nodeIds=(/1,2,5,6/)
     
     !! node Coords
     allocate(nodeCoords(numNodes*2))
     nodeCoords=(/0.0,0.0, & ! 1
                 1.0,0.0, &  ! 2
                 0.0,1.0, &  ! 5
                  1.25,1.25 /)  ! 6 

      !! node owners
      allocate(nodeOwners(numNodes))
      nodeOwners=0 ! everything on proc 0

      ! Fill in elem data
      numTriElems=0
      numQuadElems=1
      numElems=numTriElems+numQuadElems
      numElemConns=3*numTriElems+4*numQuadElems

      !! elem ids
       allocate(elemIds(numElems))
      elemIds=(/1/) 

      !! elem mask
      allocate(elemMask(numElems))
      elemMask=(/1/) 

      !! elem types
      allocate(elemTypes(numElems))
       elemTypes=(/ESMF_MESHELEMTYPE_QUAD/) ! 1

      !! elem coords
      allocate(elemCoords(2*numElems))
      elemCoords=(/0.5,0.5/)  ! 1

      !! elem conn
      allocate(elemConn(numElemConns))
      elemConn=(/1,2,4,3/) ! 1

     else if (localPet .eq. 1) then

     ! Fill in node data
      numNodes=6

     !! node ids
     allocate(nodeIds(numNodes))
     nodeIds=(/2,3,4,6,7,8/)
     
     !! node Coords
     allocate(nodeCoords(numNodes*2))
     nodeCoords=(/1.0,0.0, &  ! 2
                  2.0,0.0, &  ! 3
                  3.0,0.0, &  ! 4
                  1.25,1.25, &  ! 6
                  1.75,1.25, &  ! 7
                   3.0,1.0 /)  ! 8

 

      !! node owners
       allocate(nodeOwners(numNodes))
      nodeOwners=(/0, & ! 2
                   1, & ! 3
                   1, & ! 4
                   0, & ! 6
                   1, & ! 7
                   1/)  ! 8

      ! Fill in elem data
      numTriElems=0
      numQuadElems=2
      numElems=numTriElems+numQuadElems
      numElemConns=3*numTriElems+4*numQuadElems
 
      !! elem ids
      allocate(elemIds(numElems))
      elemIds=(/2,3/)

      !! elem mask
      allocate(elemMask(numElems))
      elemMask=(/0,0/) 

      !! elem types
      allocate(elemTypes(numElems))
      elemTypes=(/ESMF_MESHELEMTYPE_QUAD, & ! 2
                  ESMF_MESHELEMTYPE_QUAD/)  ! 3

      !! elem coords
      allocate(elemCoords(2*numElems))
      elemCoords=(/1.5,0.5, & ! 2
                    2.5,0.5/)  ! 3


      !! elem conn
      allocate(elemConn(numElemConns))
       elemConn=(/1,2,5,4,   & ! 2
                 2,3,6,5/)    ! 3

     else if (localPet .eq. 2) then

     ! Fill in node data
     numNodes=9

     !! node ids
     allocate(nodeIds(numNodes))
     nodeIds=(/5,6,7,   &
               9,10,11, &
               13,14,15/)
 
     
     !! node Coords
     allocate(nodeCoords(numNodes*2))
     nodeCoords=(/0.0,1.0, &  ! 5
                  1.25,1.25, &  ! 6
                  1.75,1.25, &  ! 7
                  0.0,2.0, &  ! 9 
                  1.25,1.75, &  ! 10
                  1.75,1.75, &  ! 11
                  0.0,3.0, &  ! 13
                  1.0,3.0, &  ! 14
                  2.0,3.0/)  ! 15
  

      !! node owners
      allocate(nodeOwners(numNodes))
      nodeOwners=(/0, & ! 5
                    0, & ! 6
                   1, & ! 7
                   2, & ! 9
                   2, & ! 10
                   3, & ! 11
                   2, & ! 13
                   2, & ! 14
                   3/)  ! 15


      ! Fill in elem data
      numTriElems=0
      numQuadElems=4
       numElems=numTriElems+numQuadElems
      numElemConns=3*numTriElems+4*numQuadElems

      !! elem ids
      allocate(elemIds(numElems))
      elemIds=(/4,5,7,8/)

      !! elem mask
      allocate(elemMask(numElems))
      elemMask=(/0,0,0,0/) 

      !! elem types
      allocate(elemTypes(numElems))
      elemTypes=(/ESMF_MESHELEMTYPE_QUAD, & ! 4
                  ESMF_MESHELEMTYPE_QUAD, & ! 5
                  ESMF_MESHELEMTYPE_QUAD, & ! 7
                  ESMF_MESHELEMTYPE_QUAD/)  ! 8
 

      !! elem coords
      allocate(elemCoords(2*numElems))
      elemCoords=(/0.5,1.5, & ! 4
                    1.5,1.5, & ! 5
                   0.5,2.5, & ! 7
                   1.5,2.5/)  ! 8

      !! elem conn
      allocate(elemConn(numElemConns))
      elemConn=(/1,2,5,4,  & ! 4
                 2,3,6,5,  & ! 5
                 4,5,8,7,  & ! 7
                 5,6,9,8/)   ! 8
     else if (localPet .eq. 3) then

     ! Fill in node data
      numNodes=6

     !! node ids
     allocate(nodeIds(numNodes))
     nodeIds=(/7,8,11,12,15,16/)
     
     !! node Coords
     allocate(nodeCoords(numNodes*2))
     nodeCoords=(/1.75,1.25, &  ! 7
                  3.0,1.0, &  ! 8
                  1.75,1.75, &  ! 11
                  3.0,2.0, &  ! 12
                  2.0,3.0, &  ! 15
                   3.0,3.0 /)  ! 16
 

      !! node owners
      allocate(nodeOwners(numNodes))
       nodeOwners=(/1, & ! 7
                   1, & ! 8
                   3, & ! 11
                   3, & ! 12
                   3, & ! 15
                   3/)  ! 16

      ! Fill in elem data
      numTriElems=2
      numQuadElems=1
      numElems=numTriElems+numQuadElems
      numElemConns=3*numTriElems+4*numQuadElems

       !! elem ids
      allocate(elemIds(numElems))
      elemIds=(/6,9,10/)

      !! elem mask
      allocate(elemMask(numElems))
      elemMask=(/0,0,0/)  

      !! elem types
      allocate(elemTypes(numElems))
      elemTypes=(/ESMF_MESHELEMTYPE_QUAD, & ! 6
                  ESMF_MESHELEMTYPE_TRI,  & ! 9
                  ESMF_MESHELEMTYPE_TRI/)   ! 10

      !! elem coords
      allocate(elemCoords(2*numElems))
      elemCoords=(/2.5,1.5, & ! 6
                    2.75,2.25,& ! 9
                   2.25,2.75/)  ! 10

      !! elem conn
      allocate(elemConn(numElemConns))
       elemConn=(/1,2,4,3, & ! 6
                 3,4,6, & ! 9
                 3,6,5/) ! 10
     endif
   endif

   
   ! Create Mesh structure in 1 step
   mesh=ESMF_MeshCreate(parametricDim=2,spatialDim=2, &
        coordSys=ESMF_COORDSYS_CART, &
        nodeIds=nodeIds, nodeCoords=nodeCoords, &
        nodeOwners=nodeOwners, elementIds=elemIds,&
        elementTypes=elemTypes, elementConn=elemConn, &
         elementCoords=elemCoords, elementMask=elemMask,&
        rc=rc)
   if (rc /= ESMF_SUCCESS) return

   ! deallocate node data
   deallocate(nodeIds)
   deallocate(nodeCoords)
   deallocate(nodeOwners)
   
   ! deallocate elem data
   deallocate(elemIds)
   deallocate(elemMask)
   deallocate(elemTypes)
   deallocate(elemCoords)
   deallocate(elemConn)

end subroutine createTestMesh3x3Cart_T



  ! Test 2nd order regridding on Cartesian meshes  using an XGrid
  subroutine test_CartMeshToMesh_2nd(rc)
#undef ESMF_METHOD 
#define ESMF_METHOD "test_CartMeshToMesh_2nd"
    integer, intent(out)                :: rc
    logical :: itrp
    logical :: csrv
    integer :: localrc
  type(ESMF_Mesh) :: srcMesh
  type(ESMF_Mesh) :: dstMesh
  type(ESMF_XGrid) :: xgrid
  type(ESMF_Field) :: srcField
  type(ESMF_Field) :: dstField
  type(ESMF_Field) :: xdstField
  type(ESMF_Field) :: xField
  type(ESMF_Field) :: srcAreaField, dstAreaField
  type(ESMF_Field) :: srcFracField, dstFracField
  type(ESMF_RouteHandle) :: StoXrouteHandle
  type(ESMF_RouteHandle) :: XtoDrouteHandle
  type(ESMF_RouteHandle) :: routeHandle
  type(ESMF_ArraySpec) :: arrayspec
   type(ESMF_VM) :: vm
  real(ESMF_KIND_R8), pointer :: srcFarrayPtr(:), dstFarrayPtr(:), xdstFarrayPtr(:)
  real(ESMF_KIND_R8), pointer :: srcAreaPtr(:), dstAreaPtr(:)
 real(ESMF_KIND_R8), pointer :: srcFracPtr(:), dstFracPtr(:)
  integer :: clbnd(1),cubnd(1)
   integer :: i1,i2,i3
  real(ESMF_KIND_R8) :: x,y,z
  real(ESMF_KIND_R8) :: lat, lon, phi, theta
  real(ESMF_KIND_R8),parameter :: &
                    DEG2RAD = 3.141592653589793_ESMF_KIND_R8/180.0_ESMF_KIND_R8
  integer :: localPet, petCount
  real(ESMF_KIND_R8) :: srcmass(1), dstmass(1), srcmassg(1), dstmassg(1)
  real(ESMF_KIND_R8) :: maxerror(1), minerror(1), error
  real(ESMF_KIND_R8) :: maxerrorg(1), minerrorg(1), errorg
 
  real(ESMF_KIND_R8) :: errorTot, errorTotG, dstVal

  integer :: num_errorTot
  real(ESMF_KIND_R8) :: l_errorTot(1),g_errorTot(1)
  integer :: l_num_errorTot(1), g_num_errorTot(1)
   
  integer :: numOwnedElems
  real(ESMF_KIND_R8), pointer :: ownedElemCoords(:)

  ! result code
  integer :: finalrc

  ! Init to success
  rc=ESMF_SUCCESS
  itrp=.true.
  csrv=.true.

  ! get pet info
  call ESMF_VMGetGlobal(vm, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_VMGet(vm, petCount=petCount, localPet=localpet, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return
 

  ! If we don't have 1 or 2 PETS then exit unsuccessfully
  if ((petCount .ne. 1) .and. (petCount .ne. 2)) then
     rc=ESMF_FAILURE
     return
  endif


  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !!!!!!!!!!!!!!!! Setup Source !!!!!!!!!!!!!
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 
  ! Create Source Mesh
  call createTestMesh3x3Cart_1(srcMesh, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return
  
   
   ! Array spec for fields
  call ESMF_ArraySpecSet(arrayspec, 1, ESMF_TYPEKIND_R8, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! Create source field
  srcField = ESMF_FieldCreate(srcMesh, arrayspec, meshloc=ESMF_MESHLOC_ELEMENT, &
       name="source", rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! Create source area field
  srcAreaField = ESMF_FieldCreate(srcMesh, arrayspec, meshloc=ESMF_MESHLOC_ELEMENT, &
       name="source_area", rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! Create source frac field
  srcFracField = ESMF_FieldCreate(srcMesh, arrayspec, meshloc=ESMF_MESHLOC_ELEMENT, &
       name="source_frac", rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  ! Load test data into the source Field
  ! Should only be 1 localDE
  call ESMF_FieldGet(srcField, 0, srcFarrayPtr,  rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! Set interpolated function
  call ESMF_MeshGet(srcMesh, numOwnedElements=numOwnedElems, &
       rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

   ! Allocate space for coordinates
   allocate(ownedElemCoords(2*numOwnedElems))

    ! Set interpolated function
  call ESMF_MeshGet(srcMesh, ownedElemCoords=ownedElemCoords, &
       rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  ! loop through and set field
  do i1=1,numOwnedElems

      ! Get coords
     x=ownedElemCoords(2*i1-1)
     y=ownedElemCoords(2*i1)

     ! Set analytic field
     srcFarrayPtr(i1) = x+y+2.0

  enddo

   ! Deallocate space for coordinates
   deallocate(ownedElemCoords)


  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !!!!!!!!!!! Setup Destination !!!!!!!!!!!!!
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  ! Create Destination Mesh
  call createTestMesh3x3Cart_2(dstMesh, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  ! Array spec
  call ESMF_ArraySpecSet(arrayspec, 1, ESMF_TYPEKIND_R8, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return
   
   ! Create dest. field
   dstField = ESMF_FieldCreate(dstMesh, arrayspec, meshloc=ESMF_MESHLOC_ELEMENT, &
         name="dest", rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return
   
   ! Create dest. area field
   dstAreaField = ESMF_FieldCreate(dstMesh, arrayspec, meshloc=ESMF_MESHLOC_ELEMENT, &
        name="dest_area", rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

   ! Create dest. frac field
   dstFracField = ESMF_FieldCreate(dstMesh, arrayspec, meshloc=ESMF_MESHLOC_ELEMENT, &
        name="dest_frac", rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

   ! Create exact dest. field
   xdstField = ESMF_FieldCreate(dstMesh, arrayspec, meshloc=ESMF_MESHLOC_ELEMENT, &
        name="xdest", rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


   ! Init destination field to 0.0
   ! Should only be 1 localDE
   call ESMF_FieldGet(dstField, 0, dstFarrayPtr,  rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

   
   ! Init exact destination field
   ! Should only be 1 localDE
   call ESMF_FieldGet(xdstField, 0, xdstFarrayPtr,  rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  ! Set number of points in destination mesh
  call ESMF_MeshGet(dstMesh, numOwnedElements=numOwnedElems, &
       rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

   ! Allocate space for coordinates
   allocate(ownedElemCoords(2*numOwnedElems))

   ! Set exact destination field
   call ESMF_MeshGet(dstMesh, ownedElemCoords=ownedElemCoords, &
       rc=localrc)
   if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

   ! loop through and set xfield
   do i1=1,numOwnedElems

      ! Get coords
      x=ownedElemCoords(2*i1-1)
      y=ownedElemCoords(2*i1)

      ! Set exact analytic Field
      xdstFarrayPtr(i1) = x+y+2.0

      ! Init destination Field
      dstFarrayPtr(i1)=0.0
   enddo

   ! Deallocate space for coordinates
   deallocate(ownedElemCoords)


#if 0
   call ESMF_MeshWrite(srcMesh,"srcMesh")
   call ESMF_MeshWrite(dstMesh,"dstMesh")
#endif


#define USE_XGRID
#ifdef USE_XGRID

!write(*,*) "Using XGrid"


   ! Create XGrid
   xgrid = ESMF_XGridCreate(sideAMesh=(/srcMesh/), &
        sideBMesh=(/dstMesh/), &
        storeOverlay = .true., &
        rc=localrc)
   if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

   ! Field on XGrid
   xField = ESMF_FieldCreate(xgrid, arrayspec, &
        name="xfield", rc=localrc)
   if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return


  ! Regrid store
  call ESMF_FieldRegridStore( &
          xgrid, &
          srcField, &
          dstField=xField, &
          routeHandle=StoXrouteHandle, &
          regridmethod=ESMF_REGRIDMETHOD_CONSERVE_2ND, &
          srcFracField=srcFracField, &
          rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_FieldRegridStore( &
          xgrid, &
          xField, &
          dstField=dstField, &
          routeHandle=XToDrouteHandle, &
          regridmethod=ESMF_REGRIDMETHOD_CONSERVE_2ND, &
          dstFracField=dstFracField, &
          rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! Do regrid
  call ESMF_FieldRegrid(srcField, xField, StoXrouteHandle, &
       rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_FieldRegrid(xField, dstField, XToDrouteHandle, &
       rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! Write fields
  write(filename, fmt='(a,i1,a)') 'xField', petCount, '.nc'
  call ESMF_FieldWrite(xField, trim(filename), &
       overwrite=.true., rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  write(filename, fmt='(a,i1,a)') 'dstField', petCount, '.nc'
  call ESMF_FieldWrite(dstField, trim(filename), &
       overwrite=.true., rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! Release routehandles
  call ESMF_FieldRegridrelease(StoXrouteHandle, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_FieldRegridRelease(XtoDrouteHandle, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

#else

!write(*,*) "NOT Using XGrid"

  !!! Regrid forward from the A grid to the B grid
  ! Regrid store
  call ESMF_FieldRegridStore( &
          srcField, &
          dstField=dstField, &
          routeHandle=routeHandle, &
          regridmethod=ESMF_REGRIDMETHOD_CONSERVE_2ND, &
          dstFracField=dstFracField, &
          srcFracField=srcFracField, &
          unmappedaction=ESMF_UNMAPPEDACTION_IGNORE, &
          rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  ! Do regrid
  call ESMF_FieldRegrid(srcField, dstField, routeHandle, &
       rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  call ESMF_FieldRegridRelease(routeHandle, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return
#endif



  ! Get the integration weights
  call ESMF_FieldRegridGetArea(srcAreaField, &
          rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! Get the integration weights
  call ESMF_FieldRegridGetArea(dstAreaField, &
          rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  ! Check if the values are close
  minerror(1) = 100000.
  maxerror(1) = 0.
  error = 0.
  errorTot=0.0
  num_errorTot=0
  dstmass = 0.

  ! get dst Field
  call ESMF_FieldGet(dstField, 0, dstFarrayPtr, computationalLBound=clbnd, &
                             computationalUBound=cubnd,  rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! get exact destination Field
  call ESMF_FieldGet(xdstField, 0, xdstFarrayPtr,  rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  ! get dst area Field
  call ESMF_FieldGet(dstAreaField, 0, dstAreaPtr,  rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! get frac Field
  call ESMF_FieldGet(dstFracField, 0, dstFracptr,  rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! destination grid
  !! check relative error
  do i1=clbnd(1),cubnd(1)

     ! This is WRONG, shouldn't include Frac
     ! dstmass = dstmass + dstFracptr(i1,i2)*dstAreaptr(i1)*fptr(i1)
     
     ! Instead do this
     dstmass = dstmass + dstAreaptr(i1)*dstFarrayPtr(i1)

     ! If this destination cell isn't covered by a sig. amount of source, then don't compute error on it.
     if (dstFracPtr(i1) .lt. 0.1) cycle

     ! write(*,*) i1,"::",dstFarrayPtr(i1),xdstFarrayPtr(i1)

     ! Since fraction isn't included in weights in this case, use it to modify dstField value, so 
     ! that it's correct for partial cells
     if (dstFracPtr(i1) .ne. 0.0) then
        dstVal=dstFarrayPtr(i1)/dstFracptr(i1)
     else 
        dstVal=dstFarrayPtr(i1)
     endif

     if (xdstFarrayPtr(i1) .ne. 0.0) then
        error=ABS(dstVal - xdstFarrayPtr(i1))/ABS(xdstFarrayPtr(i1))
     else
        error=ABS(dstVal - xdstFarrayPtr(i1))
     endif

     ! total error 
     errorTot=errorTot+error
     num_errorTot=num_errorTot+1           

     ! min max error
     if (error > maxerror(1)) then
        maxerror(1) = error
     endif
     if (error < minerror(1)) then
        minerror(1) = error
     endif

  enddo

  srcmass(1) = 0.

  ! get src pointer
  call ESMF_FieldGet(srcField, 0, srcFarrayPtr, computationalLBound=clbnd, &
       computationalUBound=cubnd,  rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

     ! get src Field
  call ESMF_FieldGet(srcAreaField, 0, srcAreaptr,  rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! get frac Field
  call ESMF_FieldGet(srcFracField, 0, srcFracptr,  rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  do i1=clbnd(1),cubnd(1)
     srcmass(1) = srcmass(1) + srcFracptr(i1)*srcAreaptr(i1)*srcFarrayPtr(i1)
  enddo

  ! Init integrals
  srcmassg(1) = 0.
  dstmassg(1) = 0.
  
  call ESMF_VMAllReduce(vm, srcmass, srcmassg, 1, ESMF_REDUCE_SUM, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_VMAllReduce(vm, dstmass, dstmassg, 1, ESMF_REDUCE_SUM, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_VMAllReduce(vm, maxerror, maxerrorg, 1, ESMF_REDUCE_MAX, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_VMAllReduce(vm, minerror, minerrorg, 1, ESMF_REDUCE_MIN, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return
  
  l_errorTot(1)=errorTot
  call ESMF_VMAllReduce(vm, l_errorTot, g_errorTot, 1, ESMF_REDUCE_SUM, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  l_num_errorTot(1)=num_errorTot
  call ESMF_VMAllReduce(vm, l_num_errorTot, g_num_errorTot, 1, ESMF_REDUCE_SUM, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! return answer based on correct flags
  csrv = .false.
  if (ABS(dstmassg(1)-srcmassg(1))/srcmassg(1) < 1.0E-14)  csrv = .true.

  itrp = .false.
  if (maxerrorg(1) < 6.0E-2) itrp = .true.

  ! Uncomment these calls to see some actual regrid results
  if (localPet == 0) then
    write(*,*) 
    write(*,*) "=== Second Order Conservative between Cartesian Meshes via XGrid ==="
    write(*,*) "Conservation:"
    write(*,*) "Rel Error = ", ABS(dstmassg(1)-srcmassg(1))/srcmassg(1)
    write(*,*) "SRC mass = ", srcmassg(1)
    write(*,*) "DST mass = ", dstmassg(1)
    write(*,*) " "
    write(*,*) "Interpolation:"
    write(*,*) "Max Error = ", maxerrorg(1)
    write(*,*) "Min Error = ", minerrorg(1)
    write(*,*) "Avg Error = ", g_errorTot(1)/g_num_errorTot(1)
    write(*,*) " "
  endif


  ! Destroy the Fields
  call ESMF_FieldDestroy(srcField, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_FieldDestroy(dstField, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_FieldDestroy(srcAreaField, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_FieldDestroy(dstAreaField, rc=localrc)
   if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
   
   call ESMF_FieldDestroy(srcFracField, rc=localrc)
   if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

   call ESMF_FieldDestroy(dstFracField, rc=localrc)
   if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
   

   call ESMF_FieldDestroy(xdstField, rc=localrc)
   if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

  ! Free the meshes
  call ESMF_MeshDestroy(srcMesh, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_MeshDestroy(dstMesh, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! If either interpolation or conservation errors
  ! are too large, then return failure
  if (.not. itrp .or. .not. csrv) then
     rc=ESMF_FAILURE
  endif

  end subroutine test_CartMeshToMesh_2nd



  

 function calc_lat(i,imax,dy)
   integer :: i, imax
   real(ESMF_KIND_R8) :: calc_lat
   real(ESMF_KIND_R8) :: dy

        if (i .eq. 1) then
           calc_lat = -90.0
        else if (i .eq. imax) then
           calc_lat = 90.0
        else 
           calc_lat = REAL(i-1)*dy - 0.5*dy - 90.0
        endif
 end function calc_lat


 subroutine test_CSGridToGrid_2nd(rc)
#undef ESMF_METHOD 
#define ESMF_METHOD "test_CSGridToGrid_2nd"
        integer, intent(out)  :: rc
  logical :: itrp
  logical :: csrv
  integer :: localrc
  type(ESMF_Grid) :: srcGrid
  type(ESMF_Grid) :: dstGrid
  type(ESMF_Mesh) :: xgridMesh
  type(ESMF_XGrid) :: xgrid
  type(ESMF_Field) :: srcField
  type(ESMF_Field) :: dstField
  type(ESMF_Field) :: xdstField
  type(ESMF_Field) :: errorField
  type(ESMF_Field) :: xField
  type(ESMF_Field) :: srcArea, dstArea
  type(ESMF_Array) :: dstArray
  type(ESMF_Array) :: xdstArray
  type(ESMF_Array) :: errorArray
  type(ESMF_Array) :: srcArray
  type(ESMF_Array) :: srcAreaArray, dstAreaArray
  type(ESMF_RouteHandle) :: StoXrouteHandle
  type(ESMF_RouteHandle) :: XtoDrouteHandle
  type(ESMF_RouteHandle) :: routeHandle
  type(ESMF_ArraySpec) :: arrayspec
  type(ESMF_VM) :: vm
  real(ESMF_KIND_R8), pointer :: farrayPtrXC(:,:)
  real(ESMF_KIND_R8), pointer :: farrayPtrYC(:,:)
  real(ESMF_KIND_R8), pointer :: farrayPtr(:,:),xfarrayPtr(:,:),errorfarrayPtr(:,:),iwtsptr(:,:)
  real(ESMF_KIND_R8), pointer :: srcAreaptr(:,:), dstAreaptr(:,:)
  integer :: petMap2D(2,2,1)
  integer :: clbnd(2),cubnd(2)
  integer :: fclbnd(2),fcubnd(2)
  integer :: i1,i2, index(2)
  integer :: lDE, i
  integer ::  srclocalDECount, dstlocalDECount

  integer :: src_tile_size
  integer :: Src_nx, Src_ny
  integer :: Dst_nx, Dst_ny
  real(ESMF_KIND_R8) :: Src_dx, Src_dy, yp1
  real(ESMF_KIND_R8) :: Dst_dx, Dst_dy
   real(ESMF_KIND_R8) :: ctheta, stheta
  real(ESMF_KIND_R8) :: theta, d2rad, x, y, z
  real(ESMF_KIND_R8) :: DEG2RAD, a, lat, lon, phi
  real(ESMF_KIND_R8) :: xtmp, ytmp, ztmp
  real(ESMF_KIND_R8) :: srcmass(1), dstmass(1), srcmassg(1), dstmassg(1)
  real(ESMF_KIND_R8) :: maxerror(1), minerror(1), error
  real(ESMF_KIND_R8) :: maxerrorg(1), minerrorg(1), errorg
  integer :: localPet, petCount
  
  ! init success flag
  rc=ESMF_SUCCESS

  ! get pet info
  call ESMF_VMGetGlobal(vm, rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_VMGet(vm, petCount=petCount, localPet=localpet, rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return

        
  ! Establish the resolution of the grids
  src_tile_size=20

  Dst_nx = 100
  Dst_ny = 80

  Dst_dx = 360.0/Dst_nx
  Dst_dy = 180.0/Dst_ny

  ! degree to rad conversion
  DEG2RAD = 3.141592653589793_ESMF_KIND_R8/180.0_ESMF_KIND_R8

  ! setup source cubed sphere grid
  srcGrid=ESMF_GridCreateCubedSphere(tileSize=src_tile_size, &
       staggerLocList=(/ESMF_STAGGERLOC_CENTER, ESMF_STAGGERLOC_CORNER/), &
       rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! setup dest. grid
  dstGrid=ESMF_GridCreate1PeriDim(minIndex=(/1,1/),maxIndex=(/dst_nx,dst_ny/),regDecomp=(/1,petCount/), &
                              coordSys=ESMF_COORDSYS_SPH_DEG, &
                              indexflag=ESMF_INDEX_GLOBAL, &
                              rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  ! Create source/destination fields
  call ESMF_ArraySpecSet(arrayspec, 2, ESMF_TYPEKIND_R8, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

   srcField = ESMF_FieldCreate(srcGrid, arrayspec, &
                         staggerloc=ESMF_STAGGERLOC_CENTER, name="source", rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


   srcArea = ESMF_FieldCreate(srcGrid, arrayspec, &
                         staggerloc=ESMF_STAGGERLOC_CENTER, name="source", rc=localrc)
   if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

   errorField = ESMF_FieldCreate(dstGrid, arrayspec, &
                         staggerloc=ESMF_STAGGERLOC_CENTER, name="dest", rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


   dstField = ESMF_FieldCreate(dstGrid, arrayspec, &
                         staggerloc=ESMF_STAGGERLOC_CENTER, name="dest", rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


   xdstField = ESMF_FieldCreate(dstGrid, arrayspec, &
                         staggerloc=ESMF_STAGGERLOC_CENTER, name="dest", rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


   dstArea = ESMF_FieldCreate(dstGrid, arrayspec, &
                         staggerloc=ESMF_STAGGERLOC_CENTER, name="dest", rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  ! Allocate coordinates
  call ESMF_GridAddCoord(dstGrid, staggerloc=ESMF_STAGGERLOC_CENTER, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  call ESMF_GridAddCoord(dstGrid, staggerloc=ESMF_STAGGERLOC_CORNER, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  ! Get number of local DEs
  call ESMF_GridGet(srcGrid, localDECount=srcLocalDECount, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_GridGet(dstGrid, localDECount=dstLocalDECount, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  ! Get arrays
  ! dstArray
  call ESMF_FieldGet(dstField, array=dstArray, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! srcArray
  call ESMF_FieldGet(srcField, array=srcArray, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! xdstArray
  call ESMF_FieldGet(xdstField, array=xdstArray, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! errorArray
  call ESMF_FieldGet(errorField, array=errorArray, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  ! area Array
  call ESMF_FieldGet(srcArea, array=srcAreaArray, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  ! area Array
  call ESMF_FieldGet(dstArea, array=dstAreaArray, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  ! Source Grid
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  ! Construct analytic field
  do lDE=0,srcLocalDECount-1
 
     !! get coord 1
     call ESMF_GridGetCoord(srcGrid, localDE=lDE, staggerLoc=ESMF_STAGGERLOC_CENTER, coordDim=1, &
                            computationalLBound=clbnd, computationalUBound=cubnd, farrayPtr=farrayPtrXC, rc=localrc)
     if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return


     call ESMF_GridGetCoord(srcGrid, localDE=lDE, staggerLoc=ESMF_STAGGERLOC_CENTER, coordDim=2, &
                            computationalLBound=clbnd, computationalUBound=cubnd, farrayPtr=farrayPtrYC, rc=localrc)
     if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return


     ! get src pointer
     call ESMF_FieldGet(srcField, lDE, farrayPtr,  rc=localrc)
     if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return


     !! set coords, interpolated function
     do i1=clbnd(1),cubnd(1)
     do i2=clbnd(2),cubnd(2)

        ! Get src coordinates
        lon = farrayPtrXC(i1,i2)
        lat = farrayPtrYC(i1,i2)
     
       ! Set the source to be a function of the x,y,z coordinate
        theta = DEG2RAD*(lon)
        phi = DEG2RAD*(90.-lat)

        x = cos(theta)*sin(phi)
        y = sin(theta)*sin(phi)
        z = cos(phi)

        ! set src data
        !farrayPtr(i1,i2) = x+y+z+15.0
        !farrayPtr(i1,i2) = z+15.0

        ! set src data
        !farrayPtr(i1,i2) = 1.
        farrayPtr(i1,i2) = 2. + cos(theta)**2.*cos(2.*phi)*sin(phi)

     enddo
     enddo

  enddo    ! lDE



  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  ! Destination grid
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  ! Get memory and set coords for dst
  do lDE=0,dstLocalDECount-1
 
     !! get coords
     call ESMF_GridGetCoord(dstGrid, localDE=lDE, staggerLoc=ESMF_STAGGERLOC_CORNER, coordDim=1, &
                            computationalLBound=clbnd, computationalUBound=cubnd, farrayPtr=farrayPtrXC, rc=localrc)
     if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return

     call ESMF_GridGetCoord(dstGrid, localDE=lDE, staggerLoc=ESMF_STAGGERLOC_CORNER, coordDim=2, &
                            computationalLBound=clbnd, computationalUBound=cubnd, farrayPtr=farrayPtrYC, rc=localrc)
     if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return

     !! set coords
     do i1=clbnd(1),cubnd(1)
     do i2=clbnd(2),cubnd(2)

        ! Set dest coordinates
        farrayPtrXC(i1,i2) = REAL(i1-1)*Dst_dx + 0.5*Dst_dx
        farrayPtrYC(i1,i2) = calc_lat(i2,dst_ny+1,dst_dy)

     enddo
     enddo


    !! DO CENTER STAGGER STUFF
 
     !! get coord 1
     call ESMF_GridGetCoord(dstGrid, localDE=lDE, staggerLoc=ESMF_STAGGERLOC_CENTER, coordDim=1, &
                            computationalLBound=clbnd, computationalUBound=cubnd, farrayPtr=farrayPtrXC, rc=localrc)
     if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return

     !! get coord 2
     call ESMF_GridGetCoord(dstGrid, localDE=lDE, staggerLoc=ESMF_STAGGERLOC_CENTER, coordDim=2, &
                            computationalLBound=clbnd, computationalUBound=cubnd, farrayPtr=farrayPtrYC, rc=localrc)
     if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return


     ! get dst pointer
     call ESMF_FieldGet(dstField, lDE, farrayPtr, computationalLBound=fclbnd, &
                             computationalUBound=fcubnd,  rc=localrc)
     if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return


     ! get exact pointer
     call ESMF_FieldGet(xdstField, lDE, xfarrayPtr, rc=localrc)
     if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return


     !! set coords, interpolated function
     do i1=clbnd(1),cubnd(1)
     do i2=clbnd(2),cubnd(2)

        y= calc_lat(i2,dst_ny+1,dst_dy)
        yp1= calc_lat(i2+1,dst_ny+1,dst_dy)

        ! Set source coordinates
!        farrayPtrXC(i1,i2) = REAL(i1-1)*Dst_dx + 0.5*Dst_dx
        farrayPtrXC(i1,i2) = REAL(i1-1)*Dst_dx + 1.0*Dst_dx
        farrayPtrYC(i1,i2) = (y+yp1)/2.0

        ! init dst data
        farrayPtr(i1,i2) = 0.0

        ! init exact answer
        lon = farrayPtrXC(i1,i2)
        lat = farrayPtrYC(i1,i2)
     
       ! Set the source to be a function of the x,y,z coordinate
        theta = DEG2RAD*(lon)
        phi = DEG2RAD*(90.-lat)

        x = cos(theta)*sin(phi)
        y = sin(theta)*sin(phi)
        z = cos(phi)

        ! set exact dst data
        !xfarrayPtr(i1,i2) = x+y+z+15.0
        !xfarrayPtr(i1,i2) = z+15.0

        ! set exact dst data
        !xfarrayPtr(i1,i2) = 2. + cos(theta)**2.*cos(2.*phi)
        xfarrayPtr(i1,i2) = 2. + cos(theta)**2.*cos(2.*phi)*sin(phi)

     enddo
     enddo


  enddo    ! lDE


#if 0
  call ESMF_GridWriteVTK(srcGrid,staggerloc=ESMF_STAGGERLOC_CORNER, &
        filename="srcGridCnr", &
       rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_GridWriteVTK(dstGrid,staggerloc=ESMF_STAGGERLOC_CORNER, &
        filename="dstGridCnr", &
       rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
#endif

#define USE_XGRID_CSGRID
#ifdef USE_XGRID_CSGRID

!write(*,*) "Using XGrid"

   ! Create XGrid
   xgrid = ESMF_XGridCreate(sideAGrid=(/srcGrid/), &
        sideBGrid=(/dstGrid/), &
        storeOverlay = .true., &
        rc=localrc)
   if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
   
   ! Field on XGrid
   xField = ESMF_FieldCreate(xgrid, ESMF_TYPEKIND_R8, &
        name="xfield", rc=localrc)
   if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

#if 0
   call ESMF_XGridGet(xgrid, mesh=xgridMesh, rc=localrc)
   if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

   call ESMF_MeshWrite(xgridMesh,"xgridMesh")
#endif   

  ! Regrid store
  call ESMF_FieldRegridStore( &
          xgrid, &
          srcField, &
          dstField=xField, &
          routeHandle=StoXrouteHandle, &
          regridmethod=ESMF_REGRIDMETHOD_CONSERVE_2ND, &
          rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_FieldRegridStore( &
          xgrid, &
          xField, &
          dstField=dstField, &
          routeHandle=XToDrouteHandle, &
          regridmethod=ESMF_REGRIDMETHOD_CONSERVE_2ND, &
          rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! Do regrid
  call ESMF_FieldRegrid(srcField, xField, StoXrouteHandle, &
       rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_FieldRegrid(xField, dstField, XToDrouteHandle, &
       rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! Release routehandles
  call ESMF_FieldRegridrelease(StoXrouteHandle, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_FieldRegridRelease(XtoDrouteHandle, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

#else
!  write(*,*) "NOT Using XGrid"

  ! Do regrid store to create routehandle
  call ESMF_FieldRegridStore(srcField, &
          dstField=dstField, &
          routeHandle=routeHandle, &
          regridmethod=ESMF_REGRIDMETHOD_CONSERVE_2ND, &
          unmappedaction=ESMF_UNMAPPEDACTION_IGNORE, &
          rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! Do regrid
  call ESMF_FieldRegrid(srcField, dstField, routeHandle, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! Free routehandle
  call ESMF_FieldRegridRelease(routeHandle, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return
#endif


  ! Get the integration weights
  call ESMF_FieldRegridGetArea(srcArea, &
          rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  ! Get the integration weights
  call ESMF_FieldRegridGetArea(dstArea, &
          rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  ! Check if the values are close
  minerror(1) = 100000.
  maxerror(1) = 0.
  error = 0.
  dstmass = 0.
  do lDE=0, dstLocalDECount-1

     call ESMF_GridGetCoord(dstGrid, localDE=lDE, staggerLoc=ESMF_STAGGERLOC_CENTER, coordDim=2, &
                            computationalLBound=clbnd, computationalUBound=cubnd, farrayPtr=farrayPtrYC, rc=localrc)
     if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return


     ! get src Field
     call ESMF_FieldGet(dstField, lDE, farrayPtr, computationalLBound=clbnd, &
                             computationalUBound=cubnd,  rc=localrc)
     if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return


     ! get src destination Field
     call ESMF_FieldGet(xdstField, lDE, xfarrayPtr,  rc=localrc)
     if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return


     ! get src Field
     call ESMF_FieldGet(errorField, lDE, errorfarrayPtr,  rc=localrc)
     if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return


     ! get src Field
     call ESMF_FieldGet(dstArea, lDE, dstAreaptr,  rc=localrc)
     if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return


     ! destination grid
     !! check relative error
     do i1=clbnd(1),cubnd(1)
     do i2=clbnd(2),cubnd(2)

        dstmass = dstmass + dstAreaptr(i1,i2)*farrayPtr(i1,i2)

        if (xfarrayPtr(i1,i2) .ne. 0.0) then
           errorfarrayPtr(i1,i2)=ABS(farrayPtr(i1,i2) - xfarrayPtr(i1,i2))/ABS(xfarrayPtr(i1,i2))
           error = error + errorfarrayPtr(i1,i2)
           if (errorfarrayPtr(i1,i2) > maxerror(1)) then
             maxerror(1) = errorfarrayPtr(i1,i2)
           endif
           if (errorfarrayPtr(i1,i2) < minerror(1)) then
             minerror(1) = errorfarrayPtr(i1,i2)
           endif
        else
           errorfarrayPtr(i1,i2)=ABS(farrayPtr(i1,i2) - xfarrayPtr(i1,i2))
           error = error + errorfarrayPtr(i1,i2)
           if (errorfarrayPtr(i1,i2) > maxerror(1)) then
             maxerror(1) = errorfarrayPtr(i1,i2)
           endif
           if (errorfarrayPtr(i1,i2) < minerror(1)) then
             minerror(1) = errorfarrayPtr(i1,i2)
           endif
        endif

     enddo
     enddo

  enddo    ! lDE

  ! Compute src mask
  srcmass(1) = 0.
  do lDE=0, srclocalDECount-1

     ! get src pointer
     call ESMF_FieldGet(srcField, lDE, farrayPtr, computationalLBound=clbnd, &
                             computationalUBound=cubnd,  rc=localrc)
     if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return

     ! get src Field
     call ESMF_FieldGet(srcArea, lDE, srcAreaptr,  rc=localrc)
     if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return


     do i1=clbnd(1),cubnd(1)
     do i2=clbnd(2),cubnd(2)
        srcmass(1) = srcmass(1) + srcAreaptr(i1,i2)*farrayPtr(i1,i2)
     enddo
     enddo

  enddo    ! lDE

  srcmassg(1) = 0.
  dstmassg(1) = 0.
  
  call ESMF_VMAllReduce(vm, srcmass, srcmassg, 1, ESMF_REDUCE_SUM, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_VMAllReduce(vm, dstmass, dstmassg, 1, ESMF_REDUCE_SUM, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_VMAllReduce(vm, maxerror, maxerrorg, 1, ESMF_REDUCE_MAX, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_VMAllReduce(vm, minerror, minerrorg, 1, ESMF_REDUCE_MIN, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! return answer based on correct flags
  csrv = .false.
  if (ABS(dstmassg(1)-srcmassg(1))/srcmassg(1) < 1.0E-14) csrv = .true.

  itrp = .false.
  if (maxerrorg(1) < 1.2E-2) itrp = .true.

  ! Uncomment these calls to see some actual regrid results
  if (localPet == 0) then
     write(*,*) 
     write(*,*) "=== Second Order with Cubed Sphere Grid via XGrid ==="
     write(*,*) "Conservation:"
     write(*,*) "Rel Error = ", ABS(dstmassg(1)-srcmassg(1))/srcmassg(1)
     write(*,*) "SRC mass = ", srcmassg(1)
     write(*,*) "DST mass = ", dstmassg(1)
     write(*,*) " "
     write(*,*) "Interpolation:"
     write(*,*) "Max Error = ", maxerrorg(1)
     write(*,*) "Min Error = ", minerrorg(1)
     write(*,*) " "
  endif

#if 0
  call ESMF_GridWriteVTK(srcGrid,staggerloc=ESMF_STAGGERLOC_CENTER, &
        filename="srcGrid", array1=srcArray,  &
       rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_GridWriteVTK(srcGrid,staggerloc=ESMF_STAGGERLOC_CORNER, &
        filename="srcGridCnr", &
       rc=localrc)
  if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_GridWriteVTK(dstGrid,staggerloc=ESMF_STAGGERLOC_CENTER, &
        filename="dstGrid", array1=dstArray, array2=errorArray, &
       rc=localrc)
  if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_GridWriteVTK(dstGrid,staggerloc=ESMF_STAGGERLOC_CORNER, &
        filename="dstGridCnr", &
       rc=localrc)
  if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
#endif


  ! Destroy the Fields
   call ESMF_FieldDestroy(srcField, rc=localrc)
   if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return


   call ESMF_FieldDestroy(srcArea, rc=localrc)
   if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return


   call ESMF_FieldDestroy(errorField, rc=localrc)
   if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

   call ESMF_FieldDestroy(dstField, rc=localrc)
   if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

   call ESMF_FieldDestroy(xdstField, rc=localrc)
   if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

   call ESMF_FieldDestroy(dstArea, rc=localrc)
   if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return


  ! Free the grids
  call ESMF_GridDestroy(srcGrid, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_GridDestroy(dstGrid, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  ! If either interpolation or conservation errors
  ! are too large, then return failure
  if (.not. itrp .or. .not. csrv) then
     rc=ESMF_FAILURE
  endif

end subroutine test_CSGridToGrid_2nd



  !------------------------------------------------------------------------
  ! Utility methods
  !------------------------------------------------------------------------

  function make_grid(atm_nx, atm_ny, atm_dx, atm_dy, atm_sx, atm_sy, field, rc)

    ! return value
    type(ESMF_Grid)                           :: make_grid
    ! arguments
    integer, intent(in)                       :: atm_nx, atm_ny
    real(ESMF_KIND_R4), intent(in)            :: atm_dx, atm_dy
    real(ESMF_KIND_R4), intent(in)            :: atm_sx, atm_sy
    type(ESMF_Field), intent(out), optional   :: field
    integer, intent(out), optional            :: rc

    ! local variables
    integer                                   :: localrc, i, j
    real(ESMF_KIND_R8), pointer               :: coordX(:), coordY(:)
    real(ESMF_KIND_R8)                        :: startx, starty

    make_grid = ESMF_GridCreateNoPeriDim(maxIndex=(/atm_nx, atm_ny/), &
      coordSys=ESMF_COORDSYS_CART, &
      indexflag=ESMF_INDEX_GLOBAL, &
      coordDep1=(/1/), &
      coordDep2=(/2/), &
      rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

    call ESMF_GridAddCoord(make_grid, staggerloc=ESMF_STAGGERLOC_CENTER, &
        rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_GridAddCoord(make_grid, staggerloc=ESMF_STAGGERLOC_CORNER, &
        rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

    ! global indexing
    ! atm grid is not decomposed in the y direction
    !startx = lpet*atm_nx/npet*atm_dx
    startx = atm_sx
    starty = atm_sy
    ! compute coord
    ! X center
    !call ESMF_GridGetCoord(make_grid, localDE=0, staggerLoc=ESMF_STAGGERLOC_CENTER, &
    !    coordDim=1, farrayPtr=coordX, rc=localrc)
    !if (ESMF_LogFoundError(localrc, &
    !    ESMF_ERR_PASSTHRU, &
    !    ESMF_CONTEXT, rcToReturn=rc)) return
    !do i = lbound(coordX,1), ubound(coordX,1)
    !  coordX(i) = startx + atm_dx/2. + (i-1)*atm_dx
    !enddo
    !print *, 'coordX: ', coordX
    ! X corner
    call ESMF_GridGetCoord(make_grid, localDE=0, staggerLoc=ESMF_STAGGERLOC_CORNER, &
        coordDim=1, farrayPtr=coordX, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    do i = lbound(coordX,1), ubound(coordX,1)
      coordX(i) = startx + (i-1)*atm_dx
    enddo
    !print *, 'startx: ', startx, lbound(coordX, 1), 'coordX: ', coordX
    ! Y center
    !call ESMF_GridGetCoord(make_grid, localDE=0, staggerLoc=ESMF_STAGGERLOC_CENTER, &
    !    coordDim=2, farrayPtr=coordY, rc=localrc)
    !if (ESMF_LogFoundError(localrc, &
    !    ESMF_ERR_PASSTHRU, &
    !    ESMF_CONTEXT, rcToReturn=rc)) return
    !do i = lbound(coordY,1), ubound(coordY,1)
    !  coordY(i) = starty + atm_dy/2. + (i-1)*atm_dy
    !enddo
    ! Y corner
    call ESMF_GridGetCoord(make_grid, localDE=0, staggerLoc=ESMF_STAGGERLOC_CORNER, &
        coordDim=2, farrayPtr=coordY, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    do i = lbound(coordY,1), ubound(coordY,1)
      coordY(i) = starty + (i-1)*atm_dy
    enddo

    if(present(field)) then
      field = ESMF_FieldCreate(make_grid, typekind=ESMF_TYPEKIND_R8, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
    endif
  
    if(present(rc)) rc = ESMF_SUCCESS

  end function make_grid

  function make_grid_sph(atm_nx, atm_ny, atm_dx, atm_dy, atm_sx, atm_sy, area_adj, tag, scheme, rc)

    ! return value
    type(ESMF_Grid)                           :: make_grid_sph
    ! arguments
    integer, intent(in)                       :: atm_nx, atm_ny
    real(ESMF_KIND_R4), intent(in)            :: atm_dx, atm_dy
    real(ESMF_KIND_R4), intent(in)            :: atm_sx, atm_sy
    real(ESMF_KIND_R4), intent(in), optional  :: area_adj
    character(len=*), intent(in), optional    :: tag
    integer, intent(in) , optional            :: scheme
    integer, intent(out), optional            :: rc

    ! local variables
    integer                                   :: localrc, i, j
    real(ESMF_KIND_R8), pointer               :: coordX(:,:), coordY(:,:)
    real(ESMF_KIND_R8), pointer               :: f_area(:,:), f_area_m(:), o_area(:,:)
    real(ESMF_KIND_R8)                        :: startx, starty
    integer                                   :: l_scheme
    type(ESMF_Mesh)                           :: mesh
    type(ESMF_Field)                          :: field

    l_scheme = ESMF_REGRID_SCHEME_REGION3D
    if(present(scheme)) l_scheme = scheme

    if(l_scheme == ESMF_REGRID_SCHEME_FULL3D) then
      make_grid_sph = ESMF_GridCreate1PeriDim(maxIndex=(/atm_nx, atm_ny/), &
        indexflag=ESMF_INDEX_GLOBAL, &
        gridEdgeLWidth=(/0,0/), gridEdgeUWidth=(/0,1/), &
        !regDecomp=(/npet, 1/), &
        rc=localrc)
    else
      make_grid_sph = ESMF_GridCreateNoPeriDim(maxIndex=(/atm_nx, atm_ny/), &
        indexflag=ESMF_INDEX_GLOBAL, &
        gridEdgeLWidth=(/0,0/), gridEdgeUWidth=(/1,1/), &
        !regDecomp=(/npet, 1/), &
        rc=localrc)
    endif 
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

    call ESMF_GridAddCoord(make_grid_sph, staggerloc=ESMF_STAGGERLOC_CENTER, &
        rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_GridAddCoord(make_grid_sph, staggerloc=ESMF_STAGGERLOC_CORNER, &
        rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

    ! global indexing
    ! atm grid is not decomposed in the y direction
    !startx = lpet*atm_nx/npet*atm_dx
    startx = atm_sx
    starty = atm_sy
    ! compute coord
    ! X center
    call ESMF_GridGetCoord(make_grid_sph, localDE=0, staggerLoc=ESMF_STAGGERLOC_CENTER, &
        coordDim=1, farrayPtr=coordX, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    ! Y center
    call ESMF_GridGetCoord(make_grid_sph, localDE=0, staggerLoc=ESMF_STAGGERLOC_CENTER, &
        coordDim=2, farrayPtr=coordY, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    do i = lbound(coordX,1), ubound(coordX,1)
      do j = lbound(coordX, 2), ubound(coordX, 2)
        coordX(i,j) = startx + atm_dx/2. + (i-1)*atm_dx
        coordY(i,j) = starty + atm_dy/2. + (j-1)*atm_dy
      enddo
    enddo
    !print *, 'startx: ', startx, lbound(coordX, 1), ubound(coordX, 1), 'coordX: ', coordX(:,1)
    ! X corner
    call ESMF_GridGetCoord(make_grid_sph, localDE=0, staggerLoc=ESMF_STAGGERLOC_CORNER, &
        coordDim=1, farrayPtr=coordX, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    ! Y corner
    call ESMF_GridGetCoord(make_grid_sph, localDE=0, staggerLoc=ESMF_STAGGERLOC_CORNER, &
        coordDim=2, farrayPtr=coordY, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    do i = lbound(coordX,1), ubound(coordX,1)
      do j = lbound(coordX, 2), ubound(coordX, 2)
        coordX(i,j) = startx + (i-1)*atm_dx
        coordY(i,j) = starty + (j-1)*atm_dy
      enddo
    enddo

    if(present(area_adj)) then
      ! retrieve area

      !mesh = ESMF_GridToMesh(make_grid_sph, &
      !  ESMF_STAGGERLOC_CORNER, 0, &
      !  regridConserve=ESMF_REGRID_CONSERVE_ON, rc=localrc)
      !if (ESMF_LogFoundError(localrc, &
      !    ESMF_ERR_PASSTHRU, &
      !    ESMF_CONTEXT, rcToReturn=rc)) return

      !allocate(f_area_m(mesh%NumOwnedElements))
      !call ESMF_MeshGetElemArea(mesh,  arealist=f_area_m, rc=localrc)
      !if (ESMF_LogFoundError(localrc, &
      !    ESMF_ERR_PASSTHRU, &
      !    ESMF_CONTEXT, rcToReturn=rc)) return
      !deallocate(f_area_m)

      ! find out original Grid cell area
      field = ESMF_FieldCreate(make_grid_sph, typekind=ESMF_TYPEKIND_R8, &
        staggerloc=ESMF_STAGGERLOC_CENTER, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      call ESMF_FieldRegridGetArea(field, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      call ESMF_FieldGet(field, farrayPtr=o_area, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return

      ! add area to Grid
      call ESMF_GridAddItem(make_grid_sph, ESMF_GRIDITEM_AREA, &
        staggerloc=ESMF_STAGGERLOC_CENTER,  rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return

      call ESMF_GridGetItem(make_grid_sph, ESMF_GRIDITEM_AREA, &
        staggerloc=ESMF_STAGGERLOC_CENTER, farrayptr=f_area, &
        rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return

      ! adjust Grid area
      f_area = area_adj*o_area

    endif

    if(present(rc)) rc = ESMF_SUCCESS

  end function make_grid_sph

  function make_mesh_sph(atm_nx, atm_ny, atm_dx, atm_dy, atm_sx, atm_sy, tag, scheme, rc)

    ! return value
    type(ESMF_Mesh)                           :: make_mesh_sph
    ! arguments
    integer, intent(in)                       :: atm_nx, atm_ny
    real(ESMF_KIND_R4), intent(in)            :: atm_dx, atm_dy
    real(ESMF_KIND_R4), intent(in)            :: atm_sx, atm_sy
    character(len=*), intent(in), optional    :: tag
    integer, intent(in) , optional            :: scheme
    integer, intent(out), optional            :: rc

    ! local variables
    integer                                   :: localrc, i, j
    real(ESMF_KIND_R8), pointer               :: coordX(:,:), coordY(:,:)
    real(ESMF_KIND_R8)                        :: startx, starty
    integer                                   :: l_scheme
    type(ESMF_Grid)                           :: make_grid_sph

    l_scheme = ESMF_REGRID_SCHEME_REGION3D
    if(present(scheme)) l_scheme = scheme

    if(l_scheme == ESMF_REGRID_SCHEME_FULL3D) then
      make_grid_sph = ESMF_GridCreate1PeriDim(maxIndex=(/atm_nx, atm_ny/), &
        indexflag=ESMF_INDEX_GLOBAL, &
        gridEdgeLWidth=(/0,0/), gridEdgeUWidth=(/0,1/), &
        !regDecomp=(/npet, 1/), &
        rc=localrc)
    else
      make_grid_sph = ESMF_GridCreateNoPeriDim(maxIndex=(/atm_nx, atm_ny/), &
        indexflag=ESMF_INDEX_GLOBAL, &
        gridEdgeLWidth=(/0,0/), gridEdgeUWidth=(/1,1/), &
        !regDecomp=(/npet, 1/), &
        rc=localrc)
    endif 
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

    call ESMF_GridAddCoord(make_grid_sph, staggerloc=ESMF_STAGGERLOC_CENTER, &
        rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_GridAddCoord(make_grid_sph, staggerloc=ESMF_STAGGERLOC_CORNER, &
        rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

    ! global indexing
    ! atm grid is not decomposed in the y direction
    !startx = lpet*atm_nx/npet*atm_dx
    startx = atm_sx
    starty = atm_sy
    ! compute coord
    ! X center
    call ESMF_GridGetCoord(make_grid_sph, localDE=0, staggerLoc=ESMF_STAGGERLOC_CENTER, &
        coordDim=1, farrayPtr=coordX, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    ! Y center
    call ESMF_GridGetCoord(make_grid_sph, localDE=0, staggerLoc=ESMF_STAGGERLOC_CENTER, &
        coordDim=2, farrayPtr=coordY, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    do i = lbound(coordX,1), ubound(coordX,1)
      do j = lbound(coordX, 2), ubound(coordX, 2)
        coordX(i,j) = startx + atm_dx/2. + (i-1)*atm_dx
        coordY(i,j) = starty + atm_dy/2. + (j-1)*atm_dy
      enddo
    enddo
    !print *, 'startx: ', startx, lbound(coordX, 1), ubound(coordX, 1), 'coordX: ', coordX(:,1)
    ! X corner
    call ESMF_GridGetCoord(make_grid_sph, localDE=0, staggerLoc=ESMF_STAGGERLOC_CORNER, &
        coordDim=1, farrayPtr=coordX, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    ! Y corner
    call ESMF_GridGetCoord(make_grid_sph, localDE=0, staggerLoc=ESMF_STAGGERLOC_CORNER, &
        coordDim=2, farrayPtr=coordY, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    do i = lbound(coordX,1), ubound(coordX,1)
      do j = lbound(coordX, 2), ubound(coordX, 2)
        coordX(i,j) = startx + (i-1)*atm_dx
        coordY(i,j) = starty + (j-1)*atm_dy
      enddo
    enddo

    make_mesh_sph = ESMF_GridToMesh(make_grid_sph, &
      ESMF_STAGGERLOC_CORNER, 0, &
      regridConserve=ESMF_REGRID_CONSERVE_ON, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

    if(present(rc)) rc = ESMF_SUCCESS

  end function make_mesh_sph

  subroutine flux_exchange(xgrid, srcField, dstField, rc)

    type(ESMF_XGrid), intent(inout)           :: xgrid
    type(ESMF_Field), intent(inout)           :: srcField(:)
    type(ESMF_Field), intent(inout)           :: dstField(:)
    integer, intent(out), optional            :: rc


    integer                                   :: localrc, i, j, nsrc, ndst, lpet, npet
    type(ESMF_Field)                          :: f_xgrid
    type(ESMF_Grid), allocatable              :: srcGrid(:)
    type(ESMF_Field), allocatable             :: srcFrac(:), srcArea(:)
    type(ESMF_Grid), allocatable              :: dstGrid(:)
    type(ESMF_Field), allocatable             :: dstFrac(:), dstArea(:)
    type(ESMF_Field), allocatable             :: srcFrac2(:), dstFrac2(:)
    type(ESMF_RouteHandle), allocatable       :: s2d_rh(:,:)
    type(ESMF_RouteHandle), allocatable       :: d2s_rh(:,:)
    type(ESMF_RouteHandle), allocatable       :: s2x_rh(:), x2s_rh(:)
    type(ESMF_RouteHandle), allocatable       :: d2x_rh(:), x2d_rh(:)
    real(ESMF_KIND_R8), pointer               :: src(:,:), dst(:,:), exf(:)
    real(ESMF_KIND_R8), pointer               :: src_area(:,:), dst_area(:,:), exf_area(:)
    real(ESMF_KIND_R8), pointer               :: src_frac(:,:), dst_frac(:,:), exf_frac(:)
    real(ESMF_KIND_R8), pointer               :: src_frac2(:,:), dst_frac2(:,:)
    real(ESMF_KIND_R8)                        :: srcsum(3), allsrcsum(3), scale=2.0, exf_tarea, exf_tflux
    type(ESMF_VM)                             :: vm

    call ESMF_VMGetCurrent(vm=vm, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_VMGet(vm, localpet=lpet, petCount=npet, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

    !------------------------------------
    ! build Fields on the Grids
    !------------------------------------

    ! create a Field on the xgrid
    f_xgrid = ESMF_FieldCreate(xgrid=xgrid, TYPEKIND=ESMF_TYPEKIND_R8, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_FieldGet(f_xgrid, farrayPtr=exf, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

    nsrc = size(srcField)
    ndst = size(dstField)
    allocate(srcGrid(nsrc), srcFrac(nsrc), srcFrac2(nsrc), srcArea(nsrc))
    allocate(dstGrid(ndst), dstFrac(ndst), dstFrac2(ndst), dstArea(ndst))
    do i = 1, size(srcField)
      call ESMF_FieldGet(srcField(i), grid=srcGrid(i), rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      srcFrac(i) = ESMF_FieldCreate(srcGrid(i), typekind=ESMF_TYPEKIND_R8, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      srcFrac2(i) = ESMF_FieldCreate(srcGrid(i), typekind=ESMF_TYPEKIND_R8, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      srcArea(i) = ESMF_FieldCreate(srcGrid(i), typekind=ESMF_TYPEKIND_R8, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      call ESMF_FieldRegridGetArea(srcArea(i), rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
    enddo

    do i = 1, size(dstField)
      call ESMF_FieldGet(dstField(i), grid=dstGrid(i), rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      dstFrac(i) = ESMF_FieldCreate(dstGrid(i), typekind=ESMF_TYPEKIND_R8, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      dstFrac2(i) = ESMF_FieldCreate(dstGrid(i), typekind=ESMF_TYPEKIND_R8, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      call ESMF_FieldGet(dstFrac(i), localDe=0, farrayPtr=dst_frac, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      dstArea(i) = ESMF_FieldCreate(dstGrid(i), typekind=ESMF_TYPEKIND_R8, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      call ESMF_FieldRegridGetArea(dstArea(i), rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
    enddo

    allocate(s2d_rh(size(srcField), size(dstField)), d2s_rh(size(dstField), size(srcField)))
    allocate(s2x_rh(size(srcField)), x2s_rh(size(srcField)))
    allocate(d2x_rh(size(dstField)), x2d_rh(size(dstField)))

    do i = 1, size(srcField)
      do j = 1, size(dstField)
        call ESMF_FieldRegridStore(srcField=srcField(i), dstField=dstField(j), &
          regridmethod=ESMF_REGRIDMETHOD_CONSERVE, &
          routehandle=s2d_rh(i,j), &
          unmappedaction = ESMF_UNMAPPEDACTION_IGNORE, &
          srcFracField=srcFrac(i), dstFracField=dstFrac(j), & 
          rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return

        call ESMF_FieldRegridStore(srcField=dstField(j), dstField=srcField(i), &
          regridmethod=ESMF_REGRIDMETHOD_CONSERVE, &
          routehandle=d2s_rh(j,i), &
          unmappedaction = ESMF_UNMAPPEDACTION_IGNORE, &
          srcFracField=dstFrac(j), dstFracField=srcFrac(i), & 
          rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
      enddo
    enddo

    do i = 1, size(srcField)
      call ESMF_FieldRegridStore(xgrid, srcField=srcField(i), dstField=f_xgrid, &
        routehandle=s2x_rh(i), rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      call ESMF_FieldRegridStore(xgrid, srcField=f_xgrid, dstField=srcField(i), &
        routehandle=x2s_rh(i), rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
    enddo
    do i = 1, size(dstField)
      call ESMF_FieldRegridStore(xgrid, srcField=dstField(i), dstField=f_xgrid, &
        routehandle=d2x_rh(i), rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      call ESMF_FieldRegridStore(xgrid, srcField=f_xgrid, dstField=dstField(i), &
        routehandle=x2d_rh(i), dstFracField=dstFrac(i), dstMergeFracField=dstFrac2(i), &
        rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
    enddo

    !----------------------------------------------------
    ! Compute flux integrals
    ! Initialize src flux to constant
    !----------------------------------------------------
    exf = 0.
    do i = 1, size(srcField)
      call ESMF_FieldGet(srcField(i), farrayPtr=src, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      src = scale
    enddo

    ! Perform flux exchange
    do i = 1, size(srcField)
      call ESMF_FieldRegrid(srcField=srcField(i), dstField=f_xgrid, &
        routehandle=s2x_rh(i), zeroregion=ESMF_REGION_EMPTY, &
        rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
    enddo

    ! make sure flux is conserved on XGrid
    allocate(exf_area(lbound(exf,1):ubound(exf,1)))
    allocate(exf_frac(lbound(exf,1):ubound(exf,1)))
    call ESMF_XGridGet(xgrid, area=exf_area, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    exf_frac = 1.0
    call compute_flux1D(vm, exf, exf_area, exf_frac, allsrcsum, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    if(lpet == 0) print *, ' xgrid flux and area: ', allsrcsum
    if(abs(allsrcsum(1) - allsrcsum(2)*scale) .gt. 1.e-10) then
      call ESMF_LogSetError(rcToCheck=ESMF_RC_ARG_WRONG, & 
         msg="- inconsistent flux and area found", &
         ESMF_CONTEXT, rcToReturn=rc) 
      return
    endif
    exf_tflux = allsrcsum(1)
    exf_tarea = allsrcsum(2)
    deallocate(exf_area, exf_frac)

    !make sure flux is conserved on dst Fields
    do i = 1, size(dstField)
      call ESMF_FieldRegrid(srcField=f_xgrid, dstField=dstField(i), &
        routehandle=x2d_rh(i), rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      call ESMF_FieldGet(dstField(i), farrayPtr=dst, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return

      ! fraction
      call ESMF_FieldGet(dstFrac(i), farrayPtr=dst_frac, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      call ESMF_FieldGet(dstFrac2(i), farrayPtr=dst_frac2, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return

      ! area
      call ESMF_FieldGet(dstArea(i), farrayPtr=dst_area, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return

      call compute_flux2D(vm, dst, dst_area, dst_frac, dst_frac2, allsrcsum, dstflux=.true., rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      if(lpet == 0) print *, 'dst flux and area: ', allsrcsum
      if((abs(exf_tarea - allsrcsum(2)) .gt. 1.e-10) .or. &
         (abs(exf_tflux - allsrcsum(1)) .gt. 1.e-10)) then
        call ESMF_LogSetError(rcToCheck=ESMF_RC_ARG_WRONG, & 
           msg="- inconsistent flux and area found", &
           ESMF_CONTEXT, rcToReturn=rc) 
        return
      endif
    enddo

    do i = 1, size(dstField)
      call ESMF_FieldRegrid(srcField=dstField(i), dstField=f_xgrid, &
        routehandle=d2x_rh(i), &
        rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
    enddo
    do i = 1, size(srcField)
      call ESMF_FieldRegrid(srcField=f_xgrid, dstField=srcField(i), &
        routehandle=x2s_rh(i), rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      call ESMF_FieldGet(srcField(i), farrayPtr=src, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
    enddo

    !----------------------------------------------------
    ! clean up
    !----------------------------------------------------
    do i = 1, size(srcField)
      call ESMF_FieldDestroy(srcField(i), rc=localrc)
      call ESMF_FieldDestroy(srcArea(i), rc=localrc)
      call ESMF_FieldDestroy(srcFrac(i), rc=localrc)
      call ESMF_FieldDestroy(srcFrac2(i), rc=localrc)
      call ESMF_RoutehandleRelease(s2x_rh(i), rc=localrc)
      call ESMF_RoutehandleRelease(x2s_rh(i), rc=localrc)
    enddo
    do i = 1, size(dstField)
      call ESMF_FieldDestroy(dstField(i), rc=localrc)
      call ESMF_FieldDestroy(dstArea(i), rc=localrc)
      call ESMF_FieldDestroy(dstFrac(i), rc=localrc)
      call ESMF_FieldDestroy(dstFrac2(i), rc=localrc)
      call ESMF_RoutehandleRelease(d2x_rh(i), rc=localrc)
      call ESMF_RoutehandleRelease(x2d_rh(i), rc=localrc)
    enddo
    do i = 1, size(srcField)
      do j = 1, size(dstField)
        call ESMF_RoutehandleRelease(s2d_rh(i,j), rc=localrc)
        call ESMF_RoutehandleRelease(d2s_rh(j,i), rc=localrc)
      enddo
    enddo

    deallocate(srcArea, srcFrac, dstArea, dstFrac)
    deallocate(s2d_rh, d2s_rh)
    deallocate(s2x_rh, x2s_rh)
    deallocate(d2x_rh, x2d_rh)

    call ESMF_XGridDestroy(xgrid,rc=localrc)

    if(present(rc)) rc = ESMF_SUCCESS

  end subroutine flux_exchange

!----------------------------------------------------
  subroutine compute_flux1D(vm, flux_density, area, fraction, allsum, rc)
    type(ESMF_VM), intent(in)        :: vm
    real(ESMF_KIND_R8), pointer      :: flux_density(:) 
    real(ESMF_KIND_R8), pointer      :: area(:) 
    real(ESMF_KIND_R8), pointer      :: fraction(:) 
    real(ESMF_KIND_R8), intent(out)  :: allsum(3)
    integer, intent(out), optional   :: rc

    real(ESMF_KIND_R8)               :: sum(3)
    integer                          :: i,j, localrc

    if(present(rc)) rc = ESMF_SUCCESS

    sum = 0.
    do i = lbound(flux_density, 1), ubound(flux_density, 1)
      sum(1) = sum(1) + flux_density(i)*area(i)*fraction(i)
      sum(2) = sum(2) +                 area(i)*fraction(i)
      sum(3) = sum(3) +                 area(i)
    enddo

    call ESMF_VMAllReduce(vm, sum, allsum, 3, ESMF_REDUCE_SUM, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

  end subroutine compute_flux1D

  subroutine compute_flux2D(vm, flux_density, area, fraction, fraction2, allsum, dstflux, rc)
    type(ESMF_VM), intent(in)        :: vm
    real(ESMF_KIND_R8), pointer      :: flux_density(:,:) 
    real(ESMF_KIND_R8), pointer      :: area(:,:) 
    real(ESMF_KIND_R8), pointer      :: fraction(:,:) 
    real(ESMF_KIND_R8), pointer      :: fraction2(:,:) 
    real(ESMF_KIND_R8), intent(out)  :: allsum(3)
    logical, intent(in),  optional   :: dstflux
    integer, intent(out), optional   :: rc

    real(ESMF_KIND_R8)               :: sum(3)
    integer                          :: i,j, localrc, npet, lpet
    logical                          :: l_dstflux

    if(present(rc)) rc = ESMF_SUCCESS
    l_dstflux = .false.
    if(present(dstflux)) l_dstflux = dstflux

    call ESMF_VMGet(vm, petCount=npet, localPet=lpet, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
  
    !if(lpet == 0) write(*, '(A, 4I5)') 'compute_flux2D bounds: ', &
    !  lbound(flux_density, 1), ubound(flux_density, 1), &
    !  lbound(flux_density, 2), ubound(flux_density, 2)

    sum = 0.
    do i = lbound(flux_density, 1), ubound(flux_density, 1)
      do j = lbound(flux_density, 2), ubound(flux_density, 2)
        if(l_dstflux) then
          sum(1) = sum(1) + flux_density(i,j)*area(i,j)*fraction2(i,j)
        else
          sum(1) = sum(1) + flux_density(i,j)*area(i,j)*fraction(i,j)*fraction2(i,j)
        endif
        sum(2) = sum(2) +                 area(i,j)*fraction(i,j)
        sum(3) = sum(3) +                 area(i,j)
      enddo
    enddo

    call ESMF_VMAllReduce(vm, sum, allsum, 3, ESMF_REDUCE_SUM, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

  end subroutine compute_flux2D

  subroutine flux_exchange_sph(xgrid, scheme, area_adj, rc)

    type(ESMF_XGrid), intent(inout)           :: xgrid
    integer, intent(in),  optional            :: scheme
    real(ESMF_KIND_R8), pointer               :: coordX(:), coordY(:)
    real(ESMF_KIND_R4), intent(in), optional  :: area_adj
    integer, intent(out), optional            :: rc


    integer                                   :: localrc, i, j, nsrc, ndst, lpet, npet
    type(ESMF_Field)                          :: f_xgrid
    type(ESMF_Grid), allocatable              :: srcGrid(:)
    type(ESMF_Field), allocatable             :: srcFrac(:), srcArea(:)
    type(ESMF_Grid), allocatable              :: dstGrid(:)
    type(ESMF_Field), allocatable             :: dstFrac(:), dstArea(:)
    type(ESMF_Field), allocatable             :: srcFrac2(:)
    type(ESMF_Field), allocatable             :: dstFrac2(:)
    type(ESMF_RouteHandle), allocatable       :: s2d_rh(:,:)
    type(ESMF_RouteHandle), allocatable       :: d2s_rh(:,:)
    type(ESMF_RouteHandle), allocatable       :: s2x_rh(:), x2s_rh(:)
    type(ESMF_RouteHandle), allocatable       :: d2x_rh(:), x2d_rh(:)
    real(ESMF_KIND_R8), pointer               :: src(:,:), dst(:,:), exf(:)
    real(ESMF_KIND_R8), pointer               :: src_area(:,:), dst_area(:,:), exf_area(:)
    real(ESMF_KIND_R8), pointer               :: src_frac(:,:), dst_frac(:,:), exf_frac(:)
    real(ESMF_KIND_R8), pointer               :: src_frac2(:,:), dst_frac2(:,:)
    real(ESMF_KIND_R8)                        :: srcsum(3), allsrcsum(3), scale=2.0, exf_tarea, exf_tflux
    type(ESMF_VM)                             :: vm
    type(ESMF_Field), allocatable             :: srcField(:)
    type(ESMF_Field), allocatable             :: dstField(:)
    integer                                   :: l_scheme
    integer                                   :: sideAGC, sideBGC, sideAMC, sideBMC
    real(ESMF_KIND_R8)                        :: global_sum, l_area_adj
    character(len=1)                          :: cids(10) = (/'0','1','2','3','4','5','6','7','8','9'/)
    real(ESMF_KIND_R8)                        :: global_af, global_a
    
    l_scheme = ESMF_REGRID_SCHEME_REGION3D
    if(present(scheme)) l_scheme = scheme
    l_area_adj = 1.0
    if(present(area_adj)) l_area_adj = area_adj

    call ESMF_VMGetCurrent(vm=vm, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_VMGet(vm, localpet=lpet, petCount=npet, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

    !------------------------------------
    ! build Fields on the Grids
    !------------------------------------

    ! create a Field on the xgrid
    f_xgrid = ESMF_FieldCreate(xgrid=xgrid, TYPEKIND=ESMF_TYPEKIND_R8, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_FieldGet(f_xgrid, farrayPtr=exf, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

    call ESMF_XGridGet(xgrid, &
        sideAGridCount=sideAGC, sideBGridCount=sideBGC, &
        sideAMeshCount=sideAMC, sideBMeshCount=sideBMC, &
        rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

    nsrc = sideAGC
    ndst = sideBGC
    allocate(srcGrid(nsrc), srcField(nsrc), srcFrac(nsrc), srcFrac2(nsrc), srcArea(nsrc))
    allocate(dstGrid(ndst), dstField(ndst), dstFrac(ndst), dstFrac2(ndst), dstArea(ndst))

    call ESMF_XGridGet(xgrid, sideAGrid=srcGrid, sideBGrid=dstGrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

    do i = 1, nsrc
      srcField(i) = ESMF_FieldCreate(srcGrid(i), typekind=ESMF_TYPEKIND_R8, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      srcFrac(i) = ESMF_FieldCreate(srcGrid(i), typekind=ESMF_TYPEKIND_R8, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      srcFrac2(i) = ESMF_FieldCreate(srcGrid(i), typekind=ESMF_TYPEKIND_R8, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      srcArea(i) = ESMF_FieldCreate(srcGrid(i), typekind=ESMF_TYPEKIND_R8, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      call ESMF_FieldRegridGetArea(srcArea(i), rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
    enddo

    do i = 1, ndst
      dstField(i) = ESMF_FieldCreate(dstGrid(i), typekind=ESMF_TYPEKIND_R8, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      dstFrac(i) = ESMF_FieldCreate(dstGrid(i), typekind=ESMF_TYPEKIND_R8, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      dstFrac2(i) = ESMF_FieldCreate(dstGrid(i), typekind=ESMF_TYPEKIND_R8, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      call ESMF_FieldGet(dstFrac(i), localDe=0, farrayPtr=dst_frac, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      dstArea(i) = ESMF_FieldCreate(dstGrid(i), typekind=ESMF_TYPEKIND_R8, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      call ESMF_FieldRegridGetArea(dstArea(i), rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
    enddo

    allocate(s2d_rh(size(srcField), size(dstField)), d2s_rh(size(dstField), size(srcField)))
    allocate(s2x_rh(size(srcField)), x2s_rh(size(srcField)))
    allocate(d2x_rh(size(dstField)), x2d_rh(size(dstField)))

    do i = 1, size(srcField)
      do j = 1, size(dstField)
        call ESMF_FieldRegridStore(srcField=srcField(i), dstField=dstField(j), &
          regridmethod=ESMF_REGRIDMETHOD_CONSERVE, &
          routehandle=s2d_rh(i,j), &
          unmappedaction = ESMF_UNMAPPEDACTION_IGNORE, &
          srcFracField=srcFrac(i), dstFracField=dstFrac(j), & 
          rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return

        call ESMF_FieldRegridStore(srcField=dstField(j), dstField=srcField(i), &
          regridmethod=ESMF_REGRIDMETHOD_CONSERVE, &
          routehandle=d2s_rh(j,i), &
          unmappedaction = ESMF_UNMAPPEDACTION_IGNORE, &
          srcFracField=dstFrac(j), dstFracField=srcFrac(i), & 
          rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
      enddo
    enddo

    do i = 1, size(srcField)
      call ESMF_FieldRegridStore(xgrid, srcField=srcField(i), dstField=f_xgrid, &
        routehandle=s2x_rh(i), rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      call ESMF_FieldRegridStore(xgrid, srcField=f_xgrid, dstField=srcField(i), &
        routehandle=x2s_rh(i), rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      !call ESMF_GridWrite(srcGrid(i), cids(i)//'_srcmesh.vtk', rc=localrc)
      !if (ESMF_LogFoundError(localrc, &
      !    ESMF_ERR_PASSTHRU, &
      !    ESMF_CONTEXT, rcToReturn=rc)) return
    enddo
    do i = 1, size(dstField)
      call ESMF_FieldRegridStore(xgrid, srcField=dstField(i), dstField=f_xgrid, &
        routehandle=d2x_rh(i), rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      call ESMF_FieldRegridStore(xgrid, srcField=f_xgrid, dstField=dstField(i), &
        routehandle=x2d_rh(i), dstFracField=dstFrac(i), dstMergeFracField=dstFrac2(i), &
        rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      !call ESMF_GridWrite(dstGrid(i), cids(i)//'_dstmesh.vtk', rc=localrc)
      !if (ESMF_LogFoundError(localrc, &
      !    ESMF_ERR_PASSTHRU, &
      !    ESMF_CONTEXT, rcToReturn=rc)) return
    enddo

    !----------------------------------------------------
    ! Compute flux integrals
    ! Initialize src flux to constant
    !----------------------------------------------------
    exf = 0.
    do i = 1, size(srcField)
      call ESMF_FieldGet(srcField(i), farrayPtr=src, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      src = scale
    enddo

    ! Perform flux exchange
    do i = 1, size(srcField)
      call ESMF_FieldRegrid(srcField=srcField(i), dstField=f_xgrid, &
        routehandle=s2x_rh(i), zeroregion=ESMF_REGION_EMPTY, &
        rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
    enddo

    ! make sure flux is conserved on XGrid
    !call ESMF_MeshWrite(xgrid%xgtypep%mesh, 'xgrid.vtk', rc=localrc)
    !if (ESMF_LogFoundError(localrc, &
    !    ESMF_ERR_PASSTHRU, &
    !    ESMF_CONTEXT, rcToReturn=rc)) return
    allocate(exf_area(lbound(exf,1):ubound(exf,1)))
    allocate(exf_frac(lbound(exf,1):ubound(exf,1)))
    call ESMF_XGridGet(xgrid, area=exf_area, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    exf_frac = 1.0
    call compute_flux1D(vm, exf, exf_area, exf_frac, allsrcsum, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    if(lpet == 0) print *, ' xgrid flux and area: ', allsrcsum
    if(abs(allsrcsum(1) - allsrcsum(2)*scale*l_area_adj) .gt. 1.e-10) then
    !   write(*,*) allsrcsum(1),allsrcsum(2)*scale*l_area_adj,allsrcsum(2)*scale,allsrcsum(2),scale,l_area_adj
       call ESMF_LogSetError(rcToCheck=ESMF_RC_ARG_WRONG, & 
         msg="- inconsistent flux and area found", &
         ESMF_CONTEXT, rcToReturn=rc) 
      return
    endif
    exf_tflux = allsrcsum(1)
    exf_tarea = allsrcsum(2)
    deallocate(exf_area, exf_frac)

    !make sure flux is conserved on dst Fields
    global_sum = 0.
    global_af = 0.
    global_a = 0.
    do i = 1, size(dstField)
      call ESMF_FieldRegrid(srcField=f_xgrid, dstField=dstField(i), &
        routehandle=x2d_rh(i), rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      call ESMF_FieldGet(dstField(i), farrayPtr=dst, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return

      ! fraction
      call ESMF_FieldGet(dstFrac(i), farrayPtr=dst_frac, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      call ESMF_FieldGet(dstFrac2(i), farrayPtr=dst_frac2, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return

      ! area
      call ESMF_FieldGet(dstArea(i), farrayPtr=dst_area, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return

      call compute_flux2D(vm, dst, dst_area, dst_frac, dst_frac2, allsrcsum, dstflux=.true., rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      if(lpet == 0) print *, 'dst flux and area: ', allsrcsum
      if(ndst == 1) then
      !   write(*,*) "exf_tarea*l_area_adj=",exf_tarea*l_area_adj," allsrcsum(2)=",allsrcsum(2)
      !   write(*,*) "exf_tflux=",exf_tflux," allsrcsum(1)=",allsrcsum(1)
         
         if((abs(exf_tarea*l_area_adj - allsrcsum(2)) .gt. 1.e-10) .or. &
           (abs(exf_tflux - allsrcsum(1)) .gt. 1.e-10)) then
          call ESMF_LogSetError(rcToCheck=ESMF_RC_ARG_WRONG, & 
             msg="- inconsistent flux and area found", &
             ESMF_CONTEXT, rcToReturn=rc) 
          return
        endif
      else
        call compute_flux2D(vm, dst, dst_area, dst_frac, dst_frac2, allsrcsum, dstflux=.true., rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
        if(lpet == 0) print *, 'dst flux and area using frac2: ', allsrcsum
        global_sum = global_sum + allsrcsum(1)
        global_af = global_af + allsrcsum(2)
        global_a = global_a + allsrcsum(3)
     endif

    enddo

    ! make sure going to multiple Grids also conserve global flux
    if(ndst .gt. 1) then
     !  write(*,*) exf_tflux,global_sum,exf_tflux-global_sum
     !  write(*,*) global_af, global_a

        if ((abs(exf_tflux - global_sum) .gt. 1.e-10)) then
           call ESMF_LogSetError(rcToCheck=ESMF_RC_ARG_WRONG, & 
           msg="- inconsistent flux and area found", &
           ESMF_CONTEXT, rcToReturn=rc) 
        return
      endif
    endif

    do i = 1, size(dstField)
      call ESMF_FieldRegrid(srcField=dstField(i), dstField=f_xgrid, &
        routehandle=d2x_rh(i), &
        rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
    enddo
    do i = 1, size(srcField)
      call ESMF_FieldRegrid(srcField=f_xgrid, dstField=srcField(i), &
        routehandle=x2s_rh(i), rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      call ESMF_FieldGet(srcField(i), farrayPtr=src, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
    enddo

    !----------------------------------------------------
    ! clean up
    !----------------------------------------------------
    do i = 1, size(srcField)
      call ESMF_FieldDestroy(srcField(i), rc=localrc)
      call ESMF_FieldDestroy(srcArea(i), rc=localrc)
      call ESMF_FieldDestroy(srcFrac(i), rc=localrc)
      call ESMF_FieldDestroy(srcFrac2(i), rc=localrc)
      call ESMF_RoutehandleRelease(s2x_rh(i), rc=localrc)
      call ESMF_RoutehandleRelease(x2s_rh(i), rc=localrc)
    enddo
    do i = 1, size(dstField)
      call ESMF_FieldDestroy(dstField(i), rc=localrc)
      call ESMF_FieldDestroy(dstArea(i), rc=localrc)
      call ESMF_FieldDestroy(dstFrac(i), rc=localrc)
      call ESMF_FieldDestroy(dstFrac2(i), rc=localrc)
      call ESMF_RoutehandleRelease(d2x_rh(i), rc=localrc)
      call ESMF_RoutehandleRelease(x2d_rh(i), rc=localrc)
    enddo
    do i = 1, size(srcField)
      do j = 1, size(dstField)
        call ESMF_RoutehandleRelease(s2d_rh(i,j), rc=localrc)
        call ESMF_RoutehandleRelease(d2s_rh(j,i), rc=localrc)
      enddo
    enddo

    deallocate(srcArea, srcFrac, dstArea, dstFrac)
    deallocate(s2d_rh, d2s_rh)
    deallocate(s2x_rh, x2s_rh)
    deallocate(d2x_rh, x2d_rh)

    call ESMF_XGridDestroy(xgrid,rc=localrc)

    if(present(rc)) rc = ESMF_SUCCESS

  end subroutine flux_exchange_sph

  subroutine flux_exchange_sph_mesh(xgrid, scheme, rc)

    type(ESMF_XGrid), intent(inout)           :: xgrid
    integer, intent(in),  optional            :: scheme
    integer, intent(out), optional            :: rc


    integer                                   :: localrc, i, j, nsrc, ndst, lpet, npet
    type(ESMF_Field)                          :: f_xgrid
    type(ESMF_Mesh), allocatable              :: srcGrid(:)
    type(ESMF_Field), allocatable             :: srcFrac(:), srcArea(:)
    type(ESMF_Mesh), allocatable              :: dstGrid(:)
    type(ESMF_Field), allocatable             :: dstFrac(:), dstArea(:)
    type(ESMF_Field), allocatable             :: srcFrac2(:)
    type(ESMF_Field), allocatable             :: dstFrac2(:)
    type(ESMF_RouteHandle), allocatable       :: s2d_rh(:,:)
    type(ESMF_RouteHandle), allocatable       :: d2s_rh(:,:)
    type(ESMF_RouteHandle), allocatable       :: s2x_rh(:), x2s_rh(:)
    type(ESMF_RouteHandle), allocatable       :: d2x_rh(:), x2d_rh(:)
    real(ESMF_KIND_R8), pointer               :: src(:), dst(:), exf(:)
    real(ESMF_KIND_R8), pointer               :: src_area(:), dst_area(:), exf_area(:)
    real(ESMF_KIND_R8), pointer               :: src_frac(:), dst_frac(:), exf_frac(:)
    real(ESMF_KIND_R8), pointer               :: src_frac2(:), dst_frac2(:)
    real(ESMF_KIND_R8)                        :: srcsum(3), allsrcsum(3), scale=2.0, exf_tarea, exf_tflux
    type(ESMF_VM)                             :: vm
    type(ESMF_Field), allocatable             :: srcField(:)
    type(ESMF_Field), allocatable             :: dstField(:)
    integer                                   :: l_scheme
    integer                                   :: sideAGC, sideBGC, sideAMC, sideBMC
    real(ESMF_KIND_R8)                        :: global_sum
    character(len=1)                          :: cids(10) = (/'0','1','2','3','4','5','6','7','8','9'/)

    l_scheme = ESMF_REGRID_SCHEME_REGION3D
    if(present(scheme)) l_scheme = scheme

    call ESMF_VMGetCurrent(vm=vm, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_VMGet(vm, localpet=lpet, petCount=npet, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

    !------------------------------------
    ! build Fields on the Grids
    !------------------------------------

    ! create a Field on the xgrid
    f_xgrid = ESMF_FieldCreate(xgrid=xgrid, TYPEKIND=ESMF_TYPEKIND_R8, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_FieldGet(f_xgrid, farrayPtr=exf, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

    call ESMF_XGridGet(xgrid, &
        sideAGridCount=sideAGC, sideBGridCount=sideBGC, &
        sideAMeshCount=sideAMC, sideBMeshCount=sideBMC, &
        rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

    nsrc = sideAMC
    ndst = sideBMC
    allocate(srcGrid(nsrc), srcField(nsrc), srcFrac(nsrc), srcFrac2(nsrc), srcArea(nsrc))
    allocate(dstGrid(ndst), dstField(ndst), dstFrac(ndst), dstFrac2(ndst), dstArea(ndst))

    call ESMF_XGridGet(xgrid, sideAMesh=srcGrid, sideBMesh=dstGrid, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

    do i = 1, nsrc
      srcField(i) = ESMF_FieldCreate(srcGrid(i), meshloc=ESMF_MESHLOC_ELEMENT, &
        typekind=ESMF_TYPEKIND_R8, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      srcFrac(i) = ESMF_FieldCreate(srcGrid(i), meshloc=ESMF_MESHLOC_ELEMENT, &
        typekind=ESMF_TYPEKIND_R8, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      srcFrac2(i) = ESMF_FieldCreate(srcGrid(i), meshloc=ESMF_MESHLOC_ELEMENT, &
        typekind=ESMF_TYPEKIND_R8, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      srcArea(i) = ESMF_FieldCreate(srcGrid(i), meshloc=ESMF_MESHLOC_ELEMENT, &
        typekind=ESMF_TYPEKIND_R8, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      call ESMF_FieldRegridGetArea(srcArea(i), rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
    enddo

    do i = 1, ndst
      dstField(i) = ESMF_FieldCreate(dstGrid(i), meshloc=ESMF_MESHLOC_ELEMENT, &
        typekind=ESMF_TYPEKIND_R8, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      dstFrac(i) = ESMF_FieldCreate(dstGrid(i), meshloc=ESMF_MESHLOC_ELEMENT, &
        typekind=ESMF_TYPEKIND_R8, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      dstFrac2(i) = ESMF_FieldCreate(dstGrid(i), meshloc=ESMF_MESHLOC_ELEMENT, &
        typekind=ESMF_TYPEKIND_R8, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      call ESMF_FieldGet(dstFrac(i), localDe=0, farrayPtr=dst_frac, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      dstArea(i) = ESMF_FieldCreate(dstGrid(i), meshloc=ESMF_MESHLOC_ELEMENT, &
        typekind=ESMF_TYPEKIND_R8, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      call ESMF_FieldRegridGetArea(dstArea(i), rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
    enddo

    allocate(s2d_rh(size(srcField), size(dstField)), d2s_rh(size(dstField), size(srcField)))
    allocate(s2x_rh(size(srcField)), x2s_rh(size(srcField)))
    allocate(d2x_rh(size(dstField)), x2d_rh(size(dstField)))

    do i = 1, size(srcField)
      do j = 1, size(dstField)
        call ESMF_FieldRegridStore(srcField=srcField(i), dstField=dstField(j), &
          regridmethod=ESMF_REGRIDMETHOD_CONSERVE, &
          routehandle=s2d_rh(i,j), &
          unmappedaction = ESMF_UNMAPPEDACTION_IGNORE, &
          srcFracField=srcFrac(i), dstFracField=dstFrac(j), & 
          rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return

        call ESMF_FieldRegridStore(srcField=dstField(j), dstField=srcField(i), &
          regridmethod=ESMF_REGRIDMETHOD_CONSERVE, &
          routehandle=d2s_rh(j,i), &
          unmappedaction = ESMF_UNMAPPEDACTION_IGNORE, &
          srcFracField=dstFrac(j), dstFracField=srcFrac(i), & 
          rc=localrc)
        if (ESMF_LogFoundError(localrc, &
            ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
      enddo
    enddo

    do i = 1, size(srcField)
      call ESMF_FieldRegridStore(xgrid, srcField=srcField(i), dstField=f_xgrid, &
        routehandle=s2x_rh(i), rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      call ESMF_FieldRegridStore(xgrid, srcField=f_xgrid, dstField=srcField(i), &
        routehandle=x2s_rh(i), rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      !call ESMF_MeshWrite(srcGrid(i), cids(i)//'_srcmesh.vtk', rc=localrc)
      !if (ESMF_LogFoundError(localrc, &
      !    ESMF_ERR_PASSTHRU, &
      !    ESMF_CONTEXT, rcToReturn=rc)) return
    enddo
    do i = 1, size(dstField)
      call ESMF_FieldRegridStore(xgrid, srcField=dstField(i), dstField=f_xgrid, &
        routehandle=d2x_rh(i), rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      call ESMF_FieldRegridStore(xgrid, srcField=f_xgrid, dstField=dstField(i), &
        routehandle=x2d_rh(i), dstFracField=dstFrac(i), dstMergeFracField=dstFrac2(i), &
        rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      !call ESMF_MeshWrite(dstGrid(i), cids(i)//'_dstmesh.vtk', rc=localrc)
      !if (ESMF_LogFoundError(localrc, &
      !    ESMF_ERR_PASSTHRU, &
      !    ESMF_CONTEXT, rcToReturn=rc)) return
    enddo

    !----------------------------------------------------
    ! Compute flux integrals
    ! Initialize src flux to constant
    !----------------------------------------------------
    exf = 0.
    do i = 1, size(srcField)
      call ESMF_FieldGet(srcField(i), farrayPtr=src, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      src = scale
    enddo

    ! Perform flux exchange
    do i = 1, size(srcField)
      call ESMF_FieldRegrid(srcField=srcField(i), dstField=f_xgrid, &
        routehandle=s2x_rh(i), zeroregion=ESMF_REGION_EMPTY, &
        rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
    enddo

    ! make sure flux is conserved on XGrid
    !call ESMF_MeshWrite(xgrid%xgtypep%mesh, 'xgrid.vtk', rc=localrc)
    !if (ESMF_LogFoundError(localrc, &
    !    ESMF_ERR_PASSTHRU, &
    !    ESMF_CONTEXT, rcToReturn=rc)) return
    allocate(exf_area(lbound(exf,1):ubound(exf,1)))
    allocate(exf_frac(lbound(exf,1):ubound(exf,1)))
    call ESMF_XGridGet(xgrid, area=exf_area, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    exf_frac = 1.0
    call compute_flux1D(vm, exf, exf_area, exf_frac, allsrcsum, rc=localrc)
    if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    if(lpet == 0) print *, ' xgrid flux and area: ', allsrcsum
    !if(abs(allsrcsum(1) - allsrcsum(2)*scale) .gt. 1.e-10) then
    !  call ESMF_LogSetError(rcToCheck=ESMF_RC_ARG_WRONG, & 
    !     msg="- inconsistent flux and area found", &
    !     ESMF_CONTEXT, rcToReturn=rc) 
    !  return
    !endif
    exf_tflux = allsrcsum(1)
    exf_tarea = allsrcsum(2)
    deallocate(exf_area, exf_frac)

    !make sure flux is conserved on dst Fields
    global_sum = 0.
    do i = 1, size(dstField)
      call ESMF_FieldRegrid(srcField=f_xgrid, dstField=dstField(i), &
        routehandle=x2d_rh(i), rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      call ESMF_FieldGet(dstField(i), farrayPtr=dst, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return

      ! fraction
      call ESMF_FieldGet(dstFrac(i), farrayPtr=dst_frac, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      call ESMF_FieldGet(dstFrac2(i), farrayPtr=dst_frac2, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return

      ! area
      call ESMF_FieldGet(dstArea(i), farrayPtr=dst_area, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return

      !call compute_flux2D(vm, dst, dst_area, dst_frac, dst_frac2, allsrcsum, dstflux=.true., rc=localrc)
      !if (ESMF_LogFoundError(localrc, &
      !    ESMF_ERR_PASSTHRU, &
      !    ESMF_CONTEXT, rcToReturn=rc)) return
      !if(lpet == 0) print *, 'dst flux and area: ', allsrcsum
      !if(ndst == 1) then
      !  if((abs(exf_tarea - allsrcsum(2)) .gt. 1.e-10) .or. &
      !     (abs(exf_tflux - allsrcsum(1)) .gt. 1.e-10)) then
      !    call ESMF_LogSetError(rcToCheck=ESMF_RC_ARG_WRONG, & 
      !       msg="- inconsistent flux and area found", &
      !       ESMF_CONTEXT, rcToReturn=rc) 
      !    return
      !  endif
      !else
      !  call compute_flux2D(vm, dst, dst_area, dst_frac, dst_frac2, allsrcsum, dstflux=.true., rc=localrc)
      !  if (ESMF_LogFoundError(localrc, &
      !      ESMF_ERR_PASSTHRU, &
      !      ESMF_CONTEXT, rcToReturn=rc)) return
      !  if(lpet == 0) print *, 'dst flux and area using frac2: ', allsrcsum
      !  global_sum = global_sum + allsrcsum(1)
      !endif

    enddo

    ! make sure going to multiple Grids also conserve global flux
    !if(ndst .gt. 1) then
    !    if ((abs(exf_tflux - global_sum) .gt. 1.e-10)) then
    !    call ESMF_LogSetError(rcToCheck=ESMF_RC_ARG_WRONG, & 
    !       msg="- inconsistent flux and area found", &
    !       ESMF_CONTEXT, rcToReturn=rc) 
    !    return
    !  endif
    !endif

    do i = 1, size(dstField)
      call ESMF_FieldRegrid(srcField=dstField(i), dstField=f_xgrid, &
        routehandle=d2x_rh(i), &
        rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
    enddo
    do i = 1, size(srcField)
      call ESMF_FieldRegrid(srcField=f_xgrid, dstField=srcField(i), &
        routehandle=x2s_rh(i), rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      call ESMF_FieldGet(srcField(i), farrayPtr=src, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
          ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
    enddo

    !----------------------------------------------------
    ! clean up
    !----------------------------------------------------
    do i = 1, size(srcField)
      call ESMF_FieldDestroy(srcField(i), rc=localrc)
      call ESMF_FieldDestroy(srcArea(i), rc=localrc)
      call ESMF_FieldDestroy(srcFrac(i), rc=localrc)
      call ESMF_FieldDestroy(srcFrac2(i), rc=localrc)
      call ESMF_RoutehandleRelease(s2x_rh(i), rc=localrc)
      call ESMF_RoutehandleRelease(x2s_rh(i), rc=localrc)
    enddo
    do i = 1, size(dstField)
      call ESMF_FieldDestroy(dstField(i), rc=localrc)
      call ESMF_FieldDestroy(dstArea(i), rc=localrc)
      call ESMF_FieldDestroy(dstFrac(i), rc=localrc)
      call ESMF_FieldDestroy(dstFrac2(i), rc=localrc)
      call ESMF_RoutehandleRelease(d2x_rh(i), rc=localrc)
      call ESMF_RoutehandleRelease(x2d_rh(i), rc=localrc)
    enddo
    do i = 1, size(srcField)
      do j = 1, size(dstField)
        call ESMF_RoutehandleRelease(s2d_rh(i,j), rc=localrc)
        call ESMF_RoutehandleRelease(d2s_rh(j,i), rc=localrc)
      enddo
    enddo

    deallocate(srcArea, srcFrac, dstArea, dstFrac)
    deallocate(s2d_rh, d2s_rh)
    deallocate(s2x_rh, x2s_rh)
    deallocate(d2x_rh, x2d_rh)

    ! Destroy xgrid
    call ESMF_XGridDestroy(xgrid,rc=localrc)
    if (ESMF_LogFoundError(localrc, &
         ESMF_ERR_PASSTHRU, &
         ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! If rc present, return success
    if(present(rc)) rc = ESMF_SUCCESS

  end subroutine flux_exchange_sph_mesh


  ! This is a test that creates a small xgrid from a couple of small grids.
  ! It's useful for debugging simple issues because everything is easy to look through.
 subroutine test_side_and_elem_info(rc)
#undef ESMF_METHOD 
#define ESMF_METHOD "test_side_and_elem_info"
  integer, intent(out)  :: rc
  integer :: localrc
  type(ESMF_VM) :: vm
  type(ESMF_Grid) :: a1Grid, a2Grid
  type(ESMF_Grid) :: bGrid
  type(ESMF_XGrid) :: xgrid
  type(ESMF_Mesh) :: xgridMesh
  integer :: localPet, petCount

  
  ! init success flag
  rc=ESMF_SUCCESS

  ! get pet info
  call ESMF_VMGetGlobal(vm, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_VMGet(vm, petCount=petCount, localPet=localpet, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return


  ! Create small 4 x 4 Grid for side A
  a1Grid=ESMF_GridCreateNoPeriDimUfrm(maxIndex=(/4,4/), &
       minCornerCoord=(/0.0_ESMF_KIND_R8,0.0_ESMF_KIND_R8/), &
       maxCornerCoord=(/8.0_ESMF_KIND_R8,5.0_ESMF_KIND_R8/), &
       coordSys=ESMF_COORDSYS_CART, &
       staggerLocList=(/ESMF_STAGGERLOC_CENTER, ESMF_STAGGERLOC_CORNER/), &
       rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! Debug output
#if 0
  call ESMF_GridWriteVTK(a1Grid,staggerloc=ESMF_STAGGERLOC_CORNER, &
        filename="a1GridCnr", &
        rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
#endif
  
  ! Create small 4 x 4 Grid for side A
  a2Grid=ESMF_GridCreateNoPeriDimUfrm(maxIndex=(/4,4/), &
       minCornerCoord=(/0.0_ESMF_KIND_R8,4.0_ESMF_KIND_R8/), &
       maxCornerCoord=(/8.0_ESMF_KIND_R8,8.0_ESMF_KIND_R8/), &
       coordSys=ESMF_COORDSYS_CART, &
       staggerLocList=(/ESMF_STAGGERLOC_CENTER, ESMF_STAGGERLOC_CORNER/), &
       rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  
  ! Debug output
#if 0
  call ESMF_GridWriteVTK(a2Grid,staggerloc=ESMF_STAGGERLOC_CORNER, &
        filename="a2GridCnr", &
        rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
#endif


  ! Create small 8 x 8 Grid for side B
  bGrid=ESMF_GridCreateNoPeriDimUfrm(maxIndex=(/8,8/), &
       minCornerCoord=(/0.0_ESMF_KIND_R8,0.0_ESMF_KIND_R8/), &
       maxCornerCoord=(/8.0_ESMF_KIND_R8,8.0_ESMF_KIND_R8/), &
       coordSys=ESMF_COORDSYS_CART, &
       staggerLocList=(/ESMF_STAGGERLOC_CENTER, ESMF_STAGGERLOC_CORNER/), &
       rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! Debug output
#if 0
  call ESMF_GridWriteVTK(bGrid,staggerloc=ESMF_STAGGERLOC_CORNER, &
        filename="bGridCnr", &
        rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
#endif

  ! Create XGrid
  xgrid = ESMF_XGridCreate(sideAGrid=(/a1Grid, a2Grid/), &
       sideBGrid=(/bGrid/), &
       storeOverlay = .true., &
       rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return
  
   ! Debug output
#if 0
  call ESMF_XGridGet(xgrid, mesh=xgridMesh, rc=localrc)
   if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

   call ESMF_MeshWriteVTK(xgridMesh, "xgridMesh", rc=localrc)
   if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return
#endif

  ! Free the XGrid
  call ESMF_XGridDestroy(xgrid, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! Free the grids
  call ESMF_GridDestroy(a1Grid, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_GridDestroy(a2Grid, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  call ESMF_GridDestroy(bGrid, rc=localrc)
  if (ESMF_LogFoundError(localrc, &
       ESMF_ERR_PASSTHRU, &
       ESMF_CONTEXT, rcToReturn=rc)) return

  ! Return success
  rc=ESMF_SUCCESS

end subroutine test_side_and_elem_info


end program ESMF_XGridUTest
