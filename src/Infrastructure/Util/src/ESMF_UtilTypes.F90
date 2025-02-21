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
#define ESMF_FILENAME "ESMF_UtilTypes.F90"

!
! ESMF UtilTypes Module
!
! (all lines between the !BOP and !EOP markers will be included in the
! automated document processing.)
!------------------------------------------------------------------------------
! one blank line for protex processing - in case all routines here are
! marked internal (BOPI/EOPI), the output file will still have contents.
!BOP

!EOP

!------------------------------------------------------------------------------
! module definition

      module ESMF_UtilTypesMod
 
#include "ESMF.h"

!BOPI
! !MODULE: ESMF_UtilTypesMod - General utility/generic derived types and parms
!
! !DESCRIPTION:
!
! Common derived types and parameters which are not specifically associated
! with any one class.  Generally this must be updated strictly in sync with
! the corresponding ESMC_Util.h include file and/or ESMC_Util.C source file.
!
! See the ESMF Developers Guide document for more details.
!
!------------------------------------------------------------------------------

! !USES:
  use iso_c_binding
      ! inherit from ESMF base class
!     use ESMF_UtilTypesMod
 !!  use ESMF_InitMacrosMod Commented out to prevent circular dependency
 !!                         this is possible because since all the checks
 !!                         in this module are shallow - Bob 1/9/2007.

      implicit none
!
! !PRIVATE TYPES:
      private

!------------------------------------------------------------------------------
!
!     ! WARNING: 
!     !  constants MUST match corresponding values in ../include/ESMC_Macros.h
!
!EOPI
!BOPI

!    !PUBLIC TYPES:
!    !Global integer parameters

      integer, parameter :: ESMF_SUCCESS = 0, ESMF_FAILURE = -1

! General non-specific string length
      integer, parameter :: ESMF_MAXSTR = 256

! Maximum length of a file name, including its path.
      integer, parameter :: ESMF_MAXPATHLEN = 1024

! TODO:FIELDINTEGRATION Adjust MAXGRIDDIM
      integer, parameter :: ESMF_MAXDIM = 7, &
                            ESMF_MAXIGRIDDIM = 3, &
                            ESMF_MAXGRIDDIM = 3
     
!EOPI

      integer, parameter :: ESMF_VERSION_MAJOR        = 8
      integer, parameter :: ESMF_VERSION_MINOR        = 9
      integer, parameter :: ESMF_VERSION_REVISION     = 0
      integer, parameter :: ESMF_VERSION_PATCHLEVEL   = 0
      logical, parameter :: ESMF_VERSION_PUBLIC       = .false.
      logical, parameter :: ESMF_VERSION_BETASNAPSHOT = .true.

      character(*), parameter :: ESMF_VERSION_STRING  = "8.9.0 beta snapshot"

#if defined (ESMF_NETCDF)
      logical, parameter :: ESMF_IO_NETCDF_PRESENT = .true.
#else
      logical, parameter :: ESMF_IO_NETCDF_PRESENT = .false.
#endif

#if defined (ESMF_PIO)
      logical, parameter :: ESMF_IO_PIO_PRESENT = .true.
#else
      logical, parameter :: ESMF_IO_PIO_PRESENT = .false.
#endif

#if defined (ESMF_PNETCDF)
      logical, parameter :: ESMF_IO_PNETCDF_PRESENT = .true.
#else
      logical, parameter :: ESMF_IO_PNETCDF_PRESENT = .false.
#endif

! Needs to be kept in line with ESMC_ATT_UNGRIDDED_DIM_LABELS and
! ESMC_ATT_UNGRIDDED_DIM_LABELS in ../include/ESMCI_Util.h

      character(32), parameter :: ESMF_ATT_GRIDDED_DIM_LABELS   = 'ESMF:gridded_dim_labels'
      character(32), parameter :: ESMF_ATT_UNGRIDDED_DIM_LABELS = 'ESMF:ungridded_dim_labels'

! Needs to be kept in line with MESH_POLYBREAK_IND
! in ESMCI_Mesh.h
  integer, parameter :: ESMF_MESH_POLYBREAK=-7

!------------------------------------------------------------------------------
!
!    ! Keyword enforcement type

     type ESMF_KeywordEnforcer
       private
       integer:: quiet
     end type

!------------------------------------------------------------------------------
!
!    ! General object status, useful for any object

!     ! WARNING: 
!     !  constants MUST match corresponding values in ../include/ESMCI_Util.h

      type ESMF_Status
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      private
          integer :: status
      end type

      type(ESMF_Status), parameter :: ESMF_STATUS_UNINIT = ESMF_Status(1), &
                                      ESMF_STATUS_READY = ESMF_Status(2), &
                                      ESMF_STATUS_UNALLOCATED = ESMF_Status(3), &
                                      ESMF_STATUS_ALLOCATED = ESMF_Status(4), &
                                      ESMF_STATUS_BUSY = ESMF_Status(5), &
                                      ESMF_STATUS_INVALID = ESMF_Status(6), &
                                      ESMF_STATUS_NOT_READY = ESMF_Status(7)
 
!------------------------------------------------------------------------------
!
!    ! Generic pointer, large enough to hold a pointer on any architecture,
!    ! but not useful directly in Fortran.  Expected to be used where a
!    ! pointer generated in C++ needs to be stored on the Fortran side.

!     ! WARNING: 
!     !  constants MUST match corresponding values in ../include/ESMC_Util.h

      type ESMF_Pointer
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      !private
#if 1
          integer(C_SIZE_T) :: ptr
#else
#if (ESMC_POINTER_SIZE == 4)
          integer(selected_int_kind( 9)) :: ptr
#else
          integer(selected_int_kind(18)) :: ptr
#endif
#endif
      end type

      type(ESMF_Pointer), parameter :: ESMF_NULL_POINTER = ESMF_Pointer(0), &
                                       ESMF_BAD_POINTER = ESMF_Pointer(-1)
 
!------------------------------------------------------------------------------
!
!    ! Where we can use a derived type, the compiler will help do 
!    ! typechecking.  For those places where the compiler refuses to allow
!    ! anything but an Integer data type, use the second set of constants.

!     ! WARNING: 
!     !  constants MUST match corresponding values in ../include/ESMC_Util.h

      type ESMF_TypeKind_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      ! TODO: can this be made private now?
      !!private
        integer :: dkind
      end type

      ! these work well for internal ESMF use, arguments, etc
#ifndef ESMF_NO_INTEGER_1_BYTE 
      type(ESMF_TypeKind_Flag), parameter :: &
                   ESMF_TYPEKIND_I1 = ESMF_TypeKind_Flag(1)
#endif
#ifndef ESMF_NO_INTEGER_2_BYTE 
      type(ESMF_TypeKind_Flag), parameter :: &
                   ESMF_TYPEKIND_I2 = ESMF_TypeKind_Flag(2)
#endif
      type(ESMF_TypeKind_Flag), parameter :: &
                   ESMF_TYPEKIND_I4 = ESMF_TypeKind_Flag(3), &
                   ESMF_TYPEKIND_I8 = ESMF_TypeKind_Flag(4), &
                   ESMF_TYPEKIND_R4 = ESMF_TypeKind_Flag(5), &
                   ESMF_TYPEKIND_R8 = ESMF_TypeKind_Flag(6), &
                   ESMF_TYPEKIND_C8 = ESMF_TypeKind_Flag(7), &
                   ESMF_TYPEKIND_C16 = ESMF_TypeKind_Flag(8), &
                   ESMF_TYPEKIND_LOGICAL = ESMF_TypeKind_Flag(9), &
                   ESMF_TYPEKIND_CHARACTER = ESMF_TypeKind_Flag(10), &
                   ESMF_TYPEKIND_I  = ESMF_TypeKind_Flag(90), &
                   ESMF_TYPEKIND_R  = ESMF_TypeKind_Flag(91), &
                   ESMF_NOKIND = ESMF_TypeKind_Flag(99)

      ! these are the only Fortran kind parameters supported
      ! by ESMF.

#ifndef ESMF_NO_INTEGER_1_BYTE 
      integer, parameter :: &
                   ESMF_KIND_I1 = selected_int_kind(2)
#endif
#ifndef ESMF_NO_INTEGER_2_BYTE 
      integer, parameter :: &
                   ESMF_KIND_I2 = selected_int_kind(4)
#endif
      integer, parameter :: &
                   ESMF_KIND_I4 = selected_int_kind(9)
#ifndef ESMF_NEC_KIND_I8
      integer, parameter :: &
                   ESMF_KIND_I8 = selected_int_kind(18)
#else
      integer, parameter :: &
                   ESMF_KIND_I8 = selected_int_kind(15)
#endif
      integer, parameter :: &
                   ESMF_KIND_R4 = selected_real_kind(3,25), &
                   ESMF_KIND_R8 = selected_real_kind(6,45), &
                   ESMF_KIND_C8 = selected_real_kind(3,25), &
                   ESMF_KIND_C16 = selected_real_kind(6,45)

      integer :: defaultIntegerDummy    ! Needed to define ESMF_KIND_I
      real    :: defaultRealDummy       ! Needed to define ESMF_KIND_R
      integer, parameter :: &
                   ESMF_KIND_I = kind(defaultIntegerDummy), &
                   ESMF_KIND_R = kind(defaultRealDummy)

!------------------------------------------------------------------------------
!
!    ! Character array pointer.  For use when arrays of character pointers
!    ! are needed, but can not be directly coded due to Fortran semantics.

     type ESMF_CharPtr
#ifndef ESMF_NO_SEQUENCE
    sequence
#endif
       character(1), pointer :: cptr(:) => null ()
     end type

!------------------------------------------------------------------------------
!
!    ! Types useful to pass arrays of arrays into Fortran API

     type ESMF_PtrInt1D
       integer, pointer :: ptr(:) => null ()
     end type

     type ESMF_PtrR4D1
       real(ESMF_KIND_R4), pointer :: ptr(:) => null ()
     end type

     type ESMF_PtrR8D1
       real(ESMF_KIND_R8), pointer :: ptr(:) => null ()
     end type

!------------------------------------------------------------------------------
!    ! Size of default integer, in character storage units.
!    ! (TODO: In F2003 this could be calculated using the named constants
!    ! in the iso_fortran_env intrinsic module, by simply dividing
!    ! NUMERIC_STORAGE_SIZE by CHARACTER_STORAGE_SIZE.)
      integer, parameter :: ESMF_SIZEOF_DEFINT = 4 


! Needs to be kept the same as ESMC_REGRID_STATUS... in 
! .../Mesh/include/ESMCI_MeshRegrid.h
  integer(ESMF_KIND_I4) , parameter :: ESMF_REGRIDSTATUS_DSTMASKED=0
  integer(ESMF_KIND_I4) , parameter :: ESMF_REGRIDSTATUS_SRCMASKED=1
  integer(ESMF_KIND_I4) , parameter :: ESMF_REGRIDSTATUS_OUTSIDE=2
  integer(ESMF_KIND_I4) , parameter :: ESMF_REGRIDSTATUS_SMSK_OUT=3
  integer(ESMF_KIND_I4) , parameter :: ESMF_REGRIDSTATUS_MAPPED=4
  integer(ESMF_KIND_I4) , parameter :: ESMF_REGRIDSTATUS_SMSK_MP=5
  integer(ESMF_KIND_I4) , parameter :: ESMF_REGRIDSTATUS_OUT_MP=6
  integer(ESMF_KIND_I4) , parameter :: ESMF_REGRIDSTATUS_SMSK_OUT_MP=7
  integer(ESMF_KIND_I4) , parameter :: ESMF_REGRIDSTATUS_EXMAPPED=8

!------------------------------------------------------------------------------
!
!    ! Dummy structure which must just be big enough to hold the values.
!    ! actual data values will always be accessed on the C++ side.

      type ESMF_DataValue
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      private
          integer :: pad
      end type

!------------------------------------------------------------------------------
!     ! ESMF_MapPtr - used to provide Fortran access to C++ STL map containers
!     ! for associative lookup name-pointer pairs.

      type ESMF_MapPtr
#ifndef ESMF_NO_SEQUENCE
        sequence
#endif
        !private
        type(ESMF_Pointer) :: this
        ! only used internally -> no init macro!
      end type


!------------------------------------------------------------------------------
!
!    ! Integer object type id, one for each ESMF Object type 
!    ! plus a string "official" object name.   Keep this in sync
!    ! with the C++ version!!

      type ESMF_ObjectID
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      !private
          integer :: objectID
          character (len=32) :: objectName
#if 0 
          ESMF_INIT_DECLARE
#endif
      end type

      ! Note:  any changes made to this Fortran list must also be made to
      !        the corresponding C++ list in ESMCI_Util.C

      ! Caution:  The NAG compiler v5.2 error-exits if there are blank lines in
      !           this list.

      ! these work well for internal ESMF use, arguments, etc
      type(ESMF_ObjectID), parameter :: &
        ESMF_ID_BASE           = ESMF_ObjectID(1,  "ESMF_Base"), &
        ESMF_ID_LOGERR         = ESMF_ObjectID(2,  "ESMF_LogErr"), &
        ESMF_ID_TIME           = ESMF_ObjectID(3,  "ESMF_Time"), &
        ESMF_ID_CALENDAR       = ESMF_ObjectID(4,  "ESMF_Calendar"), &
        ESMF_ID_TIMEINTERVAL   = ESMF_ObjectID(5,  "ESMF_TimeInterval"), &
        ESMF_ID_ALARM          = ESMF_ObjectID(6,  "ESMF_Alarm"), &
        ESMF_ID_CLOCK          = ESMF_ObjectID(7,  "ESMF_Clock"), &
        ESMF_ID_ARRAYSPEC      = ESMF_ObjectID(8,  "ESMF_ArraySpec"), &
        ESMF_ID_LOCALARRAY     = ESMF_ObjectID(9,  "ESMF_LocalArray"), &
        ESMF_ID_ARRAYBUNDLE    = ESMF_ObjectID(10, "ESMF_ArrayBundle"), &
        ESMF_ID_VM             = ESMF_ObjectID(11, "ESMF_VM"), &
        ESMF_ID_DELAYOUT       = ESMF_ObjectID(12, "ESMF_DELayout"), &
        ESMF_ID_CONFIG         = ESMF_ObjectID(13, "ESMF_Config"), &
        ESMF_ID_ARRAY          = ESMF_ObjectID(14, "ESMF_Array"), &
        ESMF_ID_PHYSGRID       = ESMF_ObjectID(15, "ESMF_PhysGrid"), &
        ESMF_ID_IGRID          = ESMF_ObjectID(16, "ESMF_IGrid"), &
        ESMF_ID_EXCHANGEPACKET = ESMF_ObjectID(17, "ESMF_ExchangePacket"), &
        ESMF_ID_COMMTABLE      = ESMF_ObjectID(18, "ESMF_CommTable"), &
        ESMF_ID_ROUTETABLE     = ESMF_ObjectID(19, "ESMF_RouteTable"), &
        ESMF_ID_ROUTE          = ESMF_ObjectID(20, "ESMF_Route"), &
        ESMF_ID_ROUTEHANDLE    = ESMF_ObjectID(21, "ESMF_RouteHandle"), &
        ESMF_ID_FIELDDATAMAP   = ESMF_ObjectID(22, "ESMF_FieldDataMap"), &
        ESMF_ID_FIELD          = ESMF_ObjectID(23, "ESMF_Field"), &
        ESMF_ID_BUNDLEDATAMAP  = ESMF_ObjectID(24, "ESMF_FieldBundleDataMap"), &
        ESMF_ID_FIELDBUNDLE    = ESMF_ObjectID(25, "ESMF_FieldBundle"), &
        ESMF_ID_GEOMBASE       = ESMF_ObjectID(26, "ESMF_GeomBase"), &
        ESMF_ID_REGRID         = ESMF_ObjectID(27, "ESMF_Regrid"), &
        ESMF_ID_LOCSTREAM      = ESMF_ObjectID(28, "ESMF_Locstream"), &
        ESMF_ID_STATE          = ESMF_ObjectID(29, "ESMF_State"), &
        ESMF_ID_GRIDCOMPONENT  = ESMF_ObjectID(30, "ESMF_GridComponent"), &
        ESMF_ID_CPLCOMPONENT   = ESMF_ObjectID(31, "ESMF_CplComponent"), &
        ESMF_ID_COMPONENT      = ESMF_ObjectID(32, "ESMF_Component"), &
        ESMF_ID_XGRID          = ESMF_ObjectID(33, "ESMF_XGrid"), &
        ESMF_ID_NONE           = ESMF_ObjectID(99, "ESMF_None")

!------------------------------------------------------------------------------
!------------------------------------------------------------------------------
!
!     ! Typed true/false values which are not compiler dependent, so that
!     ! when crossing the Fortran/C++ language boundary with logical values we
!     ! have a consistent interpretation.  In C/C++ 0=false, 1=true, but this
!     ! is not defined for Fortran and different compilers use different values
!     ! for booleans.

!     ! WARNING: must match corresponding values in ../include/ESMC_Util.h

      type ESMF_Logical
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      private
          integer :: value
      end type

      type(ESMF_Logical), parameter :: ESMF_TRUE     = ESMF_Logical(1), &
                                       ESMF_FALSE    = ESMF_Logical(2)

!------------------------------------------------------------------------------
!
!     ! Typed inquire-only flag

!     ! WARNING: must match corresponding values in ../include/ESMC_Util.h

      type ESMF_InquireFlag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      private
          type(ESMF_Logical) :: flag
      end type

      type(ESMF_InquireFlag), parameter :: ESMF_INQUIREONLY = ESMF_InquireFlag(ESMF_TRUE), &
                                           ESMF_NOINQUIRE   = ESMF_InquireFlag(ESMF_FALSE)

!------------------------------------------------------------------------------
!
!     ! Typed proxy flag

!     ! WARNING: must match corresponding values in ../include/ESMC_Util.h

      type ESMF_ProxyFlag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      private
          integer :: flag
      end type

      type(ESMF_ProxyFlag), parameter :: ESMF_PROXYYES = ESMF_ProxyFlag (1),  &
                                         ESMF_PROXYNO  = ESMF_ProxyFlag (2),  &
                                         ESMF_PROXYANY = ESMF_ProxyFlag (3)

!------------------------------------------------------------------------------
!
!     ! Typed reduction operations

!     ! WARNING: must match corresponding values in ../include/ESMC_Util.h

      type ESMF_Reduce_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      private
          integer :: value
      end type

      type(ESMF_Reduce_Flag), parameter ::  ESMF_REDUCE_SUM   = ESMF_Reduce_Flag(1), &
                                          ESMF_REDUCE_MIN  = ESMF_Reduce_Flag(2), &
                                          ESMF_REDUCE_MAX  = ESMF_Reduce_Flag(3)
                                     
!------------------------------------------------------------------------------
!
!     ! Typed blocking/non-blocking flag

      type ESMF_Sync_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      private
          integer :: value
      end type

      type(ESMF_Sync_Flag), parameter:: &
        ESMF_SYNC_BLOCKING     = ESMF_Sync_Flag(1), &
        ESMF_SYNC_VASBLOCKING  = ESMF_Sync_Flag(2), &
        ESMF_SYNC_NONBLOCKING  = ESMF_Sync_Flag(3)

!------------------------------------------------------------------------------
!
!     ! Typed context flag

      type ESMF_Context_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      private
          integer :: value
      end type

      type(ESMF_Context_Flag), parameter:: &
        ESMF_CONTEXT_OWN_VM     = ESMF_Context_Flag(1), &
        ESMF_CONTEXT_PARENT_VM  = ESMF_Context_Flag(2)

!------------------------------------------------------------------------------
!
!     ! Typed termination flag

      type ESMF_End_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      private
          integer :: value
      end type

      type(ESMF_End_Flag), parameter:: &
        ESMF_END_NORMAL        = ESMF_End_Flag(1), &
        ESMF_END_KEEPMPI      = ESMF_End_Flag(2), &
        ESMF_END_ABORT        = ESMF_End_Flag(3)

!------------------------------------------------------------------------------
!
!     ! Typed DE pinning flag

      type ESMF_Pin_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      private
          integer :: value
      end type

      type(ESMF_Pin_Flag), parameter:: &
        ESMF_PIN_DE_TO_PET        = ESMF_Pin_Flag(1), &
        ESMF_PIN_DE_TO_VAS        = ESMF_Pin_Flag(2), &
        ESMF_PIN_DE_TO_SSI        = ESMF_Pin_Flag(3), &
        ESMF_PIN_DE_TO_SSI_CONTIG = ESMF_Pin_Flag(4)

!------------------------------------------------------------------------------
!
!     ! Direction type

      type ESMF_Direction_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      private
          integer :: value
      end type

      type(ESMF_Direction_Flag), parameter:: &
        ESMF_DIRECTION_FORWARD = ESMF_Direction_Flag(1), &
        ESMF_DIRECTION_REVERSE = ESMF_Direction_Flag(2)

!------------------------------------------------------------------------------
!
!     ! PIO Format type

      type ESMF_IOFmt_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      private
          integer :: io_type
      end type

      type(ESMF_IOFmt_Flag), parameter ::  &
!                           ESMF_IOFMT_BIN                 = ESMF_IOFmt_Flag(0), &
                           ESMF_IOFMT_NETCDF              = ESMF_IOFmt_Flag(1), &
                           ESMF_IOFMT_NETCDF_64BIT_DATA   = ESMF_IOFmt_Flag(2), &
                           ESMF_IOFMT_NETCDF_64BIT_OFFSET = ESMF_IOFmt_Flag(3), &
                           ESMF_IOFMT_NETCDF4             = ESMF_IOFmt_Flag(4), &
                           ESMF_IOFMT_NETCDF4P            = ESMF_IOFmt_Flag(5), &
                           ESMF_IOFMT_NETCDF4C            = ESMF_IOFmt_Flag(6), &
                           ESMF_IOFMT_CONFIG              = ESMF_IOFmt_Flag(7), &
                           ESMF_IOFMT_YAML                = ESMF_IOFmt_Flag(8)

!------------------------------------------------------------------------------
!     ! ESMF_Index_Flag
!
!     ! Interface flag for setting index bounds

      type ESMF_Index_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      !private
        integer :: i_type
      end type

      type(ESMF_Index_Flag), parameter ::  &
                               ESMF_INDEX_DELOCAL  = ESMF_Index_Flag(0), &
                               ESMF_INDEX_GLOBAL = ESMF_Index_Flag(1), &
                               ESMF_INDEX_USER = ESMF_Index_Flag(2)

!------------------------------------------------------------------------------
!     ! ESMF_StartRegion_Flag
!
!     ! Interface flag for setting index bounds

      type ESMF_StartRegion_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      private
        integer :: i_type
      end type

      type(ESMF_StartRegion_Flag), parameter ::  &
        ESMF_STARTREGION_EXCLUSIVE = ESMF_StartRegion_Flag(0), &
        ESMF_STARTREGION_COMPUTATIONAL = ESMF_StartRegion_Flag(1)

!------------------------------------------------------------------------------
!     ! ESMF_Region_Flag
!
!     ! Interface flag for setting index bounds

      type ESMF_Region_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      private
        integer :: i_type
      end type

      type(ESMF_Region_Flag), parameter ::  &
        ESMF_REGION_TOTAL = ESMF_Region_Flag(0), &
        ESMF_REGION_SELECT = ESMF_Region_Flag(1), &
        ESMF_REGION_EMPTY = ESMF_Region_Flag(2)

!------------------------------------------------------------------------------
!     ! ESMF_RouteSync_Flag
!
!     ! Interface flag for setting communication options

      type ESMF_RouteSync_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      private
        integer :: i_type
      end type

      type(ESMF_RouteSync_Flag), parameter ::  &
        ESMF_ROUTESYNC_BLOCKING        = ESMF_RouteSync_Flag(0), &
        ESMF_ROUTESYNC_NBSTART         = ESMF_RouteSync_Flag(1), &
        ESMF_ROUTESYNC_NBTESTFINISH    = ESMF_RouteSync_Flag(2), &
        ESMF_ROUTESYNC_NBWAITFINISH    = ESMF_RouteSync_Flag(3), &
        ESMF_ROUTESYNC_CANCEL          = ESMF_RouteSync_Flag(4)

!------------------------------------------------------------------------------
!     ! ESMF_AttWriteFlag
!
!     ! Interface flag for Attribute write methods

      type ESMF_AttWriteFlag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      !private
        integer :: value
      end type

      type(ESMF_AttWriteFlag), parameter ::  &
        ESMF_ATTWRITE_JSON = ESMF_AttWriteFlag(0)

!------------------------------------------------------------------------------
!     ! ESMF_AttReconcileFlag
!
!     ! Interface flag for Attribute reconcile

      type ESMF_AttReconcileFlag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      !private
        integer :: value
      end type

      type(ESMF_AttReconcileFlag), parameter ::  &
        ESMF_ATTRECONCILE_OFF = ESMF_AttReconcileFlag(0), &
        ESMF_ATTRECONCILE_ON = ESMF_AttReconcileFlag(1)

!------------------------------------------------------------------------------
!     ! ESMF_AttCopy_Flag
!
!     ! Interface flag for Attribute copy

      type ESMF_AttCopy_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      !private
        integer :: value
      end type

      type(ESMF_AttCopy_Flag), parameter ::  &
        ESMF_ATTCOPY_REFERENCE = ESMF_AttCopy_Flag(0), &
        ESMF_ATTCOPY_VALUE = ESMF_AttCopy_Flag(1)

!------------------------------------------------------------------------------
!     ! ESMF_AttGetCountFlag
!
!     ! Interface flag for Attribute copy

      type ESMF_AttGetCountFlag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      !private
        integer :: value
      end type

      type(ESMF_AttGetCountFlag), parameter ::  &
        ESMF_ATTGETCOUNT_ATTRIBUTE = ESMF_AttGetCountFlag(0), &
        ESMF_ATTGETCOUNT_ATTPACK = ESMF_AttGetCountFlag(1), &
        ESMF_ATTGETCOUNT_TOTAL = ESMF_AttGetCountFlag(2)

!------------------------------------------------------------------------------
!     ! ESMF_AttNestFlag
!
!     ! Interface flag for Attribute tree

      type ESMF_AttNest_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      !private
        integer :: value
      end type

      type(ESMF_AttNest_Flag), parameter ::  &
        ESMF_ATTNEST_OFF = ESMF_AttNest_Flag(0), &
        ESMF_ATTNEST_ON = ESMF_AttNest_Flag(1)


!------------------------------------------------------------------------------
!
!
      ! What to do when a point can't be mapped
      type ESMF_UnmappedAction_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
!  private
         integer :: unmappedaction
      end type

      type(ESMF_UnmappedAction_Flag), parameter :: &
           ESMF_UNMAPPEDACTION_ERROR    = ESMF_UnmappedAction_Flag(0), &
           ESMF_UNMAPPEDACTION_IGNORE   = ESMF_UnmappedAction_Flag(1)

!------------------------------------------------------------------------------
      type ESMF_RegridMethod_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
!  private
         integer :: regridmethod
      end type


      type(ESMF_RegridMethod_Flag), parameter :: &
           ESMF_REGRIDMETHOD_BILINEAR    = ESMF_RegridMethod_Flag(0), &
           ESMF_REGRIDMETHOD_PATCH       = ESMF_RegridMethod_Flag(1), &
           ESMF_REGRIDMETHOD_CONSERVE    = ESMF_RegridMethod_Flag(2), &
           ESMF_REGRIDMETHOD_NEAREST_STOD  = ESMF_RegridMethod_Flag(3), &
           ESMF_REGRIDMETHOD_NEAREST_DTOS  = ESMF_RegridMethod_Flag(4), &
           ESMF_REGRIDMETHOD_CONSERVE_2ND  = ESMF_RegridMethod_Flag(5)


!------------------------------------------------------------------------------
      type ESMF_ExtrapMethod_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
!  private
         integer :: extrapmethod
      end type


      type(ESMF_ExtrapMethod_Flag), parameter :: &
           ESMF_EXTRAPMETHOD_NONE    = ESMF_ExtrapMethod_Flag(0), &
           ESMF_EXTRAPMETHOD_NEAREST_STOD = ESMF_ExtrapMethod_Flag(1), &
           ESMF_EXTRAPMETHOD_NEAREST_IDAVG = ESMF_ExtrapMethod_Flag(2), &
           ESMF_EXTRAPMETHOD_NEAREST_D = ESMF_ExtrapMethod_Flag(3), &
           ESMF_EXTRAPMETHOD_CREEP = ESMF_ExtrapMethod_Flag(4), &
           ESMF_EXTRAPMETHOD_CREEP_NRST_D = ESMF_ExtrapMethod_Flag(5)

!------------------------------------------------------------------------------
      type ESMF_CubedSphereCalc_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
!  private
         integer :: cubedspherecalc
      end type

      
      type(ESMF_CubedSphereCalc_Flag), parameter :: &
           ESMF_CUBEDSPHERECALC_1TILE = ESMF_CubedSphereCalc_Flag(1), &
           ESMF_CUBEDSPHERECALC_LOCAL = ESMF_CubedSphereCalc_Flag(2)
      
!------------------------------------------------------------------------------
      type ESMF_LineType_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
!  private
         integer :: linetype
      end type


      type(ESMF_lineType_Flag), parameter :: &
           ESMF_LINETYPE_CART         = ESMF_LineType_Flag(0), &
           ESMF_LINETYPE_GREAT_CIRCLE = ESMF_LineType_Flag(1)

!------------------------------------------------------------------------------

      type ESMF_PoleMethod_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
!  private
         integer :: polemethod
      end type


      type(ESMF_PoleMethod_Flag), parameter :: &
           ESMF_POLEMETHOD_NONE    =  ESMF_PoleMethod_Flag(0), &
           ESMF_POLEMETHOD_ALLAVG  =  ESMF_PoleMethod_Flag(1), &
           ESMF_POLEMETHOD_NPNTAVG =  ESMF_PoleMethod_Flag(2), &
           ESMF_POLEMETHOD_TEETH   =  ESMF_PoleMethod_Flag(3)

!------------------------------------------------------------------------------
!
!
      type ESMF_RegridConserve
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
!  private
         integer :: regridconserve
      end type


      type(ESMF_RegridConserve), parameter :: &
           ESMF_REGRID_CONSERVE_OFF     = ESMF_RegridConserve(0), &
           ESMF_REGRID_CONSERVE_ON      = ESMF_RegridConserve(1)


!------------------------------------------------------------------------------
      type ESMF_NormType_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
!  private
         integer :: normtype
      end type


      type(ESMF_NormType_Flag), parameter :: &
           ESMF_NORMTYPE_DSTAREA      = ESMF_NormType_Flag(0), &
           ESMF_NORMTYPE_FRACAREA     = ESMF_NormType_Flag(1)

!------------------------------------------------------------------------------


!------------------------------------------------------------------------------
!
!
      integer, parameter :: ESMF_REGRID_SCHEME_FULL3D = 0, &
                            ESMF_REGRID_SCHEME_NATIVE = 1, &
                            ESMF_REGRID_SCHEME_REGION3D = 2, &
                            ESMF_REGRID_SCHEME_FULLTOREG3D=3, &
                            ESMF_REGRID_SCHEME_REGTOFULL3D=4, &
                            ESMF_REGRID_SCHEME_DCON3D=5, &
                            ESMF_REGRID_SCHEME_DCON3DWPOLE=6


      type ESMF_PredefinedDynamicMask_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
!  private
         integer :: PredefinedDynamicMask
      end type


      type(ESMF_PredefinedDynamicMask_Flag), parameter :: &
           ESMF_PREDEFINEDDYNAMICMASK_MASKDEST  =  ESMF_PredefinedDynamicMask_Flag(0), &
           ESMF_PREDEFINEDDYNAMICMASK_MASKSRC   =  ESMF_PredefinedDynamicMask_Flag(1), &
           ESMF_PREDEFINEDDYNAMICMASK_MASKSRCDEST  =  ESMF_PredefinedDynamicMask_Flag(2), &
           ESMF_PREDEFINEDDYNAMICMASK_MASKVOTE  =  ESMF_PredefinedDynamicMask_Flag(3), &
           ESMF_PREDEFINEDDYNAMICMASK_MASKDESTV  =  ESMF_PredefinedDynamicMask_Flag(4), &
           ESMF_PREDEFINEDDYNAMICMASK_MASKSRCV   =  ESMF_PredefinedDynamicMask_Flag(5), &
           ESMF_PREDEFINEDDYNAMICMASK_MASKSRCDESTV  =  ESMF_PredefinedDynamicMask_Flag(6), &
           ESMF_PREDEFINEDDYNAMICMASK_MASKVOTEV  =  ESMF_PredefinedDynamicMask_Flag(7)


!------------------------------------------------------------------------------
! ! ESMF_CoordSys_Flag
!
!------------------------------------------------------------------------------
  type ESMF_CoordSys_Flag
#ifndef ESMF_NO_SEQUENCE
  sequence
#endif
!  private
     integer :: coordsys
  end type

  type(ESMF_CoordSys_Flag), parameter :: &
    ESMF_COORDSYS_UNINIT  = ESMF_CoordSys_Flag(-1), &
    ESMF_COORDSYS_CART    = ESMF_CoordSys_Flag(0), &
    ESMF_COORDSYS_SPH_DEG = ESMF_CoordSys_Flag(1), &
    ESMF_COORDSYS_SPH_RAD = ESMF_CoordSys_Flag(2)


!------------------------------------------------------------------------------
! ! ESMF_CoordSys constants
! (Need to match the ones in ESMC_CoordSys.C)
!
!------------------------------------------------------------------------------
   real(ESMF_KIND_R8), parameter ::  ESMF_COORDSYS_DEG2RAD= &
                     0.01745329251994329547437_ESMF_KIND_R8
   real(ESMF_KIND_R8), parameter :: ESMF_COORDSYS_RAD2DEG=&
                    57.29577951308232286464772_ESMF_KIND_R8

!------------------------------------------------------------------------------
!
  type ESMF_FileFormat_Flag
#ifndef ESMF_NO_SEQUENCE
  sequence
#endif
 ! private
    integer :: fileformat
  end type

  type(ESMF_FileFormat_Flag), parameter :: &
        ESMF_FILEFORMAT_UNKNOWN = ESMF_FileFormat_Flag(0), &
        ESMF_FILEFORMAT_VTK = ESMF_FileFormat_Flag(1), &
        ESMF_FILEFORMAT_SCRIP = ESMF_FileFormat_Flag(2), &
        ESMF_FILEFORMAT_ESMFMESH = ESMF_FileFormat_Flag(3), &
        ESMF_FILEFORMAT_ESMFGRID = ESMF_FileFormat_Flag(4), &
        ESMF_FILEFORMAT_UGRID = ESMF_FileFormat_Flag(5), &
        ESMF_FILEFORMAT_CFGRID = ESMF_FileFormat_Flag(6), &
        ESMF_FILEFORMAT_GRIDSPEC = ESMF_FileFormat_Flag(6), &
        ESMF_FILEFORMAT_MOSAIC = ESMF_FileFormat_Flag(7), &
        ESMF_FILEFORMAT_TILE = ESMF_FileFormat_Flag(8)


!------------------------------------------------------------------------------
!
  type ESMF_FileMode_Flag
#ifndef ESMF_NO_SEQUENCE
  sequence
#endif
 ! private
    integer :: filemode
  end type

  type(ESMF_FileMode_Flag), parameter :: &
        ESMF_FILEMODE_BASIC = ESMF_FileMode_Flag(0), &
        ESMF_FILEMODE_WITHAUX = ESMF_FileMode_Flag(1)

!------------------------------------------------------------------------------
!
!     ! File status type (for ESMF_xxxWrite status input)

      type ESMF_FileStatus_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      private
          integer :: status_type
      end type

      type(ESMF_FileStatus_Flag), parameter ::  &
                          ESMF_FILESTATUS_UNKNOWN  = ESMF_FileStatus_Flag(0), &
                          ESMF_FILESTATUS_OLD      = ESMF_FileStatus_Flag(1), &
                          ESMF_FILESTATUS_NEW      = ESMF_FileStatus_Flag(2), &
                          ESMF_FILESTATUS_REPLACE  = ESMF_FileStatus_Flag(3)

!------------------------------------------------------------------------------
!
      type ESMF_ItemOrder_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      private
          integer :: flag
      end type

      type(ESMF_ItemOrder_Flag), parameter ::  &
        ESMF_ITEMORDER_ABC        = ESMF_ItemOrder_Flag(0), &
        ESMF_ITEMORDER_ADDORDER   = ESMF_ItemOrder_Flag(1)

!------------------------------------------------------------------------------
!
      type ESMF_TermOrder_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      private
          integer :: flag
      end type

      type(ESMF_TermOrder_Flag), parameter ::  &
        ESMF_TERMORDER_SRCSEQ     = ESMF_TermOrder_Flag(0), &
        ESMF_TERMORDER_SRCPET     = ESMF_TermOrder_Flag(1), &
        ESMF_TERMORDER_FREE       = ESMF_TermOrder_Flag(2)

!------------------------------------------------------------------------------
!
      type ESMF_MeshOp_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      private
          integer :: flag
      end type

      type(ESMF_MeshOp_Flag), parameter ::  &
        ESMF_MESHOP_DIFFERENCE    = ESMF_MeshOp_Flag(0)

!------------------------------------------------------------------------------
!     ! ESMF_RWGCheckMethod_Flag
!
!     ! Flag for selecting the method to compute route handles in
!     ! ESMF_RegridWeightGenCheck.

      type ESMF_RWGCheckMethod_Flag
#ifndef ESMF_NO_SEQUENCE
      sequence
#endif
      private
        integer :: flag
      end type

      type(ESMF_RWGCheckMethod_Flag), parameter ::  &
        ESMF_RWGCHECKMETHOD_ARRAY = ESMF_RWGCheckMethod_Flag(0), &
        ESMF_RWGCHECKMETHOD_FIELD = ESMF_RWGCheckMethod_Flag(1)

!------------------------------------------------------------------------------
!BOPI
!
! !PUBLIC TYPES:

      public ESMF_STATUS_UNINIT, ESMF_STATUS_READY, &
             ESMF_STATUS_UNALLOCATED, ESMF_STATUS_ALLOCATED, &
             ESMF_STATUS_BUSY, ESMF_STATUS_INVALID

#ifndef ESMF_NO_INTEGER_1_BYTE 
      public ESMF_TYPEKIND_I1
#endif
#ifndef ESMF_NO_INTEGER_2_BYTE 
      public ESMF_TYPEKIND_I2
#endif

      public ESMF_TYPEKIND_I4, ESMF_TYPEKIND_I8, & 
             ESMF_TYPEKIND_R4, ESMF_TYPEKIND_R8, &
             ESMF_TYPEKIND_C8, ESMF_TYPEKIND_C16, &
             ESMF_TYPEKIND_LOGICAL, ESMF_TYPEKIND_CHARACTER, &
             ESMF_KIND_I, ESMF_KIND_R, &
             ESMF_NOKIND


      public ESMF_REGRIDSTATUS_DSTMASKED, &
             ESMF_REGRIDSTATUS_SRCMASKED, &
             ESMF_REGRIDSTATUS_OUTSIDE, &
             ESMF_REGRIDSTATUS_SMSK_OUT, &
             ESMF_REGRIDSTATUS_MAPPED, &
             ESMF_REGRIDSTATUS_SMSK_MP, &
             ESMF_REGRIDSTATUS_OUT_MP, &
             ESMF_REGRIDSTATUS_SMSK_OUT_MP, &
             ESMF_REGRIDSTATUS_EXMAPPED

#ifndef ESMF_NO_INTEGER_1_BYTE 
      public ESMF_KIND_I1
#endif
#ifndef ESMF_NO_INTEGER_2_BYTE 
      public ESMF_KIND_I2
#endif
      public ESMF_KIND_I4, ESMF_KIND_I8, & 
             ESMF_KIND_R4, ESMF_KIND_R8, ESMF_KIND_C8, ESMF_KIND_C16
      public ESMF_SIZEOF_DEFINT

      public ESMF_NULL_POINTER, ESMF_BAD_POINTER

      public ESMF_Logical, ESMF_TRUE, ESMF_FALSE

      public ESMF_InquireFlag
      public ESMF_INQUIREONLY, ESMF_NOINQUIRE

      public ESMF_ProxyFlag
      public ESMF_PROXYYES, ESMF_PROXYNO, ESMF_PROXYANY

      public ESMF_Direction_Flag, ESMF_DIRECTION_FORWARD, ESMF_DIRECTION_REVERSE

      public ESMF_IOFmt_Flag, &
!             ESMF_IOFMT_BIN,  &
             ESMF_IOFMT_NETCDF, &
             ESMF_IOFMT_NETCDF_64BIT_DATA, &
             ESMF_IOFMT_NETCDF_64BIT_OFFSET, &
             ESMF_IOFMT_NETCDF4, &
             ESMF_IOFMT_NETCDF4P, &
             ESMF_IOFMT_NETCDF4C, &
             ESMF_IOFMT_CONFIG, &
             ESMF_IOFMT_YAML

      public ESMF_Index_Flag, &
             ESMF_INDEX_DELOCAL, &
             ESMF_INDEX_GLOBAL, &
             ESMF_INDEX_USER
             
      public ESMF_StartRegion_Flag, &
             ESMF_STARTREGION_EXCLUSIVE, &
             ESMF_STARTREGION_COMPUTATIONAL
             
      public ESMF_Region_Flag, &
             ESMF_REGION_TOTAL, &
             ESMF_REGION_SELECT, &
             ESMF_REGION_EMPTY
             
      public ESMF_RouteSync_Flag, &
             ESMF_ROUTESYNC_BLOCKING, &
             ESMF_ROUTESYNC_NBSTART, &
             ESMF_ROUTESYNC_NBTESTFINISH, &
             ESMF_ROUTESYNC_NBWAITFINISH, &
             ESMF_ROUTESYNC_CANCEL
             
      public ESMF_Reduce_Flag, &
             ESMF_REDUCE_SUM, &
             ESMF_REDUCE_MIN, &
             ESMF_REDUCE_MAX
             
      public ESMF_Sync_Flag, &
             ESMF_SYNC_BLOCKING, &
             ESMF_SYNC_VASBLOCKING, &
             ESMF_SYNC_NONBLOCKING
             
      public ESMF_Context_Flag, &
             ESMF_CONTEXT_OWN_VM, &
             ESMF_CONTEXT_PARENT_VM
             
      public ESMF_End_Flag, &
             ESMF_END_NORMAL, &
             ESMF_END_KEEPMPI, &
             ESMF_END_ABORT
             
      public ESMF_Pin_Flag, &
             ESMF_PIN_DE_TO_PET, &
             ESMF_PIN_DE_TO_VAS, &
             ESMF_PIN_DE_TO_SSI, &
             ESMF_PIN_DE_TO_SSI_CONTIG
             
      public ESMF_AttCopy_Flag, &
             ESMF_ATTCOPY_REFERENCE, &
             ESMF_ATTCOPY_VALUE

      public ESMF_AttGetCountFlag, &
             ESMF_ATTGETCOUNT_ATTRIBUTE, &
             ESMF_ATTGETCOUNT_ATTPACK, &
             ESMF_ATTGETCOUNT_TOTAL
             
      public ESMF_AttReconcileFlag, &
             ESMF_ATTRECONCILE_OFF, &
             ESMF_ATTRECONCILE_ON
             
      public ESMF_AttNest_Flag, &
             ESMF_ATTNEST_OFF, &
             ESMF_ATTNEST_ON
             
      public ESMF_AttWriteFlag, &
             ESMF_ATTWRITE_JSON

      public ESMF_ATT_GRIDDED_DIM_LABELS, &
             ESMF_ATT_UNGRIDDED_DIM_LABELS

      public ESMF_RegridMethod_Flag, &
             ESMF_REGRIDMETHOD_BILINEAR, &
             ESMF_REGRIDMETHOD_PATCH, &
             ESMF_REGRIDMETHOD_CONSERVE, &
             ESMF_REGRIDMETHOD_NEAREST_STOD, &
             ESMF_REGRIDMETHOD_NEAREST_DTOS, &
             ESMF_REGRIDMETHOD_CONSERVE_2ND

      public ESMF_ExtrapMethod_Flag, &
             ESMF_EXTRAPMETHOD_NONE, & 
             ESMF_EXTRAPMETHOD_NEAREST_STOD, &
             ESMF_EXTRAPMETHOD_NEAREST_IDAVG, &
             ESMF_EXTRAPMETHOD_NEAREST_D, &
             ESMF_EXTRAPMETHOD_CREEP, &
             ESMF_EXTRAPMETHOD_CREEP_NRST_D

      public ESMF_PredefinedDynamicMask_Flag, &
             ESMF_PREDEFINEDDYNAMICMASK_MASKDEST, &
             ESMF_PREDEFINEDDYNAMICMASK_MASKSRC, &
             ESMF_PREDEFINEDDYNAMICMASK_MASKSRCDEST, &
             ESMF_PREDEFINEDDYNAMICMASK_MASKVOTE, &
             ESMF_PREDEFINEDDYNAMICMASK_MASKDESTV, &
             ESMF_PREDEFINEDDYNAMICMASK_MASKSRCV, &
             ESMF_PREDEFINEDDYNAMICMASK_MASKSRCDESTV, &
             ESMF_PREDEFINEDDYNAMICMASK_MASKVOTEV

      public ESMF_CubedSphereCalc_Flag, &
             ESMF_CUBEDSPHERECALC_1TILE, &
             ESMF_CUBEDSPHERECALC_LOCAL 
      
      public ESMF_LineType_Flag, &
             ESMF_LINETYPE_CART, &
             ESMF_LINETYPE_GREAT_CIRCLE

      public ESMF_PoleMethod_Flag, &
             ESMF_POLEMETHOD_NONE, &
             ESMF_POLEMETHOD_ALLAVG, &
             ESMF_POLEMETHOD_NPNTAVG, &
             ESMF_POLEMETHOD_TEETH

      public ESMF_RegridConserve, &
             ESMF_REGRID_CONSERVE_OFF, &
             ESMF_REGRID_CONSERVE_ON

      public ESMF_REGRID_SCHEME_FULL3D, &
             ESMF_REGRID_SCHEME_NATIVE, &
             ESMF_REGRID_SCHEME_REGION3D, &
             ESMF_REGRID_SCHEME_FULLTOREG3D, &
             ESMF_REGRID_SCHEME_REGTOFULL3D, &
             ESMF_REGRID_SCHEME_DCON3D, &
             ESMF_REGRID_SCHEME_DCON3DWPOLE

      public ESMF_FAILURE, ESMF_SUCCESS

      public ESMF_IO_NETCDF_PRESENT, ESMF_IO_PIO_PRESENT
      public ESMF_IO_PNETCDF_PRESENT

      public ESMF_MAXSTR
      public ESMF_MAXPATHLEN
! TODO:FIELDINTEGRATION Adjust MAXGRIDDIM
      public ESMF_MAXDIM, ESMF_MAXIGRIDDIM, ESMF_MAXGRIDDIM

      public ESMF_VERSION_MAJOR, ESMF_VERSION_MINOR
      public ESMF_VERSION_REVISION, ESMF_VERSION_PATCHLEVEL
      public ESMF_VERSION_PUBLIC, ESMF_VERSION_BETASNAPSHOT
      public ESMF_VERSION_STRING 
      public ESMF_UtilVersionPrint

      public ESMF_ObjectID

#if 0 
      public ESMF_ObjectIDGetInit, ESMF_ObjectIDInit, ESMF_ObjectIDValidate
#endif
      public ESMF_ID_NONE
      public ESMF_ID_BASE, ESMF_ID_LOGERR, ESMF_ID_TIME
      public ESMF_ID_CALENDAR, ESMF_ID_TIMEINTERVAL, ESMF_ID_ALARM
      public ESMF_ID_CLOCK, ESMF_ID_ARRAYSPEC, ESMF_ID_LOCALARRAY
      public ESMF_ID_ARRAYBUNDLE, ESMF_ID_VM, ESMF_ID_DELAYOUT
      public ESMF_ID_CONFIG, ESMF_ID_ARRAY
      public ESMF_ID_COMMTABLE, ESMF_ID_ROUTETABLE, ESMF_ID_ROUTE
      public ESMF_ID_ROUTEHANDLE, ESMF_ID_FIELDDATAMAP, ESMF_ID_FIELD
      public ESMF_ID_FIELDBUNDLE, ESMF_ID_GEOMBASE, ESMF_ID_XGRID
      public ESMF_ID_REGRID, ESMF_ID_LOCSTREAM, ESMF_ID_STATE
      public ESMF_ID_GRIDCOMPONENT, ESMF_ID_CPLCOMPONENT, ESMF_ID_COMPONENT

      public ESMF_KeywordEnforcer

      public ESMF_Status, ESMF_Pointer, ESMF_CharPtr, ESMF_PtrInt1D
      public ESMF_PtrR4D1, ESMF_PtrR8D1
      public ESMF_TypeKind_Flag, ESMF_DataValue

      public ESMF_MapPtr

      public ESMF_PointerPrint

      public ESMF_UnmappedAction_Flag, ESMF_UNMAPPEDACTION_ERROR, &
                                   ESMF_UNMAPPEDACTION_IGNORE

      public ESMF_FileFormat_Flag, ESMF_FILEFORMAT_VTK, ESMF_FILEFORMAT_SCRIP, &
             ESMF_FILEFORMAT_ESMFMESH, ESMF_FILEFORMAT_ESMFGRID, &
             ESMF_FILEFORMAT_UGRID, ESMF_FILEFORMAT_GRIDSPEC, &
             ESMF_FILEFORMAT_CFGRID, ESMF_FILEFORMAT_MOSAIC, &
             ESMF_FILEFORMAT_UNKNOWN, ESMF_FILEFORMAT_TILE

      public ESMF_FileMode_Flag, ESMF_FILEMODE_BASIC, ESMF_FILEMODE_WITHAUX

      public ESMF_FileStatus_Flag, ESMF_FILESTATUS_UNKNOWN,   &
                                  ESMF_FILESTATUS_OLD,       &
                                  ESMF_FILESTATUS_NEW,       &
                                  ESMF_FILESTATUS_REPLACE

      public ESMF_ItemOrder_Flag
      public ESMF_ITEMORDER_ABC, ESMF_ITEMORDER_ADDORDER
      
      public ESMF_TermOrder_Flag
      public ESMF_TERMORDER_SRCSEQ, ESMF_TERMORDER_SRCPET, ESMF_TERMORDER_FREE

      public ESMF_MeshOp_Flag
      public ESMF_MESHOP_DIFFERENCE


      public ESMF_CoordSys_Flag
      public ESMF_COORDSYS_UNINIT,  &
             ESMF_COORDSYS_CART,    &
             ESMF_COORDSYS_SPH_DEG, &
             ESMF_COORDSYS_SPH_RAD

      public ESMF_COORDSYS_DEG2RAD, &
             ESMF_COORDSYS_RAD2DEG

      public ESMF_NormType_Flag
      public ESMF_NORMTYPE_DSTAREA, ESMF_NORMTYPE_FRACAREA

      public ESMF_MESH_POLYBREAK

      public ESMF_RWGCheckMethod_Flag
      public ESMF_RWGCHECKMETHOD_ARRAY, ESMF_RWGCHECKMETHOD_FIELD

!  Overloaded = operator functions
      public operator(==), operator(/=), assignment(=)
!

!------------------------------------------------------------------------------

! overload == & /= with additional derived types so you can compare 
!  them as if they were simple integers.
 

interface operator (==)
  module procedure ESMF_atreceq
  module procedure ESMF_sfeq
  module procedure ESMF_dkeq
  module procedure ESMF_pteq
  module procedure ESMF_tfeq
  module procedure ESMF_bfeq
  module procedure ESMF_ctfeq
  module procedure ESMF_tnfeq
  module procedure ESMF_pineq
  module procedure ESMF_freq
  module procedure ESMF_ifeq
  module procedure ESMF_inqfeq
  module procedure ESMF_rfeq
  module procedure ESMF_unmappedactioneq
  module procedure ESMF_ioeq
  module procedure ESMF_RegridPoleEq
  module procedure ESMF_FileFormatEq
  module procedure ESMF_FileModeEq
  module procedure ESMF_FileStatusEq
  module procedure ESMF_RegridMethodEq
  module procedure ESMF_ExtrapMethodEq
  module procedure ESMF_CubedSphereCalcEq
  module procedure ESMF_CoordSysEqual
  module procedure ESMF_LineTypeEqual
  module procedure ESMF_NormTypeEqual
  module procedure ESMF_RWGCheckMethodEqual
  module procedure ESMF_TermOrderEq
  module procedure ESMF_PredefinedDynamicMask_FlagEq
end interface

interface operator (/=)
  module procedure ESMF_sfne
  module procedure ESMF_dkne
  module procedure ESMF_ptne
  module procedure ESMF_tfne
  module procedure ESMF_bfne
  module procedure ESMF_ctfne
  module procedure ESMF_tnfne
  module procedure ESMF_pinne
  module procedure ESMF_frne
  module procedure ESMF_ifneq
  module procedure ESMF_unmappedactionne
  module procedure ESMF_RegridPoleNe
  module procedure ESMF_FileFormatNe
  module procedure ESMF_FileModeNe
  module procedure ESMF_FileStatusNe
  module procedure ESMF_RegridMethodNe
  module procedure ESMF_ExtrapMethodNe
  module procedure ESMF_CubedSphereCalcNe
  module procedure ESMF_CoordSysNotEqual
  module procedure ESMF_LineTypeNotEqual
  module procedure ESMF_NormTypeNotEqual
  module procedure ESMF_RWGCheckMethodNotEqual
end interface

interface assignment (=)
  module procedure ESMF_TypeKindToInt
  module procedure ESMF_IntToTypeKind
  module procedure ESMF_bfas
  module procedure ESMF_dkas_string
  module procedure ESMF_tfas
  module procedure ESMF_tfas_v
  module procedure ESMF_tfas2
  module procedure ESMF_tfas2_v
  module procedure ESMF_ptas
  module procedure ESMF_ptas2
  module procedure ESMF_ioas
  module procedure ESMF_ifas_string
  module procedure ESMF_FileFormatAsString
  module procedure ESMF_FileStatusAs
end interface  


!------------------------------------------------------------------------------
! ! ESMF_MethodTable

  type ESMF_MethodTable
#ifndef ESMF_NO_SEQUENCE
    sequence
#endif
    !private
    type(ESMF_Pointer) :: this
    ! only use internally -> no init macro!
  end type
     
  public ESMF_MethodTable


!------------------------------------------------------------------------------
! ! ESMF_DynamicMaskElement

  type ESMF_DynamicMaskElementR8R8R8
    real(ESMF_KIND_R8), pointer       :: dstElement
    real(ESMF_KIND_R8), allocatable   :: factor(:)
    real(ESMF_KIND_R8), allocatable   :: srcElement(:)
  end type

  type ESMF_DynamicMaskElementR8R8R8V
    real(ESMF_KIND_R8), pointer       :: dstElement(:)
    real(ESMF_KIND_R8), allocatable   :: factor(:)
    type(ESMF_PtrR8D1), allocatable   :: srcElement(:)
  end type

  type ESMF_DynamicMaskElementR4R8R4
    real(ESMF_KIND_R4), pointer       :: dstElement
    real(ESMF_KIND_R8), allocatable   :: factor(:)
    real(ESMF_KIND_R4), allocatable   :: srcElement(:)
  end type

  type ESMF_DynamicMaskElementR4R8R4V
    real(ESMF_KIND_R4), pointer       :: dstElement(:)
    real(ESMF_KIND_R8), allocatable   :: factor(:)
    type(ESMF_PtrR4D1), allocatable   :: srcElement(:)
  end type

  type ESMF_DynamicMaskElementR4R4R4
    real(ESMF_KIND_R4), pointer       :: dstElement
    real(ESMF_KIND_R4), allocatable   :: factor(:)
    real(ESMF_KIND_R4), allocatable   :: srcElement(:)
  end type

  type ESMF_DynamicMaskElementR4R4R4V
    real(ESMF_KIND_R4), pointer       :: dstElement(:)
    real(ESMF_KIND_R4), allocatable   :: factor(:)
    type(ESMF_PtrR4D1), allocatable   :: srcElement(:)
  end type

  public ESMF_DynamicMaskElementR8R8R8, ESMF_DynamicMaskElementR8R8R8V
  public ESMF_DynamicMaskElementR4R8R4, ESMF_DynamicMaskElementR4R8R4V
  public ESMF_DynamicMaskElementR4R4R4, ESMF_DynamicMaskElementR4R4R4V

!------------------------------------------------------------------------------

      contains

#if 0 
!------------------------------------------------------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ObjectIDGetInit"
!BOPI
! !IROUTINE:  ESMF_ObjectIDGetInit - Get initialization status.

! !INTERFACE:
    function ESMF_ObjectIDGetInit(s)
!
! !ARGUMENTS:
       type(ESMF_ObjectID), intent(in), optional :: s
       ESMF_INIT_TYPE :: ESMF_ObjectIDGetInit
!
! !DESCRIPTION:
!      Get the initialization status of the shallow class {\tt domain}.
!
!     The arguments are:
!     \begin{description}
!     \item [s]
!           {\tt ESMF\_ObjectID} from which to retrieve status.
!     \end{description}
!
!EOPI

       if (present(s)) then
         ESMF_ObjectIDGetInit = ESMF_INIT_GET(s)
       else
         ESMF_ObjectIDGetInit = ESMF_INIT_DEFINED
       endif

    end function ESMF_ObjectIDGetInit

!------------------------------------------------------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ObjectIDInit"
!BOPI
! !IROUTINE:  ESMF_ObjectIDInit - Initialize ObjectID

! !INTERFACE:
    subroutine ESMF_ObjectIDInit(s)
!
! !ARGUMENTS:
       type(ESMF_ObjectID) :: s
!
! !DESCRIPTION:
!      Initialize the shallow class {\tt ObjectID}.
!
!     The arguments are:
!     \begin{description}
!     \item [s]
!           {\tt ESMF\_ObjectID} of which being initialized.
!     \end{description}
!
!EOPI
       ESMF_INIT_SET_DEFINED(s)
    end subroutine ESMF_ObjectIDInit

!------------------------------------------------------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ObjectIDValidate"
!BOPI
! !IROUTINE:  ESMF_ObjectIDValidate - Check validity of a ObjectID 

! !INTERFACE:
    subroutine ESMF_ObjectIDValidate(s,rc)
!
! !ARGUMENTS:
       type(ESMF_ObjectID), intent(inout) :: s
       integer, intent(out), optional :: rc
!
! !DESCRIPTION:
!      Validates that the {\tt ObjectID} is internally consistent.
!
!     The arguments are:
!     \begin{description}
!     \item [s]
!           {\tt ESMF\_ObjectID} to validate.
!     \item [{[rc]}]
!           Return code; equals {\tt ESMF\_SUCCESS} if the {\tt ObjectID}
!           is valid.
!     \end{description}
!
!EOPI

    ! Initialize return code; assume routine not implemented
    if (present(rc)) rc = ESMF_RC_NOT_IMPL

     ESMF_INIT_CHECK_SET_SHALLOW(ESMF_ObjectIDGetInit,ESMF_ObjectIDInit,s)

     ! return success
     if(present(rc)) then
       rc = ESMF_SUCCESS
     endif
    end subroutine ESMF_ObjectIDValidate

#endif

!------------------------------------------------------------------------------
! function to compare two ESMF_AttReconcileFlag types

impure elemental function ESMF_atreceq(atrec1, atrec2)
  logical ESMF_atreceq
  type(ESMF_AttReconcileFlag), intent(in) :: atrec1, atrec2

  ESMF_atreceq = (atrec1%value == atrec2%value)
end function ESMF_atreceq

!------------------------------------------------------------------------------
! function to compare two ESMF_Status flags to see if they're the same or not

recursive function ESMF_sfeq(sf1, sf2) result (sfeq)
 logical sfeq
 type(ESMF_Status), intent(in) :: sf1, sf2

 sfeq = (sf1%status == sf2%status)
end function

recursive function ESMF_sfne(sf1, sf2) result (sfne)
 logical :: sfne
 type(ESMF_Status), intent(in) :: sf1, sf2

 sfne = (sf1%status /= sf2%status)
end function

!------------------------------------------------------------------------------
! function to compare two ESMF_TypeKinds to see if they're the same or not

impure elemental function ESMF_dkeq(dk1, dk2)
 logical ESMF_dkeq
 type(ESMF_TypeKind_Flag), intent(in) :: dk1, dk2

 ESMF_dkeq = (dk1%dkind == dk2%dkind)
end function

impure elemental function ESMF_dkne(dk1, dk2)
 logical ESMF_dkne
 type(ESMF_TypeKind_Flag), intent(in) :: dk1, dk2

 ESMF_dkne = (dk1%dkind /= dk2%dkind)
end function

!------------------------------------------------------------------------------
! TypeKind assignments

subroutine ESMF_TypeKindToInt(lhsInt, rhsTypeKind)
  integer,                   intent(out) :: lhsInt
  type(ESMF_TypeKind_Flag),  intent(in)  :: rhsTypeKind
  lhsInt = rhsTypeKind%dkind
end subroutine

subroutine ESMF_IntToTypeKind(lhsTypeKind, rhsInt)
  type(ESMF_TypeKind_Flag),  intent(out) :: lhsTypeKind
  integer,                   intent(in)  :: rhsInt
  lhsTypeKind = ESMF_TypeKind_Flag(rhsInt)
end subroutine


!------------------------------------------------------------------------------
! subroutine to assign string value of an ESMF_TypeKind_Flag

subroutine ESMF_dkas_string(string, dkval)
 character(len=*), intent(out) :: string
 type(ESMF_TypeKind_Flag), intent(in) :: dkval

 string = '(UNKNOWN)'
#ifndef ESMF_NO_INTEGER_1_BYTE 
 if (dkval == ESMF_TYPEKIND_I1) then
   string = 'ESMF_TYPEKIND_I1'
 endif
#endif
#ifndef ESMF_NO_INTEGER_2_BYTE 
 if (dkval == ESMF_TYPEKIND_I2) then
   string = 'ESMF_TYPEKIND_I2'
 endif
#endif
 if (dkval == ESMF_TYPEKIND_I4) then
   string = 'ESMF_TYPEKIND_I4'
 elseif (dkval == ESMF_TYPEKIND_I8) then
   string = 'ESMF_TYPEKIND_I8'
 elseif (dkval == ESMF_TYPEKIND_R4) then
   string = 'ESMF_TYPEKIND_R4'
 elseif (dkval == ESMF_TYPEKIND_R8) then
   string = 'ESMF_TYPEKIND_R8'
 elseif (dkval == ESMF_TYPEKIND_C8) then
   string = 'ESMF_TYPEKIND_C8'
 elseif (dkval == ESMF_TYPEKIND_C16) then
   string = 'ESMF_TYPEKIND_C16'
 elseif (dkval == ESMF_TYPEKIND_LOGICAL) then
   string = 'ESMF_TYPEKIND_LOGICAL'
 elseif (dkval == ESMF_TYPEKIND_CHARACTER) then
   string = 'ESMF_TYPEKIND_CHARACTER'
 elseif (dkval == ESMF_TYPEKIND_I) then
   string = 'ESMF_TYPEKIND_I'
 elseif (dkval == ESMF_TYPEKIND_R) then
   string = 'ESMF_TYPEKIND_R'
 elseif (dkval == ESMF_NOKIND) then
   string = 'ESMF_NOKIND'
 endif
   
end subroutine


!------------------------------------------------------------------------------
! function to assign ESMF_Sync_Flags

subroutine ESMF_bfas(bf1, bf2)
 type(ESMF_Sync_Flag), intent(out) :: bf1
 type(ESMF_Sync_Flag), intent(in)  :: bf2

 bf1%value = bf2%value
end subroutine

impure elemental function ESMF_bfeq(bf1, bf2)
 logical ESMF_bfeq
 type(ESMF_Sync_Flag), intent(in) :: bf1, bf2

 ESMF_bfeq = (bf1%value == bf2%value)
end function

impure elemental function ESMF_bfne(bf1, bf2)
 logical ESMF_bfne
 type(ESMF_Sync_Flag), intent(in) :: bf1, bf2

 ESMF_bfne = (bf1%value /= bf2%value)
end function

!------------------------------------------------------------------------------
! function to compare two ESMF_Context_Flags

impure elemental function ESMF_ctfeq(ctf1, ctf2)
 logical ESMF_ctfeq
 type(ESMF_Context_Flag), intent(in) :: ctf1, ctf2

 ESMF_ctfeq = (ctf1%value == ctf2%value)
end function

impure elemental function ESMF_ctfne(ctf1, ctf2)
 logical ESMF_ctfne
 type(ESMF_Context_Flag), intent(in) :: ctf1, ctf2

 ESMF_ctfne = (ctf1%value /= ctf2%value)
end function

!------------------------------------------------------------------------------
! function to compare two ESMF_End_Flags

impure elemental function ESMF_tnfeq(tnf1, tnf2)
 logical ESMF_tnfeq
 type(ESMF_End_Flag), intent(in) :: tnf1, tnf2

 ESMF_tnfeq = (tnf1%value == tnf2%value)
end function

impure elemental function ESMF_tnfne(tnf1, tnf2)
 logical ESMF_tnfne
 type(ESMF_End_Flag), intent(in) :: tnf1, tnf2

 ESMF_tnfne = (tnf1%value /= tnf2%value)
end function

!------------------------------------------------------------------------------
! function to compare two ESMF_Pointers to see if they're the same or not

impure elemental function ESMF_pteq(pt1, pt2)
 logical ESMF_pteq
 type(ESMF_Pointer), intent(in) :: pt1, pt2

 ESMF_pteq = (pt1%ptr == pt2%ptr)
end function

impure elemental function ESMF_ptne(pt1, pt2)
 logical ESMF_ptne
 type(ESMF_Pointer), intent(in) :: pt1, pt2

 ESMF_ptne = (pt1%ptr /= pt2%ptr)
end function

recursive subroutine ESMF_ptas(ptval, intval)
 type(ESMF_Pointer), intent(out) :: ptval
 integer, intent(in) :: intval

 ptval%ptr = intval
end subroutine

recursive subroutine ESMF_ptas2(ptval2, ptval)
 type(ESMF_Pointer), intent(out) :: ptval2
 type(ESMF_Pointer), intent(in) :: ptval

 ptval2%ptr = ptval%ptr
end subroutine

!------------------------------------------------------------------------------
! function to compare two ESMF_Logicals to see if they're the same or not
! also assignment to real f90 logical 

impure elemental function ESMF_tfeq(tf1, tf2)
 logical ESMF_tfeq
 type(ESMF_Logical), intent(in) :: tf1, tf2

 ESMF_tfeq = (tf1%value == tf2%value)
end function

impure elemental function ESMF_tfne(tf1, tf2)
 logical ESMF_tfne
 type(ESMF_Logical), intent(in) :: tf1, tf2

 ESMF_tfne = (tf1%value /= tf2%value)
end function

subroutine ESMF_tfas(lval, tfval)
 logical, intent(out) :: lval
 type(ESMF_Logical), intent(in) :: tfval

 lval = (tfval%value == 1)    ! this must match initializer
end subroutine

subroutine ESMF_tfas_v(lval, tfval)
 logical, intent(out) :: lval(:)
 type(ESMF_Logical), intent(in) :: tfval(:)

 lval = (tfval%value == 1)    ! this must match initializer
end subroutine

subroutine ESMF_tfas2 (tfval, lval)
 type(ESMF_Logical), intent(out) :: tfval
 logical, intent(in) :: lval

 tfval = merge (ESMF_TRUE, ESMF_FALSE, lval)
end subroutine

subroutine ESMF_tfas2_v (tfval, lval)
 type(ESMF_Logical), intent(out) :: tfval(:)
 logical, intent(in) :: lval(:)

 tfval = merge (ESMF_TRUE, ESMF_FALSE, lval)
end subroutine

!------------------------------------------------------------------------------
! function to compare two ESMF_Pin_Flag types

impure elemental function ESMF_pineq(pin1, pin2)
 logical ESMF_pineq
 type(ESMF_Pin_Flag), intent(in) :: pin1, pin2

 ESMF_pineq = (pin1%value == pin2%value)
end function

impure elemental function ESMF_pinne(pin1, pin2)
 logical ESMF_pinne
 type(ESMF_Pin_Flag), intent(in) :: pin1, pin2

 ESMF_pinne = (pin1%value /= pin2%value)
end function

!------------------------------------------------------------------------------
! function to compare two ESMF_Direction_Flag types

impure elemental function ESMF_freq(fr1, fr2)
 logical ESMF_freq
 type(ESMF_Direction_Flag), intent(in) :: fr1, fr2

 ESMF_freq = (fr1%value == fr2%value)
end function

impure elemental function ESMF_frne(fr1, fr2)
 logical ESMF_frne
 type(ESMF_Direction_Flag), intent(in) :: fr1, fr2

 ESMF_frne = (fr1%value /= fr2%value)
end function

!------------------------------------------------------------------------------
! function to compare two ESMF_IOFmt_Flag

subroutine ESMF_ioas(io1, io2)
 type(ESMF_IOFmt_Flag), intent(out) :: io1
 type(ESMF_IOFmt_Flag), intent(in)  :: io2

 io1%io_type = io2%io_type
end subroutine

impure elemental function ESMF_ioeq(io1, io2)
  logical ESMF_ioeq
  type(ESMF_IOFmt_Flag), intent(in) :: io1, io2

  ESMF_ioeq = (io1%io_type == io2%io_type)
end function

!------------------------------------------------------------------------------
! function to compare two ESMF_Index_Flag types

impure elemental function ESMF_ifeq(if1, if2)
  logical ESMF_ifeq
  type(ESMF_Index_Flag), intent(in) :: if1, if2

  ESMF_ifeq = (if1%i_type == if2%i_type)
end function

impure elemental function ESMF_ifneq(if1, if2)
  logical ESMF_ifneq
  type(ESMF_Index_Flag), intent(in) :: if1, if2

  ESMF_ifneq = (if1%i_type /= if2%i_type)
end function

!------------------------------------------------------------------------------
! subroutine to assign string value of an ESMF_Index_Flag

subroutine ESMF_ifas_string(string, ifval)
 character(len=*), intent(out) :: string
 type(ESMF_Index_Flag), intent(in) :: ifval

 if (ifval == ESMF_INDEX_DELOCAL) then
   write(string,'(a)') 'ESMF_INDEX_DELOCAL'
 elseif (ifval == ESMF_INDEX_GLOBAL) then
   write(string,'(a)') 'ESMF_INDEX_GLOBAL'
 elseif (ifval == ESMF_INDEX_USER) then
   write(string,'(a)') 'ESMF_INDEX_USER'
 endif

end subroutine

!------------------------------------------------------------------------------
! function to compare two ESMF_InquireFlag types

impure elemental function ESMF_inqfeq(inqf1, inqf2)
  logical ESMF_inqfeq
  type(ESMF_InquireFlag), intent(in) :: inqf1, inqf2

  ESMF_inqfeq = (inqf1%flag == inqf2%flag)
end function ESMF_inqfeq

!------------------------------------------------------------------------------
! function to compare two ESMF_Region_Flag types

impure elemental function ESMF_rfeq(rf1, rf2)
  logical ESMF_rfeq
  type(ESMF_Region_Flag), intent(in) :: rf1, rf2

  ESMF_rfeq = (rf1%i_type == rf2%i_type)
end function


!------------------------------------------------------------------------------
!------------------------------------------------------------------------------
! subroutine to print the corresponding C pointer of ESMF_Pointer object

subroutine ESMF_PointerPrint(ptr)
  type(ESMF_Pointer), intent(in) :: ptr
  call c_pointerprint(ptr)
end subroutine

!------------------------------------------------------------------------------
! function to compare two ESMF_UNMAPPEDACTION types

impure elemental function ESMF_unmappedactioneq(uma1, uma2)
 logical ESMF_unmappedactioneq
 type(ESMF_UnmappedAction_Flag), intent(in) :: uma1, uma2

 ESMF_unmappedactioneq = (uma1%unmappedaction == uma2%unmappedaction)
end function

impure elemental function ESMF_unmappedactionne(uma1, uma2)
 logical ESMF_unmappedactionne
 type(ESMF_UnmappedAction_Flag), intent(in) :: uma1, uma2

 ESMF_unmappedactionne = (uma1%unmappedaction /= uma2%unmappedaction)
end function


!------------------------------------------------------------------------------
! function to compare two ESMF_PoleMethod types

impure elemental function ESMF_RegridPoleEq(rp1, rp2)
 logical ESMF_RegridPoleEq
 type(ESMF_PoleMethod_Flag), intent(in) :: rp1, rp2

 ESMF_RegridPoleEq = (rp1%polemethod == rp2%polemethod)
end function

impure elemental function ESMF_RegridPoleNe(rp1, rp2)
 logical ESMF_RegridPoleNe
 type(ESMF_PoleMethod_Flag), intent(in) :: rp1, rp2

 ESMF_RegridPoleNe = (rp1%polemethod /= rp2%polemethod)
end function

!------------------------------------------------------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_FileFormatEq"
impure elemental function ESMF_FileFormatEq(FileFormat1, FileFormat2)

! !RETURN VALUE:
      logical :: ESMF_FileFormatEq

! !ARGUMENTS:

      type (ESMF_FileFormat_Flag), intent(in) :: &
         FileFormat1,      &! Two igrid statuses to compare for
         FileFormat2        ! equality

      ESMF_FileFormatEq = (FileFormat1%fileformat == &
                              FileFormat2%fileformat)

end function ESMF_FileFormatEq
!------------------------------------------------------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_FileFormatNe"
 impure elemental function ESMF_FileFormatNe(FileFormat1, FileFormat2)

! !RETURN VALUE:
      logical :: ESMF_FileFormatNe

! !ARGUMENTS:

      type (ESMF_FileFormat_Flag), intent(in) :: &
         FileFormat1,      &! Two FileFormatType Statuses to compare for
         FileFormat2        ! inequality


      ESMF_FileFormatNe = (FileFormat1%fileformat /= &
                                 FileFormat2%fileformat)

end function ESMF_FileFormatNe
!------------------------------------------------------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_FileFormatAsString"
subroutine ESMF_FileFormatAsString(String, FileFormat)
  character(len=*), intent(out) :: String
  type(ESMF_FileFormat_Flag), intent(in) :: FileFormat

  if (FileFormat == ESMF_FILEFORMAT_UNKNOWN) then
     String = 'ESMF_FILEFORMAT_UNKNOWN'
  else if (FileFormat == ESMF_FILEFORMAT_VTK) then
     String = 'ESMF_FILEFORMAT_VTK'
  else if (FileFormat == ESMF_FILEFORMAT_SCRIP) then
     String = 'ESMF_FILEFORMAT_SCRIP'
  else if (FileFormat == ESMF_FILEFORMAT_ESMFMESH) then
     String = 'ESMF_FILEFORMAT_ESMFMESH'
  else if (FileFormat == ESMF_FILEFORMAT_ESMFGRID) then
     String = 'ESMF_FILEFORMAT_ESMFGRID'
  else if (FileFormat == ESMF_FILEFORMAT_UGRID) then
     String = 'ESMF_FILEFORMAT_UGRID'
  else if (FileFormat == ESMF_FILEFORMAT_CFGRID) then
     ! Note that ESMF_FILEFORMAT_CFGRID is the same as ESMF_FILEFORMAT_GRIDSPEC
     String = 'ESMF_FILEFORMAT_CFGRID/ESMF_FILEFORMAT_GRIDSPEC'
  else if (FileFormat == ESMF_FILEFORMAT_MOSAIC) then
     String = 'ESMF_FILEFORMAT_MOSAIC'
  else if (FileFormat == ESMF_FILEFORMAT_TILE) then
     String = 'ESMF_FILEFORMAT_TILE'
  else
     String = '(Unexpected ESMF_FILEFORMAT value)'
  end if
end subroutine ESMF_FileFormatAsString

!------------------------------------------------------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_FileModeEq"
impure elemental function ESMF_FileModeEq(FileMode1, FileMode2)

  logical :: ESMF_FileModeEq

  type (ESMF_FileMode_Flag), intent(in) :: FileMode1, FileMode2

  ESMF_FileModeEq = (FileMode1%filemode == FileMode2%filemode)

end function ESMF_FileModeEq
!------------------------------------------------------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_FileModeNe"
impure elemental function ESMF_FileModeNe(FileMode1, FileMode2)

  logical :: ESMF_FileModeNe

  type (ESMF_FileMode_Flag), intent(in) :: FileMode1, FileMode2

  ESMF_FileModeNe = (FileMode1%filemode /= FileMode2%filemode)

end function ESMF_FileModeNe
!------------------------------------------------------------------------------

! function to compare/assign two ESMF_FileStatus_Flags
!------------------------------------------------------------------------------

subroutine ESMF_FileStatusAs(fs1, fs2)
 type(ESMF_FileStatus_Flag), intent(out) :: fs1
 type(ESMF_FileStatus_Flag), intent(in)  :: fs2

 fs1%status_type = fs2%status_type
end subroutine ESMF_FileStatusAs

impure elemental function ESMF_FileStatusEq(fs1, fs2)
  logical ESMF_FileStatusEq
  type(ESMF_FileStatus_Flag), intent(in) :: fs1, fs2

  ESMF_FileStatusEq = (fs1%status_type == fs2%status_type)
end function ESMF_FileStatusEq

impure elemental function ESMF_FileStatusNe(fs1, fs2)
  logical ESMF_FileStatusNe
  type(ESMF_FileStatus_Flag), intent(in) :: fs1, fs2

  ESMF_FileStatusNe = (fs1%status_type == fs2%status_type)
end function ESMF_FileStatusNe

!------------------------------------------------------------------------------
! function to compare two ESMF_RegridMethod types

impure elemental function ESMF_RegridMethodEq(rp1, rp2)
 logical ESMF_RegridMethodEq
 type(ESMF_RegridMethod_Flag), intent(in) :: rp1, rp2

 ESMF_RegridMethodEq = (rp1%regridmethod == rp2%regridmethod)
end function

impure elemental function ESMF_RegridMethodNe(rp1, rp2)
 logical ESMF_RegridMethodNe
 type(ESMF_RegridMethod_Flag), intent(in) :: rp1, rp2

 ESMF_RegridMethodNe = (rp1%regridmethod /= rp2%regridmethod)
end function

!------------------------------------------------------------------------------
! function to compare two ESMF_CubedSphereCalc types

impure elemental function ESMF_CubedSphereCalcEq(csc1, csc2)
 logical ESMF_CubedSphereCalcEq
 type(ESMF_CubedSphereCalc_Flag), intent(in) :: csc1, csc2

 ESMF_CubedSphereCalcEq = (csc1%cubedspherecalc == csc2%cubedspherecalc)
end function

impure elemental function ESMF_CubedSphereCalcNe(csc1, csc2)
 logical ESMF_CubedSphereCalcNe
 type(ESMF_CubedSphereCalc_Flag), intent(in) :: csc1, csc2

 ESMF_CubedSphereCalcNe = (csc1%cubedspherecalc /= csc2%cubedspherecalc)
end function

!------------------------------------------------------------------------------
! function to compare two ESMF_ExtrapMethod types

impure elemental function ESMF_ExtrapMethodEq(ep1, ep2)
 logical ESMF_ExtrapMethodEq
 type(ESMF_ExtrapMethod_Flag), intent(in) :: ep1, ep2

 ESMF_ExtrapMethodEq = (ep1%extrapmethod == ep2%extrapmethod)
end function

impure elemental function ESMF_ExtrapMethodNe(ep1, ep2)
 logical ESMF_ExtrapMethodNe
 type(ESMF_ExtrapMethod_Flag), intent(in) :: ep1, ep2

 ESMF_ExtrapMethodNe = (ep1%extrapmethod /= ep2%extrapmethod)
end function


!------------------------------------------------------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_CoordSysEqual"
!BOPI
! !IROUTINE: ESMF_CoordSysEqual - Equality of Coordinate Systems
!
! !INTERFACE:
      impure elemental function ESMF_CoordSysEqual(CoordSys1, CoordSys2)

! !RETURN VALUE:
      logical :: ESMF_CoordSysEqual

! !ARGUMENTS:

      type (ESMF_CoordSys_Flag), intent(in) :: &
         CoordSys1,      &! Two igrid statuses to compare for
         CoordSys2        ! equality

! !DESCRIPTION:
!     This routine compares two ESMF CoordSys statuses to see if
!     they are equivalent.
!
!     The arguments are:
!     \begin{description}
!     \item[CoordSys1, CoordSys2]
!          Two igrid statuses to compare for equality
!     \end{description}
!
!EOPI

      ESMF_CoordSysEqual = (CoordSys1%coordsys == &
                              CoordSys2%coordsys)

      end function ESMF_CoordSysEqual
!------------------------------------------------------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_CoordSysNotEqual"
!BOPI
! !IROUTINE: ESMF_CoordSysNotEqual - Non-equality of CoordSys statuses
!
! !INTERFACE:
      impure elemental function ESMF_CoordSysNotEqual(CoordSys1, CoordSys2)

! !RETURN VALUE:
      logical :: ESMF_CoordSysNotEqual

! !ARGUMENTS:

      type (ESMF_CoordSys_Flag), intent(in) :: &
         CoordSys1,      &! Two CoordSys Statuses to compare for
         CoordSys2        ! inequality

! !DESCRIPTION:
!     This routine compares two ESMF CoordSys statuses to see if
!     they are unequal.
!
!     The arguments are:
!     \begin{description}
!     \item[CoordSys1, CoordSys2]
!          Two statuses of CoordSyss to compare for inequality
!     \end{description}
!
!EOPI

      ESMF_CoordSysNotEqual = (CoordSys1%coordsys /= &
                                 CoordSys2%coordsys)

      end function ESMF_CoordSysNotEqual



!------------------------------------------------------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_NormTypeEqual"
!BOPI
! !IROUTINE: ESMF_NormTypeEqual - Equality of Coordinate Systems
!
! !INTERFACE:
      impure elemental function ESMF_NormTypeEqual(NormType1, NormType2)

! !RETURN VALUE:
      logical :: ESMF_NormTypeEqual

! !ARGUMENTS:

      type (ESMF_NormType_Flag), intent(in) :: &
         NormType1,      &! Two igrid statuses to compare for
         NormType2        ! equality

! !DESCRIPTION:
!     This routine compares two ESMF NormType statuses to see if
!     they are equivalent.
!
!     The arguments are:
!     \begin{description}
!     \item[NormType1, NormType2]
!          Two igrid statuses to compare for equality
!     \end{description}
!
!EOPI

      ESMF_NormTypeEqual = (NormType1%normtype == &
                              NormType2%normtype)

      end function ESMF_NormTypeEqual
!------------------------------------------------------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_NormTypeNotEqual"
!BOPI
! !IROUTINE: ESMF_NormTypeNotEqual - Non-equality of NormType statuses
!
! !INTERFACE:
      impure elemental function ESMF_NormTypeNotEqual(NormType1, NormType2)

! !RETURN VALUE:
      logical :: ESMF_NormTypeNotEqual

! !ARGUMENTS:

      type (ESMF_NormType_Flag), intent(in) :: &
         NormType1,      &! Two NormType Statuses to compare for
         NormType2        ! inequality

! !DESCRIPTION:
!     This routine compares two ESMF NormType statuses to see if
!     they are unequal.
!
!     The arguments are:
!     \begin{description}
!     \item[NormType1, NormType2]
!          Two statuses of NormTypes to compare for inequality
!     \end{description}
!
!EOPI

      ESMF_NormTypeNotEqual = (NormType1%normtype /= &
                                 NormType2%normtype)

      end function ESMF_NormTypeNotEqual


!------------------------------------------------------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_LineTypeEqual"
!BOPI
! !IROUTINE: ESMF_LineTypeEqual - Equality of Coordinate Systems
!
! !INTERFACE:
      impure elemental function ESMF_LineTypeEqual(LineType1, LineType2)

! !RETURN VALUE:
      logical :: ESMF_LineTypeEqual

! !ARGUMENTS:

      type (ESMF_LineType_Flag), intent(in) :: &
         LineType1,      &! Two igrid statuses to compare for
         LineType2        ! equality

! !DESCRIPTION:
!     This routine compares two ESMF LineType statuses to see if
!     they are equivalent.
!
!     The arguments are:
!     \begin{description}
!     \item[LineType1, LineType2]
!          Two igrid statuses to compare for equality
!     \end{description}
!
!EOPI

      ESMF_LineTypeEqual = (LineType1%linetype == &
                              LineType2%linetype)

      end function ESMF_LineTypeEqual
!------------------------------------------------------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_LineTypeNotEqual"
!BOPI
! !IROUTINE: ESMF_LineTypeNotEqual - Non-equality of LineType statuses
!
! !INTERFACE:
      impure elemental function ESMF_LineTypeNotEqual(LineType1, LineType2)

! !RETURN VALUE:
      logical :: ESMF_LineTypeNotEqual

! !ARGUMENTS:

      type (ESMF_LineType_Flag), intent(in) :: &
         LineType1,      &! Two LineType Statuses to compare for
         LineType2        ! inequality

! !DESCRIPTION:
!     This routine compares two ESMF LineType statuses to see if
!     they are unequal.
!
!     The arguments are:
!     \begin{description}
!     \item[LineType1, LineType2]
!          Two statuses of LineTypes to compare for inequality
!     \end{description}
!
!EOPI

      ESMF_LineTypeNotEqual = (LineType1%linetype /= &
                                 LineType2%linetype)

      end function ESMF_LineTypeNotEqual


!------------------------------------------------------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_RWGCheckMethodEqual"
!BOPI
! !IROUTINE: ESMF_RWGCheckMethodEqual - Check equality of RWGCheckMethod flags.
!
! !INTERFACE:
      impure elemental function ESMF_RWGCheckMethodEqual(CheckMethod1, CheckMethod2)

! !RETURN VALUE:
      logical :: ESMF_RWGCheckMethodEqual

! !ARGUMENTS:

      type (ESMF_RWGCheckMethod_Flag), intent(in) :: &
         CheckMethod1,      & ! Two statuses to compare
         CheckMethod2

! !DESCRIPTION:
!     This routine compares two ESMF RWGCheckMethod statuses to see
!     if they are equivalent.
!
!     The arguments are:
!     \begin{description}
!     \item[CheckMethod1, CheckMethod2]
!          Two statuses to compare for equality.
!     \end{description}
!
!EOPI

      ESMF_RWGCheckMethodEqual = (CheckMethod1%flag == &
                                  CheckMethod2%flag)

      end function ESMF_RWGCheckMethodEqual
!-------------------------------------------------------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_RWGCheckMethodNotEqual"
!BOPI
! !IROUTINE: ESMF_RWGCheckMethodNotEqual - Check equality of RWGCheckMethod flags.
!
! !INTERFACE:
      impure elemental function ESMF_RWGCheckMethodNotEqual(CheckMethod1, CheckMethod2)

! !RETURN VALUE:
      logical :: ESMF_RWGCheckMethodNotEqual

! !ARGUMENTS:

      type (ESMF_RWGCheckMethod_Flag), intent(in) :: &
         CheckMethod1,      & ! Two statuses to compare
         CheckMethod2

! !DESCRIPTION:
!     This routine compares two ESMF RWGCheckMethod statuses to see
!     if they are equivalent.
!
!     The arguments are:
!     \begin{description}
!     \item[CheckMethod1, CheckMethod2]
!          Two statuses to compare for equality.
!     \end{description}
!
!EOPI

      ESMF_RWGCheckMethodNotEqual = (CheckMethod1%flag /= &
                                     CheckMethod2%flag)

      end function ESMF_RWGCheckMethodNotEqual
!-------------------------------------------------------------------------------

!------------------------------------------------------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_TermOrderEq"
!BOPI
! !IROUTINE: ESMF_TermOrderEq - Equality of TermOrder Flag
!
! !INTERFACE:
      impure elemental function ESMF_TermOrderEq(termOrder1, termOrder2)

! !RETURN VALUE:
      logical :: ESMF_TermOrderEq

! !ARGUMENTS:

      type (ESMF_TermOrder_Flag), intent(in) :: &
         termOrder1,      &
         termOrder2

! !DESCRIPTION:
!     This routine compares two ESMF TermOrder flags to see if
!     they are equivalent.
!
!     The arguments are:
!     \begin{description}
!     \item[termOrder1, termOrder2]
!          termorder flags
!     \end{description}
!
!EOPI

      ESMF_TermOrderEq = (termOrder1%flag == termOrder2%flag)

      end function ESMF_TermOrderEq

#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_TermOrderEq"
!BOPI
! !IROUTINE: ESMF_TermOrderEq - Equality of TermOrder Flag
!
! !INTERFACE:
      impure elemental function ESMF_PredefinedDynamicMask_FlagEq(flag1, flag2)

! !RETURN VALUE:
      logical :: ESMF_PredefinedDynamicMask_FlagEq

! !ARGUMENTS:

      type (ESMF_PredefinedDynamicMask_Flag), intent(in) :: &
         flag1,      &
         flag2 

! !DESCRIPTION:
!     This routine compares two ESMF PredefinedDynamicMask flags to see if
!     they are equivalent.
!
!     The arguments are:
!     \begin{description}
!     \item[flag1, flag2]
!          PredefinedDynamicMask flags
!     \end{description}
!
!EOPI

      ESMF_PredefinedDynamicMask_FlagEq = (flag1%PredefinedDynamicMask == flag2%PredefinedDynamicMask)

      end function ESMF_PredefinedDynamicMask_FlagEq

!------------------------------------------------------------------------- 
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_UtilVersionPrint"
!BOPI
!  !IROUTINE:  ESMF_UtilPrintVersion
!  
! !INTERFACE: 
  subroutine ESMF_UtilVersionPrint (keywordenforcer, vFlag, versionFlag, rc) 
!
! !ARGUMENTS:
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
      logical, intent(in),  optional :: vFlag
      logical, intent(in),  optional :: versionFlag
      integer, intent(out), optional :: rc

!
! !DESCRIPTION:
!   Print the ESMF library version and copyright info to stdout.
!
!     The arguments are:
!     \begin{description}
!     \item[{[vFlag]}]
!       Print one-line version information
!     \item[{[versionFlag]}]
!       Print full version and copyright output.
!     \item[{[rc]}]
!       Return code; equals {\tt ESMF\_SUCCESS} if there are no errors.
!     \end{description}
!
!
!EOPI

    if (present(rc)) rc = ESMF_FAILURE

    if (present (vFlag)) then
      if (vFlag) then
        print *, "  ESMF_VERSION_STRING:       ", ESMF_VERSION_STRING
      end if
    end if

    if (present (vFlag) .and. present (versionFlag)) then
      if (vFlag .and. versionFlag) then
        print *
      end if
    end if

    if (present (versionFlag)) then
      if (versionFlag) then
        print *, "  ESMF_VERSION_STRING:       ", ESMF_VERSION_STRING
#ifdef ESMF_VERSION_STRING_GIT
        print *, "  ESMF_VERSION_STRING_GIT:   ", ESMF_VERSION_STRING_GIT
#else
        print *, "  ESMF_VERSION_STRING_GIT:   ", "(not available)"
#endif
        print *, "  ESMF_VERSION_MAJOR:        ", ESMF_VERSION_MAJOR
        print *, "  ESMF_VERSION_MINOR:        ", ESMF_VERSION_MINOR
        print *, "  ESMF_VERSION_REVISION:     ", ESMF_VERSION_REVISION
        print *, "  ESMF_VERSION_PATCHLEVEL:   ", ESMF_VERSION_PATCHLEVEL
        print *, "  ESMF_VERSION_PUBLIC:       ", ESMF_VERSION_PUBLIC
        print *, "  ESMF_VERSION_BETASNAPSHOT: ", ESMF_VERSION_BETASNAPSHOT
        print *, ""
        print *, "Earth System Modeling Framework"
        print *, ""
        print *, "Copyright (c) 2002-2025 University Corporation for Atmospheric Research,"
        print *, "Massachusetts Institute of Technology, Geophysical Fluid Dynamics Laboratory,"
        print *, "University of Michigan, National Centers for Environmental Prediction,"
        print *, "Los Alamos National Laboratory, Argonne National Laboratory,"
        print *, "NASA Goddard Space Flight Center."
        print *, "All rights reserved."
        print *, ""
        print *, "Permission is hereby granted, free of charge, to any person obtaining a copy"
        print *, "of this software and associated documentation files (the 'Software'), to"
        print *, "deal with the Software without restriction, including without limitation the"
        print *, "rights to use, copy, modify, merge, publish, distribute, sublicense, and/or"
        print *, "sell copies of the Software, and to permit persons to whom the Software is"
        print *, "furnished to do so, subject to the following conditions:"
        print *, "   1. Redistributions of source code must retain the above copyright notice,"
        print *, "      this list of conditions and the following disclaimers."
        print *, "   2. Redistributions in binary form must reproduce the above copyright"
        print *, "      notice, this list of conditions and the following disclaimers in the"
        print *, "      documentation and/or other materials provided with the distribution."
        print *, "   3. Neither the names of the organizations developing this software, nor"
        print *, "      the names of its contributors may be used to endorse or promote products"
        print *, "      derived from this Software without specific prior written permission."
        print *, ""
        print *, "THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR"
        print *, "IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,"
        print *, "FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE"
        print *, "CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER"
        print *, "LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING"
        print *, "FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS"
        print *, "WITH THE SOFTWARE."
      end if
    end if

    if (present(rc)) rc = ESMF_SUCCESS

  end subroutine ESMF_UtilVersionPrint

end module ESMF_UtilTypesMod
