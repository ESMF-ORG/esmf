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

module ESMF_dstDynamicMaskMod

  ! !USES:
  use ESMF_UtilTypesMod     ! ESMF utility types
  use ESMF_InitMacrosMod    ! ESMF initializer macros
  use ESMF_LogErrMod
  implicit none
  private

  public :: dstDynMaskProcR4R8R4V
  public :: dstDynMaskProcR8R8R8V
  public :: dstDynMaskProcR4R8R4
  public :: dstDynMaskProcR8R8R8


  contains

  subroutine dstDynMaskProcR4R8R4V(dynamicMaskList, dynamicSrcMaskValue, dynamicDstMaskValue, rc)
    type(ESMF_DynamicMaskElementR4R8R4V), pointer              :: dynamicMaskList(:)
    real(ESMF_KIND_R4),            intent(in), optional :: dynamicSrcMaskValue
    real(ESMF_KIND_R4),            intent(in), optional :: dynamicDstMaskValue
    integer,                       intent(out)          :: rc
    integer :: i, j, k

    if (associated(dynamicMaskList)) then
      do i=1, size(dynamicMaskList)
        do k = 1, size(dynamicMaskList(i)%dstElement)
          if (.not. match_r4(dynamicDstMaskValue,dynamicMaskList(i)%dstElement(k))) then
             dynamicMaskList(i)%dstElement(k)=0.0
             do j=1, size(dynamicMaskList(i)%factor)
                 dynamicMaskList(i)%dstElement(k) = dynamicMaskList(i)%dstElement(k) &
                 + dynamicMaskList(i)%factor(j) * dynamicMaskList(i)%srcElement(j)%ptr(k)
             enddo  
          end if
        end do
      enddo
    endif
    rc = ESMF_SUCCESS
  end subroutine dstDynMaskProcR4R8R4V

  subroutine dstDynMaskProcR8R8R8V(dynamicMaskList, dynamicSrcMaskValue, dynamicDstMaskValue, rc)
    type(ESMF_DynamicMaskElementR8R8R8V), pointer              :: dynamicMaskList(:)
    real(ESMF_KIND_R8),            intent(in), optional :: dynamicSrcMaskValue
    real(ESMF_KIND_R8),            intent(in), optional :: dynamicDstMaskValue
    integer,                       intent(out)          :: rc
    integer :: i, j, k

    if (associated(dynamicMaskList)) then
      do i=1, size(dynamicMaskList)
        do k = 1, size(dynamicMaskList(i)%dstElement)
          if (.not. match_r8(dynamicDstMaskValue,dynamicMaskList(i)%dstElement(k))) then
             dynamicMaskList(i)%dstElement(k)=0.d0
             do j=1, size(dynamicMaskList(i)%factor)
                 dynamicMaskList(i)%dstElement(k) = dynamicMaskList(i)%dstElement(k) &
                 + dynamicMaskList(i)%factor(j) * dynamicMaskList(i)%srcElement(j)%ptr(k)
             enddo  
          end if
        end do
      enddo
    endif
    rc = ESMF_SUCCESS
  end subroutine dstDynMaskProcR8R8R8V

  subroutine dstDynMaskProcR8R8R8(dynamicMaskList, dynamicSrcMaskValue, &
    dynamicDstMaskValue, rc)
    type(ESMF_DynamicMaskElementR8R8R8), pointer        :: dynamicMaskList(:)
    real(ESMF_KIND_R8),            intent(in), optional :: dynamicSrcMaskValue
    real(ESMF_KIND_R8),            intent(in), optional :: dynamicDstMaskValue
    integer,                       intent(out)          :: rc
    integer :: i, j
    if (associated(dynamicMaskList)) then
      do i=1, size(dynamicMaskList)
        if (.not. match_r8(dynamicDstMaskValue, dynamicMaskList(i)%dstElement)) then
           dynamicMaskList(i)%dstElement=0.d0
           do j=1, size(dynamicMaskList(i)%factor)
               dynamicMaskList(i)%dstElement = dynamicMaskList(i)%dstElement &
                 + dynamicMaskList(i)%factor(j) &
                 * dynamicMaskList(i)%srcElement(j)
           enddo
        endif
      enddo
    endif
    ! return successfully
    rc = ESMF_SUCCESS
  end subroutine dstDynMaskProcR8R8R8

  subroutine dstDynMaskProcR4R8R4(dynamicMaskList, dynamicSrcMaskValue, &
    dynamicDstMaskValue, rc)
    type(ESMF_DynamicMaskElementR4R8R4), pointer        :: dynamicMaskList(:)
    real(ESMF_KIND_R4),            intent(in), optional :: dynamicSrcMaskValue
    real(ESMF_KIND_R4),            intent(in), optional :: dynamicDstMaskValue
    integer,                       intent(out)          :: rc
    integer :: i, j
    if (associated(dynamicMaskList)) then
      do i=1, size(dynamicMaskList)
        if (.not. match_r4(dynamicDstMaskValue, dynamicMaskList(i)%dstElement)) then
           dynamicMaskList(i)%dstElement=0.0
           do j=1, size(dynamicMaskList(i)%factor)
               dynamicMaskList(i)%dstElement = dynamicMaskList(i)%dstElement &
                 + dynamicMaskList(i)%factor(j) &
                 * dynamicMaskList(i)%srcElement(j)
           enddo
        endif
      enddo
    endif
    ! return successfully
    rc = ESMF_SUCCESS
  end subroutine dstDynMaskProcR4R8R4

  logical function match_r4(missing,b)
    real(ESMF_KIND_R4), intent(in) :: missing, b
    match_r4 = (missing==b)
  end function match_r4

  logical function match_r8(missing,b)
    real(ESMF_KIND_R8), intent(in) :: missing, b
    match_r8 = (missing==b)
  end function match_r8

end module ESMF_dstDynamicMaskMod

