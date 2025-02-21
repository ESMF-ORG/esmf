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
#define ESMF_FILENAME "ESMF_Array.F90"
!==============================================================================
!
! ESMF Array Module
module ESMF_ArrayMod
!
!==============================================================================
!
! This file contains the Fortran wrapper code for the C++ implementation of
!  the Array class.
!
!------------------------------------------------------------------------------
! INCLUDES
#include "ESMF.h"

!==============================================================================
!BOPI
! !MODULE: ESMF_ArrayMod
!

!   Fortran API wrapper of C++ implemenation of Array
!
!------------------------------------------------------------------------------

! !USES:
  use iso_c_binding

  use ESMF_UtilTypesMod     ! ESMF utility types
  use ESMF_InitMacrosMod    ! ESMF initializer macros
  use ESMF_BaseMod          ! ESMF base class
  use ESMF_LogErrMod        ! ESMF error handling
  use ESMF_LocalArrayMod
  use ESMF_ArraySpecMod
  use ESMF_VMMod
  use ESMF_DELayoutMod
  use ESMF_DistGridMod
  use ESMF_RHandleMod
  use ESMF_F90InterfaceMod  ! ESMF Fortran-C++ interface helper
  use ESMF_FactorReadMod    ! ESMF helpers for reading from netCDF file
  use ESMF_DynamicMaskMod
  use ESMF_PredefinedDynamicMaskMod
  
  ! class sub modules
  use ESMF_ArrayCreateMod   ! contains the ESMF_Array derived type definition
  use ESMF_ArrayGatherMod
  use ESMF_ArrayGetMod
  use ESMF_ArrayHaMod
  use ESMF_ArrayScatterMod
  
  implicit none

!------------------------------------------------------------------------------
! !PRIVATE TYPES:
  private

!------------------------------------------------------------------------------
! !PUBLIC TYPES:
  public ESMF_Array                 ! implemented in ESMF_ArrayCreateMod 
  
!------------------------------------------------------------------------------

!------------------------------------------------------------------------------
!
! !PUBLIC MEMBER FUNCTIONS:

! - ESMF-public methods:
  public operator(==)               ! implemented in ESMF_ArrayCreateMod 
  public operator(/=)               ! implemented in ESMF_ArrayCreateMod 
  public ESMF_ArrayCopy             ! implemented in ESMF_ArrayCreateMod 
  public ESMF_ArrayCreate           ! implemented in ESMF_ArrayCreateMod 
  public ESMF_ArrayDestroy          ! implemented in ESMF_ArrayCreateMod 
  public ESMF_ArrayGather           ! implemented in ESMF_ArrayGatherMod 
  public ESMF_ArrayGet              ! implemented in ESMF_ArrayGetMod 
  public ESMF_ArrayHalo             ! implemented in ESMF_ArrayHaMod
  public ESMF_ArrayHaloRelease      ! implemented in ESMF_ArrayHaMod
  public ESMF_ArrayHaloStore        ! implemented in ESMF_ArrayHaMod
  public ESMF_ArrayIsCreated        ! implemented in ESMF_ArrayHaMod
  public ESMF_ArrayLog              ! implemented in ESMF_ArrayHaMod
  public ESMF_ArrayPrint            ! implemented in ESMF_ArrayHaMod
  public ESMF_ArrayRead             ! implemented in ESMF_ArrayHaMod
  public ESMF_ArrayRedist           ! implemented in ESMF_ArrayHaMod
  public ESMF_ArrayRedistRelease    ! implemented in ESMF_ArrayHaMod
  public ESMF_ArrayRedistStore      ! implemented in ESMF_ArrayHaMod
  public ESMF_ArrayReduce
  public ESMF_ArrayScatter          ! implemented in ESMF_ArrayScatterMod 
  public ESMF_ArraySet
  public ESMF_ArraySMM
  public ESMF_ArraySMMRelease
  public ESMF_ArraySMMStore
  public ESMF_ArraySync
  public ESMF_ArrayValidate
  public ESMF_ArrayWrite

! - ESMF-internal methods:
  public ESMF_ArrayGetInit          ! implemented in ESMF_ArrayCreateMod
  public ESMF_ArraySetInitCreated   ! implemented in ESMF_ArrayCreateMod
  public ESMF_ArrayGetThis          ! implemented in ESMF_ArrayCreateMod
  public ESMF_ArraySetThis          ! implemented in ESMF_ArrayCreateMod
  public ESMF_ArraySetThisNull      ! implemented in ESMF_ArrayCreateMod
  public ESMF_ArrayCopyThis         ! implemented in ESMF_ArrayCreateMod
  public ESMF_ArrayIsProxy          ! implemented in ESMF_ArrayCreateMod


!EOPI
!------------------------------------------------------------------------------

!------------------------------------------------------------------------------
! The following line turns the CVS identifier string into a printable variable.
  character(*), parameter, private :: version = &
    '$Id$'

!==============================================================================
! 
! INTERFACE BLOCKS
!
!==============================================================================

! -------------------------- ESMF-public method -------------------------------
!BOPI
! !IROUTINE: ESMF_ArraySet -- Generic interface

! !INTERFACE:
  interface ESMF_ArraySet

! !PRIVATE MEMBER FUNCTIONS:
!
    module procedure ESMF_ArraySetDefault
    module procedure ESMF_ArraySetPLocalDe
      
! !DESCRIPTION: 
! This interface provides a single entry point for the various 
!  types of {\tt ESMF\_ArraySet} functions.   
!EOPI 
  end interface


! -------------------------- ESMF-public method -------------------------------
!BOPI
! !IROUTINE: ESMF_ArraySMMStore -- Generic interface

! !INTERFACE:
  interface ESMF_ArraySMMStore

! !PRIVATE MEMBER FUNCTIONS:
!
    module procedure ESMF_ArraySMMStoreInd4I4
    module procedure ESMF_ArraySMMStoreInd4I8
    module procedure ESMF_ArraySMMStoreInd4R4
    module procedure ESMF_ArraySMMStoreInd4R8
    module procedure ESMF_ArraySMMStoreInd8I4
    module procedure ESMF_ArraySMMStoreInd8I8
    module procedure ESMF_ArraySMMStoreInd8R4
    module procedure ESMF_ArraySMMStoreInd8R8
    module procedure ESMF_ArraySMMStoreInd4I4TP
    module procedure ESMF_ArraySMMStoreInd4I8TP
    module procedure ESMF_ArraySMMStoreInd4R4TP
    module procedure ESMF_ArraySMMStoreInd4R8TP
    module procedure ESMF_ArraySMMStoreInd8I4TP
    module procedure ESMF_ArraySMMStoreInd8I8TP
    module procedure ESMF_ArraySMMStoreInd8R4TP
    module procedure ESMF_ArraySMMStoreInd8R8TP
    module procedure ESMF_ArraySMMStoreNF
    module procedure ESMF_ArraySMMStoreNFTP
    module procedure ESMF_ArraySMMStoreFromFile
    module procedure ESMF_ArraySMMStoreFromFileTP
!EOPI

  end interface


! -------------------------- ESMF-public method -------------------------------
!BOPI
! !IROUTINE: ESMF_ArrayReduce -- Generic interface

! !INTERFACE:
  interface ESMF_ArrayReduce

! !PRIVATE MEMBER FUNCTIONS:
!
    module procedure ESMF_ArrayReduce
    module procedure ESMF_ArrayReduceFarray

! todo: need to write vector version where the user can specify which
!       dimensions of narray are supposed to be reduced. output is vector
!       good news is that the vector version does not have to be type/kind
!       overloaded because of the result being a LocalArray!

! !DESCRIPTION: 
! This interface provides a single entry point for the various 
!  types of {\tt ESMF\_ArrayReduce} functions.   
!EOPI 
  end interface


!------------------------------------------------------------------------------
! ! Interoperability interfaces

#ifndef ESMF_NO_F2018ASSUMEDTYPE

  interface

    subroutine c_ESMC_ArraySMMStoreInd4(srcArray, dstArray, routehandle, &
      typekindFactors, factorList, factorListCount, factorIndexList, &
      ignoreUnmatched, srcTermProcessing, pipelineDepth, rc)
      import                :: ESMF_Array, ESMF_RouteHandle
      import                :: ESMF_TypeKind_Flag, ESMF_InterArray, ESMF_Logical
      type(ESMF_Array)      :: srcArray, dstArray
      type(ESMF_RouteHandle):: routehandle
      type(ESMF_TypeKind_Flag):: typekindFactors
      type(*)               :: factorList(*)
      integer               :: factorListCount
      type(ESMF_InterArray) :: factorIndexList
      type(ESMF_Logical)    :: ignoreUnmatched
      integer               :: srcTermProcessing, pipelineDepth
      integer               :: rc
    end subroutine

    subroutine c_ESMC_ArraySMMStoreInd8(srcArray, dstArray, routehandle, &
      typekindFactors, factorList, factorListCount, factorIndexList, &
      ignoreUnmatched, srcTermProcessing, pipelineDepth, rc)
      import                :: ESMF_Array, ESMF_RouteHandle
      import                :: ESMF_TypeKind_Flag, ESMF_InterArray, ESMF_Logical
      type(ESMF_Array)      :: srcArray, dstArray
      type(ESMF_RouteHandle):: routehandle
      type(ESMF_TypeKind_Flag):: typekindFactors
      type(*)               :: factorList(*)
      integer               :: factorListCount
      type(ESMF_InterArray) :: factorIndexList
      type(ESMF_Logical)    :: ignoreUnmatched
      integer               :: srcTermProcessing, pipelineDepth
      integer               :: rc
    end subroutine

  end interface

#endif

!------------------------------------------------------------------------------

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

contains

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArrayReduce()"
!BOPI
! !IROUTINE: ESMF_ArrayReduce

! !INTERFACE:
  subroutine ESMF_ArrayReduce(array, result, reduceflag, rootPET, vm, rc)
!
! !ARGUMENTS:
    type(ESMF_Array),       intent(inout)         :: array
    real(ESMF_KIND_R8),     intent(out), optional :: result
    type(ESMF_Reduce_Flag), intent(in)            :: reduceflag
    integer,                intent(in)            :: rootPET
    type(ESMF_VM),          intent(in),  optional :: vm
    integer,                intent(out), optional :: rc  
!
! !DESCRIPTION:
!     Fully reduce the entire Array into a single {\tt result} on {\tt rootPET}
!     according to the operation specified in {\tt reduceflag}. Only root must
!     specify a valid result argument.
!
!     This version of the interface 
!     implements the PET-based blocking paradigm: Each PET of the VM must issue
!     this call exactly once for {\em all} of its DEs. The
!     call will block until all PET-local data objects are accessible.
!
!     The arguments are:
!     \begin{description}
!     \item[array] 
!        The {\tt ESMF\_Array} object across which data will be scattered.
!     \item[{[result ]}]
!        Argument into which to reduce the Array. Only root
!        must provide a valid {\tt result} argument.
!     \item[reduceflag] 
!        Reduction operation. See section \ref{const:reduce} for a list of 
!        valid reduce operations. There will be options that determine the 
!        sequence of operations to ensure bit-wise reproducibility.
!     \item[rootPET]
!          root.
!     \item[{[vm]}]
!        Optional {\tt ESMF\_VM} object of the current context. Providing the
!        VM of the current context will lower the method's overhead.
!     \item[{[rc]}] 
!          Return code; equals {\tt ESMF\_SUCCESS} if there are no errors.
!     \end{description}
!
!EOPI
!------------------------------------------------------------------------------
    integer                 :: localrc      ! local return code

    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL
    
    result = real(0.,ESMF_KIND_R8)  ! quiet down compiler warnings while not fully implemented
    
  end subroutine ESMF_ArrayReduce
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArrayReduce()"
!BOPI
! !IROUTINE: ESMF_ArrayReduce

! !INTERFACE:
  ! Private name; call using ESMF_ArrayReduce()
  subroutine ESMF_ArrayReduceFarray(array, farray, reduceflag, rootPET, &
    dimList, tile, vm, rc)
!
! !ARGUMENTS:
    type(ESMF_Array),           intent(inout)           :: array
    real(ESMF_KIND_R8), target, intent(out),  optional  :: farray(:,:)
    type(ESMF_Reduce_Flag),     intent(in)              :: reduceflag
    integer,                    intent(in)              :: rootPET
    integer,                    intent(in)              :: dimList(:)
    integer,                    intent(in),   optional  :: tile
    type(ESMF_VM),              intent(in),   optional  :: vm
    integer,                    intent(out),  optional  :: rc  
!
! !DESCRIPTION:
!     Reduce the dimensions specified in {\tt dimList} of the Array object 
!     into {\tt farray} on {\tt rootPET} according to the operation specified 
!     in {\tt reduceflag}. Only root must provide a valid {\tt farray} argument.
!     
!     This partial reduction operation is tile specific, i.e. only a single
!     DistGrid tile of the Array will be reduced. The tile can be selected
!     by the optional {\tt tile} argument. The shape of the provided 
!     {\tt farray} argument must match that of the Array tile reduced by the
!     dimensions specified in {\tt dimList}.
!      
!
!     This version of the interface 
!     implements the PET-based blocking paradigm: Each PET of the VM must issue
!     this call exactly once for {\em all} of its DEs. The
!     call will block until all PET-local data objects are accessible.
!
!     The arguments are:
!     \begin{description}
!     \item[array] 
!        The {\tt ESMF\_Array} object across which data will be scattered.
!     \item[{[farray]}]
!        Fortran array into which to reduce the Array. Only root
!        must provide a valid {\tt farray} argument.
!     \item[reduceflag] 
!        Reduction operation. See section \ref{const:reduce} for a list of 
!        valid reduce operations. There will be options that determine the 
!        sequence of operations to ensure bit-wise reproducibility.
!     \item[rootPET]
!          root.
!     \item[dimList]
!        List of Array dimensions to be reduced.
!     \item[{[tile]}]
!        The DistGrid tile in {\tt array} to reduce into {\tt farray}.
!        By default tile 1 of {\tt farray} will be reduced.
!     \item[{[vm]}]
!        Optional {\tt ESMF\_VM} object of the current context. Providing the
!        VM of the current context will lower the method's overhead.
!     \item[{[rc]}] 
!          Return code; equals {\tt ESMF\_SUCCESS} if there are no errors.
!     \end{description}
!
!EOPI
!------------------------------------------------------------------------------
    integer                 :: localrc      ! local return code

    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL
    
  end subroutine ESMF_ArrayReduceFarray
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArraySetDefault()"
!BOP
! !IROUTINE: ESMF_ArraySet - Set object-wide Array information
!
! !INTERFACE:
  ! Private name; call using ESMF_ArraySet()
  subroutine ESMF_ArraySetDefault(array, keywordEnforcer, computationalLWidth, &
    computationalUWidth, name, rc)

!
! !ARGUMENTS:
    type(ESMF_Array),   intent(inout)         :: array
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    integer,            intent(in),  optional :: computationalLWidth(:,:)
    integer,            intent(in),  optional :: computationalUWidth(:,:)
    character(len = *), intent(in),  optional :: name
    integer,            intent(out), optional :: rc
!
! !STATUS:
! \begin{itemize}
! \item\apiStatusCompatibleVersion{5.2.0r}
! \end{itemize}
!
! !DESCRIPTION:
!     Sets adjustable settings in an {\tt ESMF\_Array} object. Arrays with
!     tensor dimensions will set values for {\em all} tensor components.
!
!     The arguments are:
!     \begin{description}
!     \item [array]
!       {\tt ESMF\_Array} object for which to set properties.
!     \item[{[computationalLWidth]}] 
!       \begin{sloppypar}
!       This argument must have of size {\tt (dimCount, localDeCount)}.
!       {\tt computationalLWidth} specifies the lower corner of the
!       computational region with respect to the lower corner of the exclusive
!       region for all local DEs.
!       \end{sloppypar}
!     \item[{[computationalUWidth]}] 
!       \begin{sloppypar}
!       This argument must have of size {\tt (dimCount, localDeCount)}.
!       {\tt computationalUWidth} specifies the upper corner of the
!       computational region with respect to the upper corner of the exclusive
!       region for all local DEs.
!       \end{sloppypar}
!     \item [{[name]}]
!       The Array name.
!     \item [{[rc]}]
!       Return code; equals {\tt ESMF\_SUCCESS} if there are no errors.
!     \end{description}
!
!EOP
!------------------------------------------------------------------------------
    integer                 :: localrc                ! local return code
    type(ESMF_InterArray)   :: computationalLWidthArg ! helper variable
    type(ESMF_InterArray)   :: computationalUWidthArg ! helper variable

    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL
    
    ! Check init status of arguments
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, array, rc)
    
    ! Set the name in Base object
    if (present(name)) then
      if (array%isNamedAlias) then
        array%name = trim(name)
      else
        call c_ESMC_SetName(array, "Array", name, localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      endif
    endif

    ! Deal with (optional) array arguments
    computationalLWidthArg = &
      ESMF_InterArrayCreate(farray2D=computationalLWidth, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    computationalUWidthArg = &
      ESMF_InterArrayCreate(farray2D=computationalUWidth, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySet(array, computationalLWidthArg, &
      computationalUWidthArg, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Garbage collection
    call ESMF_InterArrayDestroy(computationalLWidthArg, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    call ESMF_InterArrayDestroy(computationalUWidthArg, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! return successfully
    if (present(rc)) rc = ESMF_SUCCESS

  end subroutine ESMF_ArraySetDefault
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArraySetPLocalDe()"
!BOP
! !IROUTINE: ESMF_ArraySet - Set DE-local Array information
!
! !INTERFACE:
  ! Private name; call using ESMF_ArraySet()
  subroutine ESMF_ArraySetPLocalDe(array, keywordEnforcer, localDe, rimSeqIndex, rc)

!
! !ARGUMENTS:
    type(ESMF_Array),   intent(inout)         :: array
    integer,            intent(in)            :: localDe
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    integer,            intent(in),  optional :: rimSeqIndex(:)
    integer,            intent(out), optional :: rc
!
! !STATUS:
! \begin{itemize}
! \item\apiStatusCompatibleVersion{5.2.0r}
! \end{itemize}
!
! !DESCRIPTION:
!     Sets adjustable settings in an {\tt ESMF\_Array} object for a specific
!     localDe.
!
!     The arguments are:
!     \begin{description}
!     \item [array]
!       {\tt ESMF\_Array} object for which to set properties.
!     \item [localDe]
!       Local DE for which to set values.
!     \item[{[rimSeqIndex]}] 
!       Sequence indices in the halo rim of localDe.
!     \item [{[rc]}]
!       Return code; equals {\tt ESMF\_SUCCESS} if there are no errors.
!     \end{description}
!
!EOP
!------------------------------------------------------------------------------
    integer                 :: localrc      ! local return code

    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL
    
    ! Call into the internal method
    call ESMF_ArraySetPLocalDeInternal(array, localDe, rimSeqIndex, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! return successfully
    if (present(rc)) rc = ESMF_SUCCESS

  end subroutine ESMF_ArraySetPLocalDe
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArraySMM()"
!BOP
! !IROUTINE: ESMF_ArraySMM - Execute an Array sparse matrix multiplication
!
! !INTERFACE:
  subroutine ESMF_ArraySMM(srcArray, dstArray, routehandle, keywordEnforcer, &
    routesyncflag, finishedflag, cancelledflag, zeroregion, termorderflag, &
    checkflag, dynamicMask, preDefinedDynamicMask, rc)
!
! !ARGUMENTS:
    type(ESMF_Array),               intent(in),    optional :: srcArray
    type(ESMF_Array),               intent(inout), optional :: dstArray
    type(ESMF_RouteHandle),         intent(inout)           :: routehandle
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    type(ESMF_RouteSync_Flag),      intent(in),    optional :: routesyncflag
    logical,                        intent(out),   optional :: finishedflag
    logical,                        intent(out),   optional :: cancelledflag
    type(ESMF_Region_Flag),         intent(in),    optional :: zeroregion
    type(ESMF_TermOrder_Flag),      intent(in),    optional :: termorderflag
    logical,                        intent(in),    optional :: checkflag
    type(ESMF_DynamicMask), target, intent(in),    optional :: dynamicMask
    type(ESMF_PredefinedDynamicMask), intent(in),  optional :: preDefinedDynamicMask
    integer,                        intent(out),   optional :: rc
!
! !STATUS:
! \begin{itemize}
! \item\apiStatusCompatibleVersion{5.2.0r}
! \item\apiStatusModifiedSinceVersion{5.2.0r}
! \begin{description}
! \item[6.1.0] Added argument {\tt termorderflag}.
!              The new argument gives the user control over the order in which
!              the src terms are summed up.
! \item[7.1.0r] Added argument {\tt dynamicMask}.
!              The new argument supports the dynamic masking feature.
! \end{description}
! \end{itemize}
!
! !DESCRIPTION:
!   \begin{sloppypar}
!   Execute a precomputed Array sparse matrix multiplication from {\tt srcArray}
!   to {\tt dstArray}.
!   Both {\tt srcArray} and {\tt dstArray} must match the respective Arrays
!   used during {\tt ESMF\_ArraySMMStore()} in {\em type}, {\em kind}, and 
!   memory layout of the {\em distributed} dimensions. However, the size, 
!   number, and index order of {\em undistributed} dimensions may be different. See section
!   \ref{RH:Reusability} for a more detailed discussion of RouteHandle 
!   reusability.
!   \end{sloppypar}
!
!   The {\tt srcArray} and {\tt dstArray} arguments are optional in support of
!   the situation where {\tt srcArray} and/or {\tt dstArray} are not defined on
!   all PETs. The {\tt srcArray} and {\tt dstArray} must be specified on those
!   PETs that hold source or destination DEs, respectively, but may be omitted
!   on all other PETs. PETs that hold neither source nor destination DEs may
!   omit both arguments.
!
!   It is erroneous to specify the identical Array object for {\tt srcArray} and
!   {\tt dstArray} arguments.
!
!   See {\tt ESMF\_ArraySMMStore()} on how to precompute 
!   {\tt routehandle}. See section \ref{Array:SparseMatMul} for details on the
!   operation {\tt ESMF\_ArraySMM()} performs.
!
!   This call is {\em collective} across the current VM.
!
!   \begin{description}
!   \item [{[srcArray]}]
!     {\tt ESMF\_Array} with source data.
!   \item [{[dstArray]}]
!     {\tt ESMF\_Array} with destination data.
!   \item [routehandle]
!     Handle to the precomputed Route.
!   \item [{[routesyncflag]}]
!     Indicate communication option. Default is {\tt ESMF\_ROUTESYNC\_BLOCKING},
!     resulting in a blocking operation.
!     See section \ref{const:routesync} for a complete list of valid settings.
!   \item [{[finishedflag]}]
!     \begin{sloppypar}
!     Used in combination with {\tt routesyncflag = ESMF\_ROUTESYNC\_NBTESTFINISH}.
!     Returned {\tt finishedflag} equal to {\tt .true.} indicates that all
!     operations have finished. A value of {\tt .false.} indicates that there
!     are still unfinished operations that require additional calls with
!     {\tt routesyncflag = ESMF\_ROUTESYNC\_NBTESTFINISH}, or a final call with
!     {\tt routesyncflag = ESMF\_ROUTESYNC\_NBWAITFINISH}. For all other {\tt routesyncflag}
!     settings the returned value in {\tt finishedflag} is always {\tt .true.}.
!     \end{sloppypar}
!   \item [{[cancelledflag]}]
!     A value of {\tt .true.} indicates that were cancelled communication
!     operations. In this case the data in the {\tt dstArray} must be considered
!     invalid. It may have been partially modified by the call. A value of
!     {\tt .false.} indicates that none of the communication operations was
!     cancelled. The data in {\tt dstArray} is valid if {\tt finishedflag} 
!     returns equal {\tt .true.}.
!   \item [{[zeroregion]}]
!     \begin{sloppypar}
!     If set to {\tt ESMF\_REGION\_TOTAL} {\em (default)} the total regions of
!     all DEs in {\tt dstArray} will be initialized to zero before updating the 
!     elements with the results of the sparse matrix multiplication. If set to
!     {\tt ESMF\_REGION\_EMPTY} the elements in {\tt dstArray} will not be
!     modified prior to the sparse matrix multiplication and results will be
!     added to the incoming element values. Setting {\tt zeroregion} to 
!     {\tt ESMF\_REGION\_SELECT} will only zero out those elements in the 
!     destination Array that will be updated by the sparse matrix
!     multiplication. See section \ref{const:region} for a complete list of
!     valid settings.
!     \end{sloppypar}
!   \item [{[termorderflag]}]
!     Specifies the order of the source side terms in all of the destination
!     sums. The {\tt termorderflag} only affects the order of terms during 
!     the execution of the RouteHandle. See the \ref{RH:bfb} section for an
!     in-depth discussion of {\em all} bit-for-bit reproducibility
!     aspects related to route-based communication methods.
!     See \ref{const:termorderflag} for a full list of options.
!     The default setting depends on whether the {\tt dynamicMask} argument
!     is present or not. With {\tt dynamicMask} argument present, the default
!     of {\tt termorderflag} is {\tt ESMF\_TERMORDER\_SRCSEQ}. This ensures
!     that {\tt all} source terms are present on the destination side, and 
!     the interpolation can be calculated as a single sum. When 
!     {\tt dynamicMask} is absent, the default of {\tt termorderflag} is
!     {\tt ESMF\_TERMORDER\_FREE}, allowing maximum flexibility and partial 
!     sums for optimum performance.
!   \item [{[checkflag]}]
!     If set to {\tt .TRUE.} the input Array pair will be checked for
!     consistency with the precomputed operation provided by {\tt routehandle}.
!     If set to {\tt .FALSE.} {\em (default)} only a very basic input check
!     will be performed, leaving many inconsistencies undetected. Set
!     {\tt checkflag} to {\tt .FALSE.} to achieve highest performance.
!   \item [{[dynamicMask]}]
!     Object holding dynamic masking information.
!     See section \ref{RH:DynMask} for a discussion of dynamic masking.
!   \item [{[rc]}]
!     Return code; equals {\tt ESMF\_SUCCESS} if there are no errors.
!   \end{description}
!
!EOP
!------------------------------------------------------------------------------
    integer                     :: localrc            ! local return code
    type(ESMF_Array)            :: opt_srcArray       ! helper variable
    type(ESMF_Array)            :: opt_dstArray       ! helper variable
    type(ESMF_RouteSync_Flag)   :: opt_routesyncflag  ! helper variable
    type(ESMF_Logical)          :: opt_finishedflag   ! helper variable
    type(ESMF_Logical)          :: opt_cancelledflag  ! helper variable
    type(ESMF_Region_Flag)      :: opt_zeroregion     ! helper variable
    type(ESMF_TermOrder_Flag)   :: opt_termorderflag  ! helper variable
    type(ESMF_Logical)          :: opt_checkflag      ! helper variable
    type(ESMF_DynamicMaskStateWrpR8R8R8) :: dynMaskStateR8R8R8
#ifndef ESMF_NO_DYNMASKOVERLOAD
    type(ESMF_DynamicMaskStateWrpR8R8R8V):: dynMaskStateR8R8R8V
    type(ESMF_DynamicMaskStateWrpR4R8R4) :: dynMaskStateR4R8R4
    type(ESMF_DynamicMaskStateWrpR4R8R4V):: dynMaskStateR4R8R4V
    type(ESMF_DynamicMaskStateWrpR4R4R4) :: dynMaskStateR4R4R4
    type(ESMF_DynamicMaskStateWrpR4R4R4V):: dynMaskStateR4R4R4V
#endif
    type(ESMF_Logical)          :: handleAllElements
    type(ESMF_Pointer)          :: this
    type(ESMF_TypeKind_Flag)    :: src_type, dst_type
    type(ESMF_DynamicMask), target :: local_dynamicMask
    type(Logical)          :: have_dynMask 

    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL
    if (present(dynamicMask) .and. present(preDefinedDynamicMask)) then
      rc = ESMF_RC_NOT_IMPL
      if (ESMF_LogFoundError(localrc, &
        ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
    end if
    have_dynMask = present(dynamicMask) .or. present(preDefinedDynamicMask)
    if (present(dynamicMask)) local_dynamicMask = dynamicMask

    ! Check init status of arguments, deal with optional Array args
    ESMF_INIT_CHECK_DEEP(ESMF_RouteHandleGetInit, routehandle, rc)
    if (present(srcArray)) then
      call ESMF_ArrayGetThis(srcArray, this, rc=localrc)
      if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
      if (this /= ESMF_NULL_POINTER) then
        ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, srcArray, rc)
      endif
      opt_srcArray = srcArray
      call ESMF_ArrayGet(opt_srcArray, typeKind=src_type, rc=localrc)
    else
      call ESMF_ArraySetThisNull(opt_srcArray, rc=localrc)
      if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
      src_type = ESMF_NOKIND
    endif
    if (present(dstArray)) then
      call ESMF_ArrayGetThis(dstArray, this, rc=localrc)
      if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
      if (this /= ESMF_NULL_POINTER) then
        ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, dstArray, rc)
      endif
      opt_dstArray = dstArray
      call ESMF_ArrayGet(opt_dstArray, typeKind=dst_type, rc=localrc)
    else
      call ESMF_ArraySetThisNull(opt_dstArray, rc=localrc)
      if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
        ESMF_CONTEXT, rcToReturn=rc)) return
      dst_type = ESMF_NOKIND
    endif
  
    if(present(preDefinedDynamicMask)) local_dynamicMask = preDefinedDynamicMask%create_DynamicMask(src_type, dst_type, rc)
    ! prepare for passing of dynamic masking
    if (have_dynMask) then
      ! check for valid input
      ESMF_INIT_CHECK_SHALLOW_SHORT(ESMF_DynamicMaskGetInit, local_dynamicMask, rc)
      if (local_dynamicMask%typeKey=="R8R8R8") then
        ! insert dynMaskState into RouteHandle for Fortran layer
        dynMaskStateR8R8R8%wrap => local_dynamicMask%dmsR8R8R8
        call c_ESMC_RouteHandleSetASR8R8R8(routehandle, dynMaskStateR8R8R8, &
          localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
        ! set required dynamic masking info for C++ layer
        if (local_dynamicMask%dmsR8R8R8%dynamicSrcMaskIsPresent) then
          call c_ESMC_RouteHandleSetDynSrcMask(routehandle, &
            local_dynamicMask%dmsR8R8R8%dynamicSrcMaskValue, localrc)
          if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
        endif
        if (local_dynamicMask%dmsR8R8R8%dynamicDstMaskIsPresent) then
          call c_ESMC_RouteHandleSetDynDstMask(routehandle, &
            local_dynamicMask%dmsR8R8R8%dynamicDstMaskValue, localrc)
          if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
        endif
        handleAllElements = local_dynamicMask%dmsR8R8R8%handleAllElements
        call c_ESMC_RouteHandleSetHandleAll(routehandle, &
          handleAllElements, localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
#ifndef ESMF_NO_DYNMASKOVERLOAD
      else if (local_dynamicMask%typeKey=="R8R8R8V") then
        ! insert dynMaskState into RouteHandle for Fortran layer
        dynMaskStateR8R8R8V%wrap => local_dynamicMask%dmsR8R8R8V
        call c_ESMC_RouteHandleSetASR8R8R8V(routehandle, dynMaskStateR8R8R8V, &
          localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
        ! set required dynamic masking info for C++ layer
        if (local_dynamicMask%dmsR8R8R8V%dynamicSrcMaskIsPresent) then
          call c_ESMC_RouteHandleSetDynSrcMask(routehandle, &
            local_dynamicMask%dmsR8R8R8V%dynamicSrcMaskValue, localrc)
          if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
        endif
        if (local_dynamicMask%dmsR8R8R8V%dynamicDstMaskIsPresent) then
          call c_ESMC_RouteHandleSetDynDstMask(routehandle, &
            local_dynamicMask%dmsR8R8R8V%dynamicDstMaskValue, localrc)
          if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
        endif
        handleAllElements = local_dynamicMask%dmsR8R8R8V%handleAllElements
        call c_ESMC_RouteHandleSetHandleAll(routehandle, &
          handleAllElements, localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      else if (local_dynamicMask%typeKey=="R4R8R4") then
        ! insert dynMaskState into RouteHandle for Fortran layer
        dynMaskStateR4R8R4%wrap => local_dynamicMask%dmsR4R8R4
        call c_ESMC_RouteHandleSetASR4R8R4(routehandle, dynMaskStateR4R8R4, &
          localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
        ! set required dynamic masking info for C++ layer
        if (local_dynamicMask%dmsR4R8R4%dynamicSrcMaskIsPresent) then
          call c_ESMC_RouteHandleSetDynSrcMask(routehandle, &
            local_dynamicMask%dmsR4R8R4%dynamicSrcMaskValue, localrc)
          if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
        endif
        if (local_dynamicMask%dmsR4R8R4%dynamicDstMaskIsPresent) then
          call c_ESMC_RouteHandleSetDynDstMask(routehandle, &
            local_dynamicMask%dmsR4R8R4%dynamicDstMaskValue, localrc)
          if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
        endif
        handleAllElements = local_dynamicMask%dmsR4R8R4%handleAllElements
        call c_ESMC_RouteHandleSetHandleAll(routehandle, &
          handleAllElements, localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      else if (local_dynamicMask%typeKey=="R4R8R4V") then
        ! insert dynMaskState into RouteHandle for Fortran layer
        dynMaskStateR4R8R4V%wrap => local_dynamicMask%dmsR4R8R4V
        call c_ESMC_RouteHandleSetASR4R8R4V(routehandle, dynMaskStateR4R8R4V, &
          localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
        ! set required dynamic masking info for C++ layer
        if (local_dynamicMask%dmsR4R8R4V%dynamicSrcMaskIsPresent) then
          call c_ESMC_RouteHandleSetDynSrcMask(routehandle, &
            local_dynamicMask%dmsR4R8R4V%dynamicSrcMaskValue, localrc)
          if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
        endif
        if (local_dynamicMask%dmsR4R8R4V%dynamicDstMaskIsPresent) then
          call c_ESMC_RouteHandleSetDynDstMask(routehandle, &
            local_dynamicMask%dmsR4R8R4V%dynamicDstMaskValue, localrc)
          if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
        endif
        handleAllElements = local_dynamicMask%dmsR4R8R4V%handleAllElements
        call c_ESMC_RouteHandleSetHandleAll(routehandle, &
          handleAllElements, localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      else if (local_dynamicMask%typeKey=="R4R4R4") then
        ! insert dynMaskState into RouteHandle for Fortran layer
        dynMaskStateR4R4R4%wrap => local_dynamicMask%dmsR4R4R4
        call c_ESMC_RouteHandleSetASR4R4R4(routehandle, dynMaskStateR4R4R4, &
          localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
        ! set required dynamic masking info for C++ layer
        if (local_dynamicMask%dmsR4R4R4%dynamicSrcMaskIsPresent) then
          call c_ESMC_RouteHandleSetDynSrcMask(routehandle, &
            local_dynamicMask%dmsR4R4R4%dynamicSrcMaskValue, localrc)
          if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
        endif
        if (local_dynamicMask%dmsR4R4R4%dynamicDstMaskIsPresent) then
          call c_ESMC_RouteHandleSetDynDstMask(routehandle, &
            local_dynamicMask%dmsR4R4R4%dynamicDstMaskValue, localrc)
          if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
        endif
        handleAllElements = local_dynamicMask%dmsR4R4R4%handleAllElements
        call c_ESMC_RouteHandleSetHandleAll(routehandle, &
          handleAllElements, localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
      else if (local_dynamicMask%typeKey=="R4R4R4V") then
        ! insert dynMaskState into RouteHandle for Fortran layer
        dynMaskStateR4R4R4V%wrap => local_dynamicMask%dmsR4R4R4V
        call c_ESMC_RouteHandleSetASR4R4R4V(routehandle, dynMaskStateR4R4R4V, &
          localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
        ! set required dynamic masking info for C++ layer
        if (local_dynamicMask%dmsR4R4R4V%dynamicSrcMaskIsPresent) then
          call c_ESMC_RouteHandleSetDynSrcMask(routehandle, &
            local_dynamicMask%dmsR4R4R4V%dynamicSrcMaskValue, localrc)
          if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
        endif
        if (local_dynamicMask%dmsR4R4R4V%dynamicDstMaskIsPresent) then
          call c_ESMC_RouteHandleSetDynDstMask(routehandle, &
            local_dynamicMask%dmsR4R4R4V%dynamicDstMaskValue, localrc)
          if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
            ESMF_CONTEXT, rcToReturn=rc)) return
        endif
        handleAllElements = local_dynamicMask%dmsR4R4R4V%handleAllElements
        call c_ESMC_RouteHandleSetHandleAll(routehandle, &
          handleAllElements, localrc)
        if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
          ESMF_CONTEXT, rcToReturn=rc)) return
#endif
      else
        call ESMF_LogSetError(rcToCheck=ESMF_RC_ARG_INCOMP, &
          msg="Invalid 'typeKey' found in dynamicMask object.", &
          ESMF_CONTEXT, rcToReturn=rc)
        return
      endif
    endif
    
    ! Set default flags
    opt_routesyncflag = ESMF_ROUTESYNC_BLOCKING
    if (present(routesyncflag)) opt_routesyncflag = routesyncflag
    opt_zeroregion = ESMF_REGION_TOTAL
    if (present(zeroregion)) opt_zeroregion = zeroregion
    opt_termorderflag = ESMF_TERMORDER_FREE
    if (present(dynamicMask)) opt_termorderflag = ESMF_TERMORDER_SRCSEQ
    if (present(termorderflag)) opt_termorderflag = termorderflag
    opt_checkflag = ESMF_FALSE
    if (present(checkflag)) opt_checkflag = checkflag
    
    ! ensure consistent termorder for dynamic masking
    if (present(dynamicMask) .and. &
      .not.(opt_termorderflag == ESMF_TERMORDER_SRCSEQ)) then
        call ESMF_LogSetError(rcToCheck=ESMF_RC_ARG_INCOMP, &
          msg="Must use 'ESMF_TERMORDER_SRCSEQ' for dynamic masking", &
          ESMF_CONTEXT, rcToReturn=rc)
        return
    endif
        
    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMM(opt_srcArray, opt_dstArray, routehandle, &
      opt_routesyncflag, opt_finishedflag, opt_cancelledflag, opt_zeroregion, &
      opt_termorderflag, opt_checkflag, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
      
    ! translate back finishedflag
    if (present(finishedflag)) then
      finishedflag = opt_finishedflag
    endif
    
    ! translate back cancelledflag
    if (present(cancelledflag)) then
      cancelledflag = opt_cancelledflag
    endif
    
    ! return successfully
    if (present(rc)) rc = ESMF_SUCCESS

  end subroutine ESMF_ArraySMM
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArraySMMRelease()"
!BOP
! !IROUTINE: ESMF_ArraySMMRelease - Release resources associated with Array sparse matrix multiplication
!
! !INTERFACE:
  subroutine ESMF_ArraySMMRelease(routehandle, keywordEnforcer, noGarbage, rc)
!
! !ARGUMENTS:
    type(ESMF_RouteHandle), intent(inout)         :: routehandle
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    logical,                intent(in),  optional :: noGarbage
    integer,                intent(out), optional :: rc
!
! !STATUS:
! \begin{itemize}
! \item\apiStatusCompatibleVersion{5.2.0r}
! \item\apiStatusModifiedSinceVersion{5.2.0r}
! \begin{description}
! \item[8.0.0] Added argument {\tt noGarbage}.
!   The argument provides a mechanism to override the default garbage collection
!   mechanism when destroying an ESMF object.
! \end{description}
! \end{itemize}
!
! !DESCRIPTION:
!   Release resources associated with an Array sparse matrix multiplication. 
!   After this call {\tt routehandle} becomes invalid.
!
!   \begin{description}
!   \item [routehandle]
!     Handle to the precomputed Route.
!   \item[{[noGarbage]}]
!     If set to {\tt .TRUE.} the object will be fully destroyed and removed
!     from the ESMF garbage collection system. Note however that under this 
!     condition ESMF cannot protect against accessing the destroyed object 
!     through dangling aliases -- a situation which may lead to hard to debug 
!     application crashes.
! 
!     It is generally recommended to leave the {\tt noGarbage} argument
!     set to {\tt .FALSE.} (the default), and to take advantage of the ESMF 
!     garbage collection system which will prevent problems with dangling
!     aliases or incorrect sequences of destroy calls. However this level of
!     support requires that a small remnant of the object is kept in memory
!     past the destroy call. This can lead to an unexpected increase in memory
!     consumption over the course of execution in applications that use 
!     temporary ESMF objects. For situations where the repeated creation and 
!     destruction of temporary objects leads to memory issues, it is 
!     recommended to call with {\tt noGarbage} set to {\tt .TRUE.}, fully 
!     removing the entire temporary object from memory.
!   \item [{[rc]}]
!     Return code; equals {\tt ESMF\_SUCCESS} if there are no errors.
!   \end{description}
!
!EOP
!------------------------------------------------------------------------------
    integer                 :: localrc      ! local return code

    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL

    ! Check init status of arguments, deal with optional Array args
    ESMF_INIT_CHECK_DEEP(ESMF_RouteHandleGetInit, routehandle, rc)
        
    ! Call into the RouteHandle code
    call ESMF_RouteHandleRelease(routehandle, noGarbage=noGarbage, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! return successfully
    if (present(rc)) rc = ESMF_SUCCESS

  end subroutine ESMF_ArraySMMRelease
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
!BOP
! !IROUTINE: ESMF_ArraySMMStore - Precompute Array sparse matrix multiplication with local factors
!
! !INTERFACE:
! ! Private name; call using ESMF_ArraySMMStore()
! subroutine ESMF_ArraySMMStore<type><kind>(srcArray, dstArray, &
!   routehandle, factorList, factorIndexList, keywordEnforcer, &
!   ignoreUnmatchedIndices, srcTermProcessing, pipelineDepth, rc)
!
! !ARGUMENTS:
!   type(ESMF_Array),          intent(in)              :: srcArray
!   type(ESMF_Array),          intent(inout)           :: dstArray
!   type(ESMF_RouteHandle),    intent(inout)           :: routehandle
!   <type>(ESMF_KIND_<kind>), target, intent(in)       :: factorList(:)
!   integer(ESMF_KIND_<kind>), intent(in)              :: factorIndexList(:,:)
!type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
!   logical,                   intent(in),    optional :: ignoreUnmatchedIndices
!   integer,                   intent(inout), optional :: srcTermProcessing
!   integer,                   intent(inout), optional :: pipelineDepth
!   integer,                   intent(out),   optional :: rc
!
! !STATUS:
! \begin{itemize}
! \item\apiStatusCompatibleVersion{5.2.0r}
! \item\apiStatusModifiedSinceVersion{5.2.0r}
! \begin{description}
! \item[6.1.0] Added argument {\tt srcTermProcessing}.
!              Added argument {\tt pipelineDepth}.
!              The new arguments provide access to the tuning parameters
!              affecting the sparse matrix execution.
! \item[7.0.0] Added argument {\tt transposeRoutehandle} to allow a handle to
!              the transposed matrix operation to be returned.\newline
!              Added argument {\tt ignoreUnmatchedIndices} to support sparse 
!              matrices that contain elements with indices that do not have a
!              match within the source or destination Array.
! \item[7.1.0r] Removed argument {\tt transposeRoutehandle} and provide it
!              via interface overloading instead. This allows argument 
!              {\tt srcArray} to stay strictly intent(in) for this entry point.
! \end{description}
! \end{itemize}
!
! !DESCRIPTION:
! \label{ArraySMMStoreTK}
! {\tt ESMF\_ArraySMMStore()} is a collective method across all PETs of the
! current Component. The interface of the method is overloaded, allowing 
! -- in principle -- each PET to call into {\tt ESMF\_ArraySMMStore()}
! through a different entry point. Restrictions apply as to which combinations
! are sensible. All other combinations result in ESMF run time errors. The
! complete semantics of the {\tt ESMF\_ArraySMMStore()} method, as provided
! through the separate entry points shown in \ref{ArraySMMStoreTK} and
! \ref{ArraySMMStoreNF}, is described in the following paragraphs as a whole.
!
!   \begin{sloppypar}
!   Store an Array sparse matrix multiplication operation from {\tt srcArray}
!   to {\tt dstArray}. PETs that specify non-zero matrix coefficients must use
!   the <type><kind> overloaded interface and provide the {\tt factorList} and
!   {\tt factorIndexList} arguments. Providing {\tt factorList} and
!   {\tt factorIndexList} arguments with {\tt size(factorList) = (/0/)} and
!   {\tt size(factorIndexList) = (/2,0/)} or {\tt (/4,0/)} indicates that a 
!   PET does not provide matrix elements. Alternatively, PETs that do not 
!   provide matrix elements may also call into the overloaded interface
!   {\em without} {\tt factorList} and {\tt factorIndexList} arguments.
!   \end{sloppypar}
!
!   Both {\tt srcArray} and {\tt dstArray} are interpreted as sequentialized
!   vectors. The sequence is defined by the order of DistGrid dimensions and 
!   the order of tiles within the DistGrid or by user-supplied arbitrary
!   sequence indices. See section \ref{Array:SparseMatMul} for details on the
!   definition of {\em sequence indices}.
!
!   Source and destination Arrays, as well as the supplied {\tt factorList}
!   argument, may be of different <type><kind>. Further source and
!   destination Arrays may differ in shape and number of elements.
!
!   It is erroneous to specify the identical Array object for {\tt srcArray} and
!   {\tt dstArray} arguments.
!
!   The routine returns an {\tt ESMF\_RouteHandle} that can be used to call 
!   {\tt ESMF\_ArraySMM()} on any pair of Arrays that matches 
!   {\tt srcArray} and {\tt dstArray} in {\em type}, {\em kind}, and 
!   memory layout of the {\em distributed} dimensions. However, the size,
!   number, and index order of {\em undistributed} dimensions may be different.
!   See section \ref{RH:Reusability} for a more detailed discussion of 
!   RouteHandle reusability.
!
!   This method is overloaded for:\newline
!   {\tt ESMF\_TYPEKIND\_I4}, {\tt ESMF\_TYPEKIND\_I8},\newline 
!   {\tt ESMF\_TYPEKIND\_R4}, {\tt ESMF\_TYPEKIND\_R8}.
!
!   This call is {\em collective} across the current VM.
!
!   \begin{description}
!
!   \item [srcArray]
!     {\tt ESMF\_Array} with source data.
!
!   \item [dstArray]
!     {\tt ESMF\_Array} with destination data. The data in this Array may be
!     destroyed by this call.
!
!   \item [routehandle]
!     Handle to the precomputed Route.
!
!   \item [factorList]
!     List of non-zero coefficients.
!
!   \item [factorIndexList]
!     Pairs of sequence indices for the factors stored in {\tt factorList}.
!
!     \begin{sloppypar}
!     The second dimension of {\tt factorIndexList} steps through the list of
!     pairs, i.e. {\tt size(factorIndexList,2) == size(factorList)}. The first
!     dimension of {\tt factorIndexList} is either of size 2 or size 4.
!     \end{sloppypar}
!
!     In the {\em size 2 format} {\tt factorIndexList(1,:)} specifies the
!     sequence index of the source element in the {\tt srcArray} while
!     {\tt factorIndexList(2,:)} specifies the sequence index of the
!     destination element in {\tt dstArray}. For this format to be a valid
!     option source and destination Arrays must have matching number of
!     tensor elements (the product of the sizes of all Array tensor dimensions).
!     Under this condition an identity matrix can be applied within the space of
!     tensor elements for each sparse matrix factor.
!
!     \begin{sloppypar}
!     The {\em size 4 format} is more general and does not require a matching
!     tensor element count. Here the {\tt factorIndexList(1,:)} specifies the
!     sequence index while {\tt factorIndexList(2,:)} specifies the tensor
!     sequence index of the source element in the {\tt srcArray}. Further
!     {\tt factorIndexList(3,:)} specifies the sequence index and
!     {\tt factorIndexList(4,:)} specifies the tensor sequence index of the 
!     destination element in the {\tt dstArray}.
!     \end{sloppypar}
!
!     See section \ref{Array:SparseMatMul} for details on the definition of 
!     Array {\em sequence indices} and {\em tensor sequence indices}.
!
!   \item [{[ignoreUnmatchedIndices]}]
!     A logical flag that affects the behavior for when sequence indices 
!     in the sparse matrix are encountered that do not have a match on the 
!     {\tt srcArray} or {\tt dstArray} side. The default setting is 
!     {\tt .false.}, indicating that it is an error when such a situation is 
!     encountered. Setting {\tt ignoreUnmatchedIndices} to {\tt .true.} ignores
!     entries with unmatched indices.
!
!   \item [{[srcTermProcessing]}]
!     The {\tt srcTermProcessing} parameter controls how many source terms,
!     located on the same PET and summing into the same destination element,
!     are summed into partial sums on the source PET before being transferred
!     to the destination PET. A value of 0 indicates that the entire arithmetic
!     is done on the destination PET; source elements are neither multiplied 
!     by their factors nor added into partial sums before being sent off by the
!     source PET. A value of 1 indicates that source elements are multiplied
!     by their factors on the source side before being sent to the destination
!     PET. Larger values of {\tt srcTermProcessing} indicate the maximum number
!     of terms in the partial sums on the source side.
!
!     Note that partial sums may lead to bit-for-bit differences in the results.
!     See section \ref{RH:bfb} for an in-depth discussion of {\em all}
!     bit-for-bit reproducibility aspects related to route-based communication
!     methods.
!
!     \begin{sloppypar}
!     The {\tt ESMF\_ArraySMMStore()} method implements an auto-tuning scheme
!     for the {\tt srcTermProcessing} parameter. The intent on the 
!     {\tt srcTermProcessing} argument is "{\tt inout}" in order to 
!     support both overriding and accessing the auto-tuning parameter.
!     If an argument $>= 0$ is specified, it is used for the 
!     {\tt srcTermProcessing} parameter, and the auto-tuning phase is skipped.
!     In this case the {\tt srcTermProcessing} argument is not modified on
!     return. If the provided argument is $< 0$, the {\tt srcTermProcessing}
!     parameter is determined internally using the auto-tuning scheme. In this
!     case the {\tt srcTermProcessing} argument is re-set to the internally
!     determined value on return. Auto-tuning is also used if the optional 
!     {\tt srcTermProcessing} argument is omitted.
!     \end{sloppypar}
!     
!   \item [{[pipelineDepth]}]
!     The {\tt pipelineDepth} parameter controls how many messages a PET
!     may have outstanding during a sparse matrix exchange. Larger values
!     of {\tt pipelineDepth} typically lead to better performance. However,
!     on some systems too large a value may lead to performance degradation,
!     or runtime errors.
!
!     Note that the pipeline depth has no effect on the bit-for-bit
!     reproducibility of the results. However, it may affect the performance
!     reproducibility of the exchange.
!
!     The {\tt ESMF\_ArraySMMStore()} method implements an auto-tuning scheme
!     for the {\tt pipelineDepth} parameter. The intent on the 
!     {\tt pipelineDepth} argument is "{\tt inout}" in order to 
!     support both overriding and accessing the auto-tuning parameter.
!     If an argument $>= 0$ is specified, it is used for the 
!     {\tt pipelineDepth} parameter, and the auto-tuning phase is skipped.
!     In this case the {\tt pipelineDepth} argument is not modified on
!     return. If the provided argument is $< 0$, the {\tt pipelineDepth}
!     parameter is determined internally using the auto-tuning scheme. In this
!     case the {\tt pipelineDepth} argument is re-set to the internally
!     determined value on return. Auto-tuning is also used if the optional 
!     {\tt pipelineDepth} argument is omitted.
!     
!   \item [{[rc]}]
!     Return code; equals {\tt ESMF\_SUCCESS} if there are no errors.
!   \end{description}
!
!EOP
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArraySMMStoreInd4I4()"
!BOPI
! !IROUTINE: ESMF_ArraySMMStore - Precompute and store an Array sparse matrix multiplication 
!
! !INTERFACE:
  ! Private name; call using ESMF_ArraySMMStore()
  subroutine ESMF_ArraySMMStoreInd4I4(srcArray, dstArray, routehandle, &
    factorList, factorIndexList, keywordEnforcer, ignoreUnmatchedIndices, &
    srcTermProcessing, pipelineDepth, rc)
!
! !ARGUMENTS:
    type(ESMF_Array),              intent(in)              :: srcArray
    type(ESMF_Array),              intent(inout)           :: dstArray
    type(ESMF_RouteHandle),        intent(inout)           :: routehandle
    integer(ESMF_KIND_I4), target, intent(in)              :: factorList(:)
    integer,                       intent(in)              :: factorIndexList(:,:)
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    logical,                       intent(in),    optional :: ignoreUnmatchedIndices
    integer,                       intent(inout), optional :: srcTermProcessing
    integer,                       intent(inout), optional :: pipelineDepth
    integer,                       intent(out),   optional :: rc
!
!EOPI
!------------------------------------------------------------------------------
    integer                         :: localrc            ! local return code
    integer(ESMF_KIND_I4), pointer  :: opt_factorList(:)  ! helper variable
    integer                         :: len_factorList     ! helper variable
    type(ESMF_InterArray)           :: factorIndexListArg ! helper variable
    type(ESMF_Logical)              :: opt_ignoreUnmatched  ! helper variable

    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL

    ! Check init status of arguments
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, srcArray, rc)
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, dstArray, rc)
    
    ! Wrap factor arguments
    len_factorList = size(factorList)
    opt_factorList => factorList
    factorIndexListArg = &
      ESMF_InterArrayCreate(farray2D=factorIndexList, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Set default flags
    opt_ignoreUnmatched = ESMF_FALSE
    if (present(ignoreUnmatchedIndices)) opt_ignoreUnmatched = ignoreUnmatchedIndices

    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreInd4(srcArray, dstArray, routehandle, &
      ESMF_TYPEKIND_I4, opt_factorList, len_factorList, factorIndexListArg, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Garbage collection
    call ESMF_InterArrayDestroy(factorIndexListArg, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Mark routehandle object as being created
    call ESMF_RouteHandleSetInitCreated(routehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! return successfully
    if (present(rc)) rc = ESMF_SUCCESS

  end subroutine ESMF_ArraySMMStoreInd4I4
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArraySMMStoreInd4I8()"
!BOPI
! !IROUTINE: ESMF_ArraySMMStore - Precompute and store an Array sparse matrix multiplication
!
! !INTERFACE:
  ! Private name; call using ESMF_ArraySMMStore()
  subroutine ESMF_ArraySMMStoreInd4I8(srcArray, dstArray, routehandle, &
    factorList, factorIndexList, keywordEnforcer, ignoreUnmatchedIndices, &
    srcTermProcessing, pipelineDepth, rc)
!
! !ARGUMENTS:
    type(ESMF_Array),              intent(in)              :: srcArray
    type(ESMF_Array),              intent(inout)           :: dstArray
    type(ESMF_RouteHandle),        intent(inout)           :: routehandle
    integer(ESMF_KIND_I8), target, intent(in)              :: factorList(:)
    integer,                       intent(in)              :: factorIndexList(:,:)
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    logical,                       intent(in),    optional :: ignoreUnmatchedIndices
    integer,                       intent(inout), optional :: srcTermProcessing
    integer,                       intent(inout), optional :: pipelineDepth
    integer,                       intent(out),   optional :: rc
!
!EOPI
!------------------------------------------------------------------------------
    integer                         :: localrc            ! local return code
    integer(ESMF_KIND_I8), pointer  :: opt_factorList(:)  ! helper variable
    integer                         :: len_factorList     ! helper variable
    type(ESMF_InterArray)           :: factorIndexListArg ! helper variable
    type(ESMF_Logical)              :: opt_ignoreUnmatched  ! helper variable

    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL
    
    ! Check init status of arguments
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, srcArray, rc)
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, dstArray, rc)
    
    ! Wrap factor arguments
    len_factorList = size(factorList)
    opt_factorList => factorList
    factorIndexListArg = &
      ESMF_InterArrayCreate(farray2D=factorIndexList, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Set default flags
    opt_ignoreUnmatched = ESMF_FALSE
    if (present(ignoreUnmatchedIndices)) opt_ignoreUnmatched = ignoreUnmatchedIndices

    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreInd4(srcArray, dstArray, routehandle, &
      ESMF_TYPEKIND_I8, opt_factorList, len_factorList, factorIndexListArg, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Garbage collection
    call ESMF_InterArrayDestroy(factorIndexListArg, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Mark routehandle object as being created
    call ESMF_RouteHandleSetInitCreated(routehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! return successfully
    if (present(rc)) rc = ESMF_SUCCESS

  end subroutine ESMF_ArraySMMStoreInd4I8
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArraySMMStoreInd4R4()"
!BOPI
! !IROUTINE: ESMF_ArraySMMStore - Precompute and store an Array sparse matrix multiplication
!
! !INTERFACE:
  ! Private name; call using ESMF_ArraySMMStore()
  subroutine ESMF_ArraySMMStoreInd4R4(srcArray, dstArray, routehandle, &
    factorList, factorIndexList, keywordEnforcer, ignoreUnmatchedIndices, &
    srcTermProcessing, pipelineDepth, rc)
!
! !ARGUMENTS:
    type(ESMF_Array),           intent(in)              :: srcArray
    type(ESMF_Array),           intent(inout)           :: dstArray
    type(ESMF_RouteHandle),     intent(inout)           :: routehandle
    real(ESMF_KIND_R4), target, intent(in)              :: factorList(:)
    integer,                    intent(in)              :: factorIndexList(:,:)
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    logical,                    intent(in),    optional :: ignoreUnmatchedIndices
    integer,                    intent(inout), optional :: srcTermProcessing
    integer,                    intent(inout), optional :: pipelineDepth
    integer,                    intent(out),   optional :: rc
!
!EOPI
!------------------------------------------------------------------------------
    integer                       :: localrc            ! local return code
    real(ESMF_KIND_R4), pointer   :: opt_factorList(:)  ! helper variable
    integer                       :: len_factorList     ! helper variable
    type(ESMF_InterArray)         :: factorIndexListArg ! helper variable
    type(ESMF_Logical)            :: opt_ignoreUnmatched  ! helper variable

    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL
    
    ! Check init status of arguments
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, srcArray, rc)
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, dstArray, rc)
    
    ! Wrap factor arguments
    len_factorList = size(factorList)
    opt_factorList => factorList
    factorIndexListArg = &
      ESMF_InterArrayCreate(farray2D=factorIndexList, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Set default flags
    opt_ignoreUnmatched = ESMF_FALSE
    if (present(ignoreUnmatchedIndices)) opt_ignoreUnmatched = ignoreUnmatchedIndices

    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreInd4(srcArray, dstArray, routehandle, &
      ESMF_TYPEKIND_R4, opt_factorList, len_factorList, factorIndexListArg, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Garbage collection
    call ESMF_InterArrayDestroy(factorIndexListArg, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Mark routehandle object as being created
    call ESMF_RouteHandleSetInitCreated(routehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! return successfully
    if (present(rc)) rc = ESMF_SUCCESS

  end subroutine ESMF_ArraySMMStoreInd4R4
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArraySMMStoreInd4R8()"
!BOPI
! !IROUTINE: ESMF_ArraySMMStore - Precompute and store an Array sparse matrix multiplication
!
! !INTERFACE:
  ! Private name; call using ESMF_ArraySMMStore()
  subroutine ESMF_ArraySMMStoreInd4R8(srcArray, dstArray, routehandle, &
    factorList, factorIndexList, keywordEnforcer, ignoreUnmatchedIndices, &
    srcTermProcessing, pipelineDepth, rc)
!
! !ARGUMENTS:
    type(ESMF_Array),           intent(in)              :: srcArray
    type(ESMF_Array),           intent(inout)           :: dstArray
    type(ESMF_RouteHandle),     intent(inout)           :: routehandle
    real(ESMF_KIND_R8), target, intent(in)              :: factorList(:)
    integer,                    intent(in)              :: factorIndexList(:,:)
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    logical,                    intent(in),    optional :: ignoreUnmatchedIndices
    integer,                    intent(inout), optional :: srcTermProcessing
    integer,                    intent(inout), optional :: pipelineDepth
    integer,                    intent(out),   optional :: rc
!
!EOPI
!------------------------------------------------------------------------------
    integer                       :: localrc            ! local return code
    real(ESMF_KIND_R8), pointer   :: opt_factorList(:)  ! helper variable
    integer                       :: len_factorList     ! helper variable
    type(ESMF_InterArray)         :: factorIndexListArg ! helper variable
    type(ESMF_Logical)            :: opt_ignoreUnmatched  ! helper variable

    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL
    
    ! Check init status of arguments
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, srcArray, rc)
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, dstArray, rc)
    
    ! Wrap factor arguments
    len_factorList = size(factorList)
    opt_factorList => factorList
    factorIndexListArg = &
      ESMF_InterArrayCreate(farray2D=factorIndexList, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Set default flags
    opt_ignoreUnmatched = ESMF_FALSE
    if (present(ignoreUnmatchedIndices)) opt_ignoreUnmatched = ignoreUnmatchedIndices

    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreInd4(srcArray, dstArray, routehandle, &
      ESMF_TYPEKIND_R8, opt_factorList, len_factorList, factorIndexListArg, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Garbage collection
    call ESMF_InterArrayDestroy(factorIndexListArg, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Mark routehandle object as being created
    call ESMF_RouteHandleSetInitCreated(routehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! return successfully
    if (present(rc)) rc = ESMF_SUCCESS

  end subroutine ESMF_ArraySMMStoreInd4R8
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArraySMMStoreInd8I4()"
!BOPI
! !IROUTINE: ESMF_ArraySMMStore - Precompute and store an Array sparse matrix multiplication 
!
! !INTERFACE:
  ! Private name; call using ESMF_ArraySMMStore()
  subroutine ESMF_ArraySMMStoreInd8I4(srcArray, dstArray, routehandle, &
    factorList, factorIndexList, keywordEnforcer, ignoreUnmatchedIndices, &
    srcTermProcessing, pipelineDepth, rc)
!
! !ARGUMENTS:
    type(ESMF_Array),              intent(in)              :: srcArray
    type(ESMF_Array),              intent(inout)           :: dstArray
    type(ESMF_RouteHandle),        intent(inout)           :: routehandle
    integer(ESMF_KIND_I4), target, intent(in)              :: factorList(:)
    integer(ESMF_KIND_I8),         intent(in)              :: factorIndexList(:,:)
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    logical,                       intent(in),    optional :: ignoreUnmatchedIndices
    integer,                       intent(inout), optional :: srcTermProcessing
    integer,                       intent(inout), optional :: pipelineDepth
    integer,                       intent(out),   optional :: rc
!
!EOPI
!------------------------------------------------------------------------------
    integer                         :: localrc            ! local return code
    integer(ESMF_KIND_I4), pointer  :: opt_factorList(:)  ! helper variable
    integer                         :: len_factorList     ! helper variable
    type(ESMF_InterArray)           :: factorIndexListArg ! helper variable
    type(ESMF_Logical)              :: opt_ignoreUnmatched  ! helper variable

    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL

    ! Check init status of arguments
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, srcArray, rc)
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, dstArray, rc)
    
    ! Wrap factor arguments
    len_factorList = size(factorList)
    opt_factorList => factorList
    factorIndexListArg = &
      ESMF_InterArrayCreate(farray2DI8=factorIndexList, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Set default flags
    opt_ignoreUnmatched = ESMF_FALSE
    if (present(ignoreUnmatchedIndices)) opt_ignoreUnmatched = ignoreUnmatchedIndices

    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreInd8(srcArray, dstArray, routehandle, &
      ESMF_TYPEKIND_I4, opt_factorList, len_factorList, factorIndexListArg, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Garbage collection
    call ESMF_InterArrayDestroy(factorIndexListArg, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Mark routehandle object as being created
    call ESMF_RouteHandleSetInitCreated(routehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! return successfully
    if (present(rc)) rc = ESMF_SUCCESS

  end subroutine ESMF_ArraySMMStoreInd8I4
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArraySMMStoreInd8I8()"
!BOPI
! !IROUTINE: ESMF_ArraySMMStore - Precompute and store an Array sparse matrix multiplication
!
! !INTERFACE:
  ! Private name; call using ESMF_ArraySMMStore()
  subroutine ESMF_ArraySMMStoreInd8I8(srcArray, dstArray, routehandle, &
    factorList, factorIndexList, keywordEnforcer, ignoreUnmatchedIndices, &
    srcTermProcessing, pipelineDepth, rc)
!
! !ARGUMENTS:
    type(ESMF_Array),              intent(in)              :: srcArray
    type(ESMF_Array),              intent(inout)           :: dstArray
    type(ESMF_RouteHandle),        intent(inout)           :: routehandle
    integer(ESMF_KIND_I8), target, intent(in)              :: factorList(:)
    integer(ESMF_KIND_I8),         intent(in)              :: factorIndexList(:,:)
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    logical,                       intent(in),    optional :: ignoreUnmatchedIndices
    integer,                       intent(inout), optional :: srcTermProcessing
    integer,                       intent(inout), optional :: pipelineDepth
    integer,                       intent(out),   optional :: rc
!
!EOPI
!------------------------------------------------------------------------------
    integer                         :: localrc            ! local return code
    integer(ESMF_KIND_I8), pointer  :: opt_factorList(:)  ! helper variable
    integer                         :: len_factorList     ! helper variable
    type(ESMF_InterArray)           :: factorIndexListArg ! helper variable
    type(ESMF_Logical)              :: opt_ignoreUnmatched  ! helper variable

    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL
    
    ! Check init status of arguments
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, srcArray, rc)
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, dstArray, rc)
    
    ! Wrap factor arguments
    len_factorList = size(factorList)
    opt_factorList => factorList
    factorIndexListArg = &
      ESMF_InterArrayCreate(farray2DI8=factorIndexList, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Set default flags
    opt_ignoreUnmatched = ESMF_FALSE
    if (present(ignoreUnmatchedIndices)) opt_ignoreUnmatched = ignoreUnmatchedIndices

    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreInd8(srcArray, dstArray, routehandle, &
      ESMF_TYPEKIND_I8, opt_factorList, len_factorList, factorIndexListArg, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Garbage collection
    call ESMF_InterArrayDestroy(factorIndexListArg, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Mark routehandle object as being created
    call ESMF_RouteHandleSetInitCreated(routehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! return successfully
    if (present(rc)) rc = ESMF_SUCCESS

  end subroutine ESMF_ArraySMMStoreInd8I8
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArraySMMStoreInd8R4()"
!BOPI
! !IROUTINE: ESMF_ArraySMMStore - Precompute and store an Array sparse matrix multiplication
!
! !INTERFACE:
  ! Private name; call using ESMF_ArraySMMStore()
  subroutine ESMF_ArraySMMStoreInd8R4(srcArray, dstArray, routehandle, &
    factorList, factorIndexList, keywordEnforcer, ignoreUnmatchedIndices, &
    srcTermProcessing, pipelineDepth, rc)
!
! !ARGUMENTS:
    type(ESMF_Array),           intent(in)              :: srcArray
    type(ESMF_Array),           intent(inout)           :: dstArray
    type(ESMF_RouteHandle),     intent(inout)           :: routehandle
    real(ESMF_KIND_R4), target, intent(in)              :: factorList(:)
    integer(ESMF_KIND_I8),      intent(in)              :: factorIndexList(:,:)
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    logical,                    intent(in),    optional :: ignoreUnmatchedIndices
    integer,                    intent(inout), optional :: srcTermProcessing
    integer,                    intent(inout), optional :: pipelineDepth
    integer,                    intent(out),   optional :: rc
!
!EOPI
!------------------------------------------------------------------------------
    integer                       :: localrc            ! local return code
    real(ESMF_KIND_R4), pointer   :: opt_factorList(:)  ! helper variable
    integer                       :: len_factorList     ! helper variable
    type(ESMF_InterArray)         :: factorIndexListArg ! helper variable
    type(ESMF_Logical)            :: opt_ignoreUnmatched  ! helper variable

    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL
    
    ! Check init status of arguments
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, srcArray, rc)
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, dstArray, rc)
    
    ! Wrap factor arguments
    len_factorList = size(factorList)
    opt_factorList => factorList
    factorIndexListArg = &
      ESMF_InterArrayCreate(farray2DI8=factorIndexList, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Set default flags
    opt_ignoreUnmatched = ESMF_FALSE
    if (present(ignoreUnmatchedIndices)) opt_ignoreUnmatched = ignoreUnmatchedIndices

    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreInd8(srcArray, dstArray, routehandle, &
      ESMF_TYPEKIND_R4, opt_factorList, len_factorList, factorIndexListArg, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Garbage collection
    call ESMF_InterArrayDestroy(factorIndexListArg, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Mark routehandle object as being created
    call ESMF_RouteHandleSetInitCreated(routehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! return successfully
    if (present(rc)) rc = ESMF_SUCCESS

  end subroutine ESMF_ArraySMMStoreInd8R4
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArraySMMStoreInd8R8()"
!BOPI
! !IROUTINE: ESMF_ArraySMMStore - Precompute and store an Array sparse matrix multiplication
!
! !INTERFACE:
  ! Private name; call using ESMF_ArraySMMStore()
  subroutine ESMF_ArraySMMStoreInd8R8(srcArray, dstArray, routehandle, &
    factorList, factorIndexList, keywordEnforcer, ignoreUnmatchedIndices, &
    srcTermProcessing, pipelineDepth, rc)
!
! !ARGUMENTS:
    type(ESMF_Array),           intent(in)              :: srcArray
    type(ESMF_Array),           intent(inout)           :: dstArray
    type(ESMF_RouteHandle),     intent(inout)           :: routehandle
    real(ESMF_KIND_R8), target, intent(in)              :: factorList(:)
    integer(ESMF_KIND_I8),      intent(in)              :: factorIndexList(:,:)
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    logical,                    intent(in),    optional :: ignoreUnmatchedIndices
    integer,                    intent(inout), optional :: srcTermProcessing
    integer,                    intent(inout), optional :: pipelineDepth
    integer,                    intent(out),   optional :: rc
!
!EOPI
!------------------------------------------------------------------------------
    integer                       :: localrc            ! local return code
    real(ESMF_KIND_R8), pointer   :: opt_factorList(:)  ! helper variable
    integer                       :: len_factorList     ! helper variable
    type(ESMF_InterArray)         :: factorIndexListArg ! helper variable
    type(ESMF_Logical)            :: opt_ignoreUnmatched  ! helper variable

    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL
    
    ! Check init status of arguments
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, srcArray, rc)
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, dstArray, rc)
    
    ! Wrap factor arguments
    len_factorList = size(factorList)
    opt_factorList => factorList
    factorIndexListArg = &
      ESMF_InterArrayCreate(farray2DI8=factorIndexList, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Set default flags
    opt_ignoreUnmatched = ESMF_FALSE
    if (present(ignoreUnmatchedIndices)) opt_ignoreUnmatched = ignoreUnmatchedIndices

    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreInd8(srcArray, dstArray, routehandle, &
      ESMF_TYPEKIND_R8, opt_factorList, len_factorList, factorIndexListArg, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Garbage collection
    call ESMF_InterArrayDestroy(factorIndexListArg, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Mark routehandle object as being created
    call ESMF_RouteHandleSetInitCreated(routehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! return successfully
    if (present(rc)) rc = ESMF_SUCCESS

  end subroutine ESMF_ArraySMMStoreInd8R8
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
!BOP
! !IROUTINE: ESMF_ArraySMMStore - Precompute Array sparse matrix multiplication and transpose with local factors
!
! !INTERFACE:
! ! Private name; call using ESMF_ArraySMMStore()
! subroutine ESMF_ArraySMMStore<type><kind>TP(srcArray, dstArray, &
!   routehandle, transposeRoutehandle, factorList, factorIndexList, &
!   keywordEnforcer, ignoreUnmatchedIndices, srcTermProcessing, pipelineDepth, &
!   rc)
!
! !ARGUMENTS:
!   type(ESMF_Array),          intent(inout)           :: srcArray
!   type(ESMF_Array),          intent(inout)           :: dstArray
!   type(ESMF_RouteHandle),    intent(inout)           :: routehandle
!   type(ESMF_RouteHandle),    intent(inout)           :: transposeRoutehandle
!   <type>(ESMF_KIND_<kind>), target, intent(in)       :: factorList(:)
!   integer(ESMF_KIND_<kind>), intent(in)              :: factorIndexList(:,:)
!type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
!   logical,                   intent(in),    optional :: ignoreUnmatchedIndices
!   integer,                   intent(inout), optional :: srcTermProcessing
!   integer,                   intent(inout), optional :: pipelineDepth
!   integer,                   intent(out),   optional :: rc
!
! !DESCRIPTION:
! \label{ArraySMMStoreTKTP}
! {\tt ESMF\_ArraySMMStore()} is a collective method across all PETs of the
! current Component. The interface of the method is overloaded, allowing 
! -- in principle -- each PET to call into {\tt ESMF\_ArraySMMStore()}
! through a different entry point. Restrictions apply as to which combinations
! are sensible. All other combinations result in ESMF run time errors. The
! complete semantics of the {\tt ESMF\_ArraySMMStore()} method, as provided
! through the separate entry points shown in \ref{ArraySMMStoreTKTP} and
! \ref{ArraySMMStoreNFTP}, is described in the following paragraphs as a whole.
!
!   \begin{sloppypar}
!   Store an Array sparse matrix multiplication operation from {\tt srcArray}
!   to {\tt dstArray}. PETs that specify non-zero matrix coefficients must use
!   the <type><kind> overloaded interface and provide the {\tt factorList} and
!   {\tt factorIndexList} arguments. Providing {\tt factorList} and
!   {\tt factorIndexList} arguments with {\tt size(factorList) = (/0/)} and
!   {\tt size(factorIndexList) = (/2,0/)} or {\tt (/4,0/)} indicates that a 
!   PET does not provide matrix elements. Alternatively, PETs that do not 
!   provide matrix elements may also call into the overloaded interface
!   {\em without} {\tt factorList} and {\tt factorIndexList} arguments.
!   \end{sloppypar}
!
!   Both {\tt srcArray} and {\tt dstArray} are interpreted as sequentialized
!   vectors. The sequence is defined by the order of DistGrid dimensions and 
!   the order of tiles within the DistGrid or by user-supplied arbitrary
!   sequence indices. See section \ref{Array:SparseMatMul} for details on the
!   definition of {\em sequence indices}.
!
!   Source and destination Arrays, as well as the supplied {\tt factorList}
!   argument, may be of different <type><kind>. Further source and
!   destination Arrays may differ in shape and number of elements.
!
!   It is erroneous to specify the identical Array object for {\tt srcArray} and
!   {\tt dstArray} arguments.
!
!   The routine returns an {\tt ESMF\_RouteHandle} that can be used to call 
!   {\tt ESMF\_ArraySMM()} on any pair of Arrays that matches 
!   {\tt srcArray} and {\tt dstArray} in {\em type}, {\em kind}, and 
!   memory layout of the {\em distributed} dimensions. However, the size,
!   number, and index order of {\em undistributed} dimensions may be different.
!   See section \ref{RH:Reusability} for a more detailed discussion of
!   RouteHandle reusability.
!
!   This method is overloaded for:\newline
!   {\tt ESMF\_TYPEKIND\_I4}, {\tt ESMF\_TYPEKIND\_I8},\newline 
!   {\tt ESMF\_TYPEKIND\_R4}, {\tt ESMF\_TYPEKIND\_R8}.
!
!   This call is {\em collective} across the current VM.
!
!   \begin{description}
!
!   \item [srcArray]
!     {\tt ESMF\_Array} with source data. The data in this Array may be
!     destroyed by this call.
!
!   \item [dstArray]
!     {\tt ESMF\_Array} with destination data. The data in this Array may be
!     destroyed by this call.
!
!   \item [routehandle]
!     Handle to the precomputed Route.
!
!   \item [{[transposeRoutehandle]}]
!     Handle to the transposed matrix operation. The transposed operation goes
!     from {\tt dstArray} to {\tt srcArray}.
!
!   \item [factorList]
!     List of non-zero coefficients.
!
!   \item [factorIndexList]
!     Pairs of sequence indices for the factors stored in {\tt factorList}.
!
!     \begin{sloppypar}
!     The second dimension of {\tt factorIndexList} steps through the list of
!     pairs, i.e. {\tt size(factorIndexList,2) == size(factorList)}. The first
!     dimension of {\tt factorIndexList} is either of size 2 or size 4.
!     \end{sloppypar}
!
!     In the {\em size 2 format} {\tt factorIndexList(1,:)} specifies the
!     sequence index of the source element in the {\tt srcArray} while
!     {\tt factorIndexList(2,:)} specifies the sequence index of the
!     destination element in {\tt dstArray}. For this format to be a valid
!     option source and destination Arrays must have matching number of
!     tensor elements (the product of the sizes of all Array tensor dimensions).
!     Under this condition an identity matrix can be applied within the space of
!     tensor elements for each sparse matrix factor.
!
!     \begin{sloppypar}
!     The {\em size 4 format} is more general and does not require a matching
!     tensor element count. Here the {\tt factorIndexList(1,:)} specifies the
!     sequence index while {\tt factorIndexList(2,:)} specifies the tensor
!     sequence index of the source element in the {\tt srcArray}. Further
!     {\tt factorIndexList(3,:)} specifies the sequence index and
!     {\tt factorIndexList(4,:)} specifies the tensor sequence index of the 
!     destination element in the {\tt dstArray}.
!     \end{sloppypar}
!
!     See section \ref{Array:SparseMatMul} for details on the definition of 
!     Array {\em sequence indices} and {\em tensor sequence indices}.
!
!   \item [{[ignoreUnmatchedIndices]}]
!     A logical flag that affects the behavior for when sequence indices 
!     in the sparse matrix are encountered that do not have a match on the 
!     {\tt srcArray} or {\tt dstArray} side. The default setting is 
!     {\tt .false.}, indicating that it is an error when such a situation is 
!     encountered. Setting {\tt ignoreUnmatchedIndices} to {\tt .true.} ignores
!     entries with unmatched indices.
!
!   \item [{[srcTermProcessing]}]
!     The {\tt srcTermProcessing} parameter controls how many source terms,
!     located on the same PET and summing into the same destination element,
!     are summed into partial sums on the source PET before being transferred
!     to the destination PET. A value of 0 indicates that the entire arithmetic
!     is done on the destination PET; source elements are neither multiplied 
!     by their factors nor added into partial sums before being sent off by the
!     source PET. A value of 1 indicates that source elements are multiplied
!     by their factors on the source side before being sent to the destination
!     PET. Larger values of {\tt srcTermProcessing} indicate the maximum number
!     of terms in the partial sums on the source side.
!
!     Note that partial sums may lead to bit-for-bit differences in the results.
!     See section \ref{RH:bfb} for an in-depth discussion of {\em all}
!     bit-for-bit reproducibility aspects related to route-based communication
!     methods.
!
!     \begin{sloppypar}
!     The {\tt ESMF\_ArraySMMStore()} method implements an auto-tuning scheme
!     for the {\tt srcTermProcessing} parameter. The intent on the 
!     {\tt srcTermProcessing} argument is "{\tt inout}" in order to 
!     support both overriding and accessing the auto-tuning parameter.
!     If an argument $>= 0$ is specified, it is used for the 
!     {\tt srcTermProcessing} parameter, and the auto-tuning phase is skipped.
!     In this case the {\tt srcTermProcessing} argument is not modified on
!     return. If the provided argument is $< 0$, the {\tt srcTermProcessing}
!     parameter is determined internally using the auto-tuning scheme. In this
!     case the {\tt srcTermProcessing} argument is re-set to the internally
!     determined value on return. Auto-tuning is also used if the optional 
!     {\tt srcTermProcessing} argument is omitted.
!     \end{sloppypar}
!     
!   \item [{[pipelineDepth]}]
!     The {\tt pipelineDepth} parameter controls how many messages a PET
!     may have outstanding during a sparse matrix exchange. Larger values
!     of {\tt pipelineDepth} typically lead to better performance. However,
!     on some systems too large a value may lead to performance degradation,
!     or runtime errors.
!
!     Note that the pipeline depth has no effect on the bit-for-bit
!     reproducibility of the results. However, it may affect the performance
!     reproducibility of the exchange.
!
!     The {\tt ESMF\_ArraySMMStore()} method implements an auto-tuning scheme
!     for the {\tt pipelineDepth} parameter. The intent on the 
!     {\tt pipelineDepth} argument is "{\tt inout}" in order to 
!     support both overriding and accessing the auto-tuning parameter.
!     If an argument $>= 0$ is specified, it is used for the 
!     {\tt pipelineDepth} parameter, and the auto-tuning phase is skipped.
!     In this case the {\tt pipelineDepth} argument is not modified on
!     return. If the provided argument is $< 0$, the {\tt pipelineDepth}
!     parameter is determined internally using the auto-tuning scheme. In this
!     case the {\tt pipelineDepth} argument is re-set to the internally
!     determined value on return. Auto-tuning is also used if the optional 
!     {\tt pipelineDepth} argument is omitted.
!     
!   \item [{[rc]}]
!     Return code; equals {\tt ESMF\_SUCCESS} if there are no errors.
!   \end{description}
!
!EOP
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArraySMMStoreInd4I4TP()"
!BOPI
! !IROUTINE: ESMF_ArraySMMStore - Precompute and store an Array sparse matrix multiplication 
!
! !INTERFACE:
  ! Private name; call using ESMF_ArraySMMStore()
  subroutine ESMF_ArraySMMStoreInd4I4TP(srcArray, dstArray, routehandle, &
    transposeRoutehandle, factorList, factorIndexList, keywordEnforcer, &
    ignoreUnmatchedIndices, srcTermProcessing, pipelineDepth, rc)
!
! !ARGUMENTS:
    type(ESMF_Array),              intent(inout)           :: srcArray
    type(ESMF_Array),              intent(inout)           :: dstArray
    type(ESMF_RouteHandle),        intent(inout)           :: routehandle
    type(ESMF_RouteHandle),        intent(inout)           :: transposeRoutehandle
    integer(ESMF_KIND_I4), target, intent(in)              :: factorList(:)
    integer,                       intent(in)              :: factorIndexList(:,:)
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    logical,                       intent(in),    optional :: ignoreUnmatchedIndices
    integer,                       intent(inout), optional :: srcTermProcessing
    integer,                       intent(inout), optional :: pipelineDepth
    integer,                       intent(out),   optional :: rc
!
!EOPI
!------------------------------------------------------------------------------
    integer                         :: localrc            ! local return code
    integer(ESMF_KIND_I4), pointer  :: opt_factorList(:)  ! helper variable
    integer                         :: len_factorList     ! helper variable
    type(ESMF_InterArray)           :: factorIndexListArg ! helper variable
    integer                         :: tupleSize, i       ! helper variable
    integer, allocatable            :: transposeFIL(:,:)  ! helper variable
    type(ESMF_Logical)              :: opt_ignoreUnmatched  ! helper variable

    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL

    ! Check init status of arguments
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, srcArray, rc)
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, dstArray, rc)
    
    ! Wrap factor arguments
    len_factorList = size(factorList)
    opt_factorList => factorList
    factorIndexListArg = &
      ESMF_InterArrayCreate(farray2D=factorIndexList, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Set default flags
    opt_ignoreUnmatched = ESMF_FALSE
    if (present(ignoreUnmatchedIndices)) opt_ignoreUnmatched = ignoreUnmatchedIndices

    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreInd4(srcArray, dstArray, routehandle, &
      ESMF_TYPEKIND_I4, opt_factorList, len_factorList, factorIndexListArg, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Garbage collection
    call ESMF_InterArrayDestroy(factorIndexListArg, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Mark routehandle object as being created
    call ESMF_RouteHandleSetInitCreated(routehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Compute the transposeRoutehandle
    ! Construct the transpose of the factorIndexList
    tupleSize = size(factorIndexList,1)
    allocate(transposeFIL(tupleSize, len_factorList))
    if (tupleSize==2) then
      do i=1, len_factorList
        transposeFIL(1,i)=factorIndexList(2,i)
        transposeFIL(2,i)=factorIndexList(1,i)
      enddo
    else if (tupleSize==4) then
      do i=1, len_factorList
        transposeFIL(1,i)=factorIndexList(3,i)
        transposeFIL(2,i)=factorIndexList(4,i)
        transposeFIL(3,i)=factorIndexList(1,i)
        transposeFIL(4,i)=factorIndexList(2,i)
      enddo
    endif
    ! wrap transposeFIL
    factorIndexListArg = &
      ESMF_InterArrayCreate(farray2D=transposeFIL, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreInd4(dstArray, srcArray, transposeRoutehandle, &
      ESMF_TYPEKIND_I4, opt_factorList, len_factorList, factorIndexListArg, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    ! Garbage collection
    call ESMF_InterArrayDestroy(factorIndexListArg, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    deallocate(transposeFIL)
    ! Mark transposeRoutehandle object as being created
    call ESMF_RouteHandleSetInitCreated(transposeRoutehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! return successfully
    if (present(rc)) rc = ESMF_SUCCESS

  end subroutine ESMF_ArraySMMStoreInd4I4TP
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArraySMMStoreInd4I8TP()"
!BOPI
! !IROUTINE: ESMF_ArraySMMStore - Precompute and store an Array sparse matrix multiplication
!
! !INTERFACE:
  ! Private name; call using ESMF_ArraySMMStore()
  subroutine ESMF_ArraySMMStoreInd4I8TP(srcArray, dstArray, routehandle, &
    transposeRoutehandle, factorList, factorIndexList, keywordEnforcer, &
    ignoreUnmatchedIndices, srcTermProcessing, pipelineDepth, rc)
!
! !ARGUMENTS:
    type(ESMF_Array),              intent(inout)           :: srcArray
    type(ESMF_Array),              intent(inout)           :: dstArray
    type(ESMF_RouteHandle),        intent(inout)           :: routehandle
    type(ESMF_RouteHandle),        intent(inout)           :: transposeRoutehandle
    integer(ESMF_KIND_I8), target, intent(in)              :: factorList(:)
    integer,                       intent(in)              :: factorIndexList(:,:)
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    logical,                       intent(in),    optional :: ignoreUnmatchedIndices
    integer,                       intent(inout), optional :: srcTermProcessing
    integer,                       intent(inout), optional :: pipelineDepth
    integer,                       intent(out),   optional :: rc
!
!EOPI
!------------------------------------------------------------------------------
    integer                         :: localrc            ! local return code
    integer(ESMF_KIND_I8), pointer  :: opt_factorList(:)  ! helper variable
    integer                         :: len_factorList     ! helper variable
    type(ESMF_InterArray)           :: factorIndexListArg ! helper variable
    integer                         :: tupleSize, i       ! helper variable
    integer, allocatable            :: transposeFIL(:,:)  ! helper variable
    type(ESMF_Logical)              :: opt_ignoreUnmatched  ! helper variable

    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL
    
    ! Check init status of arguments
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, srcArray, rc)
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, dstArray, rc)
    
    ! Wrap factor arguments
    len_factorList = size(factorList)
    opt_factorList => factorList
    factorIndexListArg = &
      ESMF_InterArrayCreate(farray2D=factorIndexList, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Set default flags
    opt_ignoreUnmatched = ESMF_FALSE
    if (present(ignoreUnmatchedIndices)) opt_ignoreUnmatched = ignoreUnmatchedIndices

    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreInd4(srcArray, dstArray, routehandle, &
      ESMF_TYPEKIND_I8, opt_factorList, len_factorList, factorIndexListArg, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Garbage collection
    call ESMF_InterArrayDestroy(factorIndexListArg, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Mark routehandle object as being created
    call ESMF_RouteHandleSetInitCreated(routehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Compute the transposeRoutehandle
    ! Construct the transpose of the factorIndexList
    tupleSize = size(factorIndexList,1)
    allocate(transposeFIL(tupleSize, len_factorList))
    if (tupleSize==2) then
      do i=1, len_factorList
        transposeFIL(1,i)=factorIndexList(2,i)
        transposeFIL(2,i)=factorIndexList(1,i)
      enddo
    else if (tupleSize==4) then
      do i=1, len_factorList
        transposeFIL(1,i)=factorIndexList(3,i)
        transposeFIL(2,i)=factorIndexList(4,i)
        transposeFIL(3,i)=factorIndexList(1,i)
        transposeFIL(4,i)=factorIndexList(2,i)
      enddo
    endif
    ! wrap transposeFIL
    factorIndexListArg = &
      ESMF_InterArrayCreate(farray2D=transposeFIL, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreInd4(dstArray, srcArray, transposeRoutehandle, &
      ESMF_TYPEKIND_I8, opt_factorList, len_factorList, factorIndexListArg, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    ! Garbage collection
    call ESMF_InterArrayDestroy(factorIndexListArg, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    deallocate(transposeFIL)
    ! Mark transposeRoutehandle object as being created
    call ESMF_RouteHandleSetInitCreated(transposeRoutehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! return successfully
    if (present(rc)) rc = ESMF_SUCCESS

  end subroutine ESMF_ArraySMMStoreInd4I8TP
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArraySMMStoreInd4R4TP()"
!BOPI
! !IROUTINE: ESMF_ArraySMMStore - Precompute and store an Array sparse matrix multiplication
!
! !INTERFACE:
  ! Private name; call using ESMF_ArraySMMStore()
  subroutine ESMF_ArraySMMStoreInd4R4TP(srcArray, dstArray, routehandle, &
    transposeRoutehandle, factorList, factorIndexList, keywordEnforcer, &
    ignoreUnmatchedIndices, srcTermProcessing, pipelineDepth, rc)
!
! !ARGUMENTS:
    type(ESMF_Array),           intent(inout)           :: srcArray
    type(ESMF_Array),           intent(inout)           :: dstArray
    type(ESMF_RouteHandle),     intent(inout)           :: routehandle
    type(ESMF_RouteHandle),     intent(inout)           :: transposeRoutehandle
    real(ESMF_KIND_R4), target, intent(in)              :: factorList(:)
    integer,                    intent(in)              :: factorIndexList(:,:)
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    logical,                    intent(in),    optional :: ignoreUnmatchedIndices
    integer,                    intent(inout), optional :: srcTermProcessing
    integer,                    intent(inout), optional :: pipelineDepth
    integer,                    intent(out),   optional :: rc
!
!EOPI
!------------------------------------------------------------------------------
    integer                       :: localrc            ! local return code
    real(ESMF_KIND_R4), pointer   :: opt_factorList(:)  ! helper variable
    integer                       :: len_factorList     ! helper variable
    type(ESMF_InterArray)         :: factorIndexListArg ! helper variable
    integer                       :: tupleSize, i       ! helper variable
    integer, allocatable          :: transposeFIL(:,:)  ! helper variable
    type(ESMF_Logical)            :: opt_ignoreUnmatched  ! helper variable

    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL
    
    ! Check init status of arguments
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, srcArray, rc)
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, dstArray, rc)
    
    ! Wrap factor arguments
    len_factorList = size(factorList)
    opt_factorList => factorList
    factorIndexListArg = &
      ESMF_InterArrayCreate(farray2D=factorIndexList, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Set default flags
    opt_ignoreUnmatched = ESMF_FALSE
    if (present(ignoreUnmatchedIndices)) opt_ignoreUnmatched = ignoreUnmatchedIndices

    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreInd4(srcArray, dstArray, routehandle, &
      ESMF_TYPEKIND_R4, opt_factorList, len_factorList, factorIndexListArg, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Garbage collection
    call ESMF_InterArrayDestroy(factorIndexListArg, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Mark routehandle object as being created
    call ESMF_RouteHandleSetInitCreated(routehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Compute the transposeRoutehandle
    ! Construct the transpose of the factorIndexList
    tupleSize = size(factorIndexList,1)
    allocate(transposeFIL(tupleSize, len_factorList))
    if (tupleSize==2) then
      do i=1, len_factorList
        transposeFIL(1,i)=factorIndexList(2,i)
        transposeFIL(2,i)=factorIndexList(1,i)
      enddo
    else if (tupleSize==4) then
      do i=1, len_factorList
        transposeFIL(1,i)=factorIndexList(3,i)
        transposeFIL(2,i)=factorIndexList(4,i)
        transposeFIL(3,i)=factorIndexList(1,i)
        transposeFIL(4,i)=factorIndexList(2,i)
      enddo
    endif
    ! wrap transposeFIL
    factorIndexListArg = &
      ESMF_InterArrayCreate(farray2D=transposeFIL, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreInd4(dstArray, srcArray, transposeRoutehandle, &
      ESMF_TYPEKIND_R4, opt_factorList, len_factorList, factorIndexListArg, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    ! Garbage collection
    call ESMF_InterArrayDestroy(factorIndexListArg, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    deallocate(transposeFIL)
    ! Mark transposeRoutehandle object as being created
    call ESMF_RouteHandleSetInitCreated(transposeRoutehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! return successfully
    if (present(rc)) rc = ESMF_SUCCESS

  end subroutine ESMF_ArraySMMStoreInd4R4TP
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArraySMMStoreInd4R8TP()"
!BOPI
! !IROUTINE: ESMF_ArraySMMStore - Precompute and store an Array sparse matrix multiplication
!
! !INTERFACE:
  ! Private name; call using ESMF_ArraySMMStore()
  subroutine ESMF_ArraySMMStoreInd4R8TP(srcArray, dstArray, routehandle, &
    transposeRoutehandle, factorList, factorIndexList, keywordEnforcer, &
    ignoreUnmatchedIndices, srcTermProcessing, pipelineDepth, rc)
!
! !ARGUMENTS:
    type(ESMF_Array),           intent(inout)           :: srcArray
    type(ESMF_Array),           intent(inout)           :: dstArray
    type(ESMF_RouteHandle),     intent(inout)           :: routehandle
    type(ESMF_RouteHandle),     intent(inout)           :: transposeRoutehandle
    real(ESMF_KIND_R8), target, intent(in)              :: factorList(:)
    integer,                    intent(in)              :: factorIndexList(:,:)
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    logical,                    intent(in),    optional :: ignoreUnmatchedIndices
    integer,                    intent(inout), optional :: srcTermProcessing
    integer,                    intent(inout), optional :: pipelineDepth
    integer,                    intent(out),   optional :: rc
!
!EOPI
!------------------------------------------------------------------------------
    integer                       :: localrc            ! local return code
    real(ESMF_KIND_R8), pointer   :: opt_factorList(:)  ! helper variable
    integer                       :: len_factorList     ! helper variable
    type(ESMF_InterArray)         :: factorIndexListArg ! helper variable
    integer                       :: tupleSize, i       ! helper variable
    integer, allocatable          :: transposeFIL(:,:)  ! helper variable
    type(ESMF_Logical)            :: opt_ignoreUnmatched  ! helper variable

    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL
    
    ! Check init status of arguments
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, srcArray, rc)
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, dstArray, rc)
    
    ! Wrap factor arguments
    len_factorList = size(factorList)
    opt_factorList => factorList
    factorIndexListArg = &
      ESMF_InterArrayCreate(farray2D=factorIndexList, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Set default flags
    opt_ignoreUnmatched = ESMF_FALSE
    if (present(ignoreUnmatchedIndices)) opt_ignoreUnmatched = ignoreUnmatchedIndices

    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreInd4(srcArray, dstArray, routehandle, &
      ESMF_TYPEKIND_R8, opt_factorList, len_factorList, factorIndexListArg, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Garbage collection
    call ESMF_InterArrayDestroy(factorIndexListArg, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Mark routehandle object as being created
    call ESMF_RouteHandleSetInitCreated(routehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Compute the transposeRoutehandle
    ! Construct the transpose of the factorIndexList
    tupleSize = size(factorIndexList,1)
    allocate(transposeFIL(tupleSize, len_factorList))
    if (tupleSize==2) then
      do i=1, len_factorList
        transposeFIL(1,i)=factorIndexList(2,i)
        transposeFIL(2,i)=factorIndexList(1,i)
      enddo
    else if (tupleSize==4) then
      do i=1, len_factorList
        transposeFIL(1,i)=factorIndexList(3,i)
        transposeFIL(2,i)=factorIndexList(4,i)
        transposeFIL(3,i)=factorIndexList(1,i)
        transposeFIL(4,i)=factorIndexList(2,i)
      enddo
    endif
    ! wrap transposeFIL
    factorIndexListArg = &
      ESMF_InterArrayCreate(farray2D=transposeFIL, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreInd4(dstArray, srcArray, transposeRoutehandle, &
      ESMF_TYPEKIND_R8, opt_factorList, len_factorList, factorIndexListArg, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    ! Garbage collection
    call ESMF_InterArrayDestroy(factorIndexListArg, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    deallocate(transposeFIL)
    ! Mark transposeRoutehandle object as being created
    call ESMF_RouteHandleSetInitCreated(transposeRoutehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! return successfully
    if (present(rc)) rc = ESMF_SUCCESS

  end subroutine ESMF_ArraySMMStoreInd4R8TP
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArraySMMStoreInd8I4TP()"
!BOPI
! !IROUTINE: ESMF_ArraySMMStore - Precompute and store an Array sparse matrix multiplication 
!
! !INTERFACE:
  ! Private name; call using ESMF_ArraySMMStore()
  subroutine ESMF_ArraySMMStoreInd8I4TP(srcArray, dstArray, routehandle, &
    transposeRoutehandle, factorList, factorIndexList, keywordEnforcer, &
    ignoreUnmatchedIndices, srcTermProcessing, pipelineDepth, rc)
!
! !ARGUMENTS:
    type(ESMF_Array),              intent(inout)           :: srcArray
    type(ESMF_Array),              intent(inout)           :: dstArray
    type(ESMF_RouteHandle),        intent(inout)           :: routehandle
    type(ESMF_RouteHandle),        intent(inout)           :: transposeRoutehandle
    integer(ESMF_KIND_I4), target, intent(in)              :: factorList(:)
    integer(ESMF_KIND_I8),         intent(in)              :: factorIndexList(:,:)
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    logical,                       intent(in),    optional :: ignoreUnmatchedIndices
    integer,                       intent(inout), optional :: srcTermProcessing
    integer,                       intent(inout), optional :: pipelineDepth
    integer,                       intent(out),   optional :: rc
!
!EOPI
!------------------------------------------------------------------------------
    integer                         :: localrc            ! local return code
    integer(ESMF_KIND_I4), pointer  :: opt_factorList(:)  ! helper variable
    integer                         :: len_factorList     ! helper variable
    type(ESMF_InterArray)           :: factorIndexListArg ! helper variable
    integer                         :: tupleSize, i       ! helper variable
    integer(ESMF_KIND_I8), allocatable :: transposeFIL(:,:)  ! helper variable
    type(ESMF_Logical)              :: opt_ignoreUnmatched  ! helper variable

    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL

    ! Check init status of arguments
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, srcArray, rc)
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, dstArray, rc)
    
    ! Wrap factor arguments
    len_factorList = size(factorList)
    opt_factorList => factorList
    factorIndexListArg = &
      ESMF_InterArrayCreate(farray2DI8=factorIndexList, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Set default flags
    opt_ignoreUnmatched = ESMF_FALSE
    if (present(ignoreUnmatchedIndices)) opt_ignoreUnmatched = ignoreUnmatchedIndices

    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreInd8(srcArray, dstArray, routehandle, &
      ESMF_TYPEKIND_I4, opt_factorList, len_factorList, factorIndexListArg, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Garbage collection
    call ESMF_InterArrayDestroy(factorIndexListArg, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Mark routehandle object as being created
    call ESMF_RouteHandleSetInitCreated(routehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Compute the transposeRoutehandle
    ! Construct the transpose of the factorIndexList
    tupleSize = size(factorIndexList,1)
    allocate(transposeFIL(tupleSize, len_factorList))
    if (tupleSize==2) then
      do i=1, len_factorList
        transposeFIL(1,i)=factorIndexList(2,i)
        transposeFIL(2,i)=factorIndexList(1,i)
      enddo
    else if (tupleSize==4) then
      do i=1, len_factorList
        transposeFIL(1,i)=factorIndexList(3,i)
        transposeFIL(2,i)=factorIndexList(4,i)
        transposeFIL(3,i)=factorIndexList(1,i)
        transposeFIL(4,i)=factorIndexList(2,i)
      enddo
    endif
    ! wrap transposeFIL
    factorIndexListArg = &
      ESMF_InterArrayCreate(farray2DI8=transposeFIL, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreInd8(dstArray, srcArray, transposeRoutehandle, &
      ESMF_TYPEKIND_I4, opt_factorList, len_factorList, factorIndexListArg, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    ! Garbage collection
    call ESMF_InterArrayDestroy(factorIndexListArg, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    deallocate(transposeFIL)
    ! Mark transposeRoutehandle object as being created
    call ESMF_RouteHandleSetInitCreated(transposeRoutehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! return successfully
    if (present(rc)) rc = ESMF_SUCCESS

  end subroutine ESMF_ArraySMMStoreInd8I4TP
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArraySMMStoreInd8I8TP()"
!BOPI
! !IROUTINE: ESMF_ArraySMMStore - Precompute and store an Array sparse matrix multiplication
!
! !INTERFACE:
  ! Private name; call using ESMF_ArraySMMStore()
  subroutine ESMF_ArraySMMStoreInd8I8TP(srcArray, dstArray, routehandle, &
    transposeRoutehandle, factorList, factorIndexList, keywordEnforcer, &
    ignoreUnmatchedIndices, srcTermProcessing, pipelineDepth, rc)
!
! !ARGUMENTS:
    type(ESMF_Array),              intent(inout)           :: srcArray
    type(ESMF_Array),              intent(inout)           :: dstArray
    type(ESMF_RouteHandle),        intent(inout)           :: routehandle
    type(ESMF_RouteHandle),        intent(inout)           :: transposeRoutehandle
    integer(ESMF_KIND_I8), target, intent(in)              :: factorList(:)
    integer(ESMF_KIND_I8),         intent(in)              :: factorIndexList(:,:)
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    logical,                       intent(in),    optional :: ignoreUnmatchedIndices
    integer,                       intent(inout), optional :: srcTermProcessing
    integer,                       intent(inout), optional :: pipelineDepth
    integer,                       intent(out),   optional :: rc
!
!EOPI
!------------------------------------------------------------------------------
    integer                         :: localrc            ! local return code
    integer(ESMF_KIND_I8), pointer  :: opt_factorList(:)  ! helper variable
    integer                         :: len_factorList     ! helper variable
    type(ESMF_InterArray)           :: factorIndexListArg ! helper variable
    integer                         :: tupleSize, i       ! helper variable
    integer(ESMF_KIND_I8), allocatable :: transposeFIL(:,:)  ! helper variable
    type(ESMF_Logical)              :: opt_ignoreUnmatched  ! helper variable

    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL
    
    ! Check init status of arguments
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, srcArray, rc)
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, dstArray, rc)
    
    ! Wrap factor arguments
    len_factorList = size(factorList)
    opt_factorList => factorList
    factorIndexListArg = &
      ESMF_InterArrayCreate(farray2DI8=factorIndexList, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Set default flags
    opt_ignoreUnmatched = ESMF_FALSE
    if (present(ignoreUnmatchedIndices)) opt_ignoreUnmatched = ignoreUnmatchedIndices

    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreInd8(srcArray, dstArray, routehandle, &
      ESMF_TYPEKIND_I8, opt_factorList, len_factorList, factorIndexListArg, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Garbage collection
    call ESMF_InterArrayDestroy(factorIndexListArg, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Mark routehandle object as being created
    call ESMF_RouteHandleSetInitCreated(routehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Compute the transposeRoutehandle
    ! Construct the transpose of the factorIndexList
    tupleSize = size(factorIndexList,1)
    allocate(transposeFIL(tupleSize, len_factorList))
    if (tupleSize==2) then
      do i=1, len_factorList
        transposeFIL(1,i)=factorIndexList(2,i)
        transposeFIL(2,i)=factorIndexList(1,i)
      enddo
    else if (tupleSize==4) then
      do i=1, len_factorList
        transposeFIL(1,i)=factorIndexList(3,i)
        transposeFIL(2,i)=factorIndexList(4,i)
        transposeFIL(3,i)=factorIndexList(1,i)
        transposeFIL(4,i)=factorIndexList(2,i)
      enddo
    endif
    ! wrap transposeFIL
    factorIndexListArg = &
      ESMF_InterArrayCreate(farray2DI8=transposeFIL, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreInd8(dstArray, srcArray, transposeRoutehandle, &
      ESMF_TYPEKIND_I8, opt_factorList, len_factorList, factorIndexListArg, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    ! Garbage collection
    call ESMF_InterArrayDestroy(factorIndexListArg, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    deallocate(transposeFIL)
    ! Mark transposeRoutehandle object as being created
    call ESMF_RouteHandleSetInitCreated(transposeRoutehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! return successfully
    if (present(rc)) rc = ESMF_SUCCESS

  end subroutine ESMF_ArraySMMStoreInd8I8TP
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArraySMMStoreInd8R4TP()"
!BOPI
! !IROUTINE: ESMF_ArraySMMStore - Precompute and store an Array sparse matrix multiplication
!
! !INTERFACE:
  ! Private name; call using ESMF_ArraySMMStore()
  subroutine ESMF_ArraySMMStoreInd8R4TP(srcArray, dstArray, routehandle, &
    transposeRoutehandle, factorList, factorIndexList, keywordEnforcer, &
    ignoreUnmatchedIndices, srcTermProcessing, pipelineDepth, rc)
!
! !ARGUMENTS:
    type(ESMF_Array),           intent(inout)           :: srcArray
    type(ESMF_Array),           intent(inout)           :: dstArray
    type(ESMF_RouteHandle),     intent(inout)           :: routehandle
    type(ESMF_RouteHandle),     intent(inout)           :: transposeRoutehandle
    real(ESMF_KIND_R4), target, intent(in)              :: factorList(:)
    integer(ESMF_KIND_I8),      intent(in)              :: factorIndexList(:,:)
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    logical,                    intent(in),    optional :: ignoreUnmatchedIndices
    integer,                    intent(inout), optional :: srcTermProcessing
    integer,                    intent(inout), optional :: pipelineDepth
    integer,                    intent(out),   optional :: rc
!
!EOPI
!------------------------------------------------------------------------------
    integer                       :: localrc            ! local return code
    real(ESMF_KIND_R4), pointer   :: opt_factorList(:)  ! helper variable
    integer                       :: len_factorList     ! helper variable
    type(ESMF_InterArray)         :: factorIndexListArg ! helper variable
    integer                       :: tupleSize, i       ! helper variable
    integer(ESMF_KIND_I8), allocatable :: transposeFIL(:,:)  ! helper variable
    type(ESMF_Logical)            :: opt_ignoreUnmatched  ! helper variable

    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL
    
    ! Check init status of arguments
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, srcArray, rc)
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, dstArray, rc)
    
    ! Wrap factor arguments
    len_factorList = size(factorList)
    opt_factorList => factorList
    factorIndexListArg = &
      ESMF_InterArrayCreate(farray2DI8=factorIndexList, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Set default flags
    opt_ignoreUnmatched = ESMF_FALSE
    if (present(ignoreUnmatchedIndices)) opt_ignoreUnmatched = ignoreUnmatchedIndices

    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreInd8(srcArray, dstArray, routehandle, &
      ESMF_TYPEKIND_R4, opt_factorList, len_factorList, factorIndexListArg, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Garbage collection
    call ESMF_InterArrayDestroy(factorIndexListArg, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Mark routehandle object as being created
    call ESMF_RouteHandleSetInitCreated(routehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Compute the transposeRoutehandle
    ! Construct the transpose of the factorIndexList
    tupleSize = size(factorIndexList,1)
    allocate(transposeFIL(tupleSize, len_factorList))
    if (tupleSize==2) then
      do i=1, len_factorList
        transposeFIL(1,i)=factorIndexList(2,i)
        transposeFIL(2,i)=factorIndexList(1,i)
      enddo
    else if (tupleSize==4) then
      do i=1, len_factorList
        transposeFIL(1,i)=factorIndexList(3,i)
        transposeFIL(2,i)=factorIndexList(4,i)
        transposeFIL(3,i)=factorIndexList(1,i)
        transposeFIL(4,i)=factorIndexList(2,i)
      enddo
    endif
    ! wrap transposeFIL
    factorIndexListArg = &
      ESMF_InterArrayCreate(farray2DI8=transposeFIL, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreInd8(dstArray, srcArray, transposeRoutehandle, &
      ESMF_TYPEKIND_R4, opt_factorList, len_factorList, factorIndexListArg, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    ! Garbage collection
    call ESMF_InterArrayDestroy(factorIndexListArg, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    deallocate(transposeFIL)
    ! Mark transposeRoutehandle object as being created
    call ESMF_RouteHandleSetInitCreated(transposeRoutehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! return successfully
    if (present(rc)) rc = ESMF_SUCCESS

  end subroutine ESMF_ArraySMMStoreInd8R4TP
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArraySMMStoreInd8R8TP()"
!BOPI
! !IROUTINE: ESMF_ArraySMMStore - Precompute and store an Array sparse matrix multiplication
!
! !INTERFACE:
  ! Private name; call using ESMF_ArraySMMStore()
  subroutine ESMF_ArraySMMStoreInd8R8TP(srcArray, dstArray, routehandle, &
    transposeRoutehandle, factorList, factorIndexList, keywordEnforcer, &
    ignoreUnmatchedIndices, srcTermProcessing, pipelineDepth, rc)
!
! !ARGUMENTS:
    type(ESMF_Array),           intent(inout)           :: srcArray
    type(ESMF_Array),           intent(inout)           :: dstArray
    type(ESMF_RouteHandle),     intent(inout)           :: routehandle
    type(ESMF_RouteHandle),     intent(inout)           :: transposeRoutehandle
    real(ESMF_KIND_R8), target, intent(in)              :: factorList(:)
    integer(ESMF_KIND_I8),      intent(in)              :: factorIndexList(:,:)
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    logical,                    intent(in),    optional :: ignoreUnmatchedIndices
    integer,                    intent(inout), optional :: srcTermProcessing
    integer,                    intent(inout), optional :: pipelineDepth
    integer,                    intent(out),   optional :: rc
!
!EOPI
!------------------------------------------------------------------------------
    integer                       :: localrc            ! local return code
    real(ESMF_KIND_R8), pointer   :: opt_factorList(:)  ! helper variable
    integer                       :: len_factorList     ! helper variable
    type(ESMF_InterArray)         :: factorIndexListArg ! helper variable
    integer                       :: tupleSize, i       ! helper variable
    integer(ESMF_KIND_I8), allocatable :: transposeFIL(:,:)  ! helper variable
    type(ESMF_Logical)            :: opt_ignoreUnmatched  ! helper variable

    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL
    
    ! Check init status of arguments
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, srcArray, rc)
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, dstArray, rc)
    
    ! Wrap factor arguments
    len_factorList = size(factorList)
    opt_factorList => factorList
    factorIndexListArg = &
      ESMF_InterArrayCreate(farray2DI8=factorIndexList, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Set default flags
    opt_ignoreUnmatched = ESMF_FALSE
    if (present(ignoreUnmatchedIndices)) opt_ignoreUnmatched = ignoreUnmatchedIndices

    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreInd8(srcArray, dstArray, routehandle, &
      ESMF_TYPEKIND_R8, opt_factorList, len_factorList, factorIndexListArg, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Garbage collection
    call ESMF_InterArrayDestroy(factorIndexListArg, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Mark routehandle object as being created
    call ESMF_RouteHandleSetInitCreated(routehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Compute the transposeRoutehandle
    ! Construct the transpose of the factorIndexList
    tupleSize = size(factorIndexList,1)
    allocate(transposeFIL(tupleSize, len_factorList))
    if (tupleSize==2) then
      do i=1, len_factorList
        transposeFIL(1,i)=factorIndexList(2,i)
        transposeFIL(2,i)=factorIndexList(1,i)
      enddo
    else if (tupleSize==4) then
      do i=1, len_factorList
        transposeFIL(1,i)=factorIndexList(3,i)
        transposeFIL(2,i)=factorIndexList(4,i)
        transposeFIL(3,i)=factorIndexList(1,i)
        transposeFIL(4,i)=factorIndexList(2,i)
      enddo
    endif
    ! wrap transposeFIL
    factorIndexListArg = &
      ESMF_InterArrayCreate(farray2DI8=transposeFIL, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreInd8(dstArray, srcArray, transposeRoutehandle, &
      ESMF_TYPEKIND_R8, opt_factorList, len_factorList, factorIndexListArg, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    ! Garbage collection
    call ESMF_InterArrayDestroy(factorIndexListArg, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    deallocate(transposeFIL)
    ! Mark transposeRoutehandle object as being created
    call ESMF_RouteHandleSetInitCreated(transposeRoutehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! return successfully
    if (present(rc)) rc = ESMF_SUCCESS

  end subroutine ESMF_ArraySMMStoreInd8R8TP
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArraySMMStoreNF()"
!BOP
! !IROUTINE: ESMF_ArraySMMStore - Precompute Array sparse matrix multiplication without local factors
!
! !INTERFACE:
  ! Private name; call using ESMF_ArraySMMStore()
  subroutine ESMF_ArraySMMStoreNF(srcArray, dstArray, routehandle, &
    keywordEnforcer, ignoreUnmatchedIndices, srcTermProcessing, pipelineDepth, &
    rc)
!
! !ARGUMENTS:
    type(ESMF_Array),       intent(in)              :: srcArray
    type(ESMF_Array),       intent(inout)           :: dstArray
    type(ESMF_RouteHandle), intent(inout)           :: routehandle
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    logical,                intent(in),    optional :: ignoreUnmatchedIndices
    integer,                intent(inout), optional :: srcTermProcessing
    integer,                intent(inout), optional :: pipelineDepth
    integer,                intent(out),   optional :: rc
!
! !STATUS:
! \begin{itemize}
! \item\apiStatusCompatibleVersion{5.2.0r}
! \item\apiStatusModifiedSinceVersion{5.2.0r}
! \begin{description}
! \item[6.1.0] Added argument {\tt srcTermProcessing}.
!              Added argument {\tt pipelineDepth}.
!              The new arguments provide access to the tuning parameters
!              affecting the sparse matrix execution.
! \item[7.0.0] Added argument {\tt transposeRoutehandle} to allow a handle to
!              the transposed matrix operation to be returned.\newline
!              Added argument {\tt ignoreUnmatchedIndices} to support sparse 
!              matrices that contain elements with indices that do not have a
!              match within the source or destination Array.
! \item[7.1.0r] Removed argument {\tt transposeRoutehandle} and provide it
!              via interface overloading instead. This allows argument 
!              {\tt srcArray} to stay strictly intent(in) for this entry point.
! \end{description}
! \end{itemize}
!
! !DESCRIPTION:
! \label{ArraySMMStoreNF}
! {\tt ESMF\_ArraySMMStore()} is a collective method across all PETs of the
! current Component. The interface of the method is overloaded, allowing 
! -- in principle -- each PET to call into {\tt ESMF\_ArraySMMStore()}
! through a different entry point. Restrictions apply as to which combinations
! are sensible. All other combinations result in ESMF run time errors. The
! complete semantics of the {\tt ESMF\_ArraySMMStore()} method, as provided
! through the separate entry points shown in \ref{ArraySMMStoreTK} and
! \ref{ArraySMMStoreNF}, is described in the following paragraphs as a whole.
!
!   \begin{sloppypar}
!   Store an Array sparse matrix multiplication operation from {\tt srcArray}
!   to {\tt dstArray}. PETs that specify non-zero matrix coefficients must use
!   the <type><kind> overloaded interface and provide the {\tt factorList} and
!   {\tt factorIndexList} arguments. Providing {\tt factorList} and
!   {\tt factorIndexList} arguments with {\tt size(factorList) = (/0/)} and
!   {\tt size(factorIndexList) = (/2,0/)} or {\tt (/4,0/)} indicates that a 
!   PET does not provide matrix elements. Alternatively, PETs that do not 
!   provide matrix elements may also call into the overloaded interface
!   {\em without} {\tt factorList} and {\tt factorIndexList} arguments.
!   \end{sloppypar}
!
!   Both {\tt srcArray} and {\tt dstArray} are interpreted as sequentialized
!   vectors. The sequence is defined by the order of DistGrid dimensions and 
!   the order of tiles within the DistGrid or by user-supplied arbitrary
!   sequence indices. See section \ref{Array:SparseMatMul} for details on the
!   definition of {\em sequence indices}.
!
!   Source and destination Arrays, as well as the supplied {\tt factorList}
!   argument, may be of different <type><kind>. Further source and
!   destination Arrays may differ in shape and number of elements.
!
!   It is erroneous to specify the identical Array object for {\tt srcArray} and
!   {\tt dstArray} arguments.
!
!   The routine returns an {\tt ESMF\_RouteHandle} that can be used to call 
!   {\tt ESMF\_ArraySMM()} on any pair of Arrays that matches 
!   {\tt srcArray} and {\tt dstArray} in {\em type}, {\em kind}, and 
!   memory layout of the {\em distributed} dimensions. However, the size,
!   number, and index order of {\em undistributed} dimensions may be different.
!   See section \ref{RH:Reusability} for a more detailed discussion of
!   RouteHandle reusability.
!
!   This call is {\em collective} across the current VM.
!
!   \begin{description}
!
!   \item [srcArray]
!     {\tt ESMF\_Array} with source data.
!
!   \item [dstArray]
!     {\tt ESMF\_Array} with destination data. The data in this Array may be
!     destroyed by this call.
!
!   \item [routehandle]
!     Handle to the precomputed Route.
!
!   \item [{[ignoreUnmatchedIndices]}]
!     A logical flag that affects the behavior for when sequence indices 
!     in the sparse matrix are encountered that do not have a match on the 
!     {\tt srcArray} or {\tt dstArray} side. The default setting is 
!     {\tt .false.}, indicating that it is an error when such a situation is 
!     encountered. Setting {\tt ignoreUnmatchedIndices} to {\tt .true.} ignores
!     entries with unmatched indices.
!
!   \item [{[srcTermProcessing]}]
!     The {\tt srcTermProcessing} parameter controls how many source terms,
!     located on the same PET and summing into the same destination element,
!     are summed into partial sums on the source PET before being transferred
!     to the destination PET. A value of 0 indicates that the entire arithmetic
!     is done on the destination PET; source elements are neither multiplied 
!     by their factors nor added into partial sums before being sent off by the
!     source PET. A value of 1 indicates that source elements are multiplied
!     by their factors on the source side before being sent to the destination
!     PET. Larger values of {\tt srcTermProcessing} indicate the maximum number
!     of terms in the partial sums on the source side.
!
!     Note that partial sums may lead to bit-for-bit differences in the results.
!     See section \ref{RH:bfb} for an in-depth discussion of {\em all}
!     bit-for-bit reproducibility aspects related to route-based communication
!     methods.
!
!     \begin{sloppypar}
!     The {\tt ESMF\_ArraySMMStore()} method implements an auto-tuning scheme
!     for the {\tt srcTermProcessing} parameter. The intent on the 
!     {\tt srcTermProcessing} argument is "{\tt inout}" in order to 
!     support both overriding and accessing the auto-tuning parameter.
!     If an argument $>= 0$ is specified, it is used for the 
!     {\tt srcTermProcessing} parameter, and the auto-tuning phase is skipped.
!     In this case the {\tt srcTermProcessing} argument is not modified on
!     return. If the provided argument is $< 0$, the {\tt srcTermProcessing}
!     parameter is determined internally using the auto-tuning scheme. In this
!     case the {\tt srcTermProcessing} argument is re-set to the internally
!     determined value on return. Auto-tuning is also used if the optional 
!     {\tt srcTermProcessing} argument is omitted.
!     \end{sloppypar}
!     
!   \item [{[pipelineDepth]}]
!     The {\tt pipelineDepth} parameter controls how many messages a PET
!     may have outstanding during a sparse matrix exchange. Larger values
!     of {\tt pipelineDepth} typically lead to better performance. However,
!     on some systems too large a value may lead to performance degradation,
!     or runtime errors.
!
!     Note that the pipeline depth has no effect on the bit-for-bit
!     reproducibility of the results. However, it may affect the performance
!     reproducibility of the exchange.
!
!     The {\tt ESMF\_ArraySMMStore()} method implements an auto-tuning scheme
!     for the {\tt pipelineDepth} parameter. The intent on the 
!     {\tt pipelineDepth} argument is "{\tt inout}" in order to 
!     support both overriding and accessing the auto-tuning parameter.
!     If an argument $>= 0$ is specified, it is used for the 
!     {\tt pipelineDepth} parameter, and the auto-tuning phase is skipped.
!     In this case the {\tt pipelineDepth} argument is not modified on
!     return. If the provided argument is $< 0$, the {\tt pipelineDepth}
!     parameter is determined internally using the auto-tuning scheme. In this
!     case the {\tt pipelineDepth} argument is re-set to the internally
!     determined value on return. Auto-tuning is also used if the optional 
!     {\tt pipelineDepth} argument is omitted.
!     
!   \item [{[rc]}]
!     Return code; equals {\tt ESMF\_SUCCESS} if there are no errors.
!   \end{description}
!
!EOP
!------------------------------------------------------------------------------
    integer                         :: localrc            ! local return code
    type(ESMF_Logical)              :: opt_ignoreUnmatched  ! helper variable

    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL
    
    ! Check init status of arguments
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, srcArray, rc)
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, dstArray, rc)
    
    ! Set default flags
    opt_ignoreUnmatched = ESMF_FALSE
    if (present(ignoreUnmatchedIndices)) opt_ignoreUnmatched = ignoreUnmatchedIndices

    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreNF(srcArray, dstArray, routehandle, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Mark routehandle object as being created
    call ESMF_RouteHandleSetInitCreated(routehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! return successfully
    if (present(rc)) rc = ESMF_SUCCESS

  end subroutine ESMF_ArraySMMStoreNF
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArraySMMStoreNFTP()"
!BOP
! !IROUTINE: ESMF_ArraySMMStore - Precompute Array sparse matrix multiplication and transpose without local factors
!
! !INTERFACE:
  ! Private name; call using ESMF_ArraySMMStore()
  subroutine ESMF_ArraySMMStoreNFTP(srcArray, dstArray, routehandle, &
    transposeRoutehandle, keywordEnforcer, ignoreUnmatchedIndices, &
    srcTermProcessing, pipelineDepth, rc)
!
! !ARGUMENTS:
    type(ESMF_Array),       intent(inout)           :: srcArray
    type(ESMF_Array),       intent(inout)           :: dstArray
    type(ESMF_RouteHandle), intent(inout)           :: routehandle
    type(ESMF_RouteHandle), intent(inout)           :: transposeRoutehandle
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    logical,                intent(in),    optional :: ignoreUnmatchedIndices
    integer,                intent(inout), optional :: srcTermProcessing
    integer,                intent(inout), optional :: pipelineDepth
    integer,                intent(out),   optional :: rc
!
! !DESCRIPTION:
! \label{ArraySMMStoreNFTP}
! {\tt ESMF\_ArraySMMStore()} is a collective method across all PETs of the
! current Component. The interface of the method is overloaded, allowing 
! -- in principle -- each PET to call into {\tt ESMF\_ArraySMMStore()}
! through a different entry point. Restrictions apply as to which combinations
! are sensible. All other combinations result in ESMF run time errors. The
! complete semantics of the {\tt ESMF\_ArraySMMStore()} method, as provided
! through the separate entry points shown in \ref{ArraySMMStoreTKTP} and
! \ref{ArraySMMStoreNFTP}, is described in the following paragraphs as a whole.
!
!   \begin{sloppypar}
!   Store an Array sparse matrix multiplication operation from {\tt srcArray}
!   to {\tt dstArray}. PETs that specify non-zero matrix coefficients must use
!   the <type><kind> overloaded interface and provide the {\tt factorList} and
!   {\tt factorIndexList} arguments. Providing {\tt factorList} and
!   {\tt factorIndexList} arguments with {\tt size(factorList) = (/0/)} and
!   {\tt size(factorIndexList) = (/2,0/)} or {\tt (/4,0/)} indicates that a 
!   PET does not provide matrix elements. Alternatively, PETs that do not 
!   provide matrix elements may also call into the overloaded interface
!   {\em without} {\tt factorList} and {\tt factorIndexList} arguments.
!   \end{sloppypar}
!
!   Both {\tt srcArray} and {\tt dstArray} are interpreted as sequentialized
!   vectors. The sequence is defined by the order of DistGrid dimensions and 
!   the order of tiles within the DistGrid or by user-supplied arbitrary
!   sequence indices. See section \ref{Array:SparseMatMul} for details on the
!   definition of {\em sequence indices}.
!
!   Source and destination Arrays, as well as the supplied {\tt factorList}
!   argument, may be of different <type><kind>. Further source and
!   destination Arrays may differ in shape and number of elements.
!
!   It is erroneous to specify the identical Array object for {\tt srcArray} and
!   {\tt dstArray} arguments.
!
!   The routine returns an {\tt ESMF\_RouteHandle} that can be used to call 
!   {\tt ESMF\_ArraySMM()} on any pair of Arrays that matches 
!   {\tt srcArray} and {\tt dstArray} in {\em type}, {\em kind}, and 
!   memory layout of the {\em distributed} dimensions. However, the size,
!   number, and index order of {\em undistributed} dimensions may be different.
!   See section \ref{RH:Reusability} for a more detailed discussion of
!   RouteHandle reusability.
!
!   This call is {\em collective} across the current VM.
!
!   \begin{description}
!
!   \item [srcArray]
!     {\tt ESMF\_Array} with source data. The data in this Array may be
!     destroyed by this call.
!
!   \item [dstArray]
!     {\tt ESMF\_Array} with destination data. The data in this Array may be
!     destroyed by this call.
!
!   \item [routehandle]
!     Handle to the precomputed Route.
!
!   \item [{[transposeRoutehandle]}]
!     Handle to the transposed matrix operation. The transposed operation goes
!     from {\tt dstArray} to {\tt srcArray}.
!     
!   \item [{[ignoreUnmatchedIndices]}]
!     A logical flag that affects the behavior for when sequence indices 
!     in the sparse matrix are encountered that do not have a match on the 
!     {\tt srcArray} or {\tt dstArray} side. The default setting is 
!     {\tt .false.}, indicating that it is an error when such a situation is 
!     encountered. Setting {\tt ignoreUnmatchedIndices} to {\tt .true.} ignores
!     entries with unmatched indices.
!
!   \item [{[srcTermProcessing]}]
!     The {\tt srcTermProcessing} parameter controls how many source terms,
!     located on the same PET and summing into the same destination element,
!     are summed into partial sums on the source PET before being transferred
!     to the destination PET. A value of 0 indicates that the entire arithmetic
!     is done on the destination PET; source elements are neither multiplied 
!     by their factors nor added into partial sums before being sent off by the
!     source PET. A value of 1 indicates that source elements are multiplied
!     by their factors on the source side before being sent to the destination
!     PET. Larger values of {\tt srcTermProcessing} indicate the maximum number
!     of terms in the partial sums on the source side.
!
!     Note that partial sums may lead to bit-for-bit differences in the results.
!     See section \ref{RH:bfb} for an in-depth discussion of {\em all}
!     bit-for-bit reproducibility aspects related to route-based communication
!     methods.
!
!     \begin{sloppypar}
!     The {\tt ESMF\_ArraySMMStore()} method implements an auto-tuning scheme
!     for the {\tt srcTermProcessing} parameter. The intent on the 
!     {\tt srcTermProcessing} argument is "{\tt inout}" in order to 
!     support both overriding and accessing the auto-tuning parameter.
!     If an argument $>= 0$ is specified, it is used for the 
!     {\tt srcTermProcessing} parameter, and the auto-tuning phase is skipped.
!     In this case the {\tt srcTermProcessing} argument is not modified on
!     return. If the provided argument is $< 0$, the {\tt srcTermProcessing}
!     parameter is determined internally using the auto-tuning scheme. In this
!     case the {\tt srcTermProcessing} argument is re-set to the internally
!     determined value on return. Auto-tuning is also used if the optional 
!     {\tt srcTermProcessing} argument is omitted.
!     \end{sloppypar}
!     
!   \item [{[pipelineDepth]}]
!     The {\tt pipelineDepth} parameter controls how many messages a PET
!     may have outstanding during a sparse matrix exchange. Larger values
!     of {\tt pipelineDepth} typically lead to better performance. However,
!     on some systems too large a value may lead to performance degradation,
!     or runtime errors.
!
!     Note that the pipeline depth has no effect on the bit-for-bit
!     reproducibility of the results. However, it may affect the performance
!     reproducibility of the exchange.
!
!     The {\tt ESMF\_ArraySMMStore()} method implements an auto-tuning scheme
!     for the {\tt pipelineDepth} parameter. The intent on the 
!     {\tt pipelineDepth} argument is "{\tt inout}" in order to 
!     support both overriding and accessing the auto-tuning parameter.
!     If an argument $>= 0$ is specified, it is used for the 
!     {\tt pipelineDepth} parameter, and the auto-tuning phase is skipped.
!     In this case the {\tt pipelineDepth} argument is not modified on
!     return. If the provided argument is $< 0$, the {\tt pipelineDepth}
!     parameter is determined internally using the auto-tuning scheme. In this
!     case the {\tt pipelineDepth} argument is re-set to the internally
!     determined value on return. Auto-tuning is also used if the optional 
!     {\tt pipelineDepth} argument is omitted.
!     
!   \item [{[rc]}]
!     Return code; equals {\tt ESMF\_SUCCESS} if there are no errors.
!   \end{description}
!
!EOP
!------------------------------------------------------------------------------
    integer                         :: localrc            ! local return code
    type(ESMF_Logical)              :: opt_ignoreUnmatched  ! helper variable

    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL
    
    ! Check init status of arguments
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, srcArray, rc)
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, dstArray, rc)
    
    ! Set default flags
    opt_ignoreUnmatched = ESMF_FALSE
    if (present(ignoreUnmatchedIndices)) opt_ignoreUnmatched = ignoreUnmatchedIndices

    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreNF(srcArray, dstArray, routehandle, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Mark routehandle object as being created
    call ESMF_RouteHandleSetInitCreated(routehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! Compute the transposeRoutehandle
    ! Call into the C++ interface, which will sort out optional arguments
    call c_ESMC_ArraySMMStoreNF(dstArray, srcArray, transposeRoutehandle, &
      opt_ignoreUnmatched, srcTermProcessing, pipelineDepth, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    ! Mark transposeRoutehandle object as being created
    call ESMF_RouteHandleSetInitCreated(transposeRoutehandle, rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
    
    ! return successfully
    if (present(rc)) rc = ESMF_SUCCESS

  end subroutine ESMF_ArraySMMStoreNFTP
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArraySMMStoreFromFile"
!BOP
! !IROUTINE: ESMF_ArraySMMStore - Precompute sparse matrix multiplication using factors read from file.
!
! !INTERFACE:
! ! Private name; call using ESMF_ArraySMMStore()
  subroutine ESMF_ArraySMMStoreFromFile(srcArray, dstArray, filename, &
    routehandle, keywordEnforcer, ignoreUnmatchedIndices, &
    srcTermProcessing, pipelineDepth, rc)

! ! ARGUMENTS:
    type(ESMF_Array),       intent(in)              :: srcArray
    type(ESMF_Array),       intent(inout)           :: dstArray
    character(len=*),       intent(in)              :: filename
    type(ESMF_RouteHandle), intent(inout)           :: routehandle
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    logical,                intent(in),    optional :: ignoreUnmatchedIndices
    integer,                intent(inout), optional :: srcTermProcessing
    integer,                intent(inout), optional :: pipeLineDepth
    integer,                intent(out),   optional :: rc
!
! !DESCRIPTION:
!
! Compute an {\tt ESMF\_RouteHandle} using factors read from file.
!
! The arguments are:
!
! \begin{description}
!
! \item [srcArray]
!     {\tt ESMF\_Array} with source data.
!
! \item [dstArray]
!       {\tt ESMF\_Array} with destination data. The data in this Array may be
!       destroyed by this call.
!
! \item [filename]
!       Path to the file containing weights for creating an {\tt ESMF\_RouteHandle}.
!       See ~(\ref{sec:weightfileformat}) for a description of the SCRIP weight
!       file format. Only "row", "col", and "S" variables are required. They
!       must be one-dimensionsal with dimension "n\_s".
!
! \item [routehandle]
!       Handle to the {\tt ESMF\_RouteHandle}.
!
!   \item [{[ignoreUnmatchedIndices]}]
!     A logical flag that affects the behavior for when sequence indices
!     in the sparse matrix are encountered that do not have a match on the
!     {\tt srcArray} or {\tt dstArray} side. The default setting is
!     {\tt .false.}, indicating that it is an error when such a situation is
!     encountered. Setting {\tt ignoreUnmatchedIndices} to {\tt .true.} ignores
!     entries with unmatched indices.
!
!   \item [{[srcTermProcessing]}]
!     The {\tt srcTermProcessing} parameter controls how many source terms,
!     located on the same PET and summing into the same destination element,
!     are summed into partial sums on the source PET before being transferred
!     to the destination PET. A value of 0 indicates that the entire arithmetic
!     is done on the destination PET; source elements are neither multiplied
!     by their factors nor added into partial sums before being sent off by the
!     source PET. A value of 1 indicates that source elements are multiplied
!     by their factors on the source side before being sent to the destination
!     PET. Larger values of {\tt srcTermProcessing} indicate the maximum number
!     of terms in the partial sums on the source side.
!
!     Note that partial sums may lead to bit-for-bit differences in the results.
!     See section \ref{RH:bfb} for an in-depth discussion of {\em all}
!     bit-for-bit reproducibility aspects related to route-based communication
!     methods.
!
!     \begin{sloppypar}
!     The {\tt ESMF\_ArraySMMStore()} method implements an auto-tuning scheme
!     for the {\tt srcTermProcessing} parameter. The intent on the
!     {\tt srcTermProcessing} argument is "{\tt inout}" in order to
!     support both overriding and accessing the auto-tuning parameter.
!     If an argument $>= 0$ is specified, it is used for the
!     {\tt srcTermProcessing} parameter, and the auto-tuning phase is skipped.
!     In this case the {\tt srcTermProcessing} argument is not modified on
!     return. If the provided argument is $< 0$, the {\tt srcTermProcessing}
!     parameter is determined internally using the auto-tuning scheme. In this
!     case the {\tt srcTermProcessing} argument is re-set to the internally
!     determined value on return. Auto-tuning is also used if the optional
!     {\tt srcTermProcessing} argument is omitted.
!     \end{sloppypar}
!
!   \item [{[pipelineDepth]}]
!     The {\tt pipelineDepth} parameter controls how many messages a PET
!     may have outstanding during a sparse matrix exchange. Larger values
!     of {\tt pipelineDepth} typically lead to better performance. However,
!     on some systems too large a value may lead to performance degradation,
!     or runtime errors.
!
!     Note that the pipeline depth has no effect on the bit-for-bit
!     reproducibility of the results. However, it may affect the performance
!     reproducibility of the exchange.
!     The {\tt ESMF\_ArraySMMStore()} method implements an auto-tuning scheme
!     for the {\tt pipelineDepth} parameter. The intent on the
!     {\tt pipelineDepth} argument is "{\tt inout}" in order to
!     support both overriding and accessing the auto-tuning parameter.
!     If an argument $>= 0$ is specified, it is used for the
!     {\tt pipelineDepth} parameter, and the auto-tuning phase is skipped.
!     In this case the {\tt pipelineDepth} argument is not modified on
!     return. If the provided argument is $< 0$, the {\tt pipelineDepth}
!     parameter is determined internally using the auto-tuning scheme. In this
!     case the {\tt pipelineDepth} argument is re-set to the internally
!     determined value on return. Auto-tuning is also used if the optional
!     {\tt pipelineDepth} argument is omitted.
!
!   \item [{[rc]}]
!     Return code; equals {\tt ESMF\_SUCCESS} if there are no errors.
!
! \end{description}
!
!EOP
!-------------------------------------------------------------------------------
    real(ESMF_KIND_R8), dimension(:), allocatable :: factorList
    integer, dimension(:, :), allocatable :: factorIndexList
    integer :: localrc

    ! Initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL

    ! Fill the factorList and factorIndexList.
    call ESMF_FactorRead(filename, &
                         factorList, &
                         factorIndexList, &
                         rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Generate routeHandle from factorList and factorIndexList
    call ESMF_ArraySMMStore(srcArray=srcArray, &
                            dstArray=dstArray, &
                            routehandle=routeHandle, &
                            factorList=factorList, &
                            factorIndexList=factorIndexList,   &
                            ignoreUnmatchedIndices=ignoreUnmatchedIndices, &
                            srcTermProcessing=srcTermProcessing, &
                            pipeLineDepth=pipeLineDepth, &
                            rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    deallocate(factorList)
    deallocate(factorIndexList)

    if (present(rc)) rc = ESMF_SUCCESS

  end subroutine ESMF_ArraySMMStoreFromFile
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArraySMMStoreFromFileTP"
!BOP
! !IROUTINE: ESMF_ArraySMMStore - Precompute sparse matrix multiplication and transpose using factors read from file.
!
! !INTERFACE:
! ! Private name; call using ESMF_ArraySMMStore()
  subroutine ESMF_ArraySMMStoreFromFileTP(srcArray, dstArray, filename, &
    routehandle, transposeRoutehandle, keywordEnforcer, ignoreUnmatchedIndices,&
    srcTermProcessing, pipelineDepth, rc)

! ! ARGUMENTS:
    type(ESMF_Array),       intent(inout)           :: srcArray
    type(ESMF_Array),       intent(inout)           :: dstArray
    character(len=*),       intent(in)              :: filename
    type(ESMF_RouteHandle), intent(inout)           :: routehandle
    type(ESMF_RouteHandle), intent(inout)           :: transposeRoutehandle
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    logical,                intent(in),    optional :: ignoreUnmatchedIndices
    integer,                intent(inout), optional :: srcTermProcessing
    integer,                intent(inout), optional :: pipeLineDepth
    integer,                intent(out),   optional :: rc
!
! !DESCRIPTION:
!
! Compute an {\tt ESMF\_RouteHandle} using factors read from file.
!
! The arguments are:
!
! \begin{description}
!
! \item [srcArray]
!     {\tt ESMF\_Array} with source data. The data in this Array may be
!     destroyed by this call.
!
! \item [dstArray]
!       {\tt ESMF\_Array} with destination data. The data in this Array may be
!       destroyed by this call.
!
! \item [filename]
!       Path to the file containing weights for creating an {\tt ESMF\_RouteHandle}.
!       See ~(\ref{sec:weightfileformat}) for a description of the SCRIP weight
!       file format. Only "row", "col", and "S" variables are required. They
!       must be one-dimensionsal with dimension "n\_s".
!
! \item [routehandle]
!       Handle to the {\tt ESMF\_RouteHandle}.
!
!   \item [{[transposeRoutehandle]}]
!     Handle to the transposed matrix operation. The transposed operation goes
!     from {\tt dstArray} to {\tt srcArray}.
!
!   \item [{[ignoreUnmatchedIndices]}]
!     A logical flag that affects the behavior for when sequence indices
!     in the sparse matrix are encountered that do not have a match on the
!     {\tt srcArray} or {\tt dstArray} side. The default setting is
!     {\tt .false.}, indicating that it is an error when such a situation is
!     encountered. Setting {\tt ignoreUnmatchedIndices} to {\tt .true.} ignores
!     entries with unmatched indices.
!
!   \item [{[srcTermProcessing]}]
!     The {\tt srcTermProcessing} parameter controls how many source terms,
!     located on the same PET and summing into the same destination element,
!     are summed into partial sums on the source PET before being transferred
!     to the destination PET. A value of 0 indicates that the entire arithmetic
!     is done on the destination PET; source elements are neither multiplied
!     by their factors nor added into partial sums before being sent off by the
!     source PET. A value of 1 indicates that source elements are multiplied
!     by their factors on the source side before being sent to the destination
!     PET. Larger values of {\tt srcTermProcessing} indicate the maximum number
!     of terms in the partial sums on the source side.
!
!     Note that partial sums may lead to bit-for-bit differences in the results.
!     See section \ref{RH:bfb} for an in-depth discussion of {\em all}
!     bit-for-bit reproducibility aspects related to route-based communication
!     methods.
!
!     \begin{sloppypar}
!     The {\tt ESMF\_ArraySMMStore()} method implements an auto-tuning scheme
!     for the {\tt srcTermProcessing} parameter. The intent on the
!     {\tt srcTermProcessing} argument is "{\tt inout}" in order to
!     support both overriding and accessing the auto-tuning parameter.
!     If an argument $>= 0$ is specified, it is used for the
!     {\tt srcTermProcessing} parameter, and the auto-tuning phase is skipped.
!     In this case the {\tt srcTermProcessing} argument is not modified on
!     return. If the provided argument is $< 0$, the {\tt srcTermProcessing}
!     parameter is determined internally using the auto-tuning scheme. In this
!     case the {\tt srcTermProcessing} argument is re-set to the internally
!     determined value on return. Auto-tuning is also used if the optional
!     {\tt srcTermProcessing} argument is omitted.
!     \end{sloppypar}
!
!   \item [{[pipelineDepth]}]
!     The {\tt pipelineDepth} parameter controls how many messages a PET
!     may have outstanding during a sparse matrix exchange. Larger values
!     of {\tt pipelineDepth} typically lead to better performance. However,
!     on some systems too large a value may lead to performance degradation,
!     or runtime errors.
!
!     Note that the pipeline depth has no effect on the bit-for-bit
!     reproducibility of the results. However, it may affect the performance
!     reproducibility of the exchange.
!     The {\tt ESMF\_ArraySMMStore()} method implements an auto-tuning scheme
!     for the {\tt pipelineDepth} parameter. The intent on the
!     {\tt pipelineDepth} argument is "{\tt inout}" in order to
!     support both overriding and accessing the auto-tuning parameter.
!     If an argument $>= 0$ is specified, it is used for the
!     {\tt pipelineDepth} parameter, and the auto-tuning phase is skipped.
!     In this case the {\tt pipelineDepth} argument is not modified on
!     return. If the provided argument is $< 0$, the {\tt pipelineDepth}
!     parameter is determined internally using the auto-tuning scheme. In this
!     case the {\tt pipelineDepth} argument is re-set to the internally
!     determined value on return. Auto-tuning is also used if the optional
!     {\tt pipelineDepth} argument is omitted.
!
!   \item [{[rc]}]
!     Return code; equals {\tt ESMF\_SUCCESS} if there are no errors.
!
! \end{description}
!
!EOP
!-------------------------------------------------------------------------------
    real(ESMF_KIND_R8), dimension(:), allocatable :: factorList
    integer, dimension(:, :), allocatable :: factorIndexList
    integer :: localrc

    ! Initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL

    ! Fill the factorList and factorIndexList.
    call ESMF_FactorRead(filename, &
                         factorList, &
                         factorIndexList, &
                         rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    ! Generate routeHandle from factorList and factorIndexList
    call ESMF_ArraySMMStore(srcArray=srcArray, &
                            dstArray=dstArray, &
                            routehandle=routeHandle, &
                            factorList=factorList, &
                            factorIndexList=factorIndexList,   &
                            ignoreUnmatchedIndices=ignoreUnmatchedIndices, &
                            srcTermProcessing=srcTermProcessing, &
                            transposeRoutehandle=transposeRoutehandle, &
                            pipeLineDepth=pipeLineDepth, &
                            rc=localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return

    deallocate(factorList)
    deallocate(factorIndexList)

    if (present(rc)) rc = ESMF_SUCCESS

  end subroutine ESMF_ArraySMMStoreFromFileTP
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArraySync()"
!BOP
! !IROUTINE: ESMF_ArraySync - Synchronize DEs across the Array in case of sharing

! !INTERFACE:
  subroutine ESMF_ArraySync(array, keywordEnforcer, rc)
!
! !ARGUMENTS:
    type(ESMF_Array), intent(in)            :: array
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    integer,          intent(out), optional :: rc  
!
! !DESCRIPTION:
!     Synchronizes access to DEs across {\tt array} to make sure PETs correctly
!     access the data for read and write when DEs are shared. 
!
!     The arguments are:
!     \begin{description}
!     \item[array] 
!          Specified {\tt ESMF\_Array} object.
!     \item[{[rc]}] 
!          Return code; equals {\tt ESMF\_SUCCESS} if there are no errors.
!     \end{description}
!
!EOP
!------------------------------------------------------------------------------
    integer                 :: localrc      ! local return code

    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL
    
    ! Check init status of arguments
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, array, rc)
    
    ! Call into the C++ interface, which will sort out optional arguments.
    call c_ESMC_ArraySync(array, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
      
    ! return successfully
    if (present(rc)) rc = ESMF_SUCCESS
    
  end subroutine ESMF_ArraySync
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArrayValidate()"
!BOP
! !IROUTINE: ESMF_ArrayValidate - Validate object-wide Array information

! !INTERFACE:
  subroutine ESMF_ArrayValidate(array, keywordEnforcer, rc)
!
! !ARGUMENTS:
    type(ESMF_Array), intent(in)            :: array
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    integer,          intent(out), optional :: rc  
!
! !STATUS:
! \begin{itemize}
! \item\apiStatusCompatibleVersion{5.2.0r}
! \end{itemize}
!
! !DESCRIPTION:
!      Validates that the {\tt Array} is internally consistent.
!      The method returns an error code if problems are found.  
!
!     The arguments are:
!     \begin{description}
!     \item[array] 
!          Specified {\tt ESMF\_Array} object.
!     \item[{[rc]}] 
!          Return code; equals {\tt ESMF\_SUCCESS} if there are no errors.
!     \end{description}
!
!EOP
!------------------------------------------------------------------------------
    integer                 :: localrc      ! local return code

    ! initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL
    
    ! Check init status of arguments
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, array, rc)
    
    ! Call into the C++ interface, which will sort out optional arguments.
    call c_ESMC_ArrayValidate(array, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU, &
      ESMF_CONTEXT, rcToReturn=rc)) return
      
    ! return successfully
    if (present(rc)) rc = ESMF_SUCCESS
    
  end subroutine ESMF_ArrayValidate
!------------------------------------------------------------------------------


! -------------------------- ESMF-public method -------------------------------
#undef  ESMF_METHOD
#define ESMF_METHOD "ESMF_ArrayWrite"
!BOP
! !IROUTINE: ESMF_ArrayWrite - Write Array data into a file
! \label{api:ArrayWrite}
!
! !INTERFACE:
  subroutine ESMF_ArrayWrite(array, fileName, keywordEnforcer, &
      variableName, convention, purpose,  &
      overwrite, status, timeslice, iofmt, rc)
!
! !ARGUMENTS:
    type(ESMF_Array),           intent(in)            :: array
    character(*),               intent(in)            :: fileName
type(ESMF_KeywordEnforcer), optional:: keywordEnforcer ! must use keywords below
    character(*),               intent(in),  optional :: variableName
    character(*),               intent(in),  optional :: convention
    character(*),               intent(in),  optional :: purpose
    logical,                    intent(in),  optional :: overwrite
    type(ESMF_FileStatus_Flag), intent(in),  optional :: status
    integer,                    intent(in),  optional :: timeslice
    type(ESMF_IOFmt_Flag),      intent(in),  optional :: iofmt
    integer,                    intent(out), optional :: rc
!
! !DESCRIPTION:
!   Write Array data into a file. For this API to be functional, the 
!   environment variable {\tt ESMF\_PIO} should be set to either "internal" or "external" when
!   the ESMF library is built.  Please see the section on 
!   Data I/O,~\ref{io:dataio}. 
!
!   When {\tt convention} and {\tt purpose} arguments are specified,
!   a NetCDF variable can be created with user-specified dimension labels and
!   attributes.  Dimension labels may be defined for both gridded and
!   ungridded dimensions.  Dimension labels for gridded dimensions are specified
!   at the DistGrid level by attaching an ESMF Attribute package to it.  The Attribute
!   package must contain an attribute named by the pre-defined ESMF parameter
!   {\tt ESMF\_ATT\_GRIDDED\_DIM\_LABELS}.  The corresponding value is an array of
!   character strings specifying the desired names of the dimensions.  Likewise,
!   for ungridded dimensions, an Attribute package is attached at the Array level.
!   The name of the name must be {\tt ESMF\_ATT\_UNGRIDDED\_DIM\_LABELS}.
!
!   NetCDF attributes for the variable can also be specified.  As with dimension labels,
!   an Attribute package is added to the Array with the desired names and values.
!   A value may be either a scalar character string, or a scalar or array of type
!   integer, real, or double precision.  Dimension label attributes can co-exist with
!   variable attributes within a common Attribute package.
!
!   Limitations:
!   \begin{itemize}
!     \item Not supported in {\tt ESMF\_COMM=mpiuni} mode.
!   \end{itemize}
!
!  The arguments are:
!  \begin{description}
!   \item[array]
!    The {\tt ESMF\_Array} object that contains data to be written.
!   \item[fileName]
!    The name of the output file to which Array data is written.
!    If this is a multi-tile Array, then fileName must contain
!    exactly one instance of "*"; this is a placeholder that will be replaced
!    by the tile number, with each tile being written to a separate file. (For
!    example, for a fileName of "myfile*.nc", tile 1 will be written to
!    "myfile1.nc", tile 2 to "myfile2.nc", etc.)
!    (This handling of the fileName for multi-tile I/O is subject to change.)
!   \item[{[variableName]}]
!    Variable name in the output file; default is the "name" of Array.
!    Use this argument only in the I/O format (such as NetCDF) that
!    supports variable name. If the I/O format does not support this
!    (such as binary format), ESMF will return an error code.
!   \item[{[convention]}]
!     Specifies an Attribute package associated with the Array, used to create NetCDF
!     dimension labels and attributes for the variable in the file.  When this argument is present,
!     the {\tt purpose} argument must also be present.  Use this argument only with a NetCDF
!     I/O format. If binary format is used, ESMF will return an error code.
!   \item[{[purpose]}]
!     Specifies an Attribute package associated with the Array, used to create NetCDF
!     dimension labels and attributes for the variable in the file.  When this argument is present,
!     the {\tt convention} argument must also be present.  Use this argument only with a NetCDF
!     I/O format. If binary format is used, ESMF will return an error code.
!   \item[{[overwrite]}]
!    \begin{sloppypar}
!      A logical flag, the default is .false., i.e., existing Array data may
!      {\em not} be overwritten. If .true., only the
!      data corresponding to the Array's name will be
!      be overwritten. If the {\tt timeslice} option is given, only data for
!      the given timeslice may be overwritten.
!      Note that it is always an error to attempt to overwrite a NetCDF
!      variable with data which has a different shape.
!    \end{sloppypar}
!   \item[{[status]}]
!    \begin{sloppypar}
!    The file status. Please see Section~\ref{const:filestatusflag} for
!    the list of options. If not present, defaults to
!    {\tt ESMF\_FILESTATUS\_UNKNOWN}.
!    \end{sloppypar}
!   \item[{[timeslice]}]
!    \begin{sloppypar}
!    Some I/O formats (e.g. NetCDF) support the output of data in form of
!    time slices.  An unlimited dimension called {\tt time} is defined in the
!    file variable for this capability.
!    The {\tt timeslice} argument provides access to the {\tt time} dimension,
!    and must have a positive value. The behavior of this
!    option may depend on the setting of the {\tt overwrite} flag:
!    \begin{description}
!    \item[{\tt overwrite = .false.}:]\ If the timeslice value is
!    less than the maximum time already in the file, the write will fail.
!    \item[{\tt overwrite = .true.}:]\ Any positive timeslice value is valid.
!    \end{description}
!    By default, i.e. by omitting the {\tt timeslice} argument, no
!    provisions for time slicing are made in the output file,
!    however, if the file already contains a time axis for the variable,
!    a timeslice one greater than the maximum will be written.
!    \end{sloppypar}
!   \item[{[iofmt]}]
!    \begin{sloppypar}
!    The I/O format.  Please see Section~\ref{opt:iofmtflag} for the list
!    of options. If not present, defaults to {\tt ESMF\_IOFMT\_NETCDF}.
!    \end{sloppypar}
!   \item[{[rc]}]
!    Return code; equals {\tt ESMF\_SUCCESS} if there are no errors.
!  \end{description}
!
!EOP
!------------------------------------------------------------------------------

    ! Local vars
    integer                    :: localrc           ! local return code
    type(ESMF_Logical)         :: opt_overwriteflag ! helper variable
    type(ESMF_FileStatus_Flag) :: opt_status        ! helper variable
    type(ESMF_IOFmt_Flag)      :: opt_iofmt         ! helper variable
    integer                    :: file_ext_p
    integer                    :: ndims

    ! Initialize return code; assume routine not implemented
    localrc = ESMF_RC_NOT_IMPL
    if (present(rc)) rc = ESMF_RC_NOT_IMPL

#ifdef ESMF_PIO

    ! Check init status of arguments
    ESMF_INIT_CHECK_DEEP(ESMF_ArrayGetInit, array, rc)

    ! Set default flags
    opt_overwriteflag = ESMF_FALSE
    if (present(overwrite)) opt_overwriteflag = overwrite

    opt_status = ESMF_FILESTATUS_UNKNOWN
    if (present(status)) opt_status = status

    ! Set iofmt based on file name extension (if present)
    if (present (iofmt)) then
      opt_iofmt = iofmt
    else
      opt_iofmt = ESMF_IOFMT_NETCDF
    end if

    ! Attributes

    if (present (convention) .neqv. present (purpose)) then
      if (ESMF_LogFoundError (ESMF_RC_ARG_WRONG,  &
          msg='Both convention and purpose must be specified',  &
          ESMF_CONTEXT, rcToReturn=rc)) return
    end if

    ! Call into the C++ interface, which will call IO object
    call c_esmc_arraywrite(array, fileName,  &
        variableName, convention, purpose,  &
        opt_overwriteflag,          &
        opt_status, timeslice, opt_iofmt, localrc)
    if (ESMF_LogFoundError(localrc, ESMF_ERR_PASSTHRU,  &
        ESMF_CONTEXT, rcToReturn=rc)) return

    ! Return successfully
    if (present(rc)) rc = ESMF_SUCCESS

#else
    ! Return indicating PIO not present
    call ESMF_LogSetError(rcToCheck=ESMF_RC_LIB_NOT_PRESENT, &
      msg="ESMF must be compiled with PIO support to support I/O methods", &
      ESMF_CONTEXT, rcToReturn=rc)
#endif

  end subroutine ESMF_ArrayWrite
!------------------------------------------------------------------------------

end module ESMF_ArrayMod
