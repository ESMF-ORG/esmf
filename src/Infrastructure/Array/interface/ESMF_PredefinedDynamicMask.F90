! $Id$
!
! Earth System Modeling Framework
! Copyright (c) 2002-2024, University Corporation for Atmospheric Research,
! Massachusetts Institute of Technology, Geophysical Fluid Dynamics
! Laboratory, University of Michigan, National Centers for Environmental
! Prediction, Los Alamos National Laboratory, Argonne National Laboratory,
! NASA Goddard Space Flight Center.
! Licensed under the University of Illinois-NCSA License.
!
#include "ESMF.h"

module ESMF_PredefinedDynamicMaskMod

  ! !USES:
  use ESMF_UtilTypesMod     ! ESMF utility types
  use ESMF_DynamicMaskMod
  use ESMF_InitMacrosMod    ! ESMF initializer macros
  use ESMF_LogErrMod
  use ESMF_srcDynamicMaskMod
  use ESMF_dstDynamicMaskMod
  use ESMF_voteDynamicMaskMod
  implicit none
  private

!------------------------------------------------------------------------------
! ! ESMF_CubedSphereTransform_Args
!
!------------------------------------------------------------------------------
  type ESMF_PredefinedDynamicMask
    real(ESMF_KIND_R4) :: srcMaskValue_R4
    real(ESMF_KIND_R4) :: dstMaskValue_R4
    real(ESMF_KIND_R8) :: srcMaskValue_R8
    real(ESMF_KIND_R8) :: dstMaskValue_R8
    type(ESMF_PredefinedDynamicMask_Flag) :: maskType
    contains 
       procedure :: create_DynamicMask
  end type


  public :: ESMF_PredefinedDynamicMask 
  public :: ESMF_PredefinedDynamicMaskSet

  contains

  subroutine ESMF_PredefinedDynamicMaskSet(preDefinedDynamicMask,srcMaskValueR4,dstMaskValueR4,srcMaskValueR8,dstMaskValueR8,maskType,rc)
    type(ESMF_PredefinedDynamicMask), intent(out) :: preDefinedDynamicMask
    real(ESMF_KIND_R4), intent(in), optional :: srcMaskValueR4
    real(ESMF_KIND_R4), intent(in), optional :: dstMaskValueR4
    real(ESMF_KIND_R8), intent(in), optional :: srcMaskValueR8
    real(ESMF_KIND_R8), intent(in), optional :: dstMaskValueR8
    type(ESMF_PredefinedDynamicMask_Flag), intent(in), optional :: maskType
    integer, optional, intent(out) :: rc

    if (present(srcMaskValueR4)) preDefinedDynamicMask%srcMaskValue_R4=srcMaskValueR4
    if (present(dstMaskValueR4)) preDefinedDynamicMask%dstMaskValue_R4=dstMaskValueR4
    if (present(srcMaskValueR8)) preDefinedDynamicMask%srcMaskValue_R8=srcMaskValueR8
    if (present(dstMaskValueR8)) preDefinedDynamicMask%dstMaskValue_R8=dstMaskValueR8
    if (present(maskType)) preDefinedDynamicMask%maskType=maskType

    if (present(rc)) rc =ESMF_SUCCESS

  end subroutine ESMF_PredefinedDynamicMaskSet 

  function create_DynamicMask(this, src_type, dst_type, rc) result(dynamicMask)
     type(ESMF_DynamicMask) :: dynamicMask
     class(ESMF_PredefinedDynamicMask), intent(in) :: this
     type(ESMF_TypeKind_Flag), intent(in) :: src_type
     type(ESMF_TypeKind_Flag), intent(in) :: dst_type
     integer, optional, intent(out) :: rc
     integer :: localrc
     type(ESMF_TypeKind_Flag) :: mask_type
     
     mask_type = get_mask_type(src_type, dst_type, rc) 

     if (this%maskType == ESMF_PREDEFINEDDYNAMICMASK_MASKSRCV) then
        if (mask_type == ESMF_TYPEKIND_R4) then 
           call ESMF_DynamicMaskSetR4R8R4V(dynamicMask, srcDynMaskProcR4R8R4V ,dynamicSrcMaskValue=this%srcMaskValue_R4, handleAllElements=.true.)
        else if (mask_type == ESMF_TYPEKIND_R8) then
           call ESMF_DynamicMaskSetR8R8R8V(dynamicMask, srcDynMaskProcR8R8R8V ,dynamicSrcMaskValue=this%srcMaskValue_R8, handleAllElements=.true.)
        end if
     else if (this%maskType == ESMF_PREDEFINEDDYNAMICMASK_MASKSRC) then
        if (mask_type == ESMF_TYPEKIND_R4) then 
           call ESMF_DynamicMaskSetR4R8R4(dynamicMask, srcDynMaskProcR4R8R4 ,dynamicSrcMaskValue=this%srcMaskValue_R4, handleAllElements=.true.)
        else if (mask_type == ESMF_TYPEKIND_R8) then
           call ESMF_DynamicMaskSetR8R8R8(dynamicMask, srcDynMaskProcR8R8R8 ,dynamicSrcMaskValue=this%srcMaskValue_R8, handleAllElements=.true.)
        end if
     else if (this%maskType == ESMF_PREDEFINEDDYNAMICMASK_MASKDESTV) then
        if (mask_type == ESMF_TYPEKIND_R4) then 
           call ESMF_DynamicMaskSetR4R8R4V(dynamicMask, dstDynMaskProcR4R8R4V ,dynamicSrcMaskValue=this%srcMaskValue_R4, handleAllElements=.true.)
        else if (mask_type == ESMF_TYPEKIND_R8) then
           call ESMF_DynamicMaskSetR8R8R8V(dynamicMask, dstDynMaskProcR8R8R8V ,dynamicSrcMaskValue=this%srcMaskValue_R8, handleAllElements=.true.)
        end if
     else if (this%maskType == ESMF_PREDEFINEDDYNAMICMASK_MASKDEST) then
        if (mask_type == ESMF_TYPEKIND_R4) then 
           call ESMF_DynamicMaskSetR4R8R4(dynamicMask, dstDynMaskProcR4R8R4 ,dynamicDstMaskValue=this%dstMaskValue_R4, handleAllElements=.true.)
        else if (mask_type == ESMF_TYPEKIND_R8) then
           call ESMF_DynamicMaskSetR8R8R8(dynamicMask, dstDynMaskProcR8R8R8 ,dynamicDstMaskValue=this%dstMaskValue_R8, handleAllElements=.true.)
        end if
     else if (this%maskType == ESMF_PREDEFINEDDYNAMICMASK_MASKVOTEV) then
        if (mask_type == ESMF_TYPEKIND_R4) then 
           call ESMF_DynamicMaskSetR4R8R4V(dynamicMask, voteDynMaskProcR4R8R4V ,dynamicSrcMaskValue=this%srcMaskValue_R4, handleAllElements=.true.)
        else if (mask_type == ESMF_TYPEKIND_R8) then
           call ESMF_DynamicMaskSetR8R8R8V(dynamicMask, voteDynMaskProcR8R8R8V ,dynamicSrcMaskValue=this%srcMaskValue_R8, handleAllElements=.true.)
        end if
     else if (this%maskType == ESMF_PREDEFINEDDYNAMICMASK_MASKVOTE) then
        if (mask_type == ESMF_TYPEKIND_R4) then 
           call ESMF_DynamicMaskSetR4R8R4(dynamicMask, voteDynMaskProcR4R8R4 ,dynamicDstMaskValue=this%dstMaskValue_R4, handleAllElements=.true.)
        else if (mask_type == ESMF_TYPEKIND_R8) then
           call ESMF_DynamicMaskSetR8R8R8(dynamicMask, voteDynMaskProcR8R8R8 ,dynamicDstMaskValue=this%dstMaskValue_R8, handleAllElements=.true.)
        end if
     else
        localrc = ESMF_RC_NOT_IMPL
        if (ESMF_LogFoundError(rcTocheck=localrc, &
           ESMF_ERR_PASSTHRU, &
           line=__LINE__, file=__FILE__, rcToReturn=rc)) return
     end if
     if (present(rc)) rc=ESMF_SUCCESS
  end function create_DynamicMask

  function get_mask_type(src_type, dst_type, rc) result(mask_type)
     type(ESMF_TypeKind_Flag) :: mask_type
     type(ESMF_TypeKind_Flag), intent(in) :: src_type
     type(ESMF_TypeKind_Flag), intent(in) :: dst_type
     integer, optional, intent(out)       :: rc

     integer :: localrc

     if (src_type == dst_type) then
        mask_type = src_type
     else
        if ((src_type .eq. ESMF_TYPEKIND_R4) .and. (dst_type .eq. ESMF_NOKIND)) then
           mask_type = ESMF_TYPEKIND_R4
        else if ((src_type .eq. ESMF_TYPEKIND_R8) .and. (dst_type .eq. ESMF_NOKIND)) then
           mask_type = ESMF_TYPEKIND_R8
        else if ((dst_type .eq. ESMF_TYPEKIND_R4) .and. (src_type .eq. ESMF_NOKIND)) then
           mask_type = ESMF_TYPEKIND_R4
        else if ((dst_type .eq. ESMF_TYPEKIND_R8) .and. (src_type .eq. ESMF_NOKIND)) then
           mask_type = ESMF_TYPEKIND_R8
        end if
     end if
     if (present(rc)) rc=ESMF_SUCCESS

  end function get_mask_type

end module ESMF_PredefinedDynamicMaskMod

