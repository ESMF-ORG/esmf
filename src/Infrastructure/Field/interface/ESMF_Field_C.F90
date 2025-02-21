!  $Id$
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
! F77 interface files for C++ layer calling into F90 implementation layer.
!  This cannot use any F90 syntax, including modules, or allocatable 
!   arrays, or ...
!
!==============================================================================
#define ESMF_FILENAME "ESMF_Field_C.F90"
!
!------------------------------------------------------------------------------
! INCLUDES
#include "ESMF.h"
!==============================================================================
!------------------------------------------------------------------------------
! The following line turns the CVS identifier string into a printable variable.
!      character(*), parameter, private :: version = &
!      '$Id$'
!==============================================================================

#undef  ESMF_METHOD
#define ESMF_METHOD "f_esmf_fieldcreategridas"
  subroutine f_esmf_fieldcreategridas(field, grid_pointer, arrayspec, &
    staggerloc, gridToFieldMap, len1, gtfmpresent, &
    ungriddedLBound, len2, uglbpresent, &
    ungriddedUBound, len3, ugubpresent, name, rc)

    use ESMF_UtilTypesMod
    use ESMF_BaseMod
    use ESMF_LogErrMod
    use ESMF_ArraySpecMod
    use ESMF_StaggerLocMod
    use ESMF_GridMod
    use ESMF_FieldMod
    use ESMF_FieldCreateMod

    implicit none

    ! arguments
    type(ESMF_Field)               :: field
    type(ESMF_Pointer)             :: grid_pointer
    type(ESMF_ArraySpec)           :: arrayspec
    type(ESMF_StaggerLoc)          :: staggerloc
    integer, intent(in)            :: len1, len2, len3
    integer, intent(in)            :: gtfmpresent, uglbpresent, ugubpresent
    integer                        :: gridToFieldMap(1:len1), &
                                      ungriddedLBound(1:len2), &
                                      ungriddedUBound(1:len3)
    character(len=*),intent(in)    :: name
    integer, intent(out)           :: rc              
  
    ! local variables  
    type(ESMF_Grid)          :: grid
  
    ! initialize return code; assume routine not implemented
    rc = ESMF_RC_NOT_IMPL

    grid%this = grid_pointer

    ESMF_INIT_SET_CREATED(grid)
    
    if (gtfmpresent == 0 .and. uglbpresent == 0 .and. ugubpresent == 0) then
      field = ESMF_FieldCreate(grid, arrayspec=arrayspec, staggerloc=staggerloc, &
        name=name, rc=rc)
    else if (gtfmpresent == 1 .and. uglbpresent == 0 .and. ugubpresent == 0) then
      field = ESMF_FieldCreate(grid, arrayspec=arrayspec, staggerloc=staggerloc, &
        gridToFieldMap=gridToFieldMap, &
        name=name, rc=rc)
    else if (gtfmpresent == 0 .and. uglbpresent == 1 .and. ugubpresent == 0) then
      field = ESMF_FieldCreate(grid, arrayspec=arrayspec, staggerloc=staggerloc, &
        ungriddedLBound=ungriddedLBound, &
        name=name, rc=rc)
    else if (gtfmpresent == 0 .and. uglbpresent == 0 .and. ugubpresent == 1) then
      field = ESMF_FieldCreate(grid, arrayspec=arrayspec, staggerloc=staggerloc, &
        ungriddedUBound=ungriddedUBound, &
        name=name, rc=rc)
    else if (gtfmpresent == 1 .and. uglbpresent == 1 .and. ugubpresent == 0) then
      field = ESMF_FieldCreate(grid, arrayspec=arrayspec, staggerloc=staggerloc, &
        gridToFieldMap=gridToFieldMap, &
        ungriddedLBound=ungriddedLBound, &
        name=name, rc=rc)
    else if (gtfmpresent == 0 .and. uglbpresent == 1 .and. ugubpresent == 1) then
      field = ESMF_FieldCreate(grid, arrayspec=arrayspec, staggerloc=staggerloc, &
        ungriddedLBound=ungriddedLBound, &
        ungriddedUBound=ungriddedUBound, &
        name=name, rc=rc)
    else if (gtfmpresent == 1 .and. uglbpresent == 0 .and. ugubpresent == 1) then
      field = ESMF_FieldCreate(grid, arrayspec=arrayspec, staggerloc=staggerloc, &
        gridToFieldMap=gridToFieldMap, &
        ungriddedUBound=ungriddedUBound, &
        name=name, rc=rc)
    else if (gtfmpresent == 1 .and. uglbpresent == 1 .and. ugubpresent == 1) then
      field = ESMF_FieldCreate(grid, arrayspec=arrayspec, staggerloc=staggerloc, &
        gridToFieldMap=gridToFieldMap, &
        ungriddedLBound=ungriddedLBound, &
        ungriddedUBound=ungriddedUBound, &
        name=name, rc=rc)
    endif
    if (ESMF_LogFoundError(rc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
   
    rc = ESMF_SUCCESS
  
  end subroutine f_esmf_fieldcreategridas

#undef  ESMF_METHOD
#define ESMF_METHOD "f_esmf_fieldcreategridtk"
  subroutine f_esmf_fieldcreategridtk(field, grid_pointer, typekind, &
    staggerloc, gridToFieldMap, len1, gtfmpresent, &
    ungriddedLBound, len2, uglbpresent, &
    ungriddedUBound, len3, ugubpresent, name, rc)

    use ESMF_UtilTypesMod
    use ESMF_BaseMod
    use ESMF_LogErrMod
    use ESMF_FieldMod
    use ESMF_FieldCreateMod
    use ESMF_StaggerLocMod
    use ESMF_GridMod

    implicit none

    ! arguments
    type(ESMF_Field)               :: field
    type(ESMF_Pointer)             :: grid_pointer
    type(ESMF_TypeKind_Flag)       :: typekind
    type(ESMF_StaggerLoc)          :: staggerloc
    integer, intent(in)            :: len1, len2, len3
    integer, intent(in)            :: gtfmpresent, uglbpresent, ugubpresent
    integer                        :: gridToFieldMap(1:len1), &
                                      ungriddedLBound(1:len2), &
                                      ungriddedUBound(1:len3)
    character(len=*),intent(in)    :: name
    integer, intent(out)           :: rc              
  
    ! local variables  
    type(ESMF_Grid)          :: grid
 
  ! initialize return code; assume routine not implemented
    rc = ESMF_RC_NOT_IMPL

    grid%this = grid_pointer

    ESMF_INIT_SET_CREATED(grid)
 
    if (gtfmpresent == 0 .and. uglbpresent == 0 .and. ugubpresent == 0) then
    field = ESMF_FieldCreate(grid, typekind=typekind, staggerloc=staggerloc, &
        name=name, rc=rc)    
    else if (gtfmpresent == 1 .and. uglbpresent == 0 .and. ugubpresent == 0) then
    field = ESMF_FieldCreate(grid, typekind=typekind, staggerloc=staggerloc, &
        gridToFieldMap=gridToFieldMap, &
        name=name, rc=rc)    
    else if (gtfmpresent == 0 .and. uglbpresent == 1 .and. ugubpresent == 0) then
    field = ESMF_FieldCreate(grid, typekind=typekind, staggerloc=staggerloc, &
        ungriddedLBound=ungriddedLBound, &
        name=name, rc=rc)    
    else if (gtfmpresent == 0 .and. uglbpresent == 0 .and. ugubpresent == 1) then
    field = ESMF_FieldCreate(grid, typekind=typekind, staggerloc=staggerloc, &
        ungriddedUBound=ungriddedUBound, &
        name=name, rc=rc)    
    else if (gtfmpresent == 1 .and. uglbpresent == 1 .and. ugubpresent == 0) then
    field = ESMF_FieldCreate(grid, typekind=typekind, staggerloc=staggerloc, &
        gridToFieldMap=gridToFieldMap, &
        ungriddedLBound=ungriddedLBound, &
        name=name, rc=rc)    
    else if (gtfmpresent == 0 .and. uglbpresent == 1 .and. ugubpresent == 1) then
    field = ESMF_FieldCreate(grid, typekind=typekind, staggerloc=staggerloc, &
        ungriddedLBound=ungriddedLBound, &
        ungriddedUBound=ungriddedUBound, &
        name=name, rc=rc)    
    else if (gtfmpresent == 1 .and. uglbpresent == 0 .and. ugubpresent == 1) then
    field = ESMF_FieldCreate(grid, typekind=typekind, staggerloc=staggerloc, &
        gridToFieldMap=gridToFieldMap, &
        ungriddedUBound=ungriddedUBound, &
        name=name, rc=rc)    
    else if (gtfmpresent == 1 .and. uglbpresent == 1 .and. ugubpresent == 1) then
    field = ESMF_FieldCreate(grid, typekind=typekind, staggerloc=staggerloc, &
        gridToFieldMap=gridToFieldMap, &
        ungriddedLBound=ungriddedLBound, &
        ungriddedUBound=ungriddedUBound, &
        name=name, rc=rc)    
    endif
    if (ESMF_LogFoundError(rc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
   
    rc = ESMF_SUCCESS
  
  end subroutine f_esmf_fieldcreategridtk

#undef  ESMF_METHOD
#define ESMF_METHOD "f_esmf_fieldcreatemeshas"
  subroutine f_esmf_fieldcreatemeshas(field, mesh_pointer, arrayspec, &
    gridToFieldMap, len1, gtfmpresent, &
    ungriddedLBound, len2, uglbpresent, &
    ungriddedUBound, len3, ugubpresent, name, rc)

    use ESMF_UtilTypesMod
    use ESMF_BaseMod
    use ESMF_LogErrMod
    use ESMF_ArraySpecMod
    use ESMF_MeshMod
    use ESMF_FieldMod
    use ESMF_FieldCreateMod

    implicit none

    ! arguments
    type(ESMF_Field)               :: field
    type(ESMF_Pointer)             :: mesh_pointer
    type(ESMF_ArraySpec)           :: arrayspec
    integer, intent(in)            :: len1, len2, len3
    integer, intent(in)            :: gtfmpresent, uglbpresent, ugubpresent
    integer                        :: gridToFieldMap(1:len1), &
                                      ungriddedLBound(1:len2), &
                                      ungriddedUBound(1:len3)
    character(len=*),intent(in)    :: name
    integer, intent(out)           :: rc              
  
    ! local variables  
    type(ESMF_Mesh)          :: mesh
  
  ! initialize return code; assume routine not implemented
    rc = ESMF_RC_NOT_IMPL

    ! mesh%this = mesh_pointer

    mesh = ESMF_MeshCreateFromIntPtr(mesh_pointer)
  
    if (gtfmpresent == 0 .and. uglbpresent == 0 .and. ugubpresent == 0) then
    field = ESMF_FieldCreate(mesh, arrayspec=arrayspec, &
        name=name, rc=rc)    
    else if (gtfmpresent == 1 .and. uglbpresent == 0 .and. ugubpresent == 0) then
    field = ESMF_FieldCreate(mesh, arrayspec=arrayspec, &
        gridToFieldMap=gridToFieldMap, &
        name=name, rc=rc)    
    else if (gtfmpresent == 0 .and. uglbpresent == 1 .and. ugubpresent == 0) then
    field = ESMF_FieldCreate(mesh, arrayspec=arrayspec, &
        ungriddedLBound=ungriddedLBound, &
        name=name, rc=rc)    
    else if (gtfmpresent == 0 .and. uglbpresent == 0 .and. ugubpresent == 1) then
    field = ESMF_FieldCreate(mesh, arrayspec=arrayspec, &
        ungriddedUBound=ungriddedUBound, &
        name=name, rc=rc)    
    else if (gtfmpresent == 1 .and. uglbpresent == 1 .and. ugubpresent == 0) then
    field = ESMF_FieldCreate(mesh, arrayspec=arrayspec, &
        gridToFieldMap=gridToFieldMap, &
        ungriddedLBound=ungriddedLBound, &
        name=name, rc=rc)    
    else if (gtfmpresent == 0 .and. uglbpresent == 1 .and. ugubpresent == 1) then
    field = ESMF_FieldCreate(mesh, arrayspec=arrayspec, &
        ungriddedLBound=ungriddedLBound, &
        ungriddedUBound=ungriddedUBound, &
        name=name, rc=rc)    
    else if (gtfmpresent == 1 .and. uglbpresent == 0 .and. ugubpresent == 1) then
    field = ESMF_FieldCreate(mesh, arrayspec=arrayspec, &
        gridToFieldMap=gridToFieldMap, &
        ungriddedUBound=ungriddedUBound, &
        name=name, rc=rc)    
    else if (gtfmpresent == 1 .and. uglbpresent == 1 .and. ugubpresent == 1) then
    field = ESMF_FieldCreate(mesh, arrayspec=arrayspec, &
        gridToFieldMap=gridToFieldMap, &
        ungriddedLBound=ungriddedLBound, &
        ungriddedUBound=ungriddedUBound, &
        name=name, rc=rc)    
    endif
    if (ESMF_LogFoundError(rc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
   
    rc = ESMF_SUCCESS
  
  end subroutine f_esmf_fieldcreatemeshas

#undef  ESMF_METHOD
#define ESMF_METHOD "f_esmf_fieldcreatemeshtk"
  subroutine f_esmf_fieldcreatemeshtk(field, mesh_pointer, typekind, meshloc, &
    gridToFieldMap, len1, gtfmpresent, &
    ungriddedLBound, len2, uglbpresent, &
    ungriddedUBound, len3, ugubpresent, name, rc)

    use ESMF_UtilTypesMod
    use ESMF_BaseMod
    use ESMF_LogErrMod
    use ESMF_MeshMod
    use ESMF_FieldMod
    use ESMF_FieldCreateMod

    implicit none

    ! arguments
    type(ESMF_Field)               :: field
    type(ESMF_Pointer)             :: mesh_pointer
    type(ESMF_TypeKind_Flag)       :: typekind
    type(ESMF_MeshLoc)             :: meshloc
    integer, intent(in)            :: len1, len2, len3
    integer, intent(in)            :: gtfmpresent, uglbpresent, ugubpresent
    integer                        :: gridToFieldMap(1:len1), &
                                      ungriddedLBound(1:len2), &
                                      ungriddedUBound(1:len3)
    character(len=*),intent(in)    :: name
    integer, intent(out)           :: rc              
  
    ! local variables  
    type(ESMF_Mesh)          :: mesh
  
    ! initialize return code; assume routine not implemented
    rc = ESMF_RC_NOT_IMPL

    ! mesh%this = mesh_pointer

    mesh = ESMF_MeshCreateFromIntPtr(mesh_pointer)

    if (gtfmpresent == 0 .and. uglbpresent == 0 .and. ugubpresent == 0) then
    field = ESMF_FieldCreate(mesh, typekind=typekind, meshloc=meshloc, &
        name=name, rc=rc)    
    else if (gtfmpresent == 1 .and. uglbpresent == 0 .and. ugubpresent == 0) then
    field = ESMF_FieldCreate(mesh, typekind=typekind, meshloc=meshloc, &
        gridToFieldMap=gridToFieldMap, &
        name=name, rc=rc)    
    else if (gtfmpresent == 0 .and. uglbpresent == 1 .and. ugubpresent == 0) then
    field = ESMF_FieldCreate(mesh, typekind=typekind, meshloc=meshloc, &
        ungriddedLBound=ungriddedLBound, &
        name=name, rc=rc)    
    else if (gtfmpresent == 0 .and. uglbpresent == 0 .and. ugubpresent == 1) then
    field = ESMF_FieldCreate(mesh, typekind=typekind, meshloc=meshloc, &
        ungriddedUBound=ungriddedUBound, &
        name=name, rc=rc)    
    else if (gtfmpresent == 1 .and. uglbpresent == 1 .and. ugubpresent == 0) then
    field = ESMF_FieldCreate(mesh, typekind=typekind, meshloc=meshloc, &
        gridToFieldMap=gridToFieldMap, &
        ungriddedLBound=ungriddedLBound, &
        name=name, rc=rc)    
    else if (gtfmpresent == 0 .and. uglbpresent == 1 .and. ugubpresent == 1) then
    field = ESMF_FieldCreate(mesh, typekind=typekind, meshloc=meshloc, &
        ungriddedLBound=ungriddedLBound, &
        ungriddedUBound=ungriddedUBound, &
        name=name, rc=rc)    
    else if (gtfmpresent == 1 .and. uglbpresent == 0 .and. ugubpresent == 1) then
    field = ESMF_FieldCreate(mesh, typekind=typekind, meshloc=meshloc, &
        gridToFieldMap=gridToFieldMap, &
        ungriddedUBound=ungriddedUBound, &
        name=name, rc=rc)    
    else if (gtfmpresent == 1 .and. uglbpresent == 1 .and. ugubpresent == 1) then
    field = ESMF_FieldCreate(mesh, typekind=typekind, meshloc=meshloc, &
        gridToFieldMap=gridToFieldMap, &
        ungriddedLBound=ungriddedLBound, &
        ungriddedUBound=ungriddedUBound, &
        name=name, rc=rc)    
    endif
    if (ESMF_LogFoundError(rc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
   
    rc = ESMF_SUCCESS
  
  end subroutine f_esmf_fieldcreatemeshtk

#undef  ESMF_METHOD
#define ESMF_METHOD "f_esmf_fieldcreatelocstreamas"
  subroutine f_esmf_fieldcreatelocstreamas(field, locstream_pointer, arrayspec, &
    staggerloc, gridToFieldMap, len1, gtfmpresent, &
    ungriddedLBound, len2, uglbpresent, &
    ungriddedUBound, len3, ugubpresent, name, rc)

    use ESMF_UtilTypesMod
    use ESMF_BaseMod
    use ESMF_LogErrMod
    use ESMF_ArraySpecMod
    use ESMF_StaggerLocMod
    use ESMF_LocStreamMod
    use ESMF_FieldMod
    use ESMF_FieldCreateMod

    implicit none

    ! arguments
    type(ESMF_Field)               :: field
    type(ESMF_LocStreamType)             :: locstream_pointer
    type(ESMF_ArraySpec)           :: arrayspec
    type(ESMF_StaggerLoc)          :: staggerloc
    integer, intent(in)            :: len1, len2, len3
    integer, intent(in)            :: gtfmpresent, uglbpresent, ugubpresent
    integer                        :: gridToFieldMap(1:len1), &
                                      ungriddedLBound(1:len2), &
                                      ungriddedUBound(1:len3)
    character(len=*),intent(in)    :: name
    integer, intent(out)           :: rc              
  
    ! local variables  
    type(ESMF_LocStream)          :: locstream
  
    ! initialize return code; assume routine not implemented
    rc = ESMF_RC_NOT_IMPL

    locstream%lstypep = locstream_pointer

    ESMF_INIT_SET_CREATED(locstream)
    
    if (gtfmpresent == 0 .and. uglbpresent == 0 .and. ugubpresent == 0) then
      field = ESMF_FieldCreate(locstream, arrayspec=arrayspec, &
        name=name, rc=rc)
    else if (gtfmpresent == 1 .and. uglbpresent == 0 .and. ugubpresent == 0) then
      field = ESMF_FieldCreate(locstream, arrayspec=arrayspec, &
        gridToFieldMap=gridToFieldMap, &
        name=name, rc=rc)
    else if (gtfmpresent == 0 .and. uglbpresent == 1 .and. ugubpresent == 0) then
      field = ESMF_FieldCreate(locstream, arrayspec=arrayspec, &
        ungriddedLBound=ungriddedLBound, &
        name=name, rc=rc)
    else if (gtfmpresent == 0 .and. uglbpresent == 0 .and. ugubpresent == 1) then
      field = ESMF_FieldCreate(locstream, arrayspec=arrayspec, &
        ungriddedUBound=ungriddedUBound, &
        name=name, rc=rc)
    else if (gtfmpresent == 1 .and. uglbpresent == 1 .and. ugubpresent == 0) then
      field = ESMF_FieldCreate(locstream, arrayspec=arrayspec, &
        gridToFieldMap=gridToFieldMap, &
        ungriddedLBound=ungriddedLBound, &
        name=name, rc=rc)
    else if (gtfmpresent == 0 .and. uglbpresent == 1 .and. ugubpresent == 1) then
      field = ESMF_FieldCreate(locstream, arrayspec=arrayspec, &
        ungriddedLBound=ungriddedLBound, &
        ungriddedUBound=ungriddedUBound, &
        name=name, rc=rc)
    else if (gtfmpresent == 1 .and. uglbpresent == 0 .and. ugubpresent == 1) then
      field = ESMF_FieldCreate(locstream, arrayspec=arrayspec, &
        gridToFieldMap=gridToFieldMap, &
        ungriddedUBound=ungriddedUBound, &
        name=name, rc=rc)
    else if (gtfmpresent == 1 .and. uglbpresent == 1 .and. ugubpresent == 1) then
      field = ESMF_FieldCreate(locstream, arrayspec=arrayspec, &
        gridToFieldMap=gridToFieldMap, &
        ungriddedLBound=ungriddedLBound, &
        ungriddedUBound=ungriddedUBound, &
        name=name, rc=rc)
    endif
    if (ESMF_LogFoundError(rc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
   
    rc = ESMF_SUCCESS
  
  end subroutine f_esmf_fieldcreatelocstreamas

#undef  ESMF_METHOD
#define ESMF_METHOD "f_esmf_fieldcreatelocstreamtk"
  subroutine f_esmf_fieldcreatelocstreamtk(field, locstream, typekind, &
    gridToFieldMap, len1, gtfmpresent, &
    ungriddedLBound, len2, uglbpresent, &
    ungriddedUBound, len3, ugubpresent, name, rc)

    use ESMF_UtilTypesMod
    use ESMF_BaseMod
    use ESMF_LogErrMod
    use ESMF_FieldMod
    use ESMF_FieldCreateMod
    use ESMF_StaggerLocMod
    use ESMF_LocStreamMod

    implicit none

    ! arguments
    type(ESMF_Field)               :: field
    type(ESMF_LocStream)             :: locstream
    type(ESMF_TypeKind_Flag)       :: typekind
    type(ESMF_StaggerLoc)          :: staggerloc
    integer, intent(in)            :: len1, len2, len3
    integer, intent(in)            :: gtfmpresent, uglbpresent, ugubpresent
    integer                        :: gridToFieldMap(1:len1), &
                                      ungriddedLBound(1:len2), &
                                      ungriddedUBound(1:len3)
    character(len=*),intent(in)    :: name
    integer, intent(out)           :: rc              
  
    ! local variables  
!    type(ESMF_LocStream)          :: locstream
 
  ! initialize return code; assume routine not implemented
    rc = ESMF_RC_NOT_IMPL

!    locstream%lstypep = locstream_pointer

    ESMF_INIT_SET_CREATED(locstream)
 
    if (gtfmpresent == 0 .and. uglbpresent == 0 .and. ugubpresent == 0) then
        field = ESMF_FieldCreate(locstream, typekind=typekind, &
                                 name=name, rc=rc)    
    else if (gtfmpresent == 1 .and. uglbpresent == 0 .and. ugubpresent == 0) then
        field = ESMF_FieldCreate(locstream, typekind=typekind, &
                                 gridToFieldMap=gridToFieldMap, &
                                 name=name, rc=rc)    
    else if (gtfmpresent == 0 .and. uglbpresent == 1 .and. ugubpresent == 0) then
        field = ESMF_FieldCreate(locstream, typekind=typekind, &
                                 ungriddedLBound=ungriddedLBound, &
                                 name=name, rc=rc)    
    else if (gtfmpresent == 0 .and. uglbpresent == 0 .and. ugubpresent == 1) then
        field = ESMF_FieldCreate(locstream, typekind=typekind, &
                                 ungriddedUBound=ungriddedUBound, &
                                 name=name, rc=rc)    
    else if (gtfmpresent == 1 .and. uglbpresent == 1 .and. ugubpresent == 0) then
        field = ESMF_FieldCreate(locstream, typekind=typekind, &
                                 gridToFieldMap=gridToFieldMap, &
                                 ungriddedLBound=ungriddedLBound, &
                                 name=name, rc=rc)    
    else if (gtfmpresent == 0 .and. uglbpresent == 1 .and. ugubpresent == 1) then
        field = ESMF_FieldCreate(locstream, typekind=typekind, &
                                 ungriddedLBound=ungriddedLBound, &
                                 ungriddedUBound=ungriddedUBound, &
                                 name=name, rc=rc)    
    else if (gtfmpresent == 1 .and. uglbpresent == 0 .and. ugubpresent == 1) then
        field = ESMF_FieldCreate(locstream, typekind=typekind, &
                                 gridToFieldMap=gridToFieldMap, &
                                 ungriddedUBound=ungriddedUBound, &
                                 name=name, rc=rc)    
    else if (gtfmpresent == 1 .and. uglbpresent == 1 .and. ugubpresent == 1) then
        field = ESMF_FieldCreate(locstream, typekind=typekind, &
                                 gridToFieldMap=gridToFieldMap, &
                                 ungriddedLBound=ungriddedLBound, &
                                 ungriddedUBound=ungriddedUBound, &
                                 name=name, rc=rc)    
    endif
    if (ESMF_LogFoundError(rc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return


    rc = ESMF_SUCCESS
  
  end subroutine f_esmf_fieldcreatelocstreamtk


#undef  ESMF_METHOD
#define ESMF_METHOD "f_esmf_fieldprint"
  subroutine f_esmf_fieldprint(field, rc)

    use ESMF_UtilTypesMod
    use ESMF_BaseMod
    use ESMF_LogErrMod
    use ESMF_ArraySpecMod
    use ESMF_FieldMod
    use ESMF_FieldPrMod

    implicit none

    type(ESMF_Field),intent(inout) :: field
    integer, intent(out)           :: rc              

    integer :: localrc

    localrc = ESMF_RC_NOT_IMPL

    call ESMF_FieldPrint(field, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! return successfully
    rc = ESMF_SUCCESS
  
  end subroutine f_esmf_fieldprint

#undef  ESMF_METHOD
#define ESMF_METHOD "f_esmf_fieldcast"
  subroutine f_esmf_fieldcast(fieldOut, fieldIn, rc)

    use ESMF_UtilTypesMod
    use ESMF_BaseMod
    use ESMF_LogErrMod
    use ESMF_ArraySpecMod
    use ESMF_FieldMod
    use ESMF_FieldPrMod

    implicit none

    type(ESMF_Field),intent(inout) :: fieldOut
    type(ESMF_Field),intent(inout) :: fieldIn
    integer, intent(out)           :: rc              

    integer :: localrc

    localrc = ESMF_RC_NOT_IMPL

    ! simple assignment
    fieldOut = fieldIn

    ! return successfully
    rc = ESMF_SUCCESS
  
  end subroutine f_esmf_fieldcast

#undef  ESMF_METHOD
#define ESMF_METHOD "f_esmf_fieldgetmesh"
  subroutine f_esmf_fieldgetmesh(field, meshp, rc)

    use ESMF_UtilTypesMod
    use ESMF_BaseMod
    use ESMF_LogErrMod
    use ESMF_ArraySpecMod
    use ESMF_MeshMod
    use ESMF_FieldMod
    use ESMF_FieldGetMod

    implicit none

    type(ESMF_Field),intent(inout) :: field
    type(ESMF_Pointer)             :: meshp
    integer, intent(out)           :: rc              

    type(ESMF_Mesh)             :: mesh

    rc = ESMF_RC_NOT_IMPL

    call ESMF_FieldGet(field, mesh=mesh, rc=rc)
    if (ESMF_LogFoundError(rc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    meshp = mesh%this;

    rc = ESMF_SUCCESS
  
  end subroutine f_esmf_fieldgetmesh

#undef  ESMF_METHOD
#define ESMF_METHOD "f_esmf_fieldgetarray"
  subroutine f_esmf_fieldgetarray(field, array, rc)

    use ESMF_UtilTypesMod
    use ESMF_BaseMod
    use ESMF_LogErrMod
    use ESMF_ArraySpecMod
    use ESMF_ArrayMod
    use ESMF_FieldMod
    use ESMF_FieldGetMod

    implicit none

    ! arguments
    type(ESMF_Field),intent(inout) :: field
    type(ESMF_Array)               :: array
    integer, intent(out)           :: rc              

    ! local
    type(ESMF_Array)               :: l_array

    rc = ESMF_RC_NOT_IMPL

    call ESMF_FieldGet(field, array=l_array, rc=rc)
    if (ESMF_LogFoundError(rc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! because ESMF_Array.this is private, it cannot be accessed directly
    ! we use the public interface to do the ptr copy;
    ! the array object returned to the C interface must consist only of
    ! the 'this' pointer. It must not contain the isInit member.
    call ESMF_ArrayCopyThis(l_array, array, rc)
    if (ESMF_LogFoundError(rc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    rc = ESMF_SUCCESS
  
  end subroutine f_esmf_fieldgetarray

#undef  ESMF_METHOD
#define ESMF_METHOD "f_esmf_fielddestroy"
  subroutine f_esmf_fielddestroy(field, rc)

    use ESMF_UtilTypesMod
    use ESMF_BaseMod
    use ESMF_LogErrMod
    use ESMF_FieldMod
    use ESMF_FieldCreateMod

    implicit none

    type(ESMF_Field)               :: field
    integer, intent(out)           :: rc     
  
  ! initialize return code; assume routine not implemented
    rc = ESMF_RC_NOT_IMPL
  
    call ESMF_FieldDestroy(field, rc=rc)
    if (ESMF_LogFoundError(rc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
  
    rc = ESMF_SUCCESS
  
  end subroutine f_esmf_fielddestroy


#undef  ESMF_METHOD
#define ESMF_METHOD "f_esmf_fieldgetbounds"
  subroutine f_esmf_fieldgetbounds(field, localDe, exclusiveLBound, len1, exclusiveUBound, len2, rc)

    use ESMF_UtilTypesMod
    use ESMF_BaseMod
    use ESMF_LogErrMod
    use ESMF_FieldMod
    use ESMF_FieldCreateMod
    use ESMF_FieldGetMod

    implicit none

    type(ESMF_Field)     :: field
    integer              :: localDe
    integer              :: len1, len2
    integer              :: exclusiveLBound(1:len1)
    integer              :: exclusiveUBound(1:len2)
    integer, intent(out) :: rc

  ! initialize return code; assume routine not implemented
    rc = ESMF_RC_NOT_IMPL

    call ESMF_FieldGetBounds(field, localDe=localDe, &
      exclusiveLBound=exclusiveLBound, exclusiveUBound=exclusiveUBound, rc=rc)
    if (ESMF_LogFoundError(rc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    rc = ESMF_SUCCESS

  end subroutine f_esmf_fieldgetbounds


subroutine f_esmf_fieldcollectgarbage(field, rc)
#undef  ESMF_METHOD
#define ESMF_METHOD "f_esmf_fieldcollectgarbage()"
    use ESMF_UtilTypesMod
    use ESMF_BaseMod
    use ESMF_LogErrMod
    use ESMF_FieldMod
    use ESMF_FieldCreateMod

    implicit none

    type(ESMF_Field)      :: field
    integer, intent(out)  :: rc
  
    integer :: localrc
  
    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    rc = ESMF_RC_NOT_IMPL
  
    !print *, "collecting Field garbage"

    if (associated(field%ftypep)) then
      ! destruct internal data allocations
      call ESMF_FieldDestruct(field%ftypep, rc=localrc)
      if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
      ! deallocate actual FieldType allocation
      !print *, "deallocate(field%ftypep)"
      deallocate(field%ftypep, stat=localrc)
      if (ESMF_LogFoundDeallocError(localrc, msg="Deallocating Field", &
        ESMF_CONTEXT, rcToReturn=rc)) return
    endif
    nullify(field%ftypep)

    ! return successfully
    rc = ESMF_SUCCESS

  end subroutine f_esmf_fieldcollectgarbage

#undef  ESMF_METHOD
#define ESMF_METHOD "f_esmf_fieldread"
  subroutine f_esmf_fieldread (field,  &
      file, variableName, timeSlice, iofmt, rc)
    use ESMF_FieldMod
    use ESMF_FieldPrMod
    use ESMF_LogErrMod
    use ESMF_UtilTypesMod

    implicit none

    type(ESMF_Field), intent(inout)   :: field
    character(*),     intent(in)      :: file
    character(*),     intent(in)      :: variableName
    integer,          intent(in)      :: timeSlice
    type(ESMF_IOFmt_Flag), intent(in) :: iofmt
    integer,          intent(out)     :: rc

    integer :: localrc

! if (present (variableName)) then
! print *, ESMF_METHOD, ': file = ', file, ', variableName = ', variableName
! else
! print *, ESMF_METHOD, ': file = ', file, ', variableName not present'
! end if
! print *, ESMF_METHOD, ': timeSlice =', timeSlice
    call ESMF_FieldRead (field, file,  &
        variableName=variablename, timeSlice=timeSlice, iofmt=iofmt,  &
        rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    rc = ESMF_SUCCESS

  end subroutine f_esmf_fieldread

#undef  ESMF_METHOD
#define ESMF_METHOD "f_esmf_fieldwrite"
  subroutine f_esmf_fieldwrite (field,  &
      file, variableName, overwrite, status, timeSlice, iofmt, rc)
    use ESMF_FieldMod
    use ESMF_FieldWrMod
    use ESMF_LogErrMod
    use ESMF_UtilTypesMod

    implicit none

    type(ESMF_Field), intent(inout)   :: field
    character(*),     intent(in)      :: file
    character(*),     intent(in), optional :: variableName
    logical,          intent(in)      :: overwrite
    type(ESMF_FileStatus_Flag), intent(in) :: status
    integer,          intent(in)      :: timeSlice
    type(ESMF_IOFmt_Flag), intent(in) :: iofmt
    integer,          intent(out)     :: rc

    integer :: localrc

! if (present (variableName)) then
! print *, ESMF_METHOD, ': file = ', file, ', variableName = ', variableName
! else
! print *, ESMF_METHOD, ': file = ', file, ', variableName not present'
! end if
! print *, ESMF_METHOD, ': overwrite = ', overwrite, ', timeSlice =', timeSlice
    call ESMF_FieldWrite (field, fileName=file,  &
        variableName=variablename,  &
        overwrite=overwrite, status=status, timeSlice=timeSlice, iofmt=iofmt,  &
        rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    rc = ESMF_SUCCESS

  end subroutine f_esmf_fieldwrite

#undef  ESMF_METHOD
#define ESMF_METHOD "f_esmf_regridgetarea"
  subroutine f_esmf_regridgetarea(field, rc)

    use ESMF_UtilTypesMod
    use ESMF_BaseMod
    use ESMF_LogErrMod
    use ESMF_FieldRegridMod
    use ESMF_FieldMod

    implicit none

    type(ESMF_Field)        :: field
    integer                 :: rc

    integer :: localrc

    ! initialize return code; assume routine not implemented
    rc = ESMF_RC_NOT_IMPL
    localrc = ESMF_RC_NOT_IMPL

    call ESMF_FieldRegridGetArea(field, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    rc = ESMF_SUCCESS

  end subroutine f_esmf_regridgetarea

#undef  ESMF_METHOD
#define ESMF_METHOD "f_esmf_regrid"
  subroutine f_esmf_regrid(srcField, dstField, routehandle, zeroregion, zrpresent, rc)

    use ESMF_UtilTypesMod
    use ESMF_BaseMod
    use ESMF_LogErrMod
    use ESMF_RHandleMod
    use ESMF_FieldRegridMod
    use ESMF_FieldMod

    implicit none

    type(ESMF_Field)        :: srcField
    type(ESMF_Field)        :: dstField
    type(ESMF_RouteHandle)  :: routehandle
    type(ESMF_Region_Flag)  :: zeroregion
    integer, intent(in)     :: zrpresent
    integer                 :: rc 

    integer :: localrc
    type(ESMF_RouteHandle)  :: l_routehandle
 
    ! initialize return code; assume routine not implemented
    rc = ESMF_RC_NOT_IMPL
    localrc = ESMF_RC_NOT_IMPL

    ! Must first create a proper ESMF_RouteHandle that contains the 
    ! required "isInit" class member.
    ! Copy the this pointer a new ESMF_RouteHandle object
    call ESMF_RouteHandleCopyThis(routehandle, l_routehandle, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    ! set the valid init code of the new object
    call ESMF_RouteHandleSetInitCreated(l_routehandle, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! handle the zeroregion flag
    if (zrpresent == 0) then
      call ESMF_FieldRegrid(srcField, dstField, routehandle=l_routehandle, &
        rc=localrc)
    elseif (zrpresent == 1) then
      call ESMF_FieldRegrid(srcField, dstField, routehandle=l_routehandle, &
        zeroregion=zeroregion, rc=localrc)
    endif
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
  
    rc = ESMF_SUCCESS
  
  end subroutine f_esmf_regrid

#undef  ESMF_METHOD
#define ESMF_METHOD "f_esmf_regridrelease"
  subroutine f_esmf_regridrelease(routehandle, rc)

    use ESMF_UtilTypesMod
    use ESMF_BaseMod
    use ESMF_LogErrMod
    use ESMF_RHandleMod
    use ESMF_FieldRegridMod
    use ESMF_FieldMod

    implicit none

    type(ESMF_RouteHandle)  :: routehandle
    integer                 :: rc 

    integer :: localrc
    type(ESMF_RouteHandle)  :: l_routehandle
  
    ! initialize return code; assume routine not implemented
    rc = ESMF_RC_NOT_IMPL
    localrc = ESMF_RC_NOT_IMPL

    ! Must first create a proper ESMF_RouteHandle that contains the 
    ! required "isInit" class member.
    ! Copy the this pointer a new ESMF_RouteHandle object
    call ESMF_RouteHandleCopyThis(routehandle, l_routehandle, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    ! set the valid init code of the new object
    call ESMF_RouteHandleSetInitCreated(l_routehandle, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    call ESMF_FieldRegridRelease(routehandle=l_routehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
  
    rc = ESMF_SUCCESS
  
  end subroutine f_esmf_regridrelease

#undef  ESMF_METHOD
#define ESMF_METHOD "f_esmf_regridreleasefactors"
  subroutine f_esmf_regridreleasefactors(factorList, factorIndexList, numfac, rc)
    use ESMF_UtilTypesMod
    use iso_c_binding

    implicit none

    type(C_PTR), intent(out) :: factorList
    type(C_PTR), intent(out) :: factorIndexList
    integer(C_INT), intent(in)  :: numfac
    integer, intent(inout) :: rc

    real(ESMF_KIND_R8), dimension(:), pointer :: factorListFPtr
    integer(ESMF_KIND_I4), dimension(:,:), pointer :: factorIndexListFPtr

    rc = ESMF_RC_NOT_IMPL

    call C_F_POINTER(factorList, factorListFPtr, [numfac])
    deallocate(factorListFPtr)

    call C_F_POINTER(factorIndexList, factorIndexListFPtr, [2, numfac])
    deallocate(factorIndexListFPtr)

    rc = ESMF_SUCCESS

  end subroutine f_esmf_regridreleasefactors

! ==================================================================================

#undef  ESMF_METHOD
#define ESMF_METHOD "f_esmf_regridstore"
  subroutine f_esmf_regridstore(srcField, dstField, &
                                srcMaskValues, len1, &
                                dstMaskValues, len2, &
                                routehandle, &
                                regridmethod, &
                                polemethod, &
                                regridPoleNPnts, &
                                linetype, &
                                normtype, &
                                extrapMethod, &
                                extrapNumSrcPnts, &
                                extrapDistExponent, &
                                extrapNumLevels, &
                                unmappedaction, &
                                ignoreDegenerate, &
                                factorList, &
                                factorIndexList, &
                                numFactors, &
                                srcFracField, &
                                dstFracField, &
                                rc)

    use ESMF_UtilTypesMod
    use ESMF_BaseMod
    use ESMF_LogErrMod
    use ESMF_RHandleMod
    use ESMF_FieldRegridMod
    use ESMF_FieldMod
    use iso_c_binding

    implicit none

    type(ESMF_Field)                        :: srcField
    type(ESMF_Field)                        :: dstField
    integer                                 :: len1, len2
    integer,optional                        :: srcMaskValues(len1), &
                                               dstMaskValues(len2)
    type(ESMF_RouteHandle),optional         :: routehandle
    type(ESMF_RegridMethod_Flag),optional   :: regridmethod
    type(ESMF_PoleMethod_Flag),optional     :: polemethod
    integer,optional                        :: regridPoleNPnts

    type(ESMF_LineType_Flag),optional       :: linetype
    type(ESMF_NormType_Flag),optional       :: normtype
    type(ESMF_ExtrapMethod_Flag), optional  :: extrapMethod
    integer, optional                       :: extrapNumSrcPnts
    real(ESMF_KIND_R4), optional            :: extrapDistExponent
    integer, optional                       :: extrapNumLevels
    type(ESMF_UnmappedAction_Flag),optional :: unmappedaction
    logical,optional                        :: ignoreDegenerate

    type(C_PTR), optional                   :: factorList
    type(C_PTR), optional                   :: factorIndexList
    integer,optional                        :: numFactors

    type(ESMF_Field),optional               :: srcFracField
    type(ESMF_Field),optional               :: dstFracField
    integer,optional                        :: rc

    !--------------------------------------------------------------------------

    integer :: localrc
    type(ESMF_RouteHandle) :: l_routehandle

    real(ESMF_KIND_R8), pointer    :: factorListFPtr(:)
    integer(ESMF_KIND_I4), pointer :: factorIndexListFPtr(:,:)

    !--------------------------------------------------------------------------

    ! This is called by the C++ Field::regridstore method which is called by
    ! ESMC_FieldRegridStore which is called by Python Regrid.

    ! initialize return code; assume routine not implemented
    rc = ESMF_RC_NOT_IMPL
    localrc = ESMF_RC_NOT_IMPL

    ! Only return factors if numFactors is a specific integer. This circumvents
    ! odd behavior by C_ASSOCIATED when calling from Python. This may also
    ! happen when calling from C. This is just safer.
    if (numFactors == -999) then

      call ESMF_FieldRegridStore(srcField, dstField, &
                                srcMaskValues=srcMaskValues, &
                                dstMaskValues=dstMaskValues, &
                                routehandle=l_routehandle, &
                                regridmethod=regridmethod, &
                                polemethod=polemethod, &
                                regridPoleNPnts=regridPoleNPnts, &
                                lineType=linetype, &
                                normType=normtype, &
                                extrapMethod=extrapMethod, &
                                extrapNumSrcPnts=extrapNumSrcPnts, &
                                extrapDistExponent=extrapDistExponent, &
                                extrapNumLevels=extrapNumLevels, &
                                unmappedaction=unmappedaction, &
                                ignoreDegenerate=ignoreDegenerate, &
                                factorList=factorListFPtr, &
                                factorIndexList=factorIndexListFPtr, &
                                srcFracField=srcFracField, &
                                dstFracField=dstFracField, &
                                rc=localrc)

        numFactors = size(factorListFPtr, 1)

        ! Associate the Fortran pointers with C pointers. Only do this if
        ! factors were created during the regrid store call.
        if (numFactors > 0) then
          factorList = C_LOC(factorListFPtr(1))
          factorIndexList = C_LOC(factorIndexListFPtr(1, 1))
        end if

    else

        call ESMF_FieldRegridStore(srcField, dstField, &
                                srcMaskValues=srcMaskValues, &
                                dstMaskValues=dstMaskValues, &
                                routehandle=l_routehandle, &
                                regridmethod=regridmethod, &
                                polemethod=polemethod, &
                                regridPoleNPnts=regridPoleNPnts, &
                                lineType=linetype, &
                                normType=normtype, &
                                extrapMethod=extrapMethod, &
                                extrapNumSrcPnts=extrapNumSrcPnts, &
                                extrapDistExponent=extrapDistExponent, &
                                extrapNumLevels=extrapNumLevels, &
                                unmappedaction=unmappedaction, &
                                ignoreDegenerate=ignoreDegenerate, &
                                srcFracField=srcFracField, &
                                dstFracField=dstFracField, &
                                rc=localrc)

        ! We are not returning factors so send something nonsensical back so it is
        ! not improperly used.
        numFactors = -1

      endif

    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
 
    ! because ESMF_RouteHandle is private, it cannot be accessed directly
    ! we use the public interface to do the ptr copy;
    ! the RouteHandle object returned to the C interface must consist only of
    ! the 'this' pointer. It must not contain the isInit member.
    call ESMF_RoutehandleCopyThis(l_routehandle, routehandle, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    rc = ESMF_SUCCESS
  
  end subroutine f_esmf_regridstore

! ==================================================================================

#undef  ESMF_METHOD
#define ESMF_METHOD "f_esmf_regridstorefile"
  subroutine f_esmf_regridstorefile(srcField, dstField, fileName, &
                                    srcMaskValues, len1, &
                                    dstMaskValues, len2, &
                                    routehandle, &
                                    regridmethod, &
                                    polemethod, &
                                    regridPoleNPnts, &
                                    linetype, &
                                    normtype, &
                                    unmappedaction, &
                                    ignoreDegenerate, &
                                    createRoutehandle, &
                                    filemode, &
                                    srcFile, &
                                    dstFile, &
                                    srcFileType, &
                                    dstFileType, &
                                    largeFileFlag, &
                                    srcFracField, &
                                    dstFracField, &
                                    rc)

    use ESMF_UtilTypesMod
    use ESMF_BaseMod
    use ESMF_LogErrMod
    use ESMF_RHandleMod
    use ESMF_FieldRegridMod
    use ESMF_FieldMod
    use ESMF_FieldCreateMod
    use ESMF_FieldGetMod
    use ESMF_IOScripMod
    use ESMF_GeomMod
    use ESMF_GridMod
    use ESMF_MeshMod
    use ESMF_LocStreamMod
    use ESMF_XGridMod
    use ESMF_StaggerLocMod
    use ESMF_VMMod
    use ESMF_UtilRWGMod

    implicit none

    type(ESMF_Field)                        :: srcField
    type(ESMF_Field)                        :: dstField
    character(*), intent(in)                :: fileName
    integer                                 :: len1, len2
    integer,optional                        :: srcMaskValues(len1), &
                                               dstMaskValues(len2)
    type(ESMF_RouteHandle)                  :: routehandle
    type(ESMF_RegridMethod_Flag)            :: regridmethod
    type(ESMF_PoleMethod_Flag)              :: polemethod
    integer                                 :: regridPoleNPnts

    type(ESMF_LineType_Flag)                :: linetype
    type(ESMF_NormType_Flag)                :: normtype
    type(ESMF_UnmappedAction_Flag)          :: unmappedaction
    logical                                 :: ignoreDegenerate
    logical, optional                       :: createRoutehandle

    type(ESMF_FileMode_Flag),   optional    :: filemode
    character(len=*),           optional    :: srcFile
    character(len=*),           optional    :: dstFile
    type(ESMF_FileFormat_Flag), optional    :: srcFileType
    type(ESMF_FileFormat_Flag), optional    :: dstFileType

    logical, optional                       :: largeFileFlag

    real(ESMF_KIND_R8), pointer             :: srcArea(:), dstArea(:)
    type(ESMF_GeomType_Flag)                :: srcgt, dstgt
    type(ESMF_TypeKind_Flag)                :: srctk, dsttk
    type(ESMF_Grid)                         :: srcgrid, dstgrid
    type(ESMF_Mesh)                         :: srcmesh, dstmesh
    integer                                 :: srcslc, dstslc
    logical                                 :: ecip

    type(ESMF_Field)                        :: srcFracField
    type(ESMF_Field)                        :: dstFracField

    type(ESMF_VM)                           :: vm
    integer                                 :: localPet, petCount
    
    integer                                 :: rc

    integer :: localrc
    type(ESMF_RouteHandle) :: l_routehandle

    real(ESMF_KIND_R8), pointer :: localFactorList(:)
    integer(ESMF_KIND_I4), pointer :: localFactorIndexList(:,:)
    
    type(ESMF_FileMode_Flag) :: filemode_local
    
    ! initialize return code; assume routine not implemented
    rc = ESMF_RC_NOT_IMPL
    localrc = ESMF_RC_NOT_IMPL
    
    call ESMF_VMGetCurrent(vm, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

    ! set up local pet info
    call ESMF_VMGet(vm, localPet=localPet, petCount=petCount, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return

    if (present (createRoutehandle)) then
      if (createRoutehandle .eqv. .false.) then  
        call ESMF_FieldRegridStore(srcField, dstField, &
                                   srcMaskValues=srcMaskValues, &
                                   dstMaskValues=dstMaskValues, &
                                   regridmethod=regridmethod, &
                                   polemethod=polemethod, &
                                   regridPoleNPnts=regridPoleNPnts, &
                                   lineType=linetype, &
                                   normType=normtype, &
                                   unmappedaction=unmappedaction, &
                                   ignoreDegenerate=ignoreDegenerate, &
                                   factorList=localFactorList, &
                                   factorIndexList=localFactorIndexList, &
                                   srcFracField=srcFracField, &
                                   dstFracField=dstFracField, &
                                   rc=localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
      else
        call ESMF_FieldRegridStore(srcField, dstField, &
                                   srcMaskValues=srcMaskValues, &
                                   dstMaskValues=dstMaskValues, &
                                   regridmethod=regridmethod, &
                                   polemethod=polemethod, &
                                   regridPoleNPnts=regridPoleNPnts, &
                                   lineType=linetype, &
                                   normType=normtype, &
                                   unmappedaction=unmappedaction, &
                                   ignoreDegenerate=ignoreDegenerate, &
                                   routehandle=l_routehandle, &
                                   factorList=localFactorList, &
                                   factorIndexList=localFactorIndexList, &
                                   srcFracField=srcFracField, &
                                   dstFracField=dstFracField, &
                                   rc=localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
      endif
    else
      call ESMF_FieldRegridStore(srcField, dstField, &
                                 srcMaskValues=srcMaskValues, &
                                 dstMaskValues=dstMaskValues, &
                                 regridmethod=regridmethod, &
                                 polemethod=polemethod, &
                                 regridPoleNPnts=regridPoleNPnts, &
                                 lineType=linetype, &
                                 normType=normtype, &
                                 unmappedaction=unmappedaction, &
                                 ignoreDegenerate=ignoreDegenerate, &
                                 routehandle=l_routehandle, &
                                 factorList=localFactorList, &
                                 factorIndexList=localFactorIndexList, &
                                 srcFracField=srcFracField, &
                                 dstFracField=dstFracField, &
                                 rc=localrc)
      if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return        
    endif

    ! write the weights to file
    filemode_local = ESMF_FILEMODE_BASIC
    if (present(filemode)) then
      filemode_local = filemode
    endif
    
    if (filemode_local == ESMF_FILEMODE_BASIC) then
      call ESMF_SparseMatrixWrite(localFactorList, localFactorIndexList, &
                                  fileName, rc=localrc)
      if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
    elseif (filemode_local == ESMF_FILEMODE_WITHAUX) then
      ! query field for geom type
      call ESMF_FieldGet(srcField, geomType=srcgt, typekind=srctk, rc=localrc)
      if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      
      ! determine which stagger locations are available
      srcslc = 0
      if (srcgt == ESMF_GEOMTYPE_GRID) then
        call ESMF_FieldGet(srcField, grid=srcgrid, rc=localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
            
        call ESMF_GridGetCoord(srcgrid, staggerloc=ESMF_STAGGERLOC_CENTER, &
                               isPresent=ecip, rc=localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return

        if (ecip .eqv. .true.) srcslc = 1
        
        call ESMF_GridGetCoord(srcgrid, staggerloc=ESMF_STAGGERLOC_CORNER, &
                               isPresent=ecip, rc=localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return

        if (ecip .eqv. .true.) srcslc = 2
      else if (srcgt == ESMF_GEOMTYPE_MESH) then
        call ESMF_FieldGet(srcField, mesh=srcmesh, rc=localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
        
        ecip = .false.
        call ESMF_MeshGet(srcmesh, elementCoordsIsPresent=ecip, rc=localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
            
        srcslc = 1
        if (ecip .eqv. .true.) srcslc = 2
      else if (srcgt == ESMF_GEOMTYPE_XGRID) then
        call ESMF_LogSetError(rcToCheck=ESMF_RC_NOT_IMPL, &
                            msg="- xgrid cannot retrieve areas", &
                            ESMF_CONTEXT, rcToReturn=rc)
      endif
      
      ! query field for geom type
      call ESMF_FieldGet(dstField, geomType=dstgt, typekind=dsttk, rc=localrc)
      if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      
      ! determine which stagger locations are available
      dstslc = 0
      if (dstgt == ESMF_GEOMTYPE_GRID) then
        call ESMF_FieldGet(dstField, grid=dstgrid, rc=localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return

        call ESMF_GridGetCoord(dstgrid, staggerloc=ESMF_STAGGERLOC_CENTER, &
                               isPresent=ecip, rc=localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return

        if (ecip .eqv. .true.) dstslc = 1
        
        call ESMF_GridGetCoord(dstgrid, staggerloc=ESMF_STAGGERLOC_CORNER, &
                               isPresent=ecip, rc=localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return

        if (ecip .eqv. .true.) dstslc = 2
      else if (dstgt == ESMF_GEOMTYPE_MESH) then
        call ESMF_FieldGet(dstField, mesh=dstmesh, rc=localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
        
        ecip = .false.
        call ESMF_MeshGet(dstmesh, elementCoordsIsPresent=ecip, rc=localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return

        dstslc = 1
        if (ecip .eqv. .true.) dstslc = 2
      else if (dstgt == ESMF_GEOMTYPE_XGRID) then
        call ESMF_LogSetError(rcToCheck=ESMF_RC_NOT_IMPL, &
                            msg="- xgrid cannot retrieve areas", &
                            ESMF_CONTEXT, rcToReturn=rc)
      endif

      ! compute the areas
      if (srcslc > 1) then
        if (srcgt == ESMF_GEOMTYPE_GRID) then
          call computeAreaGrid(srcgrid, localPet, srcarea, 0, localrc)
          if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
              ESMF_CONTEXT, rcToReturn=rc)) return
        else if (srcgt == ESMF_GEOMTYPE_MESH) then
          call computeAreaMesh(srcmesh, vm, localPet, petCount, srcarea, localrc)
          if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
              ESMF_CONTEXT, rcToReturn=rc)) return
        endif
      endif

      if (dstslc > 1) then
        if (dstgt == ESMF_GEOMTYPE_GRID) then
          call computeAreaGrid(dstgrid, petCount, dstarea, 0, localrc)
          if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
              ESMF_CONTEXT, rcToReturn=rc)) return
        else if (dstgt == ESMF_GEOMTYPE_MESH) then
          call computeAreaMesh(dstmesh, vm, localPet, petCount, dstarea, localrc)
          if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
              ESMF_CONTEXT, rcToReturn=rc)) return
        endif
      endif

      ! write the weight file
      if (srcslc > 1 .and. dstslc > 1) then
        call ESMF_OutputScripWeightFile(fileName, &
                                        localFactorList, localFactorIndexList, &
                                        srcFile=srcFile, dstFile=dstFile, &
                                        srcFileType=srcFileType, &
                                        dstFileType=dstFileType, &
                                        srcArea=srcArea, &
                                        dstArea=dstArea, &
                                        largeFileFlag=largeFileFlag, &
                                        rc=localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
      else if (srcslc > 1 .and. dstslc == 1) then
        call ESMF_OutputScripWeightFile(fileName, &
                                        localFactorList, localFactorIndexList, &
                                        srcFile=srcFile, dstFile=dstFile, &
                                        srcFileType=srcFileType, &
                                        dstFileType=dstFileType, &
                                        srcArea=srcArea, &
                                        largeFileFlag=largeFileFlag, &
                                        rc=localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
      else if (srcslc == 1 .and. dstslc > 1) then
        call ESMF_OutputScripWeightFile(fileName, &
                                        localFactorList, localFactorIndexList, &
                                        srcFile=srcFile, dstFile=dstFile, &
                                        srcFileType=srcFileType, &
                                        dstFileType=dstFileType, &
                                        dstArea=dstArea, &
                                        largeFileFlag=largeFileFlag, &
                                        rc=localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
      else if (srcslc == 1 .and. dstslc == 1) then
        call ESMF_OutputScripWeightFile(fileName, &
                                        localFactorList, localFactorIndexList, &
                                        srcFile=srcFile, dstFile=dstFile, &
                                        srcFileType=srcFileType, &
                                        dstFileType=dstFileType, &
                                        largeFileFlag=largeFileFlag, &
                                        rc=localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
      else
        call ESMF_LogSetError(rcToCheck=ESMF_RC_VAL_OUTOFRANGE, &
                              msg="- unrecognized area field options", &
                              ESMF_CONTEXT, rcToReturn=rc)
      endif
    else
      call ESMF_LogSetError(rcToCheck=ESMF_RC_VAL_OUTOFRANGE, &
                            msg="- filemode not recognized", &
                            ESMF_CONTEXT, rcToReturn=rc)
    endif
    if (ESMF_LogFoundError(localrc, &
      ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! because ESMF_RouteHandle.this is private, it cannot be accessed directly
    ! we use the public interface to do the ptr copy;
    ! the RouteHandle object returned to the C interface must consist only of
    ! the 'this' pointer. It must not contain the isInit member.
    if (present (createRoutehandle)) then
      if (createRoutehandle .eqv. .true.) then
        call ESMF_RoutehandleCopyThis(l_routehandle, routehandle, localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      endif
    else 
      call ESMF_RoutehandleCopyThis(l_routehandle, routehandle, localrc)
      if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    endif

    deallocate(localFactorList)
    deallocate(localFactorIndexList)

    rc = ESMF_SUCCESS

  end subroutine f_esmf_regridstorefile

#undef  ESMF_METHOD
#define ESMF_METHOD "f_esmf_smmstore"
  subroutine f_esmf_smmstore(srcField, dstField, &
                             filename, routehandle, &
                             ignoreUnmatchedIndices, &
                             srcTermProcessing, &
                             pipeLineDepth, &
                             rc)

    use ESMF_UtilTypesMod
    use ESMF_BaseMod
    use ESMF_LogErrMod
    use ESMF_RHandleMod
    use ESMF_FieldSMMMod
    use ESMF_FieldMod

    use ESMF_FieldGetMod

    implicit none

    type(ESMF_Field)                                :: srcField
    type(ESMF_Field)                                :: dstField
    character(len=*)                                :: filename
    type(ESMF_RouteHandle)                          :: routehandle
    logical,                               optional :: ignoreUnmatchedIndices
    integer,                               optional :: srcTermProcessing
    integer,                               optional :: pipeLineDepth
    integer,                               optional :: rc

    integer :: localrc
    type(ESMF_RouteHandle) :: l_routehandle

    ! initialize return code; assume routine not implemented
    rc = ESMF_RC_NOT_IMPL
    localrc = ESMF_RC_NOT_IMPL
    
    call ESMF_FieldSMMStore(srcField, dstField, &
                            filename, l_routehandle, &
                            ignoreUnmatchedIndices=ignoreUnmatchedIndices, &
                            srcTermProcessing=srcTermProcessing, &
                            pipeLineDepth=pipeLineDepth, &
                            rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! because ESMF_RouteHandle.this is private, it cannot be accessed directly
    ! we use the public interface to do the ptr copy;
    ! the RouteHandle object returned to the C interface must consist only of
    ! the 'this' pointer. It must not contain the isInit member.
    call ESMF_RoutehandleCopyThis(l_routehandle, routehandle, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    rc = ESMF_SUCCESS

  end subroutine f_esmf_smmstore



