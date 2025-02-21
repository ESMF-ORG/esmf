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

module ESMF_srcDynamicMaskMod

  ! !USES:
  use ESMF_UtilTypesMod     ! ESMF utility types
  use ESMF_InitMacrosMod    ! ESMF initializer macros
  use ESMF_LogErrMod
  implicit none
  private

  public :: srcDynMaskProcR4R8R4V
  public :: srcDynMaskProcR8R8R8V
  public :: srcDynMaskProcR4R8R4
  public :: srcDynMaskProcR8R8R8


  contains

  subroutine srcDynMaskProcR4R8R4V(dynamicMaskList, dynamicSrcMaskValue, dynamicDstMaskValue, rc)
    type(ESMF_DynamicMaskElementR4R8R4V), pointer              :: dynamicMaskList(:)
    real(ESMF_KIND_R4),            intent(in), optional :: dynamicSrcMaskValue
    real(ESMF_KIND_R4),            intent(in), optional :: dynamicDstMaskValue
    integer,                       intent(out)          :: rc
    integer :: i, j, k, n
    real(ESMF_KIND_R4), allocatable  :: renorm(:)

    if (associated(dynamicMaskList)) then
      n = size(dynamicMaskList(1)%srcElement(1)%ptr)
      allocate(renorm(n))

      do i=1, size(dynamicMaskList)
        dynamicMaskList(i)%dstElement = 0.0 ! set to zero

        renorm = 0.d0 ! reset
        do j=1, size(dynamicMaskList(i)%factor)
          do k = 1, size(dynamicMaskList(i)%srcElement(j)%ptr)
            if (.not. &
              match_r4(dynamicSrcMaskValue,dynamicMaskList(i)%srcElement(j)%ptr(k))) then
              dynamicMaskList(i)%dstElement(k) = dynamicMaskList(i)%dstElement(k) &
              + dynamicMaskList(i)%factor(j) * dynamicMaskList(i)%srcElement(j)%ptr(k)
                     renorm(k) = renorm(k) + dynamicMaskList(i)%factor(j)
            endif
          end do
        end do
        where (renorm > 0.d0)
          dynamicMaskList(i)%dstElement = dynamicMaskList(i)%dstElement / renorm
        elsewhere
            dynamicMaskList(i)%dstElement = dynamicSrcMaskValue
        end where
      enddo
    endif
    rc = ESMF_SUCCESS
  end subroutine srcDynMaskProcR4R8R4V

  subroutine srcDynMaskProcR8R8R8V(dynamicMaskList, dynamicSrcMaskValue, dynamicDstMaskValue, rc)
    type(ESMF_DynamicMaskElementR8R8R8V), pointer              :: dynamicMaskList(:)
    real(ESMF_KIND_R8),            intent(in), optional :: dynamicSrcMaskValue
    real(ESMF_KIND_R8),            intent(in), optional :: dynamicDstMaskValue
    integer,                       intent(out)          :: rc
    integer :: i, j, k, n
    real(ESMF_KIND_R8), allocatable  :: renorm(:)

    if (associated(dynamicMaskList)) then
      n = size(dynamicMaskList(1)%srcElement(1)%ptr)
      allocate(renorm(n))

      do i=1, size(dynamicMaskList)
        dynamicMaskList(i)%dstElement = 0.0 ! set to zero

        renorm = 0.d0 ! reset
        do j=1, size(dynamicMaskList(i)%factor)
          do k = 1, size(dynamicMaskList(i)%srcElement(j)%ptr)
            if (.not. &
              match_r8(dynamicSrcMaskValue,dynamicMaskList(i)%srcElement(j)%ptr(k))) then
              dynamicMaskList(i)%dstElement(k) = dynamicMaskList(i)%dstElement(k) &
              + dynamicMaskList(i)%factor(j) * dynamicMaskList(i)%srcElement(j)%ptr(k)
                     renorm(k) = renorm(k) + dynamicMaskList(i)%factor(j)
            endif
          end do
        end do
        where (renorm > 0.d0)
          dynamicMaskList(i)%dstElement = dynamicMaskList(i)%dstElement / renorm
        elsewhere
            dynamicMaskList(i)%dstElement = dynamicSrcMaskValue
        end where
      enddo
    endif
    rc = ESMF_SUCCESS
  end subroutine srcDynMaskProcR8R8R8V

  subroutine srcDynMaskProcR8R8R8(dynamicMaskList, dynamicSrcMaskValue, &
    dynamicDstMaskValue, rc)
    type(ESMF_DynamicMaskElementR8R8R8), pointer        :: dynamicMaskList(:)
    real(ESMF_KIND_R8),            intent(in), optional :: dynamicSrcMaskValue
    real(ESMF_KIND_R8),            intent(in), optional :: dynamicDstMaskValue
    integer,                       intent(out)          :: rc
    integer :: i, j
    real(ESMF_KIND_R8)  :: renorm
    if (associated(dynamicMaskList)) then
      do i=1, size(dynamicMaskList)
        dynamicMaskList(i)%dstElement = 0.d0 ! set to zero
        renorm = 0.d0 ! reset
        do j=1, size(dynamicMaskList(i)%factor)
          if (.not. &
            match_r8(dynamicSrcMaskValue,dynamicMaskList(i)%srcElement(j))) then
            dynamicMaskList(i)%dstElement = dynamicMaskList(i)%dstElement &
              + dynamicMaskList(i)%factor(j) &
              * dynamicMaskList(i)%srcElement(j)
            renorm = renorm + dynamicMaskList(i)%factor(j)
          endif
        enddo
        if (renorm > 0.d0) then
          dynamicMaskList(i)%dstElement = dynamicMaskList(i)%dstElement / renorm
        else if (present(dynamicSrcMaskValue)) then
          dynamicMaskList(i)%dstElement = dynamicSrcMaskValue
        else
          rc = ESMF_RC_ARG_BAD  ! error detected
          return
        endif
      enddo
    endif
    ! return successfully
    rc = ESMF_SUCCESS
  end subroutine srcDynMaskProcR8R8R8

  subroutine srcDynMaskProcR4R8R4(dynamicMaskList, dynamicSrcMaskValue, &
    dynamicDstMaskValue, rc)
    type(ESMF_DynamicMaskElementR4R8R4), pointer        :: dynamicMaskList(:)
    real(ESMF_KIND_R4),            intent(in), optional :: dynamicSrcMaskValue
    real(ESMF_KIND_R4),            intent(in), optional :: dynamicDstMaskValue
    integer,                       intent(out)          :: rc
    integer :: i, j
    real(ESMF_KIND_R8)  :: renorm
    if (associated(dynamicMaskList)) then
      do i=1, size(dynamicMaskList)
        dynamicMaskList(i)%dstElement = 0.d0 ! set to zero
        renorm = 0.d0 ! reset
        do j=1, size(dynamicMaskList(i)%factor)
          if (.not. &
            match_r4(dynamicSrcMaskValue,dynamicMaskList(i)%srcElement(j))) then
            dynamicMaskList(i)%dstElement = dynamicMaskList(i)%dstElement &
              + dynamicMaskList(i)%factor(j) &
              * dynamicMaskList(i)%srcElement(j)
            renorm = renorm + dynamicMaskList(i)%factor(j)
          endif
        enddo
        if (renorm > 0.d0) then
          dynamicMaskList(i)%dstElement = dynamicMaskList(i)%dstElement / renorm
        else if (present(dynamicSrcMaskValue)) then
          dynamicMaskList(i)%dstElement = dynamicSrcMaskValue
        else
          rc = ESMF_RC_ARG_BAD  ! error detected
          return
        endif
      enddo
    endif
    ! return successfully
    rc = ESMF_SUCCESS
  end subroutine srcDynMaskProcR4R8R4

  logical function match_r4(missing,b)
    real(ESMF_KIND_R4), intent(in) :: missing, b
    match_r4 = (missing==b)
  end function match_r4

  logical function match_r8(missing,b)
    real(ESMF_KIND_R8), intent(in) :: missing, b
    match_r8 = (missing==b)
  end function match_r8

end module ESMF_srcDynamicMaskMod

