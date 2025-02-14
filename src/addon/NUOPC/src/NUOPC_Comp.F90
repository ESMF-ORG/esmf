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
#define FILENAME "src/addon/NUOPC/src/NUOPC_Comp.F90"
!==============================================================================

module NUOPC_Comp

  use ESMF
  use NUOPC_FreeFormatDef
  use NUOPC_Base

  implicit none
  
  private
  
  ! public module interfaces
  public NUOPC_CompAreServicesSet
  public NUOPC_CompAttributeAdd
  public NUOPC_CompAttributeEgest
  public NUOPC_CompAttributeGet
  public NUOPC_CompAttributeIngest
  public NUOPC_CompAttributeInit
  public NUOPC_CompAttributeReset
  public NUOPC_CompAttributeSet
  public NUOPC_CompCheckSetClock
  public NUOPC_CompDerive
  public NUOPC_CompFilterPhaseMap
  public NUOPC_CompGet
  public NUOPC_CompSearchPhaseMap
  public NUOPC_CompSearchRevPhaseMap
  public NUOPC_CompSetClock
  public NUOPC_CompSetEntryPoint
  public NUOPC_CompSetInternalEntryPoint
  public NUOPC_CompSetServices
  public NUOPC_CompSetVM
  public NUOPC_CompSpecialize

  ! public labels
  public &
    label_ExternalAdvertise, &
    label_ExternalRealize, &
    label_ExternalDataInit, &
    label_ExternalReset

  ! interface blocks
  interface NUOPC_CompAreServicesSet
    module procedure NUOPC_GridCompAreServicesSet
    module procedure NUOPC_CplCompAreServicesSet
  end interface
  !---------------------------------------------
  interface NUOPC_CompAttributeAdd
    module procedure NUOPC_GridCompAttributeAdd
    module procedure NUOPC_CplCompAttributeAdd
  end interface
  !---------------------------------------------
  interface NUOPC_CompAttributeEgest
    module procedure NUOPC_GridCompAttributeEge
    module procedure NUOPC_CplCompAttributeEge
  end interface
  !---------------------------------------------
  interface NUOPC_CompAttributeGet
    module procedure NUOPC_GridCompAttributeGet
    module procedure NUOPC_CplCompAttributeGet
    module procedure NUOPC_GridCompAttributeGetI
    module procedure NUOPC_CplCompAttributeGetI
    module procedure NUOPC_GridCompAttributeGetSL
    module procedure NUOPC_CplCompAttributeGetSL
    module procedure NUOPC_GridCompAttributeGetIL
    module procedure NUOPC_CplCompAttributeGetIL
  end interface
  !---------------------------------------------
  interface NUOPC_CompAttributeIngest
    module procedure NUOPC_GridCompAttributeIng
    module procedure NUOPC_CplCompAttributeIng
    module procedure NUOPC_GridCompAttributeIngHC
    module procedure NUOPC_CplCompAttributeIngHC
  end interface
  !---------------------------------------------
  interface NUOPC_CompAttributeInit
    module procedure NUOPC_GridCompAttributeInit
    module procedure NUOPC_CplCompAttributeInit
  end interface
  !---------------------------------------------
  interface NUOPC_CompAttributeReset
    module procedure NUOPC_GridCompAttributeReset
    module procedure NUOPC_CplCompAttributeReset
  end interface
  !---------------------------------------------
  interface NUOPC_CompAttributeSet
    module procedure NUOPC_GridCompAttributeSetS
    module procedure NUOPC_CplCompAttributeSetS
    module procedure NUOPC_GridCompAttributeSetI
    module procedure NUOPC_CplCompAttributeSetI
    module procedure NUOPC_GridCompAttributeSetSL
    module procedure NUOPC_CplCompAttributeSetSL
  end interface
  !---------------------------------------------
  interface NUOPC_CompCheckSetClock
    module procedure NUOPC_GridCompCheckSetClock
  end interface
  !---------------------------------------------
  interface NUOPC_CompDerive
    module procedure NUOPC_GridCompDerive
    module procedure NUOPC_CplCompDerive
  end interface
  !---------------------------------------------
  interface NUOPC_CompFilterPhaseMap
    module procedure NUOPC_GridCompFilterPhaseMap
    module procedure NUOPC_CplCompFilterPhaseMap
  end interface
  !---------------------------------------------
  interface NUOPC_CompGet
    module procedure NUOPC_GridCompGet
    module procedure NUOPC_CplCompGet
  end interface
  !---------------------------------------------
  interface NUOPC_CompSearchPhaseMap
    module procedure NUOPC_GridCompSearchPhaseMap
    module procedure NUOPC_CplCompSearchPhaseMap
  end interface
  !---------------------------------------------
  interface NUOPC_CompSearchRevPhaseMap
    module procedure NUOPC_GridCompSearchRevPhaseMap
    module procedure NUOPC_CplCompSearchRevPhaseMap
  end interface
  !---------------------------------------------
  interface NUOPC_CompSetClock
    module procedure NUOPC_GridCompSetClock
  end interface
  !---------------------------------------------
  interface NUOPC_CompSetEntryPoint
    module procedure NUOPC_GridCompSetEntryPoint
    module procedure NUOPC_CplCompSetEntryPoint
  end interface
  !---------------------------------------------
  interface NUOPC_CompSetInternalEntryPoint
    module procedure NUOPC_GridCompSetIntEntryPoint
  end interface
  !---------------------------------------------
  interface NUOPC_CompSetServices
    module procedure NUOPC_GridCompSetServices
  end interface
  !---------------------------------------------
  interface NUOPC_CompSetVM
    module procedure NUOPC_GridCompSetVM
  end interface
  !---------------------------------------------
  interface NUOPC_CompSpecialize
    module procedure NUOPC_GridCompSpecialize
    module procedure NUOPC_CplCompSpecialize
  end interface

  character(*), parameter :: &
    label_ExternalAdvertise = "ExternalAdvertise"
  character(*), parameter :: &
    label_ExternalRealize = "ExternalRealize"
  character(*), parameter :: &
    label_ExternalDataInit = "ExternalDataInitialize"
  character(*), parameter :: &
    label_ExternalReset = "ExternalFinalizeReset"

  !-----------------------------------------------------------------------------
  contains
  !-----------------------------------------------------------------------------
  
  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompAreServicesSet - Check if SetServices was called
! !INTERFACE:
  ! Private name; call using NUOPC_CompAreServicesSet() 
  function NUOPC_GridCompAreServicesSet(comp, rc)
! !RETURN VALUE:
    logical :: NUOPC_GridCompAreServicesSet
! !ARGUMENTS:
    type(ESMF_GridComp), intent(in)            :: comp
    integer,             intent(out), optional :: rc
! !DESCRIPTION:
!   Return {\tt .true.} if SetServices has been called for {\tt comp}. 
!   Otherwise return {\tt .false.}.
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                 :: localrc
    type(ESMF_Pointer)      :: vm_info
    
    if (present(rc)) rc = ESMF_SUCCESS
    
    ! early bail out condition if incoming component is not valid
    if (.not.associated(comp%compp)) then
      NUOPC_GridCompAreServicesSet = .false.
      return
    endif
    
    ! get the vm_info
    call ESMF_CompGet(comp%compp, vm_info=vm_info, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
      
    if (vm_info == ESMF_NULL_POINTER) then
      NUOPC_GridCompAreServicesSet = .false.
    else
      NUOPC_GridCompAreServicesSet = .true.
    endif
      
  end function
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompAreServicesSet - Check if SetServices was called
! !INTERFACE:
  ! Private name; call using NUOPC_CompAreServicesSet() 
  function NUOPC_CplCompAreServicesSet(comp, rc)
! !RETURN VALUE:
    logical :: NUOPC_CplCompAreServicesSet
! !ARGUMENTS:
    type(ESMF_CplComp), intent(in)            :: comp
    integer,            intent(out), optional :: rc
! !DESCRIPTION:
!   Return {\tt .true.} if SetServices has been called for {\tt comp}.
!   Otherwise return {\tt .false.}.
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                 :: localrc
    type(ESMF_Pointer)      :: vm_info
    
    if (present(rc)) rc = ESMF_SUCCESS
    
    ! early bail out condition if incoming component is not valid
    if (.not.associated(comp%compp)) then
      NUOPC_CplCompAreServicesSet = .false.
      return
    endif

    ! get the vm_info
    call ESMF_CompGet(comp%compp, vm_info=vm_info, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
      
    if (vm_info == ESMF_NULL_POINTER) then
      NUOPC_CplCompAreServicesSet = .false.
    else
      NUOPC_CplCompAreServicesSet = .true.
    endif
      
  end function
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompAttributeAdd - Add NUOPC GridComp Attributes
! !INTERFACE:
  ! Private name; call using NUOPC_CompAttributeAdd() 
  subroutine NUOPC_GridCompAttributeAdd(comp, attrList, rc)
! !ARGUMENTS:
    type(ESMF_GridComp)                       :: comp
    character(len=*),   intent(in)            :: attrList(:)
    integer,            intent(out), optional :: rc
! !DESCRIPTION:
!   Add Attributes to the highest level of the standard NUOPC AttPack
!   hierarchy (convention="NUOPC", purpose="Instance").
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                 :: localrc

    if (present(rc)) rc = ESMF_SUCCESS
    
    call ESMF_AttributeAdd(comp, convention="NUOPC", purpose="Instance", &
      attrList=attrList, rc=localrc)

    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out
      
  end subroutine
  !-----------------------------------------------------------------------------
  
  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompAttributeAdd - Add NUOPC CplComp Attributes
! !INTERFACE:
  ! Private name; call using NUOPC_CompAttributeAdd() 
  subroutine NUOPC_CplCompAttributeAdd(comp, attrList, rc)
! !ARGUMENTS:
    type(ESMF_CplComp)                        :: comp
    character(len=*),   intent(in)            :: attrList(:)
    integer,            intent(out), optional :: rc
! !DESCRIPTION:
!   Add Attributes to the highest level of the standard NUOPC AttPack
!   hierarchy (convention="NUOPC", purpose="Instance").
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                 :: localrc

    if (present(rc)) rc = ESMF_SUCCESS
    
    call ESMF_AttributeAdd(comp, convention="NUOPC", purpose="Instance", &
      attrList=attrList, rc=localrc)

    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out
      
  end subroutine
  !-----------------------------------------------------------------------------
  
  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompAttributeEgest - Egest NUOPC GridComp Attributes in FreeFormat
! !INTERFACE:
  ! Private name; call using NUOPC_CompAttributeEgest() 
  subroutine NUOPC_GridCompAttributeEge(comp, freeFormat, rc)
! !ARGUMENTS:
    type(ESMF_GridComp),    intent(in)            :: comp
    type(NUOPC_FreeFormat), intent(out)           :: freeFormat
    integer,                intent(out), optional :: rc
! !DESCRIPTION:
!   Egest the Attributes of the highest level of the standard NUOPC AttPack
!   hierarchy (convention="NUOPC", purpose="Instance") as a FreeFormat object.
!   It is the caller's responsibility to destroy the created {\tt freeFormat}
!   object.
!EOP
  !-----------------------------------------------------------------------------
    character(ESMF_MAXSTR)                          :: name
    integer                                         :: localrc
    integer                                         :: stat, i, attrCount
    character(len=NUOPC_FreeFormatLen), allocatable :: stringList(:)
    character(len=NUOPC_FreeFormatLen)              :: tempString
    logical                                         :: isPresent
    type(ESMF_TypeKind_Flag)                        :: tk
    integer                                         :: k, itemCount
    character(len=80), allocatable                  :: valueSL(:)
    integer, allocatable                            :: valueIL(:)

    if (present(rc)) rc = ESMF_SUCCESS

    ! query the Component for info
    call ESMF_GridCompGet(comp, name=name, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    
    ! query attrCount
    call ESMF_AttributeGet(comp, convention="NUOPC", purpose="Instance", &
      count=attrCount, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out

    allocate(stringList(attrCount), stat=stat)
    if (ESMF_LogFoundAllocError(statusToCheck=stat, msg="stringList.", &
      line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out

    do i=1, attrCount
      ! pull out the name of the attribute
      call ESMF_AttributeGet(comp, convention="NUOPC", purpose="Instance", &
        attributeIndex=i, name=stringList(i), &
        isPresent=isPresent, typekind=tk, rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
      if (.not.isPresent .or. (tk==ESMF_NOKIND)) cycle
      call ESMF_AttributeGet(comp, convention="NUOPC", purpose="Instance", &
        attributeIndex=i, name=stringList(i), &
        typekind=tk, itemCount=itemCount, rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
      if (tk==ESMF_TYPEKIND_CHARACTER) then
        allocate(valueSL(itemCount))
        call NUOPC_CompAttributeGet(comp, name=stringList(i), &
          valueList=valueSL, rc=localrc)
        if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
          line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
        tempString=stringList(i)
        tempString=trim(tempString)//" = "
        do k=1, itemCount
          tempString=trim(tempString)//" "//valueSL(k)
        enddo
        deallocate(valueSL, stat=stat)
        if (ESMF_LogFoundDeallocError(statusToCheck=stat, &
          msg="Deallocation of valueSL.", &
          line=__LINE__, &
          file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
        stringList(i)=trim(adjustl(tempString))
      elseif (tk==ESMF_TYPEKIND_I4) then
        allocate(valueIL(itemCount))
        call NUOPC_CompAttributeGet(comp, name=stringList(i), &
          valueList=valueIL, rc=localrc)
        if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
          line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
        tempString=stringList(i)
        tempString=trim(tempString)//" = "
        do k=1, itemCount
          write(tempString, *) trim(tempString)//" ", valueIL(k)
        enddo
        deallocate(valueIL, stat=stat)
        if (ESMF_LogFoundDeallocError(statusToCheck=stat, &
          msg="Deallocation of valueIL.", &
          line=__LINE__, &
          file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
        stringList(i)=trim(adjustl(tempString))
      endif
    enddo

    freeFormat = NUOPC_FreeFormatCreate(stringList=stringList, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    
    deallocate(stringList, stat=stat)
    if (ESMF_LogFoundDeallocError(statusToCheck=stat, &
      msg="Deallocation stringList.", &
      line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out

  end subroutine
  !-----------------------------------------------------------------------------
  
  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompAttributeEgest - Egest NUOPC CplComp Attributes in FreeFormat
! !INTERFACE:
  ! Private name; call using NUOPC_CompAttributeEgest() 
  subroutine NUOPC_CplCompAttributeEge(comp, freeFormat, rc)
! !ARGUMENTS:
    type(ESMF_CplComp),     intent(in)            :: comp
    type(NUOPC_FreeFormat), intent(out)           :: freeFormat
    integer,                intent(out), optional :: rc
! !DESCRIPTION:
!   Egest the Attributes of the highest level of the standard NUOPC AttPack
!   hierarchy (convention="NUOPC", purpose="Instance") as a FreeFormat object.
!   It is the caller's responsibility to destroy the created {\tt freeFormat}
!   object.
!EOP
  !-----------------------------------------------------------------------------
    character(ESMF_MAXSTR)                          :: name
    integer                                         :: localrc
    integer                                         :: stat, i, attrCount
    character(len=NUOPC_FreeFormatLen), allocatable :: stringList(:)
    character(len=NUOPC_FreeFormatLen)              :: tempString
    logical                                         :: isPresent
    type(ESMF_TypeKind_Flag)                        :: tk
    integer                                         :: k, itemCount
    character(len=80), allocatable                  :: valueSL(:)
    integer, allocatable                            :: valueIL(:)
    
    if (present(rc)) rc = ESMF_SUCCESS

    ! query the Component for info
    call ESMF_CplCompGet(comp, name=name, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    
    ! query attrCount
    call ESMF_AttributeGet(comp, convention="NUOPC", purpose="Instance", &
      count=attrCount, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out

    allocate(stringList(attrCount), stat=stat)
    if (ESMF_LogFoundAllocError(statusToCheck=stat, msg="stringList.", &
      line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out

    do i=1, attrCount
      ! pull out the name of the attribute
      call ESMF_AttributeGet(comp, convention="NUOPC", purpose="Instance", &
        attributeIndex=i, name=stringList(i), &
        isPresent=isPresent, typekind=tk, rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
      if (.not.isPresent .or. (tk==ESMF_NOKIND)) cycle
      call ESMF_AttributeGet(comp, convention="NUOPC", purpose="Instance", &
        attributeIndex=i, name=stringList(i), &
        typekind=tk, itemCount=itemCount, rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
      if (tk==ESMF_TYPEKIND_CHARACTER) then
        allocate(valueSL(itemCount))
        call NUOPC_CompAttributeGet(comp, name=stringList(i), &
          valueList=valueSL, rc=localrc)
        if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
          line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
        tempString=stringList(i)
        tempString=trim(tempString)//" = "
        do k=1, itemCount
          tempString=trim(tempString)//" "//valueSL(k)
        enddo
        deallocate(valueSL, stat=stat)
        if (ESMF_LogFoundDeallocError(statusToCheck=stat, &
          msg="Deallocation of valueSL.", &
          line=__LINE__, &
          file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
        stringList(i)=trim(adjustl(tempString))
      elseif (tk==ESMF_TYPEKIND_I4) then
        allocate(valueIL(itemCount))
        call NUOPC_CompAttributeGet(comp, name=stringList(i), &
          valueList=valueIL, rc=localrc)
        if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
          line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
        tempString=stringList(i)
        tempString=trim(tempString)//" = "
        do k=1, itemCount
          write(tempString, *) trim(tempString)//" ", valueIL(k)
        enddo
        deallocate(valueIL, stat=stat)
        if (ESMF_LogFoundDeallocError(statusToCheck=stat, &
          msg="Deallocation of valueIL.", &
          line=__LINE__, &
          file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
        stringList(i)=trim(adjustl(tempString))
      endif
    enddo
    
    freeFormat = NUOPC_FreeFormatCreate(stringList=stringList, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    
    deallocate(stringList, stat=stat)
    if (ESMF_LogFoundDeallocError(statusToCheck=stat, &
      msg="Deallocation of stringList.", &
      line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out

  end subroutine
  !-----------------------------------------------------------------------------
  
  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompAttributeGet - Get a NUOPC GridComp Attribute - string
! !INTERFACE:
  ! Private name; call using NUOPC_CompAttributeGet() 
  subroutine NUOPC_GridCompAttributeGet(comp, name, value, isPresent, isSet, rc)
! !ARGUMENTS:
    type(ESMF_GridComp), intent(in)            :: comp
    character(*),        intent(in)            :: name
    character(*),        intent(out)           :: value
    logical,             intent(out), optional :: isPresent
    logical,             intent(out), optional :: isSet
    integer,             intent(out), optional :: rc
! !DESCRIPTION:
!   Access the attribute {\tt name} inside of {\tt comp} using the
!   convention {\tt NUOPC} and purpose {\tt Instance}.
!
!   This call assumes to find a scalar value. An error is returned otherwise.
!
!   This call concverts to a string value, regardless of the actual attribute
!   storage.
!
!   Unless {\tt isPresent} and {\tt isSet} are provided, return with error if 
!   the attribute is not present or not set, respectively.
!
!   The arguments are:
!   \begin{description}
!   \item[comp]
!     The {\tt ESMF\_GridComp} object to be queried.
!   \item[name]
!     The name of the queried attribute.
!   \item[value]
!     The value of the queried attribute.
!   \item[{[isPresent]}]
!     Set to {\tt .true.} if the queried attribute is present, {\tt .false.}
!     otherwise.
!   \item[{[isSet]}]
!     Set to {\tt .true.} if the queried attribute is set, {\tt .false.}
!     otherwise.
!   \item[{[rc]}]
!     Return code; equals {\tt ESMF\_SUCCESS} if there are no errors.
!   \end{description}
!
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                 :: localrc
    type(ESMF_Info)         :: info
    type(ESMF_TypeKind_Flag):: tk
    integer(ESMF_KIND_I4)   :: valueI4
    integer(ESMF_KIND_I8)   :: valueI8
    real(ESMF_KIND_R4)      :: valueR4
    real(ESMF_KIND_R8)      :: valueR8
    logical                 :: valueL

    if (present(rc)) rc = ESMF_SUCCESS

    call ESMF_InfoGetFromHost(comp, info=info, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out

    if (present(isSet)) isSet = .false.
    value = ""

    if (present(isPresent)) then
      isPresent = ESMF_InfoIsPresent(info, key="/NUOPC/Instance/"//name, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      if (.not.isPresent) return ! early successful return
    endif

    if (present(isSet)) then
      isSet = ESMF_InfoIsSet(info, key="/NUOPC/Instance/"//name, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      if (.not.isSet) return ! early successful return
    endif

    tk = ESMF_InfoGetTK(info, key="/NUOPC/Instance/"//name, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out

    if (tk==ESMF_TYPEKIND_CHARACTER) then
      call ESMF_InfoGet(info, key="/NUOPC/Instance/"//name, value=value, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
    else if (tk==ESMF_TYPEKIND_LOGICAL) then
      call ESMF_InfoGet(info, key="/NUOPC/Instance/"//name, value=valueL, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      write(value,*) valueL
    else if (tk==ESMF_TYPEKIND_I4) then
      call ESMF_InfoGet(info, key="/NUOPC/Instance/"//name, value=valueI4, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      write(value,*) valueI4
    else if (tk==ESMF_TYPEKIND_I8) then
      call ESMF_InfoGet(info, key="/NUOPC/Instance/"//name, value=valueI8, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      write(value,*) valueI8
    else if (tk==ESMF_TYPEKIND_R4) then
      call ESMF_InfoGet(info, key="/NUOPC/Instance/"//name, value=valueR4, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      write(value,*) valueR4
    else if (tk==ESMF_TYPEKIND_R8) then
      call ESMF_InfoGet(info, key="/NUOPC/Instance/"//name, value=valueR8, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      write(value,*) valueR8
    else if (tk==ESMF_NOKIND) then
      call ESMF_LogSetError(rcToCheck=ESMF_RC_ARG_BAD, &
        msg="Unable to retrieve value. Either invalid name or value not set.", &
        line=__LINE__, file=FILENAME, rcToReturn=rc)
      return
    else
      call ESMF_LogSetError(rcToCheck=ESMF_RC_ARG_BAD, &
        msg="Unsupported typekind", &
        line=__LINE__, file=FILENAME, rcToReturn=rc)
      return
    endif

  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompAttributeGet - Get a NUOPC CplComp Attribute - string
! !INTERFACE:
  ! Private name; call using NUOPC_CompAttributeGet() 
  subroutine NUOPC_CplCompAttributeGet(comp, name, value, isPresent, isSet, rc)
! !ARGUMENTS:
    type(ESMF_CplComp),  intent(in)            :: comp
    character(*),        intent(in)            :: name
    character(*),        intent(out)           :: value
    logical,             intent(out), optional :: isPresent
    logical,             intent(out), optional :: isSet
    integer,             intent(out), optional :: rc
! !DESCRIPTION:
!   Access the attribute {\tt name} inside of {\tt comp} using the
!   convention {\tt NUOPC} and purpose {\tt Instance}.
!
!   This call assumes to find a scalar value. An error is returned otherwise.
!
!   This call concverts to a string value, regardless of the actual attribute
!   storage.
!
!   Unless {\tt isPresent} and {\tt isSet} are provided, return with error if 
!   the attribute is not present or not set, respectively.
!
!   The arguments are:
!   \begin{description}
!   \item[comp]
!     The {\tt ESMF\_CplComp} object to be queried.
!   \item[name]
!     The name of the queried attribute.
!   \item[value]
!     The value of the queried attribute.
!   \item[{[isPresent]}]
!     Set to {\tt .true.} if the queried attribute is present, {\tt .false.}
!     otherwise.
!   \item[{[isSet]}]
!     Set to {\tt .true.} if the queried attribute is set, {\tt .false.}
!     otherwise.
!   \item[{[rc]}]
!     Return code; equals {\tt ESMF\_SUCCESS} if there are no errors.
!   \end{description}
!
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                 :: localrc
    type(ESMF_Info)         :: info
    type(ESMF_TypeKind_Flag):: tk
    integer(ESMF_KIND_I4)   :: valueI4
    integer(ESMF_KIND_I8)   :: valueI8
    real(ESMF_KIND_R4)      :: valueR4
    real(ESMF_KIND_R8)      :: valueR8
    logical                 :: valueL

    if (present(rc)) rc = ESMF_SUCCESS

    call ESMF_InfoGetFromHost(comp, info=info, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out

    if (present(isSet)) isSet = .false.
    value = ""

    if (present(isPresent)) then
      isPresent = ESMF_InfoIsPresent(info, key="/NUOPC/Instance/"//name, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      if (.not.isPresent) return ! early successful return
    endif

    if (present(isSet)) then
      isSet = ESMF_InfoIsSet(info, key="/NUOPC/Instance/"//name, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      if (.not.isSet) return ! early successful return
    endif

    tk = ESMF_InfoGetTK(info, key="/NUOPC/Instance/"//name, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out

    if (tk==ESMF_TYPEKIND_CHARACTER) then
      call ESMF_InfoGet(info, key="/NUOPC/Instance/"//name, value=value, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
    else if (tk==ESMF_TYPEKIND_LOGICAL) then
      call ESMF_InfoGet(info, key="/NUOPC/Instance/"//name, value=valueL, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      write(value,*) valueL
    else if (tk==ESMF_TYPEKIND_I4) then
      call ESMF_InfoGet(info, key="/NUOPC/Instance/"//name, value=valueI4, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      write(value,*) valueI4
    else if (tk==ESMF_TYPEKIND_I8) then
      call ESMF_InfoGet(info, key="/NUOPC/Instance/"//name, value=valueI8, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      write(value,*) valueI8
    else if (tk==ESMF_TYPEKIND_R4) then
      call ESMF_InfoGet(info, key="/NUOPC/Instance/"//name, value=valueR4, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      write(value,*) valueR4
    else if (tk==ESMF_TYPEKIND_R8) then
      call ESMF_InfoGet(info, key="/NUOPC/Instance/"//name, value=valueR8, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      write(value,*) valueR8
    else if (tk==ESMF_NOKIND) then
      call ESMF_LogSetError(rcToCheck=ESMF_RC_ARG_BAD, &
        msg="Unable to retrieve value. Either invalid name or value not set.", &
        line=__LINE__, file=FILENAME, rcToReturn=rc)
      return
    else
      call ESMF_LogSetError(rcToCheck=ESMF_RC_ARG_BAD, &
        msg="Unsupported typekind", &
        line=__LINE__, file=FILENAME, rcToReturn=rc)
      return
    endif

  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompAttributeGet - Get a NUOPC GridComp Attribute - integer
! !INTERFACE:
  ! Private name; call using NUOPC_CompAttributeGet() 
  subroutine NUOPC_GridCompAttributeGetI(comp, name, value, isPresent, isSet, rc)
! !ARGUMENTS:
    type(ESMF_GridComp), intent(in)            :: comp
    character(*),        intent(in)            :: name
    integer,             intent(out)           :: value
    logical,             intent(out), optional :: isPresent
    logical,             intent(out), optional :: isSet
    integer,             intent(out), optional :: rc
! !DESCRIPTION:
!   Access the attribute {\tt name} inside of {\tt comp} using the
!   convention {\tt NUOPC} and purpose {\tt Instance}.
!
!   Unless {\tt isPresent} and {\tt isSet} are provided, return with error if 
!   the attribute is not present or not set, respectively.
!
!   The arguments are:
!   \begin{description}
!   \item[comp]
!     The {\tt ESMF\_GridComp} object to be queried.
!   \item[name]
!     The name of the queried attribute.
!   \item[value]
!     The value of the queried attribute.
!   \item[{[isPresent]}]
!     Set to {\tt .true.} if the queried attribute is present, {\tt .false.}
!     otherwise.
!   \item[{[isSet]}]
!     Set to {\tt .true.} if the queried attribute is set, {\tt .false.}
!     otherwise.
!   \item[{[rc]}]
!     Return code; equals {\tt ESMF\_SUCCESS} if there are no errors.
!   \end{description}
!
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                 :: localrc
    type(ESMF_Info)         :: info

    if (present(rc)) rc = ESMF_SUCCESS

    call ESMF_InfoGetFromHost(comp, info=info, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out

    if (present(isSet)) isSet = .false.

    if (present(isPresent)) then
      isPresent = ESMF_InfoIsPresent(info, key="/NUOPC/Instance/"//name, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      if (.not.isPresent) return ! early successful return
    endif

    if (present(isSet)) then
      isSet = ESMF_InfoIsSet(info, key="/NUOPC/Instance/"//name, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      if (.not.isSet) return ! early successful return
    endif

    call ESMF_InfoGet(info, key="/NUOPC/Instance/"//name, value=value, &
      rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out

  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompAttributeGet - Get a NUOPC CplComp Attribute - integer
! !INTERFACE:
  ! Private name; call using NUOPC_CompAttributeGet() 
  subroutine NUOPC_CplCompAttributeGetI(comp, name, value, isPresent, isSet, rc)
! !ARGUMENTS:
    type(ESMF_CplComp),  intent(in)            :: comp
    character(*),        intent(in)            :: name
    integer,             intent(out)           :: value
    logical,             intent(out), optional :: isPresent
    logical,             intent(out), optional :: isSet
    integer,             intent(out), optional :: rc
! !DESCRIPTION:
!   Access the attribute {\tt name} inside of {\tt comp} using the
!   convention {\tt NUOPC} and purpose {\tt Instance}.
!
!   Unless {\tt isPresent} and {\tt isSet} are provided, return with error if 
!   the attribute is not present or not set, respectively.
!
!   The arguments are:
!   \begin{description}
!   \item[comp]
!     The {\tt ESMF\_CplComp} object to be queried.
!   \item[name]
!     The name of the queried attribute.
!   \item[value]
!     The value of the queried attribute.
!   \item[{[isPresent]}]
!     Set to {\tt .true.} if the queried attribute is present, {\tt .false.}
!     otherwise.
!   \item[{[isSet]}]
!     Set to {\tt .true.} if the queried attribute is set, {\tt .false.}
!     otherwise.
!   \item[{[rc]}]
!     Return code; equals {\tt ESMF\_SUCCESS} if there are no errors.
!   \end{description}
!
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                 :: localrc
    type(ESMF_Info)         :: info

    if (present(rc)) rc = ESMF_SUCCESS

    call ESMF_InfoGetFromHost(comp, info=info, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out

    if (present(isSet)) isSet = .false.

    if (present(isPresent)) then
      isPresent = ESMF_InfoIsPresent(info, key="/NUOPC/Instance/"//name, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      if (.not.isPresent) return ! early successful return
    endif

    if (present(isSet)) then
      isSet = ESMF_InfoIsSet(info, key="/NUOPC/Instance/"//name, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      if (.not.isSet) return ! early successful return
    endif

    call ESMF_InfoGet(info, key="/NUOPC/Instance/"//name, value=value, &
      rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out

  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompAttributeGet - Get a NUOPC GridComp Attribute - string list
! !INTERFACE:
  ! Private name; call using NUOPC_CompAttributeGet() 
  subroutine NUOPC_GridCompAttributeGetSL(comp, name, valueList, isPresent, &
    isSet, itemCount, typekind, rc)
! !ARGUMENTS:
    type(ESMF_GridComp),       intent(in)            :: comp
    character(*),              intent(in)            :: name
    character(*),              intent(out), optional :: valueList(:)
    logical,                   intent(out), optional :: isPresent
    logical,                   intent(out), optional :: isSet
    integer,                   intent(out), optional :: itemCount
    type(ESMF_TypeKind_Flag),  intent(out), optional :: typekind
    integer,                   intent(out), optional :: rc
! !DESCRIPTION:
!   Access the attribute {\tt name} inside of {\tt comp} using the
!   convention {\tt NUOPC} and purpose {\tt Instance}. Returns with error if
!   the attribute is not present or not set.
!
!   Unless {\tt isPresent} and {\tt isSet} are provided, return with error if 
!   the attribute is not present or not set, respectively.
!
!   The arguments are:
!   \begin{description}
!   \item[comp]
!     The {\tt ESMF\_GridComp} object to be queried.
!   \item[name]
!     The name of the queried attribute.
!   \item[{[valueList]}]
!     The list of values of the queried attribute.
!   \item[{[isPresent]}]
!     Set to {\tt .true.} if the queried attribute is present, {\tt .false.}
!     otherwise.
!   \item[{[isSet]}]
!     Set to {\tt .true.} if the queried attribute is set, {\tt .false.}
!     otherwise.
!   \item[{[itemCount]}]
!     Number of items in the attribute. Return 0 if not present or not set.
!   \item[{[typekind]}]
!     The typekind of the queried attribute.
!   \item[{[rc]}]
!     Return code; equals {\tt ESMF\_SUCCESS} if there are no errors.
!   \end{description}
!
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                 :: localrc
    type(ESMF_Info)         :: info
    logical                 :: isArray

    if (present(rc)) rc = ESMF_SUCCESS

    call ESMF_InfoGetFromHost(comp, info=info, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out

    if (present(isSet)) isSet = .false.
    if (present(itemCount)) itemCount = 0
    if (present(typekind)) typekind = ESMF_NOKIND

    if (present(isPresent)) then
      isPresent = ESMF_InfoIsPresent(info, key="/NUOPC/Instance/"//name, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      if (.not.isPresent) return ! early successful return
    endif

    if (present(isSet)) then
      isSet = ESMF_InfoIsSet(info, key="/NUOPC/Instance/"//name, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      if (.not.isSet) return ! early successful return
    endif

    if (present(itemCount)) then
      call ESMF_InfoGet(info,  key="/NUOPC/Instance/"//name, size=itemCount, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
    endif

    if (present(typekind)) then
      typekind = ESMF_InfoGetTK(info, key="/NUOPC/Instance/"//name, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      if (.not.isSet) return ! early successful return
    endif

    if (present(valueList)) then
      call ESMF_InfoGet(info, key="/NUOPC/Instance/"//name, &
        isArray=isArray, rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      if (isArray) then
        call ESMF_InfoGet(info, key="/NUOPC/Instance/"//name, &
          values=valueList, rc=localrc)
        if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
          line=__LINE__, &
          file=FILENAME, &
          rcToReturn=rc)) &
          return  ! bail out
      else
        call ESMF_InfoGet(info, key="/NUOPC/Instance/"//name, &
          value=valueList(1), rc=localrc)
        if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
          line=__LINE__, &
          file=FILENAME, &
          rcToReturn=rc)) &
          return  ! bail out
      endif
    endif

  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompAttributeGet - Get a NUOPC CplComp Attribute - string list
! !INTERFACE:
  ! Private name; call using NUOPC_CompAttributeGet() 
  subroutine NUOPC_CplCompAttributeGetSL(comp, name, valueList, isPresent, &
    isSet, itemCount, typekind, rc)
! !ARGUMENTS:
    type(ESMF_CplComp),       intent(in)            :: comp
    character(*),             intent(in)            :: name
    character(*),             intent(out), optional :: valueList(:)
    logical,                  intent(out), optional :: isPresent
    logical,                  intent(out), optional :: isSet
    integer,                  intent(out), optional :: itemCount
    type(ESMF_TypeKind_Flag), intent(out), optional :: typekind
    integer,                  intent(out), optional :: rc
! !DESCRIPTION:
!   Access the attribute {\tt name} inside of {\tt comp} using the
!   convention {\tt NUOPC} and purpose {\tt Instance}. Returns with error if
!   the attribute is not present or not set.
!
!   Unless {\tt isPresent} and {\tt isSet} are provided, return with error if 
!   the attribute is not present or not set, respectively.
!
!   The arguments are:
!   \begin{description}
!   \item[comp]
!     The {\tt ESMF\_CplComp} object to be queried.
!   \item[name]
!     The name of the queried attribute.
!   \item[{[valueList]}]
!     The list of values of the queried attribute.
!   \item[{[isPresent]}]
!     Set to {\tt .true.} if the queried attribute is present, {\tt .false.}
!     otherwise.
!   \item[{[isSet]}]
!     Set to {\tt .true.} if the queried attribute is set, {\tt .false.}
!     otherwise.
!   \item[{[itemCount]}]
!     Number of items in the attribute. Return 0 if not present or not set.
!   \item[{[typekind]}]
!     The typekind of the queried attribute.
!   \item[{[rc]}]
!     Return code; equals {\tt ESMF\_SUCCESS} if there are no errors.
!   \end{description}
!
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                 :: localrc
    type(ESMF_Info)         :: info
    logical                 :: isArray

    if (present(rc)) rc = ESMF_SUCCESS

    call ESMF_InfoGetFromHost(comp, info=info, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out

    if (present(isSet)) isSet = .false.
    if (present(itemCount)) itemCount = 0
    if (present(typekind)) typekind = ESMF_NOKIND

    if (present(isPresent)) then
      isPresent = ESMF_InfoIsPresent(info, key="/NUOPC/Instance/"//name, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      if (.not.isPresent) return ! early successful return
    endif

    if (present(isSet)) then
      isSet = ESMF_InfoIsSet(info, key="/NUOPC/Instance/"//name, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      if (.not.isSet) return ! early successful return
    endif

    if (present(itemCount)) then
      call ESMF_InfoGet(info,  key="/NUOPC/Instance/"//name, size=itemCount, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
    endif

    if (present(typekind)) then
      typekind = ESMF_InfoGetTK(info, key="/NUOPC/Instance/"//name, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      if (.not.isSet) return ! early successful return
    endif

    if (present(valueList)) then
      call ESMF_InfoGet(info, key="/NUOPC/Instance/"//name, &
        isArray=isArray, rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      if (isArray) then
        call ESMF_InfoGet(info, key="/NUOPC/Instance/"//name, &
          values=valueList, rc=localrc)
        if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
          line=__LINE__, &
          file=FILENAME, &
          rcToReturn=rc)) &
          return  ! bail out
      else
        call ESMF_InfoGet(info, key="/NUOPC/Instance/"//name, &
          value=valueList(1), rc=localrc)
        if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
          line=__LINE__, &
          file=FILENAME, &
          rcToReturn=rc)) &
          return  ! bail out
      endif
    endif

  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompAttributeGet - Get a NUOPC GridComp Attribute - integer list
! !INTERFACE:
  ! Private name; call using NUOPC_CompAttributeGet() 
  subroutine NUOPC_GridCompAttributeGetIL(comp, name, valueList, isPresent, &
    isSet, itemCount, typekind, rc)
! !ARGUMENTS:
    type(ESMF_GridComp),       intent(in)            :: comp
    character(*),              intent(in)            :: name
    integer,                   intent(out)           :: valueList(:)
    logical,                   intent(out), optional :: isPresent
    logical,                   intent(out), optional :: isSet
    integer,                   intent(out), optional :: itemCount
    type(ESMF_TypeKind_Flag),  intent(out), optional :: typekind
    integer,                   intent(out), optional :: rc
! !DESCRIPTION:
!   Access the attribute {\tt name} inside of {\tt comp} using the
!   convention {\tt NUOPC} and purpose {\tt Instance}. Returns with error if
!   the attribute is not present or not set.
!
!   Unless {\tt isPresent} and {\tt isSet} are provided, return with error if 
!   the attribute is not present or not set, respectively.
!
!   The arguments are:
!   \begin{description}
!   \item[comp]
!     The {\tt ESMF\_GridComp} object to be queried.
!   \item[name]
!     The name of the queried attribute.
!   \item[valueList]
!     The list of values of the queried attribute.
!   \item[{[isPresent]}]
!     Set to {\tt .true.} if the queried attribute is present, {\tt .false.}
!     otherwise.
!   \item[{[isSet]}]
!     Set to {\tt .true.} if the queried attribute is set, {\tt .false.}
!     otherwise.
!   \item[{[itemCount]}]
!     Number of items in the attribute. Return 0 if not present or not set.
!   \item[{[typekind]}]
!     The typekind of the queried attribute.
!   \item[{[rc]}]
!     Return code; equals {\tt ESMF\_SUCCESS} if there are no errors.
!   \end{description}
!
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                 :: localrc
    type(ESMF_Info)         :: info
    logical                 :: isArray

    if (present(rc)) rc = ESMF_SUCCESS

    call ESMF_InfoGetFromHost(comp, info=info, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out

    if (present(isSet)) isSet = .false.
    if (present(itemCount)) itemCount = 0
    if (present(typekind)) typekind = ESMF_NOKIND

    if (present(isPresent)) then
      isPresent = ESMF_InfoIsPresent(info, key="/NUOPC/Instance/"//name, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      if (.not.isPresent) return ! early successful return
    endif

    if (present(isSet)) then
      isSet = ESMF_InfoIsSet(info, key="/NUOPC/Instance/"//name, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      if (.not.isSet) return ! early successful return
    endif

    if (present(itemCount)) then
      call ESMF_InfoGet(info,  key="/NUOPC/Instance/"//name, size=itemCount, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
    endif

    if (present(typekind)) then
      typekind = ESMF_InfoGetTK(info, key="/NUOPC/Instance/"//name, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      if (.not.isSet) return ! early successful return
    endif

    call ESMF_InfoGet(info, key="/NUOPC/Instance/"//name, &
      isArray=isArray, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
    if (isArray) then
      call ESMF_InfoGet(info, key="/NUOPC/Instance/"//name, &
        values=valueList, rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
    else
      call ESMF_InfoGet(info, key="/NUOPC/Instance/"//name, &
        value=valueList(1), rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
    endif

  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompAttributeGet - Get a NUOPC CplComp Attribute - integer list
! !INTERFACE:
  ! Private name; call using NUOPC_CompAttributeGet() 
  subroutine NUOPC_CplCompAttributeGetIL(comp, name, valueList, isPresent, &
    isSet, itemCount, typekind, rc)
! !ARGUMENTS:
    type(ESMF_CplComp),       intent(in)            :: comp
    character(*),             intent(in)            :: name
    integer,                  intent(out)           :: valueList(:)
    logical,                  intent(out), optional :: isPresent
    logical,                  intent(out), optional :: isSet
    integer,                  intent(out), optional :: itemCount
    type(ESMF_TypeKind_Flag), intent(out), optional :: typekind
    integer,                  intent(out), optional :: rc
! !DESCRIPTION:
!   Access the attribute {\tt name} inside of {\tt comp} using the
!   convention {\tt NUOPC} and purpose {\tt Instance}. Returns with error if
!   the attribute is not present or not set.
!
!   Unless {\tt isPresent} and {\tt isSet} are provided, return with error if 
!   the attribute is not present or not set, respectively.
!
!   The arguments are:
!   \begin{description}
!   \item[comp]
!     The {\tt ESMF\_CplComp} object to be queried.
!   \item[name]
!     The name of the queried attribute.
!   \item[valueList]
!     The list of values of the queried attribute.
!   \item[{[isPresent]}]
!     Set to {\tt .true.} if the queried attribute is present, {\tt .false.}
!     otherwise.
!   \item[{[isSet]}]
!     Set to {\tt .true.} if the queried attribute is set, {\tt .false.}
!     otherwise.
!   \item[{[itemCount]}]
!     Number of items in the attribute. Return 0 if not present or not set.
!   \item[{[typekind]}]
!     The typekind of the queried attribute.
!   \item[{[rc]}]
!     Return code; equals {\tt ESMF\_SUCCESS} if there are no errors.
!   \end{description}
!
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                 :: localrc
    type(ESMF_Info)         :: info
    logical                 :: isArray

    if (present(rc)) rc = ESMF_SUCCESS

    call ESMF_InfoGetFromHost(comp, info=info, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out

    if (present(isSet)) isSet = .false.
    if (present(itemCount)) itemCount = 0
    if (present(typekind)) typekind = ESMF_NOKIND

    if (present(isPresent)) then
      isPresent = ESMF_InfoIsPresent(info, key="/NUOPC/Instance/"//name, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      if (.not.isPresent) return ! early successful return
    endif

    if (present(isSet)) then
      isSet = ESMF_InfoIsSet(info, key="/NUOPC/Instance/"//name, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      if (.not.isSet) return ! early successful return
    endif

    if (present(itemCount)) then
      call ESMF_InfoGet(info,  key="/NUOPC/Instance/"//name, size=itemCount, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
    endif

    if (present(typekind)) then
      typekind = ESMF_InfoGetTK(info, key="/NUOPC/Instance/"//name, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
      if (.not.isSet) return ! early successful return
    endif

    call ESMF_InfoGet(info, key="/NUOPC/Instance/"//name, &
      isArray=isArray, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
    if (isArray) then
      call ESMF_InfoGet(info, key="/NUOPC/Instance/"//name, &
        values=valueList, rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
    else
      call ESMF_InfoGet(info, key="/NUOPC/Instance/"//name, &
        value=valueList(1), rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)) &
        return  ! bail out
    endif

  end subroutine
  !-----------------------------------------------------------------------------
  
  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompAttributeIngest - Ingest free format NUOPC GridComp Attributes
! !INTERFACE:
  ! Private name; call using NUOPC_CompAttributeIngest() 
  subroutine NUOPC_GridCompAttributeIng(comp, freeFormat, addFlag, rc)
! !ARGUMENTS:
    type(ESMF_GridComp),    intent(in)            :: comp
    type(NUOPC_FreeFormat), intent(in)            :: freeFormat
    logical,                intent(in),  optional :: addFlag
    integer,                intent(out), optional :: rc
! !DESCRIPTION:
!   \label{NUOPC_GridCompAttributeIng}
!   Ingest the Attributes from a FreeFormat object onto the highest level
!   of the standard NUOPC AttPack hierarchy (convention="NUOPC", 
!   purpose="Instance").
!
!   Important: Attributes ingested by this method are stored as type character
!   strings, and must be accessed accordingly. Conversion from string into a
!   different data type, e.g. {\tt integer} or {\tt real}, is the user's
!   responsibility. This method does not support value lists. Attribute values
!   ingested by this method must not contain whitespace within the value. If
!   whitespace is found within the value the attribute will not be added to
!   the comp.
!
!   If {\tt addFlag} is {\tt .false.} (default), an error will be returned if 
!   an attribute is to be ingested that was not previously added to the 
!   {\tt comp} object. If {\tt addFlag} is {\tt .true.}, all missing attributes
!   will be added by this method automatically as needed.
!
!   Each line in {\tt freeFormat} is of this format:
!
!   \begin{verbatim}
!     attributeName = attributeValue
!   \end{verbatim}
!
!   For example:
!   \begin{verbatim}
!     Verbosity  = 0
!     Profiling  = 0
!     Diagnostic = 0
!   \end{verbatim}
!   could directly be ingested as Attributes for any instance of the four 
!   standard NUOPC component kinds. This is because {\tt Verbosity},
!   {\tt Profiling}, and {\tt Diagnostic} are pre-defined Attributes of the 
!   NUOPC component kinds according to sections \ref{DriverCompMeta}, 
!   \ref{ModelCompMeta}, \ref{MediatorCompMeta}, and \ref{ConnectorCompMeta}.
!
!   When Attributes are specified in {\tt freeFormat} that are not pre-defined
!   for a specific component kind, they can still be ingested by a component
!   instance using the {\tt addFlag=.true.} option. For instance:
!   \begin{verbatim}
!     ModelOutputChoice = 2
!   \end{verbatim}
!   specifies a user-level Attribute, which is not part of the pre-defined 
!   Attributes of any of the standard NUOPC component kinds.
!
!   Currently, whitespace is not supported in the attribute value and
!   the following attributeName fails to be added.
!
!   \begin{verbatim}
!     attributeName = attributeValue1 attributeValue2 attributedValue3
!   \end{verbatim}
!
!   If a list is needed then a comma can be used as a delimiter. The
!   attribute value list must then be parsed in user code.
!
!   \begin{verbatim}
!     attributeName = attributeValue1,attributeValue2,attributedValue3
!   \end{verbatim}
!
!EOP
  !-----------------------------------------------------------------------------
    character(ESMF_MAXSTR)                          :: name
    integer                                         :: localrc
    integer                                         :: stat
    integer                                         :: i, j
    integer                                         :: lineCount, tokenCount
    character(len=NUOPC_FreeFormatLen), allocatable :: tokenList(:)
    character(len=NUOPC_FreeFormatLen)              :: value
    logical                                         :: addFlagOpt
    logical                                         :: isPresent

    if (present(rc)) rc = ESMF_SUCCESS

    ! query the Component for info
    call ESMF_GridCompGet(comp, name=name, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    
    ! deal with optional addFlag
    addFlagOpt = .false. ! default
    if (present(addFlag)) then
      addFlagOpt = addFlag
    endif
    
    ! access the FreeFormat lineCount
    call NUOPC_FreeFormatGet(freeFormat, lineCount=lineCount, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out
    
    do i=1, lineCount
      call NUOPC_FreeFormatGetLine(freeFormat, line=i, tokenCount=tokenCount, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
        return  ! bail out
      allocate(tokenList(tokenCount))
      call NUOPC_FreeFormatGetLine(freeFormat, line=i, tokenList=tokenList, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
        return  ! bail out
      
      ! process the configuration line
      if (tokenCount >= 3) then
        if (trim(tokenList(2)) /= "=") then
          call ESMF_LogSetError(rcToCheck=ESMF_RC_ARG_BAD, &
            msg="Free format Attribute line incorrectly formatted.", &
            line=__LINE__, &
            file=trim(name)//":"//FILENAME, rcToReturn=rc)
          return  ! bail out
        endif
        if (addFlagOpt) then
          ! automatically add any Attribute
          call NUOPC_CompAttributeAdd(comp, attrList=(/trim(tokenList(1))/), &
            rc=localrc)
          if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
            line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
            return  ! bail out
        else
          call NUOPC_CompAttributeGet(comp, name=trim(tokenList(1)), &
            isPresent=isPresent, rc=localrc)
          if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
            line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
            return  ! bail out
          if (.not. isPresent) then
            if (ESMF_LogFoundError(rcToCheck=ESMF_RC_ATTR_ITEMSOFF, &
              msg="Attribute must be added before it is set. name="//trim(tokenList(1)), &
              line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
              return  ! bail out
          endif
        endif
        value=tokenList(3)
        do j=4, tokenCount
          value=trim(value)//" "//tokenList(j)
        enddo
        call NUOPC_CompAttributeSet(comp, name=trim(tokenList(1)), &
          value=trim(value), rc=localrc)
        if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
          line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
          return  ! bail out
      else
        ! Just skip these lines for now....
        !call ESMF_LogSetError(rcToCheck=ESMF_RC_ARG_BAD, &
        !  msg="Free format Attribute line incorrectly formatted.", &
        !  line=__LINE__, &
        !  file=trim(name)//":"//FILENAME, rcToReturn=rc)
        !return  ! bail out
      endif
      
      ! clean-up
      deallocate(tokenList, stat=stat)
      if (ESMF_LogFoundDeallocError(statusToCheck=stat, &
        msg="Deallocation of tokenList.", &
        line=__LINE__, &
        file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out

    enddo
    
  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompAttributeIngest - Ingest free format NUOPC CplComp Attributes
! !INTERFACE:
  ! Private name; call using NUOPC_CompAttributeIngest() 
  subroutine NUOPC_CplCompAttributeIng(comp, freeFormat, addFlag, rc)
! !ARGUMENTS:
    type(ESMF_CplComp),     intent(in)            :: comp
    type(NUOPC_FreeFormat), intent(in)            :: freeFormat
    logical,                intent(in),  optional :: addFlag
    integer,                intent(out), optional :: rc
! !DESCRIPTION:
!   \label{NUOPC_CplCompAttributeIng}
!   Ingest the Attributes from a FreeFormat object onto the highest level
!   of the standard NUOPC AttPack hierarchy (convention="NUOPC", 
!   purpose="Instance").
!
!   Important: Attributes ingested by this method are stored as type character
!   strings, and must be accessed accordingly. Conversion from string into a
!   different data type, e.g. {\tt integer} or {\tt real}, is the user's
!   responsibility.
!
!   If {\tt addFlag} is {\tt .false.} (default), an error will be returned if 
!   an attribute is to be ingested that was not previously added to the 
!   {\tt comp} object. If {\tt addFlag} is {\tt .true.}, all missing attributes
!   will be added by this method automatically as needed.
!
!   Each line in {\tt freeFormat} is of this format:
!
!   \begin{verbatim}
!     attributeName = attributeValue
!   \end{verbatim}
!
!   For example:
!   \begin{verbatim}
!     Verbosity  = 0
!     Profiling  = 0
!     Diagnostic = 0
!   \end{verbatim}
!   could directly be ingested as Attributes for any instance of the four 
!   standard NUOPC component kinds. This is because {\tt Verbosity},
!   {\tt Profiling}, and {\tt Diagnostic} are pre-defined Attributes of the 
!   NUOPC component kinds according to sections \ref{DriverCompMeta}, 
!   \ref{ModelCompMeta}, \ref{MediatorCompMeta}, and \ref{ConnectorCompMeta}.
!
!   When Attributes are specified in {\tt freeFormat} that are not pre-defined
!   for a specific component kind, they can still be ingested by a component
!   instance using the {\tt addFlag=.true.} option. For instance:
!   \begin{verbatim}
!     ModelOutputChoice = 2
!   \end{verbatim}
!   specifies a user-level Attribute, which is not part of the pre-defined 
!   Attributes of any of the standard NUOPC component kinds.
!
!EOP
  !-----------------------------------------------------------------------------
    character(ESMF_MAXSTR)                          :: name
    integer                                         :: localrc
    integer                                         :: stat
    integer                                         :: i, j
    integer                                         :: lineCount, tokenCount
    character(len=NUOPC_FreeFormatLen), allocatable :: tokenList(:)
    character(len=NUOPC_FreeFormatLen)              :: value
    logical                                         :: addFlagOpt
    logical                                         :: isPresent

    if (present(rc)) rc = ESMF_SUCCESS

    ! query the Component for info
    call ESMF_CplCompGet(comp, name=name, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    
    ! deal with optional addFlag
    addFlagOpt = .false. ! default
    if (present(addFlag)) then
      addFlagOpt = addFlag
    endif
    
    ! access the FreeFormat lineCount
    call NUOPC_FreeFormatGet(freeFormat, lineCount=lineCount, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out
    
    do i=1, lineCount
      call NUOPC_FreeFormatGetLine(freeFormat, line=i, tokenCount=tokenCount, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
        return  ! bail out
      allocate(tokenList(tokenCount))
      call NUOPC_FreeFormatGetLine(freeFormat, line=i, tokenList=tokenList, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
        return  ! bail out
      
      ! process the configuration line
      if (tokenCount >= 3) then
        if (trim(tokenList(2)) /= "=") then
          call ESMF_LogSetError(rcToCheck=ESMF_RC_ARG_BAD, &
            msg="Free format Attribute line incorrectly formatted.", &
            line=__LINE__, &
            file=trim(name)//":"//FILENAME, rcToReturn=rc)
          return  ! bail out
        endif
        if (addFlagOpt) then
          ! automatically add any Attribute
          call NUOPC_CompAttributeAdd(comp, attrList=(/trim(tokenList(1))/), &
            rc=localrc)
          if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
            line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
            return  ! bail out
        else
          call NUOPC_CompAttributeGet(comp, name=trim(tokenList(1)), &
            isPresent=isPresent, rc=localrc)
          if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
            line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
            return  ! bail out
          if (.not. isPresent) then
            if (ESMF_LogFoundError(rcToCheck=ESMF_RC_ATTR_ITEMSOFF, &
              msg="Attribute must be added before it is set. name="//trim(tokenList(1)), &
              line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
              return  ! bail out
          endif
        endif
        value=tokenList(3)
        do j=4, tokenCount
          value=trim(value)//" "//tokenList(j)
        enddo
        call NUOPC_CompAttributeSet(comp, name=trim(tokenList(1)), &
          value=trim(value), rc=localrc)
        if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
          line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
          return  ! bail out
      else
        call ESMF_LogSetError(rcToCheck=ESMF_RC_ARG_BAD, &
          msg="Free format Attribute line incorrectly formatted.", &
          line=__LINE__, &
          file=trim(name)//":"//FILENAME, rcToReturn=rc)
        return  ! bail out
      endif
      
      ! clean-up
      deallocate(tokenList, stat=stat)
      if (ESMF_LogFoundDeallocError(statusToCheck=stat, &
        msg="Deallocation of tokenList.", &
        line=__LINE__, &
        file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out

    enddo
    
  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompAttributeIngest - Ingest NUOPC GridComp Attributes from HConfig
! !INTERFACE:
  ! Private name; call using NUOPC_CompAttributeIngest() 
  subroutine NUOPC_GridCompAttributeIngHC(comp, hconfig, rc)
! !ARGUMENTS:
    type(ESMF_GridComp),    intent(in)            :: comp
    type(ESMF_HConfig),     intent(in)            :: hconfig
    integer,                intent(out), optional :: rc
! !DESCRIPTION:
!   \label{NUOPC_GridCompAttributeIngHC}
!   Ingest component attributes from a HConfig object onto the highest level
!   of the standard NUOPC AttPack hierarchy (convention="NUOPC", 
!   purpose="Instance").
!
!   The provided {\tt hconfig} is expected to be a {\em map}. An error is
!   returned if this condition is not met. Each key-value pair held by
!   {\tt hconfig} is added as an attribute to {\tt comp}.
!   A copy of the source contents is made.
!
!   Transfers of {\em scalar}, {\em sequence}, and {\em map} values
!   from {\tt hconfig} are supported.  Maps are treated recursively.
!   Sequences are restricted to scalar elements of the same typekind.
!
!   The keys of any map provided by the {\tt hconfig} object must
!   be of scalar type. Keys are interpreted as strings when transferred as an
!   attribute.
!
!   Existing attributes with the same key are overridden by this operation.
!   When attributes are overridden, the typekind of the associated value
!   element is allowed to change.
!
! \begin{verbatim}
! # A simple YAML definition of standard NUOPC attributes, followed by
! # component specific attributes.
!
! Verbosity:  4609             # decimal representation of explicit bit pattern
! Profiling:  low              # pre-defined NUOPC setting
! Diagnostic: 0                # explicit 0 turns OFF feature
! CustomSeq1: [1, 2, 3, 4]     # sequence of integers
! CustomSeq2: [1., 2., 3., 4.] # sequence of floats
! CustomSeq3: [true, false]    # sequence of bools
! CustomType: {k1: [a, aa, aaa], k2: b, k3: c}  # complex structure
! \end{verbatim}
!
!EOP
  !-----------------------------------------------------------------------------
    character(ESMF_MAXSTR)  :: name
    type(ESMF_Info)         :: info
    integer                 :: localrc

    if (present(rc)) rc = ESMF_SUCCESS

    ! query the Component for info
    call ESMF_GridCompGet(comp, name=name, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out

    ! access the Info object
    call ESMF_InfoGetFromHost(comp, info=info, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out

    ! set contents of Info according to HConfig
    call ESMF_InfoSet(info, value=hconfig, keyPrefix="/NUOPC/Instance", &
      rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out

  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompAttributeIngest - Ingest NUOPC CplComp Attributes from HConfig
! !INTERFACE:
  ! Private name; call using NUOPC_CompAttributeIngest() 
  subroutine NUOPC_CplCompAttributeIngHC(comp, hconfig, rc)
! !ARGUMENTS:
    type(ESMF_CplComp),     intent(in)            :: comp
    type(ESMF_HConfig),     intent(in)            :: hconfig
    integer,                intent(out), optional :: rc
! !DESCRIPTION:
!   \label{NUOPC_CplCompAttributeIngHC}
!   Ingest component attributes from a HConfig object onto the highest level
!   of the standard NUOPC AttPack hierarchy (convention="NUOPC", 
!   purpose="Instance").
!
!   The provided {\tt hconfig} is expected to be a {\em map}. An error is
!   returned if this condition is not met. Each key-value pair held by
!   {\tt hconfig} is added as an attribute to {\tt comp}.
!   A copy of the source contents is made.
!
!   Transfers of {\em scalar}, {\em sequence}, and {\em map} values
!   from {\tt hconfig} are supported.  Maps are treated recursively.
!   Sequences are restricted to scalar elements of the same typekind.
!
!   The keys of any map provided by the {\tt hconfig} object must
!   be of scalar type. Keys are interpreted as strings when transferred as an
!   attribute.
!
!   Existing attributes with the same key are overridden by this operation.
!   When attributes are overridden, the typekind of the associated value
!   element is allowed to change.
!
! \begin{verbatim}
! # A simple YAML definition of standard NUOPC attributes, followed by
! # component specific attributes.
!
! Verbosity:  4609             # decimal representation of explicit bit pattern
! Profiling:  low              # pre-defined NUOPC setting
! Diagnostic: 0                # explicit 0 turns OFF feature
! CustomSeq1: [1, 2, 3, 4]     # sequence of integers
! CustomSeq2: [1., 2., 3., 4.] # sequence of floats
! CustomSeq3: [true, false]    # sequence of bools
! CustomType: {k1: [a, aa, aaa], k2: b, k3: c}  # complex structure
! \end{verbatim}
!
!EOP
  !-----------------------------------------------------------------------------
    character(ESMF_MAXSTR)  :: name
    type(ESMF_Info)         :: info
    integer                 :: localrc

    if (present(rc)) rc = ESMF_SUCCESS

    ! query the Component for info
    call ESMF_CplCompGet(comp, name=name, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out

    ! access the Info object
    call ESMF_InfoGetFromHost(comp, info=info, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out

    ! set contents of Info according to HConfig
    call ESMF_InfoSet(info, value=hconfig, keyPrefix="/NUOPC/Instance", &
      rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out

  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOPI
! !IROUTINE: NUOPC_CompAttributeInit - Initialize the NUOPC GridComp Attributes
! !INTERFACE:
  ! Private name; call using NUOPC_CompAttributeInit() 
  subroutine NUOPC_GridCompAttributeInit(comp, kind, rc)
! !ARGUMENTS:
    type(ESMF_GridComp)                       :: comp
    character(len=*),   intent(in)            :: kind
    integer,            intent(out), optional :: rc
! !DESCRIPTION:
!   Add the standard NUOPC GridComp AttPack hierarchy to the Gridded Component.
!   The specifics depend on the component {\tt kind}.
!
!   The highest level in the AttPack hierarchy will have convention="NUOPC" and
!   purpose="Instance".
!EOPI
  !-----------------------------------------------------------------------------
    ! local variables
    integer                               :: localrc
    integer                               :: stat
    character(ESMF_MAXSTR), allocatable   :: attrList(:)
    
    if (present(rc)) rc = ESMF_SUCCESS
    
    ! Check for valid component kind
    if (trim(kind)=="Driver" .or. &
      trim(kind)=="Model" .or. trim(kind)=="Mediator") then
      ! The NUOPC/Component attributes
      allocate(attrList(9))
      attrList(1) = "Kind"
      attrList(2) = "Verbosity"
      attrList(3) = "Profiling"
      attrList(4) = "Diagnostic"
      attrList(5) = "CompLabel"
      attrList(6) = "InitializePhaseMap"
      attrList(7) = "RunPhaseMap"
      attrList(8) = "FinalizePhaseMap"
      attrList(9) = "IPDvX"
      call ESMF_AttributeAdd(comp, convention="NUOPC", purpose="Instance", &
        attrList=attrList, rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out
      deallocate(attrList, stat=stat)
      if (ESMF_LogFoundDeallocError(statusToCheck=stat, &
        msg="Deallocation of attrList.", &
        line=__LINE__, &
        file=FILENAME, rcToReturn=rc)) return  ! bail out
    else
      ! invalid component kind
      call ESMF_LogSetError(ESMF_RC_ARG_BAD, msg="Invalid component kind",&
        line=__LINE__, file=FILENAME, rcToReturn=rc)
      return  ! bail out
    endif

    ! Add NUOPC/Driver, NUOPC/Model, NUOPC/Mediator Attributes
    allocate(attrList(9))
    attrList(1) = "InternalInitializePhaseMap"  ! list of strings to map str to phase #
    attrList(2) = "InternalRunPhaseMap"  ! list of strings to map str to phase #
    attrList(3) = "InternalFinalizePhaseMap"  ! list of strings to map str to phase #
    attrList(4) = "NestingGeneration" ! values: integer starting 0 for parent
    attrList(5) = "Nestling"  ! values: integer starting 0 for first nestling
    attrList(6) = "InitializeDataResolution"! values: strings "false"/"true"
    attrList(7) = "InitializeDataComplete"  ! values: strings "false"/"true"
    attrList(8) = "InitializeDataProgress"  ! values: strings "false"/"true"
    attrList(9) = "HierarchyProtocol"       ! strings
    ! add Attribute packages
    call ESMF_AttributeAdd(comp, convention="NUOPC", purpose="Instance", &
      attrList=attrList, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out
    deallocate(attrList, stat=stat)
    if (ESMF_LogFoundDeallocError(statusToCheck=stat, &
      msg="Deallocation of attrList.", &
      line=__LINE__, &
      file=FILENAME, rcToReturn=rc)) return  ! bail out
    
    ! set Attributes to defaults
    call NUOPC_CompAttributeSet(comp, &
      name="Kind", value=trim(kind), &
      rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out
    call NUOPC_CompAttributeSet(comp, &
      name="Verbosity", value="0", &
      rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out
    call NUOPC_CompAttributeSet(comp, &
      name="Profiling", value="0", &
      rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out
    call NUOPC_CompAttributeSet(comp, &
      name="Diagnostic", value="0", &
      rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out
    call NUOPC_CompAttributeSet(comp, &
      name="CompLabel", value="_uninitialized", &
      rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out
    call NUOPC_CompAttributeSet(comp, &
      name="NestingGeneration", value=0, &        ! default to parent level
      rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out
    call NUOPC_CompAttributeSet(comp, &
      name="Nestling", value=0, &                 ! default to first nestling
      rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out
    call NUOPC_CompAttributeSet(comp, &
      name="InitializeDataResolution", value="true", &
      rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out
    call NUOPC_CompAttributeSet(comp, &
      name="InitializeDataComplete", value="false", &
      rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out
    call NUOPC_CompAttributeSet(comp, &
      name="InitializeDataProgress", value="false", &
      rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out

  end subroutine
  !-----------------------------------------------------------------------------
  
  !-----------------------------------------------------------------------------
!BOPI
! !IROUTINE: NUOPC_CompAttributeInit - Initialize the NUOPC CplComp Attributes
! !INTERFACE:
  ! Private name; call using NUOPC_CompAttributeInit() 
  subroutine NUOPC_CplCompAttributeInit(comp, rc)
! !ARGUMENTS:
    type(ESMF_CplComp), intent(inout)         :: comp
    integer,            intent(out), optional :: rc
! !DESCRIPTION:
!   Add the standard NUOPC CplComp AttPack hierarchy to the Coupler Component.
!
!   The highest level in the AttPack hierarchy will have convention="NUOPC" and
!   purpose="Instance".
!EOPI
  !-----------------------------------------------------------------------------
    ! local variables
    integer                               :: localrc
    integer                               :: stat
    character(ESMF_MAXSTR), allocatable   :: attrList(:)

    if (present(rc)) rc = ESMF_SUCCESS
    
    ! The NUOPC/Component attributes
    allocate(attrList(9))
    attrList(1) = "Kind"
    attrList(2) = "Verbosity"
    attrList(3) = "Profiling"
    attrList(4) = "Diagnostic"
    attrList(5) = "CompLabel"
    attrList(6) = "InitializePhaseMap"
    attrList(7) = "RunPhaseMap"
    attrList(8) = "FinalizePhaseMap"
    attrList(9) = "IPDvX"
    call ESMF_AttributeAdd(comp, convention="NUOPC", purpose="Instance",   &
      attrList=attrList, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out
    deallocate(attrList, stat=stat)
    if (ESMF_LogFoundDeallocError(statusToCheck=stat, &
      msg="Deallocation of attrList.", &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) return  ! bail out

    ! The NUOPC/Connector Attributes
    allocate(attrList(7))
    attrList(1) = "CplList"
    attrList(2) = "CplSetList"
    attrList(3) = "ConnectionOptions"
    attrList(4) = "EpochEnable"
    attrList(5) = "EpochEnterKeepAlloc"
    attrList(6) = "EpochExitKeepAlloc"
    attrList(7) = "EpochThrottle"
    call ESMF_AttributeAdd(comp, convention="NUOPC", purpose="Instance", &
      attrList=attrList, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out
    deallocate(attrList, stat=stat)
    if (ESMF_LogFoundDeallocError(statusToCheck=stat, &
      msg="Deallocation of attrList.", &
      line=__LINE__, &
      file=FILENAME, rcToReturn=rc)) return  ! bail out

    ! set Attribute defaults
    call NUOPC_CompAttributeSet(comp, &
      name="Kind", value="Connector", &
      rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out
    call NUOPC_CompAttributeSet(comp, &
      name="Verbosity", value="0", &
      rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out
    call NUOPC_CompAttributeSet(comp, &
      name="Profiling", value="0", &
      rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out
    call NUOPC_CompAttributeSet(comp, &
      name="Diagnostic", value="0", &
      rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out

  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompAttributeReset - Reset NUOPC GridComp Attributes
! !INTERFACE:
  ! Private name; call using NUOPC_CompAttributeReset() 
  subroutine NUOPC_GridCompAttributeReset(comp, attrList, rc)
! !ARGUMENTS:
    type(ESMF_GridComp)                       :: comp
    character(len=*),   intent(in)            :: attrList(:)
    integer,            intent(out), optional :: rc
! !DESCRIPTION:
!   Reset Attributes on the highest level of the standard NUOPC AttPack
!   hierarchy (convention="NUOPC", purpose="Instance").
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                 :: localrc, i

    if (present(rc)) rc = ESMF_SUCCESS

    do i=1, size(attrList)
      call ESMF_AttributeRemove(comp, convention="NUOPC", purpose="Instance", &
        name=attrList(i), rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out
    enddo
    call ESMF_AttributeAdd(comp, convention="NUOPC", purpose="Instance", &
      attrList=attrList, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out
      
  end subroutine
  !-----------------------------------------------------------------------------
  
  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompAttributeReset - Reset NUOPC CplComp Attributes
! !INTERFACE:
  ! Private name; call using NUOPC_CompAttributeReset() 
  subroutine NUOPC_CplCompAttributeReset(comp, attrList, rc)
! !ARGUMENTS:
    type(ESMF_CplComp)                        :: comp
    character(len=*),   intent(in)            :: attrList(:)
    integer,            intent(out), optional :: rc
! !DESCRIPTION:
!   Reset Attributes on the highest level of the standard NUOPC AttPack
!   hierarchy (convention="NUOPC", purpose="Instance").
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                 :: localrc, i

    if (present(rc)) rc = ESMF_SUCCESS

    do i=1, size(attrList)
      call ESMF_AttributeRemove(comp, convention="NUOPC", purpose="Instance", &
        name=attrList(i), rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out
    enddo
    call ESMF_AttributeAdd(comp, convention="NUOPC", purpose="Instance", &
      attrList=attrList, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=FILENAME, rcToReturn=rc)) return  ! bail out
      
  end subroutine
  !-----------------------------------------------------------------------------
  
  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompAttributeSet - Set a NUOPC GridComp Attribute
! !INTERFACE:
  ! Private name; call using NUOPC_CompAttributeSet() 
  subroutine NUOPC_GridCompAttributeSetS(comp, name, value, rc)
! !ARGUMENTS:
    type(ESMF_GridComp)                   :: comp
    character(*), intent(in)              :: name
    character(*), intent(in)              :: value
    integer,      intent(out), optional   :: rc
! !DESCRIPTION:
!   Set the Attribute {\tt name} inside of {\tt comp} on the highest level
!   of the standard NUOPC AttPack hierarchy (convention="NUOPC", 
!   purpose="Instance").
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                               :: localrc
    type(ESMF_Info)                       :: info
    
    if (present(rc)) rc = ESMF_SUCCESS

    call ESMF_InfoGetFromHost(comp, info=info, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out

    call ESMF_InfoSet(info, key="/NUOPC/Instance/"//name, value=value, &
      rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
    
  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompAttributeSet - Set a NUOPC CplComp Attribute
! !INTERFACE:
  ! Private name; call using NUOPC_CompAttributeSet() 
  subroutine NUOPC_CplCompAttributeSetS(comp, name, value, rc)
! !ARGUMENTS:
    type(ESMF_CplComp)                    :: comp
    character(*), intent(in)              :: name
    character(*), intent(in)              :: value
    integer,      intent(out), optional   :: rc
! !DESCRIPTION:
!   Set the Attribute {\tt name} inside of {\tt comp} on the highest level
!   of the standard NUOPC AttPack hierarchy (convention="NUOPC", 
!   purpose="Instance").
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                               :: localrc
    type(ESMF_Info)                       :: info
    
    if (present(rc)) rc = ESMF_SUCCESS

    call ESMF_InfoGetFromHost(comp, info=info, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out

    call ESMF_InfoSet(info, key="/NUOPC/Instance/"//name, value=value, &
      rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
    
  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompAttributeSet - Set a NUOPC GridComp Attribute
! !INTERFACE:
  ! Private name; call using NUOPC_CompAttributeSet() 
  subroutine NUOPC_GridCompAttributeSetI(comp, name, value, rc)
! !ARGUMENTS:
    type(ESMF_GridComp)                   :: comp
    character(*), intent(in)              :: name
    integer,      intent(in)              :: value
    integer,      intent(out), optional   :: rc
! !DESCRIPTION:
!   Set the Attribute {\tt name} inside of {\tt comp} on the highest level
!   of the standard NUOPC AttPack hierarchy (convention="NUOPC", 
!   purpose="Instance").
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                               :: localrc
    type(ESMF_Info)                       :: info
    
    if (present(rc)) rc = ESMF_SUCCESS

    call ESMF_InfoGetFromHost(comp, info=info, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out

    call ESMF_InfoSet(info, key="/NUOPC/Instance/"//name, value=value, &
      rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
    
  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompAttributeSet - Set a NUOPC CplComp Attribute
! !INTERFACE:
  ! Private name; call using NUOPC_CompAttributeSet() 
  subroutine NUOPC_CplCompAttributeSetI(comp, name, value, rc)
! !ARGUMENTS:
    type(ESMF_CplComp)                    :: comp
    character(*), intent(in)              :: name
    integer,      intent(in)              :: value
    integer,      intent(out), optional   :: rc
! !DESCRIPTION:
!   Set the Attribute {\tt name} inside of {\tt comp} on the highest level
!   of the standard NUOPC AttPack hierarchy (convention="NUOPC", 
!   purpose="Instance").
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                               :: localrc
    type(ESMF_Info)                       :: info
    
    if (present(rc)) rc = ESMF_SUCCESS

    call ESMF_InfoGetFromHost(comp, info=info, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out

    call ESMF_InfoSet(info, key="/NUOPC/Instance/"//name, value=value, &
      rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
    
  end subroutine
  !-----------------------------------------------------------------------------


  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompAttributeSet - Set a NUOPC GridComp List Attribute
! !INTERFACE:
  ! Private name; call using NUOPC_CompAttributeSet() 
  subroutine NUOPC_GridCompAttributeSetSL(comp, name, valueList, rc)
! !ARGUMENTS:
    type(ESMF_GridComp)                   :: comp
    character(*), intent(in)              :: name
    character(*), intent(in)              :: valueList(:)
    integer,      intent(out), optional   :: rc
! !DESCRIPTION:
!   Set the Attribute {\tt name} inside of {\tt comp} on the highest level
!   of the standard NUOPC AttPack hierarchy (convention="NUOPC", 
!   purpose="Instance").
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                               :: localrc
    type(ESMF_Info)                       :: info
    
    if (present(rc)) rc = ESMF_SUCCESS

    call ESMF_InfoGetFromHost(comp, info=info, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out

    call ESMF_InfoSet(info, key="/NUOPC/Instance/"//name, values=valueList, &
      rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
    
  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompAttributeSet - Set a NUOPC CplComp List Attribute
! !INTERFACE:
  ! Private name; call using NUOPC_CompAttributeSet() 
  subroutine NUOPC_CplCompAttributeSetSL(comp, name, valueList, rc)
! !ARGUMENTS:
    type(ESMF_CplComp)                    :: comp
    character(*), intent(in)              :: name
    character(*), intent(in)              :: valueList(:)
    integer,      intent(out), optional   :: rc
! !DESCRIPTION:
!   Set the Attribute {\tt name} inside of {\tt comp} on the highest level
!   of the standard NUOPC AttPack hierarchy (convention="NUOPC", 
!   purpose="Instance").
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                               :: localrc
    type(ESMF_Info)                       :: info
    
    if (present(rc)) rc = ESMF_SUCCESS

    call ESMF_InfoGetFromHost(comp, info=info, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out

    call ESMF_InfoSet(info, key="/NUOPC/Instance/"//name, values=valueList, &
      rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
    
  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompCheckSetClock - Check Clock compatibility and set stopTime
! !INTERFACE:
  ! Private name; call using NUOPC_CompCheckSetClock() 
  subroutine NUOPC_GridCompCheckSetClock(comp, externalClock, checkTimeStep, &
    forceTimeStep, rc)
! !ARGUMENTS:
    type(ESMF_GridComp),     intent(inout)         :: comp
    type(ESMF_Clock),        intent(in)            :: externalClock
    logical,                 intent(in),  optional :: checkTimeStep
    logical,                 intent(in),  optional :: forceTimeStep
    integer,                 intent(out), optional :: rc
! !DESCRIPTION:
!   Compare {\tt externalClock} to the internal clock of {\tt comp} to make sure
!   they match in their current time. Also ensure that the time step of the
!   external clock is a multiple of the time step of the internal clock. If
!   both conditions are satisfied then set the stop time of the internal clock
!   so it is reached in one time step of the external clock. Otherwise leave the
!   internal clock unchanged and return with error. The direction of
!   the involved clocks is taking into account.
!   Setting the {\tt forceTimeStep} argument to {\tt .true.} forces the
!   {\tt timeStep} of the {\tt externalClock} to be used to reset the
!   {\tt timeStep} of the internal clock.
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                 :: localrc
    type(ESMF_Clock)        :: internalClock

    if (present(rc)) rc = ESMF_SUCCESS

    call ESMF_GridCompGet(comp, clock=internalClock, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out

    call NUOPC_CheckSetClock(setClock=internalClock, &
      checkClock=externalClock, checkTimeStep=checkTimeStep, &
      forceTimeStep=forceTimeStep, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out

  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompDerive - Derive a GridComp from a generic component
! !INTERFACE:
  ! Private name; call using NUOPC_CompDerive() 
  recursive subroutine NUOPC_GridCompDerive(comp, genericSetServicesRoutine, rc)
! !ARGUMENTS:
    type(ESMF_GridComp), intent(in)            :: comp
    interface
      subroutine genericSetServicesRoutine(gridcomp, rc)
        use ESMF
        implicit none
        type(ESMF_GridComp)        :: gridcomp ! must not be optional
        integer, intent(out)       :: rc       ! must not be optional
      end subroutine
    end interface
    integer,             intent(out), optional :: rc
! !DESCRIPTION:
!   Derive a GridComp (i.e. Model, Mediator, or Driver) from a generic 
!   component by calling into the specified {\tt SetServices()} routine of the
!   generic component. This is typically the first call in the
!   {\tt SetServices()} routine of the specializing component, and is followed
!   by {\tt NUOPC\_CompSpecialize()} calls.
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                   :: localrc
    character(ESMF_MAXSTR)    :: name

    if (present(rc)) rc = ESMF_SUCCESS
    
    ! query the Component for info
    call ESMF_GridCompGet(comp, name=name, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out

    ! call into the generic SetServices routine
    call genericSetServicesRoutine(comp, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    
  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompDerive - Derive a CplComp from a generic component
! !INTERFACE:
  ! Private name; call using NUOPC_CompDerive() 
  recursive subroutine NUOPC_CplCompDerive(comp, genericSetServicesRoutine, rc)
! !ARGUMENTS:
    type(ESMF_CplComp),  intent(in)            :: comp
    interface
      subroutine genericSetServicesRoutine(cplcomp, rc)
        use ESMF
        implicit none
        type(ESMF_CplComp)         :: cplcomp  ! must not be optional
        integer, intent(out)       :: rc       ! must not be optional
      end subroutine
    end interface
    integer,             intent(out), optional :: rc
! !DESCRIPTION:
!   Derive a CplComp (i.e. Connector) from a generic
!   component by calling into the specified {\tt SetServices()} routine of the
!   generic component. This is typically the first call in the
!   {\tt SetServices()} routine of the specializing component, and is followed
!   by {\tt NUOPC\_CompSpecialize()} calls.
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                   :: localrc
    character(ESMF_MAXSTR)    :: name

    if (present(rc)) rc = ESMF_SUCCESS
    
    ! query the Component for info
    call ESMF_CplCompGet(comp, name=name, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out

    ! call into the generic SetServices routine
    call genericSetServicesRoutine(comp, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out
    
  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompFilterPhaseMap - Filter the Phase Map of a GridComp
! !INTERFACE:
  ! Private name; call using NUOPC_CompFilterPhaseMap()
  subroutine NUOPC_GridCompFilterPhaseMap(comp, methodflag, acceptStringList, &
    rc)
! !ARGUMENTS:
    type(ESMF_GridComp)                           :: comp
    type(ESMF_Method_Flag), intent(in)            :: methodflag
    character(len=*),       intent(in)            :: acceptStringList(:)
    integer,                intent(out), optional :: rc 
!
! !DESCRIPTION:
! Filter all PhaseMap entries in a GridComp (i.e. Model, Mediator, or Driver)
! that do {\em not} match any entry in the {\tt acceptStringList}.
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                   :: localrc
    integer                   :: i, ii, iii
    integer                   :: itemCount, stat
    integer                   :: acceptStringCount
    character(ESMF_MAXSTR)    :: name
    character(len=40)         :: attributeName
    character(len=NUOPC_PhaseMapStringLength), pointer :: phases(:)
    character(len=NUOPC_PhaseMapStringLength), pointer :: newPhases(:)
    logical                   :: isSet

    if (present(rc)) rc = ESMF_SUCCESS

    ! query the Component for info
    call ESMF_GridCompGet(comp, name=name, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out

    ! determine which phaseMap to deal with
    attributeName = "UnknownPhaseMap" ! initialize to something obvious
    if (methodflag == ESMF_METHOD_INITIALIZE) then
      attributeName = "InitializePhaseMap"
    elseif (methodflag == ESMF_METHOD_RUN) then
      attributeName = "RunPhaseMap"
    elseif (methodflag == ESMF_METHOD_FINALIZE) then
      attributeName = "FinalizePhaseMap"
    endif
    
    ! determine how many phaseLabels are contained in the incoming list
    acceptStringCount = size(acceptStringList)
    
    ! query the already existing phaseMap enties
    call NUOPC_CompAttributeGet(comp, name=trim(attributeName), &
      isSet=isSet, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out

    if (.not.isSet) return ! nothing to be done -> early return

    call NUOPC_CompAttributeGet(comp, name=trim(attributeName), &
      itemCount=itemCount, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out
      
    if (itemCount==0) return ! nothing to be done -> early return
    
    allocate(phases(itemCount), newPhases(itemCount), stat=stat)
    if (ESMF_LogFoundAllocError(statusToCheck=stat, &
      msg="Allocation of temporary data structure.", &
      line=__LINE__, &
      file=trim(name)//":"//FILENAME, &
      rcToReturn=rc)) return  ! bail out

    ! get the current phases
    call NUOPC_CompAttributeGet(comp, name=trim(attributeName), &
      valueList=phases, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out

    ! filter all entries that do not match entries in acceptStringList
    iii=0 ! reset
    do i=1, itemCount
      ! see if there is a match with an entry in the acceptStringList
      do ii=1, acceptStringCount
        if (index(phases(i),trim(acceptStringList(ii))) > 0 ) exit
      enddo
      if (ii <= acceptStringCount) then
        ! found a match -> preserve the phaseMap entry
        iii = iii+1
        newPhases(iii) = trim(phases(i))
      endif
    enddo
    
    ! insert a dummy entry in case no entries are left
    if (iii==0) then
      iii=1
      newPhases(1) = "IPDvDummy=-999" ! something obvious
    endif
    
    ! set the filtered phase map as the Attribute
    call NUOPC_CompAttributeSet(comp, name=trim(attributeName), &
      valueList=newPhases(1:iii), rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out
    
    ! clean-up
    deallocate(phases, newPhases, stat=stat)
    if (ESMF_LogFoundDeallocError(statusToCheck=stat, &
      msg="Deallocation of phases, newPhases.", &
      line=__LINE__, &
      file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    
  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompFilterPhaseMap - Filter the Phase Map of a CplComp
! !INTERFACE:
  ! Private name; call using NUOPC_CompFilterPhaseMap()
  subroutine NUOPC_CplCompFilterPhaseMap(comp, methodflag, acceptStringList, &
    rc)
! !ARGUMENTS:
    type(ESMF_CplComp)                            :: comp
    type(ESMF_Method_Flag), intent(in)            :: methodflag
    character(len=*),       intent(in)            :: acceptStringList(:)
    integer,                intent(out), optional :: rc 
!
! !DESCRIPTION:
! Filter all PhaseMap entries in a CplComp (i.e. Connector)
! that do {\em not} match any entry in the {\tt acceptStringList}.
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                   :: localrc
    integer                   :: i, ii, iii
    integer                   :: itemCount, stat
    integer                   :: acceptStringCount
    character(ESMF_MAXSTR)    :: name
    character(len=40)         :: attributeName
    character(len=NUOPC_PhaseMapStringLength), pointer :: phases(:)
    character(len=NUOPC_PhaseMapStringLength), pointer :: newPhases(:)
    logical                   :: isSet

    if (present(rc)) rc = ESMF_SUCCESS

    ! query the Component for info
    call ESMF_CplCompGet(comp, name=name, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out

    ! determine which phaseMap to deal with
    attributeName = "UnknownPhaseMap" ! initialize to something obvious
    if (methodflag == ESMF_METHOD_INITIALIZE) then
      attributeName = "InitializePhaseMap"
    elseif (methodflag == ESMF_METHOD_RUN) then
      attributeName = "RunPhaseMap"
    elseif (methodflag == ESMF_METHOD_FINALIZE) then
      attributeName = "FinalizePhaseMap"
    endif
    
    ! determine how many phaseLabels are contained in the incoming list
    acceptStringCount = size(acceptStringList)
    
    ! query the already existing phaseMap enties
    call NUOPC_CompAttributeGet(comp, name=trim(attributeName), &
      isSet=isSet, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out

    if (.not.isSet) return ! nothing to be done -> early return

    call NUOPC_CompAttributeGet(comp, name=trim(attributeName), &
      itemCount=itemCount, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out
    
    if (itemCount==0) return ! nothing to be done -> early return
    
    allocate(phases(itemCount), newPhases(itemCount), stat=stat)
    if (ESMF_LogFoundAllocError(statusToCheck=stat, &
      msg="Allocation of temporary data structure.", &
      line=__LINE__, &
      file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
      
    ! get the current phases
    call NUOPC_CompAttributeGet(comp, name=trim(attributeName), &
      valueList=phases, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out

    ! filter all entries that do not match entries in acceptStringList
    iii=0 ! reset
    do i=1, itemCount
      ! see if there is a match with an entry in the acceptStringList
      do ii=1, acceptStringCount
        if (index(phases(i),trim(acceptStringList(ii))) > 0 ) exit
      enddo
      if (ii <= acceptStringCount) then
        ! found a match -> preserve the phaseMap entry
        iii = iii+1
        newPhases(iii) = trim(phases(i))
      endif
    enddo
    
    ! insert a dummy entry in case no entries are left
    if (iii==0) then
      iii=1
      newPhases(1) = "IPDvDummy=-999" ! something obvious
    endif
    
    ! set the filtered phase map as the Attribute
    call NUOPC_CompAttributeSet(comp, name=trim(attributeName), &
      valueList=newPhases(1:iii), rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out
    
    ! clean-up
    deallocate(phases, newPhases, stat=stat)
    if (ESMF_LogFoundDeallocError(statusToCheck=stat, &
      msg="Deallocation of phases, newPhases.", &
      line=__LINE__, &
      file=trim(name)//":"//FILENAME, &
      rcToReturn=rc)) return  ! bail out
    
  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompGet - Access info from GridComp
! !INTERFACE:
  ! Private name; call using NUOPC_CompGet()
  subroutine NUOPC_GridCompGet(comp, name, verbosity, profiling, diagnostic, rc)
! !ARGUMENTS:
    type(ESMF_GridComp)                       :: comp
    character(len=*),   intent(out), optional :: name
    integer,            intent(out), optional :: verbosity
    integer,            intent(out), optional :: profiling
    integer,            intent(out), optional :: diagnostic
    integer,            intent(out), optional :: rc 
!
! !DESCRIPTION:
! Access information from a GridComp.
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                         :: localrc
    character(ESMF_MAXSTR)          :: lName, valueString
    integer                         :: max, high, low
    
    ! query the component for its name
    call ESMF_GridCompGet(comp, name=lName, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(lName)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out
      
    if (present(name)) name=lName

    if (present(verbosity)) then
      ! initialize the output value
      verbosity = 0
      ! query the component for its kind
      call NUOPC_CompAttributeGet(comp, name="Kind", value=valueString, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(lName)//":"//FILENAME, rcToReturn=rc)) &
        return  ! bail out
      ! set component kind specific verbosity levels
      if (trim(valueString)=="Driver") then
        max   = 65535  ! all 16 lower bits set
        high  = 32625  ! bits 0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14
        low   =  9985  ! bits 0, 8, 9, 10, 13
      else if (trim(valueString)=="Model") then
        max   = 65535  ! all 16 lower bits set
        high  = 32561  ! bits 0, 4, 5, 8, 9, 10, 11, 12, 13, 14
        low   =  9985  ! bits 0, 8, 9, 10, 13
      else if (trim(valueString)=="Mediator") then
        max   = 65535  ! all 16 lower bits set
        high  = 32561  ! bits 0, 4, 5, 8, 9, 10, 11, 12, 13, 14
        low   =  9985  ! bits 0, 8, 9, 10, 13
      endif
      ! query the component for Verbosity
      call NUOPC_CompAttributeGet(comp, name="Verbosity", value=valueString, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(lName)//":"//FILENAME, rcToReturn=rc)) &
        return  ! bail out
      verbosity = ESMF_UtilString2Int(valueString, &
        specialStringList=(/"max ", "high", "low ", "off ", "F   "/), &
        specialValueList=(/max, high, low, 0, 0/), &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(lName)//":"//FILENAME, rcToReturn=rc)) &
        return  ! bail out
    endif
    
    if (present(profiling)) then
      ! initialize the output value
      profiling = 0
      ! query the component for Profiling
      call NUOPC_CompAttributeGet(comp, name="Profiling", value=valueString, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(lName)//":"//FILENAME, rcToReturn=rc)) &
        return  ! bail out
      profiling = ESMF_UtilString2Int(valueString, &
        specialStringList=(/"max ", "high", "low ", "off ", "F   "/), &
        specialValueList=(/65535, 511, 73, 0, 0/), &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(lName)//":"//FILENAME, rcToReturn=rc)) &
        return  ! bail out
    endif
    
    if (present(diagnostic)) then
      ! initialize the output value
      diagnostic = 0
      ! query the component for Diagnostic
      call NUOPC_CompAttributeGet(comp, name="Diagnostic", value=valueString, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(lName)//":"//FILENAME, rcToReturn=rc)) &
        return  ! bail out
      diagnostic = ESMF_UtilString2Int(valueString, &
        specialStringList=(/"max ", "high", "low ", "off ", "F   "/), &
        specialValueList=(/65535, 65535, 65535, 0, 0/), &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(lName)//":"//FILENAME, rcToReturn=rc)) &
        return  ! bail out
    endif
    
    ! return successfully
    if (present(rc)) rc = ESMF_SUCCESS
    
  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompGet - Access info from CplComp
! !INTERFACE:
  ! Private name; call using NUOPC_CompGet()
  subroutine NUOPC_CplCompGet(comp, name, verbosity, profiling, diagnostic, rc)
! !ARGUMENTS:
    type(ESMF_CplComp)                        :: comp
    character(len=*),   intent(out), optional :: name
    integer,            intent(out), optional :: verbosity
    integer,            intent(out), optional :: profiling
    integer,            intent(out), optional :: diagnostic
    integer,            intent(out), optional :: rc 
!
! !DESCRIPTION:
! Access information from a CplComp.
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                         :: localrc
    character(ESMF_MAXSTR)          :: lName, valueString
    integer                         :: max, high, low

    ! query the component for its name
    call ESMF_CplCompGet(comp, name=lName, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(lName)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out

    if (present(name)) name=lName

    if (present(verbosity)) then
      ! initialize the output value
      verbosity = 0
      ! set specific verbosity levels
      max   = 65535  ! all 16 lower bits set
      high  = 65329  ! bits 0, 4, 5, 8, 9, 10, 11, 12, 13, 14, 15
      low   =  8193  ! bits 0, 13
      ! query the component for Verbosity
      call NUOPC_CompAttributeGet(comp, name="Verbosity", value=valueString, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(lName)//":"//FILENAME, rcToReturn=rc)) &
        return  ! bail out
      verbosity = ESMF_UtilString2Int(valueString, &
        specialStringList=(/"max ", "high", "low ", "off ", "F   "/), &
        specialValueList=(/max, high, low, 0, 0/), &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(lName)//":"//FILENAME, rcToReturn=rc)) &
        return  ! bail out
    endif
    
    if (present(profiling)) then
      ! initialize the output value
      profiling = 0
      ! set specific verbosity levels
      max   = 65535  ! all 16 lower bits set
      high  =   511  ! all 9 lower bits set
      low   =    73  ! bits 0, 3, 6
      ! query the component for Profiling
      call NUOPC_CompAttributeGet(comp, name="Profiling", value=valueString, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(lName)//":"//FILENAME, rcToReturn=rc)) &
        return  ! bail out
      profiling = ESMF_UtilString2Int(valueString, &
        specialStringList=(/"max ", "high", "low ", "off ", "F   "/), &
        specialValueList=(/65535, 511, 73, 0, 0/), &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(lName)//":"//FILENAME, rcToReturn=rc)) &
        return  ! bail out
    endif
    
    if (present(diagnostic)) then
      ! initialize the output value
      diagnostic = 0
      ! query the component for Diagnostic
      call NUOPC_CompAttributeGet(comp, name="Diagnostic", value=valueString, &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(lName)//":"//FILENAME, rcToReturn=rc)) &
        return  ! bail out
      diagnostic = ESMF_UtilString2Int(valueString, &
        specialStringList=(/"max ", "high", "low ", "off ", "F   "/), &
        specialValueList=(/65535, 65535, 65535, 0, 0/), &
        rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(lName)//":"//FILENAME, rcToReturn=rc)) &
        return  ! bail out
    endif
    
    ! return successfully
    if (present(rc)) rc = ESMF_SUCCESS
    
  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompSearchPhaseMap - Search the Phase Map of a GridComp
! !INTERFACE:
  ! Private name; call using NUOPC_CompSearchPhaseMap()
  subroutine NUOPC_GridCompSearchPhaseMap(comp, methodflag, internalflag, &
    phaseLabel, phaseIndex, rc)
! !ARGUMENTS:
    type(ESMF_GridComp)                           :: comp
    type(ESMF_Method_Flag), intent(in)            :: methodflag
    logical,                intent(in),  optional :: internalflag
    character(len=*),       intent(in),  optional :: phaseLabel
    integer,                intent(out)           :: phaseIndex
    integer,                intent(out), optional :: rc 
!
! !DESCRIPTION:
! Search all PhaseMap entries in a GridComp (i.e. Model, Mediator, or Driver)
! to see if {\tt phaseLabel} is found. Return the associated ESMF
! {\tt phaseIndex}, or {\tt -1} if not found. If {\tt phaseLabel} is not
! specified, set {\tt phaseIndex} to the first entry in the PhaseMap, or 
! {\tt -1} if there are no entries. The {\tt internalflag} argument 
! allows to search the internal phase maps of driver components. The default
! is {\tt internalflag=.false.}.
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                   :: localrc
    integer                   :: i
    integer                   :: itemCount, stat, ind, max
    character(ESMF_MAXSTR)    :: name
    character(len=40)         :: attributeName
    logical                   :: phaseFlag
    logical                   :: internalflagOpt
    character(len=NUOPC_PhaseMapStringLength), pointer  :: phases(:)
    character(len=NUOPC_PhaseMapStringLength)           :: tempString
    logical                   :: isSet

    if (present(rc)) rc = ESMF_SUCCESS

    ! query the Component for info
    call ESMF_GridCompGet(comp, name=name, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out

    ! deal with optional input argument
    internalflagOpt=.false. ! default
    if (present(internalflag)) internalflagOpt=internalflag

    ! determine which phaseMap to deal with
    attributeName = "UnknownPhaseMap" ! initialize to something obvious
    if (methodflag == ESMF_METHOD_INITIALIZE) then
      attributeName = "InitializePhaseMap"
      if (internalflagOpt) attributeName = "InternalInitializePhaseMap"
    elseif (methodflag == ESMF_METHOD_RUN) then
      attributeName = "RunPhaseMap"
      if (internalflagOpt) attributeName = "InternalRunPhaseMap"
    elseif (methodflag == ESMF_METHOD_FINALIZE) then
      attributeName = "FinalizePhaseMap"
      if (internalflagOpt) attributeName = "InternalFinalizePhaseMap"
    endif
    
    phaseIndex = -1             ! initialize to invalid
    phaseFlag  = .false.        ! initialize
    
    ! access phaseMap info
    call NUOPC_CompAttributeGet(comp, name=trim(attributeName), &
      isSet=isSet, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out

    if (.not.isSet) return ! nothing to be done -> early return

    call NUOPC_CompAttributeGet(comp, name=trim(attributeName), &
      itemCount=itemCount, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out
    
    ! search the phaseMap
    if (itemCount > 0) then
      allocate(phases(itemCount), stat=stat)
      if (ESMF_LogFoundAllocError(statusToCheck=stat, &
        msg="Allocation of temporary data structure.", &
        line=__LINE__, &
        file=trim(name)//":"//FILENAME, &
        rcToReturn=rc)) return  ! bail out
      call NUOPC_CompAttributeGet(comp, name=trim(attributeName), &
        valueList=phases, rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
        return  ! bail out
      if (present(phaseLabel)) then
        do i=1, itemCount
          if (index(phases(i),trim(phaseLabel//"=")) > 0) exit
        enddo
        if (i <= itemCount) then
          ! phaseLabel was found
          phaseFlag = .true.
          tempString = trim(phases(i))
        endif
      else
        phaseFlag = .true.
        tempString = trim(phases(1))  ! by default select the first map entry
      endif
      if (phaseFlag) then
        ind = index(tempString, "=")
        max = len(tempString)
        read (tempString(ind+1:max), "(i4)") phaseIndex ! obtain phase index
      endif
      ! clean-up
      deallocate(phases, stat=stat)
      if (ESMF_LogFoundDeallocError(statusToCheck=stat, &
        msg="Deallocation of phases.", &
        line=__LINE__, &
        file=trim(name)//":"//FILENAME, &
        rcToReturn=rc)) return  ! bail out
    endif
  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompSearchPhaseMap - Search the Phase Map of a CplComp
! !INTERFACE:
  ! Private name; call using NUOPC_CompSearchPhaseMap()
  subroutine NUOPC_CplCompSearchPhaseMap(comp, methodflag, phaseLabel, &
    phaseIndex, rc)
! !ARGUMENTS:
    type(ESMF_CplComp)                            :: comp
    type(ESMF_Method_Flag), intent(in)            :: methodflag
    character(len=*),       intent(in),  optional :: phaseLabel
    integer,                intent(out)           :: phaseIndex
    integer,                intent(out), optional :: rc 
!
! !DESCRIPTION:
! Search all PhaseMap entries in a CplComp (i.e. Connector)
! to see if {\tt phaseLabel} is found. Return the associated ESMF
! {\tt phaseIndex}, or {\tt -1} if not found. If {\tt phaseLabel} is not
! specified, set {\tt phaseIndex} to the first entry in the PhaseMap, or 
! {\tt -1} if there are no entries.
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                   :: localrc
    integer                   :: i
    integer                   :: itemCount, stat, ind, max
    character(ESMF_MAXSTR)    :: name
    character(len=40)         :: attributeName
    logical                   :: phaseFlag
    character(len=NUOPC_PhaseMapStringLength), pointer  :: phases(:)
    character(len=NUOPC_PhaseMapStringLength)           :: tempString
    logical                   :: isSet

    if (present(rc)) rc = ESMF_SUCCESS

    ! query the Component for info
    call ESMF_CplCompGet(comp, name=name, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out

    ! determine which phaseMap to deal with
    attributeName = "UnknownPhaseMap" ! initialize to something obvious
    if (methodflag == ESMF_METHOD_INITIALIZE) then
      attributeName = "InitializePhaseMap"
    elseif (methodflag == ESMF_METHOD_RUN) then
      attributeName = "RunPhaseMap"
    elseif (methodflag == ESMF_METHOD_FINALIZE) then
      attributeName = "FinalizePhaseMap"
    endif
    
    phaseIndex = -1             ! initialize to invalid
    phaseFlag  = .false.        ! initialize
    
    ! access phaseMap info
    call NUOPC_CompAttributeGet(comp, name=trim(attributeName), &
      isSet=isSet, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out

    if (.not.isSet) return ! nothing to be done -> early return

    call NUOPC_CompAttributeGet(comp, name=trim(attributeName), &
      itemCount=itemCount, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out
    
    ! search the phaseMap
    if (itemCount > 0) then
      allocate(phases(itemCount), stat=stat)
      if (ESMF_LogFoundAllocError(statusToCheck=stat, &
        msg="Allocation of temporary data structure.", &
        line=__LINE__, &
        file=trim(name)//":"//FILENAME, &
        rcToReturn=rc)) return  ! bail out
      call NUOPC_CompAttributeGet(comp, name=trim(attributeName), &
        valueList=phases, rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
        return  ! bail out
      if (present(phaseLabel)) then
        do i=1, itemCount
          if (index(phases(i),trim(phaseLabel//"=")) > 0) exit
        enddo
        if (i <= itemCount) then
          ! phaseLabel was found
          phaseFlag = .true.
          tempString = trim(phases(i))
        endif
      else
        phaseFlag = .true.
        tempString = trim(phases(1))  ! by default select the first map entry
      endif
      if (phaseFlag) then
        ind = index(tempString, "=")
        max = len(tempString)
        read (tempString(ind+1:max), "(i4)") phaseIndex ! obtain phase index
      endif
      ! clean-up
      deallocate(phases, stat=stat)
      if (ESMF_LogFoundDeallocError(statusToCheck=stat, &
        msg="Deallocation of phases.", &
        line=__LINE__, &
        file=trim(name)//":"//FILENAME, &
        rcToReturn=rc)) return  ! bail out
    endif
  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompSearchRevPhaseMap - Reverse Search the Phase Map of a GridComp
! !INTERFACE:
  ! Private name; call using NUOPC_CompSearchRevPhaseMap()
  subroutine NUOPC_GridCompSearchRevPhaseMap(comp, methodflag, internalflag, &
    phaseIndex, phaseLabel, rc)
! !ARGUMENTS:
    type(ESMF_GridComp)                           :: comp
    type(ESMF_Method_Flag), intent(in)            :: methodflag
    logical,                intent(in),  optional :: internalflag
    integer,                intent(in),  optional :: phaseIndex
    character(len=*),       intent(out)           :: phaseLabel
    integer,                intent(out), optional :: rc 
!
! !DESCRIPTION:
! Search all PhaseMap entries in a GridComp (i.e. Model, Mediator, or Driver)
! to see if the ESMF {\tt phaseIndex} is found. Return the associated
! {\tt phaseLabel}, or an empty string if not found. If {\tt phaseIndex} is not
! specified, set {\tt phaseLabel} to the first entry in the PhaseMap, or 
! an empty string if there are no entries. The {\tt internalflag} argument 
! allows to search the internal phase maps of driver components. The default
! is {\tt internalflag=.false.}.
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                   :: localrc
    integer                   :: i
    integer                   :: itemCount, stat, ind, max
    character(ESMF_MAXSTR)    :: name, pString
    character(len=40)         :: attributeName
    logical                   :: phaseFlag
    logical                   :: internalflagOpt
    character(len=NUOPC_PhaseMapStringLength), allocatable  :: phases(:)
    character(len=NUOPC_PhaseMapStringLength)           :: tempString
    logical                   :: isSet
    type(ESMF_Info)           :: info

    if (present(rc)) rc = ESMF_SUCCESS

    ! query the Component for info
    call ESMF_GridCompGet(comp, name=name, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
      
    ! deal with optional input argument
    internalflagOpt=.false. ! default
    if (present(internalflag)) internalflagOpt=internalflag

    ! determine which phaseMap to deal with
    attributeName = "UnknownPhaseMap" ! initialize to something obvious
    if (methodflag == ESMF_METHOD_INITIALIZE) then
      attributeName = "InitializePhaseMap"
      if (internalflagOpt) attributeName = "InternalInitializePhaseMap"
    elseif (methodflag == ESMF_METHOD_RUN) then
      attributeName = "RunPhaseMap"
      if (internalflagOpt) attributeName = "InternalRunPhaseMap"
    elseif (methodflag == ESMF_METHOD_FINALIZE) then
      attributeName = "FinalizePhaseMap"
      if (internalflagOpt) attributeName = "InternalFinalizePhaseMap"
    endif
    
    phaseLabel = ""             ! initialize to empty string
    phaseFlag  = .false.        ! initialize
    
    ! access phaseMap info
    call ESMF_InfoGetFromHost(comp, info=info, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out

    ! see if phaseMap is set
    isSet = ESMF_InfoIsSet(info, key="/NUOPC/Instance/"//trim(attributeName), &
      rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out
    if (.not.isSet) return  ! early successful return

    ! search the phaseMap
    call ESMF_InfoGetAlloc(info, key="/NUOPC/Instance/"//trim(attributeName), &
      values=phases, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    itemCount = size(phases)
    if (present(phaseIndex)) then
      write (pString,*) phaseIndex
      do i=1, itemCount
        if (index(phases(i),trim("="//trim(adjustl(pString)))) > 0) exit
      enddo
      if (i <= itemCount) then
        ! phaseIndex was found
        phaseFlag = .true.
        tempString = trim(phases(i))
      endif
    else
      phaseFlag = .true.
      tempString = trim(phases(1))  ! by default select the first map entry
    endif
    if (phaseFlag) then
      ind = index(tempString, "=")
      read (tempString(1:ind-1), "(A)") phaseLabel ! obtain phase index
    endif
    ! clean-up
    deallocate(phases, stat=stat)
    if (ESMF_LogFoundDeallocError(statusToCheck=stat, &
      msg="Deallocation of phases.", &
      line=__LINE__, &
      file=trim(name)//":"//FILENAME, &
      rcToReturn=rc)) return  ! bail out
  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompSearchRevPhaseMap - Reverse Search the Phase Map of a CplComp
! !INTERFACE:
  ! Private name; call using NUOPC_CompSearchRevPhaseMap()
  subroutine NUOPC_CplCompSearchRevPhaseMap(comp, methodflag, phaseIndex, &
    phaseLabel, rc)
! !ARGUMENTS:
    type(ESMF_CplComp)                            :: comp
    type(ESMF_Method_Flag), intent(in)            :: methodflag
    integer,                intent(in),  optional :: phaseIndex
    character(len=*),       intent(out)           :: phaseLabel
    integer,                intent(out), optional :: rc 
!
! !DESCRIPTION:
! Search all PhaseMap entries in a CplComp (i.e. Connector)
! to see if the ESMF {\tt phaseIndex} is found. Return the associated
! {\tt phaseLabel}, or an empty string if not found. If {\tt phaseIndex} is not
! specified, set {\tt phaseLabel} to the first entry in the PhaseMap, or 
! an empty string if there are no entries.
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                   :: localrc
    integer                   :: i
    integer                   :: itemCount, stat, ind, max
    character(ESMF_MAXSTR)    :: name, pString
    character(len=40)         :: attributeName
    logical                   :: phaseFlag
    character(len=NUOPC_PhaseMapStringLength), allocatable  :: phases(:)
    character(len=NUOPC_PhaseMapStringLength)           :: tempString
    logical                   :: isSet
    type(ESMF_Info)           :: info
    
    if (present(rc)) rc = ESMF_SUCCESS

    ! query the Component for info
    call ESMF_CplCompGet(comp, name=name, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out

    ! determine which phaseMap to deal with
    attributeName = "UnknownPhaseMap" ! initialize to something obvious
    if (methodflag == ESMF_METHOD_INITIALIZE) then
      attributeName = "InitializePhaseMap"
    elseif (methodflag == ESMF_METHOD_RUN) then
      attributeName = "RunPhaseMap"
    elseif (methodflag == ESMF_METHOD_FINALIZE) then
      attributeName = "FinalizePhaseMap"
    endif
    
    phaseLabel = ""             ! initialize to empty string
    phaseFlag  = .false.        ! initialize
    
    ! access phaseMap info
    call ESMF_InfoGetFromHost(comp, info=info, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out

    ! see if phaseMap is set
    isSet = ESMF_InfoIsSet(info, key="/NUOPC/Instance/"//trim(attributeName), &
      rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) &
      return  ! bail out
    if (.not.isSet) return  ! early successful return

    ! search the phaseMap
    call ESMF_InfoGetAlloc(info, key="/NUOPC/Instance/"//trim(attributeName), &
      values=phases, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    itemCount = size(phases)
    if (present(phaseIndex)) then
      write (pString,*) phaseIndex
      do i=1, itemCount
        if (index(phases(i),trim("="//trim(adjustl(pString)))) > 0) exit
      enddo
      if (i <= itemCount) then
        ! phaseIndex was found
        phaseFlag = .true.
        tempString = trim(phases(i))
      endif
    else
      phaseFlag = .true.
      tempString = trim(phases(1))  ! by default select the first map entry
    endif
    if (phaseFlag) then
      ind = index(tempString, "=")
      read (tempString(1:ind-1), "(A)") phaseLabel ! obtain phase index
    endif
    ! clean-up
    deallocate(phases, stat=stat)
    if (ESMF_LogFoundDeallocError(statusToCheck=stat, &
      msg="Deallocation of phases.", &
      line=__LINE__, &
      file=trim(name)//":"//FILENAME, &
      rcToReturn=rc)) return  ! bail out
  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompSetClock - Initialize and set the internal Clock of a GridComp
! !INTERFACE:
  ! Private name; call using NUOPC_CompSetClock()
  subroutine NUOPC_GridCompSetClock(comp, externalClock, stabilityTimeStep, rc)
! !ARGUMENTS:
    type(ESMF_GridComp),     intent(inout)         :: comp
    type(ESMF_Clock),        intent(in)            :: externalClock
    type(ESMF_TimeInterval), intent(in),  optional :: stabilityTimeStep
    integer,                 intent(out), optional :: rc
! !DESCRIPTION:
!   \label{NUOPC_GridCompSetClock}
!
!   Set the component internal clock as a copy of {\tt externalClock}, but
!   with a timeStep that is less than or equal to the stabilityTimeStep.
!   At the same time ensure that the timeStep of the external clock is
!   a multiple of the timeStep of the internal clock. If the stabilityTimeStep
!   argument is not provided then the internal clock will simply be set
!   as a copy of the external clock.
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                 :: localrc
    type(ESMF_Clock)        :: internalClock

    if (present(rc)) rc = ESMF_SUCCESS
    
    internalClock = ESMF_ClockCreate(externalClock, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out

    call NUOPC_AdjustClock(internalClock, stabilityTimeStep, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out

    call ESMF_GridCompSet(comp, clock=internalClock, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
  end subroutine
  !-----------------------------------------------------------------------------
  
  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompSetEntryPoint - Set entry point for a GridComp (DEPRECATED!)
!
! !INTERFACE:
  ! Private name; call using NUOPC_CompSetEntryPoint()
  subroutine NUOPC_GridCompSetEntryPoint(comp, methodflag, phaseLabelList, &
    userRoutine, rc)
! !ARGUMENTS:
    type(ESMF_GridComp)                     :: comp
    type(ESMF_Method_Flag), intent(in)      :: methodflag
    character(len=*),       intent(in)      :: phaseLabelList(:)
    interface
      subroutine userRoutine(gridcomp, importState, exportState, clock, rc)
        use ESMF_CompMod
        use ESMF_StateMod
        use ESMF_ClockMod
        implicit none
        type(ESMF_GridComp)         :: gridcomp     ! must not be optional
        type(ESMF_State)            :: importState  ! must not be optional
        type(ESMF_State)            :: exportState  ! must not be optional
        type(ESMF_Clock)            :: clock        ! must not be optional
        integer, intent(out)        :: rc           ! must not be optional
      end subroutine
    end interface
    integer,          intent(out), optional :: rc 
!
! !DESCRIPTION:
! Set an entry point for a GridComp (i.e. Model, Mediator, or Driver). Publish
! the new entry point in the correct {\tt PhaseMap} component attribute.
!
! Starting with version 8.1.0, the use of this method is deprecated. Components
! should instead specialize exclusively using the {\tt NUOPC\_CompSpecialize()}
! method.
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                   :: localrc
    integer                   :: i, ii, iii
    character(ESMF_MAXSTR)    :: name
    integer                   :: phase, itemCount, phaseLabelCount, stat
    character(len=8)          :: phaseString
    character(len=40)         :: attributeName
    character(len=NUOPC_PhaseMapStringLength), pointer :: phases(:)
    logical                   :: isSet

    if (present(rc)) rc = ESMF_SUCCESS
    
    ! query the Component for info
    call ESMF_GridCompGet(comp, name=name, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out

    ! determine next available phase index    
    call ESMF_GridCompGetEPPhaseCount(comp, methodflag, &
      phaseCount=phase, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    
    phase = phase + 1

    ! set the entry point with this phase index
    call ESMF_GridCompSetEntryPoint(comp, methodflag, userRoutine=userRoutine, &
      phase=phase, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    
    ! determine which phaseMap to deal with
    attributeName = "UnknownPhaseMap" ! initialize to something obvious
    if (methodflag == ESMF_METHOD_INITIALIZE) then
      attributeName = "InitializePhaseMap"
    elseif (methodflag == ESMF_METHOD_RUN) then
      attributeName = "RunPhaseMap"
    elseif (methodflag == ESMF_METHOD_FINALIZE) then
      attributeName = "FinalizePhaseMap"
    endif
    
    ! determine how many phaseLabels are contained in the incoming list
    phaseLabelCount = size(phaseLabelList)
    
    ! query the already existing phaseMap enties
    call NUOPC_CompAttributeGet(comp, name=trim(attributeName), &
      isSet=isSet, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    itemCount=0
    if (isSet) then
      call NUOPC_CompAttributeGet(comp, name=trim(attributeName), &
        itemCount=itemCount, rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    endif
    allocate(phases(itemCount+phaseLabelCount), stat=stat) ! space to add more
    if (ESMF_LogFoundAllocError(statusToCheck=stat, &
      msg="Allocation of temporary data structure.", &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    if (isSet .and. (itemCount > 0)) then
      call NUOPC_CompAttributeGet(comp, name=trim(attributeName), &
        valueList=phases(1:itemcount), rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    endif
    
    ! add the new entries to the phaseMap
    write(phaseString, "(I6)") phase
    iii=0 ! initialize
    do i=1, phaseLabelCount
      ! see if this same phaseLabel has already been used before
      do ii=1, itemCount
        if (index(phases(ii),trim(phaseLabelList(i))) > 0 ) exit
      enddo
      if (ii <= itemCount) then
        ! overwrite an existing entry with the same phaseLabel
        phases(ii) = trim(phaseLabelList(i))//"="//&
          trim(adjustl(phaseString))
      else
        ! add a new entry for the phaseLabel at the end of the list
        iii = iii+1
        phases(itemCount+iii) = trim(phaseLabelList(i))//"="//&
          trim(adjustl(phaseString))
      endif
    enddo
    
    ! set the new phaseMap in the Attribute
    call NUOPC_CompAttributeSet(comp, name=trim(attributeName), &
      valueList=phases(1:itemCount+iii), rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    
    if (methodflag == ESMF_METHOD_INITIALIZE) then
      ! Set IPDvX attribute to false, indicating use of SetEntryPoint()
      call NUOPC_CompAttributeSet(comp, name="IPDvX", value="false", rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    endif
    
    ! clean-up
    deallocate(phases, stat=stat)
    if (ESMF_LogFoundDeallocError(statusToCheck=stat, &
      msg="Deallocation of phases.", &
      line=__LINE__, &
      file=trim(name)//":"//FILENAME, &
      rcToReturn=rc)) return  ! bail out
    
  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompSetEntryPoint - Set entry point for a CplComp (DEPRECATED!)
!
! !INTERFACE:
  ! Private name; call using NUOPC_CompSetEntryPoint()
  subroutine NUOPC_CplCompSetEntryPoint(comp, methodflag, phaseLabelList, &
    userRoutine, rc)
! !ARGUMENTS:
    type(ESMF_CplComp)                      :: comp
    type(ESMF_Method_Flag), intent(in)      :: methodflag
    character(len=*),       intent(in)      :: phaseLabelList(:)
    interface
      subroutine userRoutine(cplcomp, importState, exportState, clock, rc)
        use ESMF_CompMod
        use ESMF_StateMod
        use ESMF_ClockMod
        implicit none
        type(ESMF_CplComp)          :: cplcomp      ! must not be optional
        type(ESMF_State)            :: importState  ! must not be optional
        type(ESMF_State)            :: exportState  ! must not be optional
        type(ESMF_Clock)            :: clock        ! must not be optional
        integer, intent(out)        :: rc           ! must not be optional
      end subroutine
    end interface
    integer,          intent(out), optional :: rc 
!
! !DESCRIPTION:
! Set an entry point for a CplComp (i.e. Connector). Publish
! the new entry point in the correct {\tt PhaseMap} component attribute.
!
! Starting with version 8.1.0, the use of this method is deprecated. Components
! should instead specialize exclusively using the {\tt NUOPC\_CompSpecialize()}
! method.
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                   :: localrc
    integer                   :: i, ii, iii
    character(ESMF_MAXSTR)    :: name
    integer                   :: phase, itemCount, phaseLabelCount, stat
    character(len=8)          :: phaseString
    character(len=40)         :: attributeName
    character(len=NUOPC_PhaseMapStringLength), pointer :: phases(:)
    logical                   :: isSet

    if (present(rc)) rc = ESMF_SUCCESS

    ! query the Component for info
    call ESMF_CplCompGet(comp, name=name, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out

    ! determine next available phase index    
    call ESMF_CplCompGetEPPhaseCount(comp, methodflag, &
      phaseCount=phase, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    
    phase = phase + 1

    ! set the entry point with this phase index
    call ESMF_CplCompSetEntryPoint(comp, methodflag, userRoutine=userRoutine, &
      phase=phase, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    
    ! determine which phaseMap to deal with
    attributeName = "UnknownPhaseMap" ! initialize to something obvious
    if (methodflag == ESMF_METHOD_INITIALIZE) then
      attributeName = "InitializePhaseMap"
    elseif (methodflag == ESMF_METHOD_RUN) then
      attributeName = "RunPhaseMap"
    elseif (methodflag == ESMF_METHOD_FINALIZE) then
      attributeName = "FinalizePhaseMap"
    endif
    
    ! determine how many phaseLabels are contained in the incoming list
    phaseLabelCount = size(phaseLabelList)
    
    ! query the already existing phaseMap enties
    call NUOPC_CompAttributeGet(comp, name=trim(attributeName), &
      isSet=isSet, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    itemCount=0
    if (isSet) then
      call NUOPC_CompAttributeGet(comp, name=trim(attributeName), &
        itemCount=itemCount, rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    endif
    allocate(phases(itemCount+phaseLabelCount), stat=stat) ! space to add more
    if (ESMF_LogFoundAllocError(statusToCheck=stat, &
      msg="Allocation of temporary data structure.", &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    if (isSet .and. (itemCount > 0)) then
      call NUOPC_CompAttributeGet(comp, name=trim(attributeName), &
        valueList=phases(1:itemcount), rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    endif
    
    ! add the new entries to the phaseMap
    write(phaseString, "(I6)") phase
    iii=0 ! initialize
    do i=1, phaseLabelCount
      ! see if this same phaseLabel has already been used before
      do ii=1, itemCount
        if (index(phases(ii),trim(phaseLabelList(i))) > 0 ) exit
      enddo
      if (ii <= itemCount) then
        ! overwrite an existing entry with the same phaseLabel
        phases(ii) = trim(phaseLabelList(i))//"="//&
          trim(adjustl(phaseString))
      else
        ! add a new entry for the phaseLabel at the end of the list
        iii = iii+1
        phases(itemCount+iii) = trim(phaseLabelList(i))//"="//&
          trim(adjustl(phaseString))
      endif
    enddo

    ! set the new phaseMap in the Attribute
    call NUOPC_CompAttributeSet(comp, name=trim(attributeName), &
      valueList=phases(1:itemCount+iii), rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out

    if (methodflag == ESMF_METHOD_INITIALIZE) then
      ! Set IPDvX attribute to false, indicating use of SetEntryPoint()
      call NUOPC_CompAttributeSet(comp, name="IPDvX", value="false", rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    endif

    ! clean-up
    deallocate(phases, stat=stat)
    if (ESMF_LogFoundDeallocError(statusToCheck=stat, &
      msg="Deallocation of phases.", &
      line=__LINE__, &
      file=trim(name)//":"//FILENAME, &
      rcToReturn=rc)) return  ! bail out
    
  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompSetInternalEntryPoint - Set internal entry point for a GridComp
!
! !INTERFACE:
  ! Private name; call using NUOPC_CompSetInternalEntryPoint()
  subroutine NUOPC_GridCompSetIntEntryPoint(comp, methodflag, phaseLabelList, &
    userRoutine, rc)
! !ARGUMENTS:
    type(ESMF_GridComp)                     :: comp
    type(ESMF_Method_Flag), intent(in)      :: methodflag
    character(len=*),       intent(in)      :: phaseLabelList(:)
    interface
      subroutine userRoutine(gridcomp, importState, exportState, clock, rc)
        use ESMF_CompMod
        use ESMF_StateMod
        use ESMF_ClockMod
        implicit none
        type(ESMF_GridComp)         :: gridcomp     ! must not be optional
        type(ESMF_State)            :: importState  ! must not be optional
        type(ESMF_State)            :: exportState  ! must not be optional
        type(ESMF_Clock)            :: clock        ! must not be optional
        integer, intent(out)        :: rc           ! must not be optional
      end subroutine
    end interface
    integer,          intent(out), optional :: rc 
!
! !DESCRIPTION:
! Set an {\em internal} entry point for a GridComp (i.e. Driver). Only Drivers 
! currently utilize internal entry points. Internal entry points allow user
! specialization on the driver level during initialization and run sequencing.
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer                   :: localrc
    integer                   :: i, ii, iii
    character(ESMF_MAXSTR)    :: name
    integer                   :: phase, itemCount, phaseLabelCount, stat
    character(len=8)          :: phaseString
    character(len=40)         :: attributeName
    character(len=NUOPC_PhaseMapStringLength), pointer :: phases(:)
    logical                   :: isSet

    if (present(rc)) rc = ESMF_SUCCESS
    
    ! query the Component for info
    call ESMF_GridCompGet(comp, name=name, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out

    ! determine next available phase index    
    call ESMF_GridCompGetEPPhaseCount(comp, methodflag, &
      phaseCount=phase, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    
    phase = phase + 1

    ! set the entry point with this phase index
    call ESMF_GridCompSetEntryPoint(comp, methodflag, userRoutine=userRoutine, &
      phase=phase, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    
!print *, "NUOPC_GridCompSetEntryPoint: phaseLabelList:", &
!phaseLabelList, "     phase:", phase

    ! determine which phaseMap to deal with
    attributeName = "UnknownPhaseMap" ! initialize to something obvious
    if (methodflag == ESMF_METHOD_INITIALIZE) then
      attributeName = "InternalInitializePhaseMap"
    elseif (methodflag == ESMF_METHOD_RUN) then
      attributeName = "InternalRunPhaseMap"
    elseif (methodflag == ESMF_METHOD_FINALIZE) then
      attributeName = "InternalFinalizePhaseMap"
    endif
    
    ! determine how many phaseLabels are contained in the incoming list
    phaseLabelCount = size(phaseLabelList)
    
    ! query the already existing phaseMap enties
    call NUOPC_CompAttributeGet(comp, name=trim(attributeName), &
      isSet=isSet, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    itemCount=0
    if (isSet) then
      call NUOPC_CompAttributeGet(comp, name=trim(attributeName), &
        itemCount=itemCount, rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    endif
    allocate(phases(itemCount+phaseLabelCount), stat=stat) ! space to add more
    if (ESMF_LogFoundAllocError(statusToCheck=stat, &
      msg="Allocation of temporary data structure.", &
      line=__LINE__, file=trim(name)//":"//FILENAME, &
      rcToReturn=rc)) return  ! bail out
    if (isSet .and. (itemCount > 0)) then
      call NUOPC_CompAttributeGet(comp, name=trim(attributeName), &
        valueList=phases(1:itemcount), rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    endif
    
    ! add the new entries to the phaseMap
    write(phaseString, "(I6)") phase
    iii=0 ! initialize
    do i=1, phaseLabelCount
      ! see if this same phaseLabel has already been used before
      do ii=1, itemCount
        if (index(phases(ii),trim(phaseLabelList(i))) > 0 ) exit
      enddo
      if (ii <= itemCount) then
        ! overwrite an existing entry with the same phaseLabel
        phases(ii) = trim(phaseLabelList(i))//"="//&
          trim(adjustl(phaseString))
      else
        ! add a new entry for the phaseLabel at the end of the list
        iii = iii+1
        phases(itemCount+iii) = trim(phaseLabelList(i))//"="//&
          trim(adjustl(phaseString))
      endif
    enddo
    
    ! set the new phaseMap in the Attribute
    call NUOPC_CompAttributeSet(comp, name=trim(attributeName), &
      valueList=phases(1:itemCount+iii), rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    
    ! clean-up
    deallocate(phases, stat=stat)
    if (ESMF_LogFoundDeallocError(statusToCheck=stat, &
      msg="Deallocation of phases.", &
      line=__LINE__, &
      file=trim(name)//":"//FILENAME, &
      rcToReturn=rc)) return  ! bail out

  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompSetServices - Try to find and call SetServices in a shared object
! !INTERFACE:
  ! Private name; call using NUOPC_CompSetServices()
  recursive subroutine NUOPC_GridCompSetServices(comp, sharedObj, userRc, rc)
! !ARGUMENTS:
    type(ESMF_GridComp),     intent(inout)         :: comp
    character(len=*),        intent(in),  optional :: sharedObj
    integer,                 intent(out), optional :: userRc
    integer,                 intent(out), optional :: rc
! !DESCRIPTION:
!   Try to find a routine called "{\tt SetServices}" in the {\tt sharedObj} file
!   and execute the routine. An attempt is made to find a routine that
!   is close in name to "{\tt SetServices}", allowing for compiler name
!   mangling, i.e. upper and lower case, as well as trailing underscores.
!   The asterisk character {\tt (*)} is supported as a wildcard for the
!   file name suffix in {\tt sharedObj}. When present, the asterisk is replaced
!   by "so", "dylib", and "dll", in this order, and the first successfully
!   loaded object is used. If the {\tt sharedObj} argument is not provided, the
!   executable itself is searched.
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer           :: localrc
    logical           :: userRoutineFound

    if (present(rc)) rc = ESMF_SUCCESS

    ! attempt to find something called SetServices, allowing variations
    ! caused by compiler name mangling

    call ESMF_GridCompSetServices(comp, userRoutine="setservices", &
      sharedObj=sharedObj, userRoutineFound=userRoutineFound, &
      userRc=userRc, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
    if (userRoutineFound) return ! bail out successfully

    call ESMF_GridCompSetServices(comp, userRoutine="setservices_", &
      sharedObj=sharedObj, userRoutineFound=userRoutineFound, &
      userRc=userRc, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
    if (userRoutineFound) return ! bail out successfully

    call ESMF_GridCompSetServices(comp, userRoutine="setservices__", &
      sharedObj=sharedObj, userRoutineFound=userRoutineFound, &
      userRc=userRc, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
    if (userRoutineFound) return ! bail out successfully

    call ESMF_GridCompSetServices(comp, userRoutine="SETSERVICES", &
      sharedObj=sharedObj, userRoutineFound=userRoutineFound, &
      userRc=userRc, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
    if (userRoutineFound) return ! bail out successfully

    call ESMF_GridCompSetServices(comp, userRoutine="SETSERVICES_", &
      sharedObj=sharedObj, userRoutineFound=userRoutineFound, &
      userRc=userRc, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
    if (userRoutineFound) return ! bail out successfully

    call ESMF_GridCompSetServices(comp, userRoutine="SETSERVICES__", &
      sharedObj=sharedObj, userRoutineFound=userRoutineFound, &
      userRc=userRc, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
    if (userRoutineFound) return ! bail out successfully

    call ESMF_GridCompSetServices(comp, userRoutine="SetServices", &
      sharedObj=sharedObj, userRoutineFound=userRoutineFound, &
      userRc=userRc, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
    if (userRoutineFound) return ! bail out successfully

    call ESMF_GridCompSetServices(comp, userRoutine="SetServices_", &
      sharedObj=sharedObj, userRoutineFound=userRoutineFound, &
      userRc=userRc, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
    if (userRoutineFound) return ! bail out successfully

    call ESMF_GridCompSetServices(comp, userRoutine="SetServices__", &
      sharedObj=sharedObj, userRoutineFound=userRoutineFound, &
      userRc=userRc, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
    if (userRoutineFound) return ! bail out successfully

    ! getting down to here means that none of the attempts were successful
    if (present(sharedObj)) then
      call ESMF_LogSetError(ESMF_RC_ARG_BAD, &
        msg="Could not find a matching SetServices routine in "//trim(sharedObj),&
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)
    else
      call ESMF_LogSetError(ESMF_RC_ARG_BAD, &
        msg="Could not find a matching SetServices routine in the executable.", &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)
    endif

  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompSetVM - Try to find and call SetVM in a shared object
! !INTERFACE:
  ! Private name; call using NUOPC_CompSetVM()
  recursive subroutine NUOPC_GridCompSetVM(comp, sharedObj, userRc, rc)
! !ARGUMENTS:
    type(ESMF_GridComp),     intent(inout)         :: comp
    character(len=*),        intent(in),  optional :: sharedObj
    integer,                 intent(out), optional :: userRc
    integer,                 intent(out), optional :: rc
! !DESCRIPTION:
!   Try to find a routine called "{\tt SetVM}" in the {\tt sharedObj} file
!   and execute the routine. An attempt is made to find a routine that
!   is close in name to "{\tt SetVM}", allowing for compiler name
!   mangling, i.e. upper and lower case, as well as trailing underscores.
!   The asterisk character {\tt (*)} is supported as a wildcard for the
!   file name suffix in {\tt sharedObj}. When present, the asterisk is replaced
!   by "so", "dylib", and "dll", in this order, and the first successfully
!   loaded object is used. If the {\tt sharedObj} argument is not provided, the
!   executable itself is searched.
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    integer           :: localrc
    logical           :: userRoutineFound

    if (present(rc)) rc = ESMF_SUCCESS

    ! attempt to find something called SetVM, allowing variations
    ! caused by compiler name mangling

    call ESMF_GridCompSetVM(comp, userRoutine="setvm", &
      sharedObj=sharedObj, userRoutineFound=userRoutineFound, &
      userRc=userRc, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
    if (userRoutineFound) return ! bail out successfully

    call ESMF_GridCompSetVM(comp, userRoutine="setvm_", &
      sharedObj=sharedObj, userRoutineFound=userRoutineFound, &
      userRc=userRc, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
    if (userRoutineFound) return ! bail out successfully

    call ESMF_GridCompSetVM(comp, userRoutine="setvm__", &
      sharedObj=sharedObj, userRoutineFound=userRoutineFound, &
      userRc=userRc, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
    if (userRoutineFound) return ! bail out successfully

    call ESMF_GridCompSetVM(comp, userRoutine="SETVM", &
      sharedObj=sharedObj, userRoutineFound=userRoutineFound, &
      userRc=userRc, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
    if (userRoutineFound) return ! bail out successfully

    call ESMF_GridCompSetVM(comp, userRoutine="SETVM_", &
      sharedObj=sharedObj, userRoutineFound=userRoutineFound, &
      userRc=userRc, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
    if (userRoutineFound) return ! bail out successfully

    call ESMF_GridCompSetVM(comp, userRoutine="SETVM__", &
      sharedObj=sharedObj, userRoutineFound=userRoutineFound, &
      userRc=userRc, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
    if (userRoutineFound) return ! bail out successfully

    call ESMF_GridCompSetVM(comp, userRoutine="SetVM", &
      sharedObj=sharedObj, userRoutineFound=userRoutineFound, &
      userRc=userRc, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
    if (userRoutineFound) return ! bail out successfully

    call ESMF_GridCompSetVM(comp, userRoutine="SetVM_", &
      sharedObj=sharedObj, userRoutineFound=userRoutineFound, &
      userRc=userRc, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
    if (userRoutineFound) return ! bail out successfully

    call ESMF_GridCompSetVM(comp, userRoutine="SetVM__", &
      sharedObj=sharedObj, userRoutineFound=userRoutineFound, &
      userRc=userRc, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, &
      file=FILENAME, &
      rcToReturn=rc)) &
      return  ! bail out
    if (userRoutineFound) return ! bail out successfully

    ! getting down to here means that none of the attempts were successful
    if (present(sharedObj)) then
      call ESMF_LogSetError(ESMF_RC_ARG_BAD, &
        msg="Could not find a matching SetVM routine in "//trim(sharedObj),&
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)
    else
      call ESMF_LogSetError(ESMF_RC_ARG_BAD, &
        msg="Could not find a matching SetVM routine in the executable.", &
        line=__LINE__, &
        file=FILENAME, &
        rcToReturn=rc)
    endif

  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompSpecialize - Specialize a derived GridComp
!
! !INTERFACE:
  ! Private name; call using NUOPC_CompSpecialize()
  subroutine NUOPC_GridCompSpecialize(comp, specLabel, specPhaseLabel, &
    specRoutine, rc)
! !ARGUMENTS:
    type(ESMF_GridComp)                     :: comp
    character(len=*), intent(in)            :: specLabel
    character(len=*), intent(in),  optional :: specPhaseLabel
    interface
      subroutine specRoutine(gridcomp, rc)
        use ESMF
        implicit none
        type(ESMF_GridComp)        :: gridcomp ! must not be optional
        integer, intent(out)       :: rc       ! must not be optional
      end subroutine
    end interface
    integer,          intent(out), optional :: rc 
!
! !DESCRIPTION:
! Specialize a derived GridComp (i.e. Model, Mediator, or Driver). If
! {\tt specPhaseLabel} is specified, the specialization only applies to
! the associated phase. Otherwise the specialization applies to all phases.
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    character(ESMF_MAXSTR)    :: name
    integer                   :: phaseIndex
    integer                   :: localrc
    logical                   :: isPresent, isSet

    if (present(rc)) rc = ESMF_SUCCESS

    ! query the Component for info
    call ESMF_GridCompGet(comp, name=name, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    
    ! sanity check whether this is a NUOPC derived component or not
    call NUOPC_CompAttributeGet(comp, name="Kind", isPresent=isPresent, &
      isSet=isSet, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    if (.not.isPresent .or. .not.isSet) then
      ! this does not look like a NUOPC derived component
      call ESMF_LogSetError(ESMF_RC_ARG_BAD, &
        msg="This does not look like a NUOPC derived component. "// &
          "Make sure NUOPC_CompDerive() is called before specializing.", &
        line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)
      return  ! bail out
    endif

    if (present(specPhaseLabel)) then
      ! Figure out the phase index
      call NUOPC_CompSearchPhaseMap(comp, methodflag=ESMF_METHOD_RUN, &
        phaseLabel=specPhaseLabel, phaseIndex=phaseIndex, rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
      if (phaseIndex < 0) then
        ! specPhaseLabel was not found
        call ESMF_LogSetError(ESMF_RC_ARG_BAD, &
          msg="specPhaseLabel could not be identified.", &
          line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)
        return  ! bail out
      endif
      ! add the method under the specific phase index
      call ESMF_MethodAddReplace(comp, label=specLabel, index=phaseIndex, &
        userRoutine=specRoutine, rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    else
      ! add the method under under no specific phase index
      call ESMF_MethodAddReplace(comp, label=specLabel, &
        userRoutine=specRoutine, rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    endif
    
  end subroutine
  !-----------------------------------------------------------------------------

  !-----------------------------------------------------------------------------
!BOP
! !IROUTINE: NUOPC_CompSpecialize - Specialize a derived CplComp
!
! !INTERFACE:
  ! Private name; call using NUOPC_CompSpecialize()
  subroutine NUOPC_CplCompSpecialize(comp, specLabel, specPhaseLabel, &
    specRoutine, rc)
! !ARGUMENTS:
    type(ESMF_CplComp)                      :: comp
    character(len=*), intent(in)            :: specLabel
    character(len=*), intent(in),  optional :: specPhaseLabel
    interface
      subroutine specRoutine(cplcomp, rc)
        use ESMF
        implicit none
        type(ESMF_CplComp)         :: cplcomp  ! must not be optional
        integer, intent(out)       :: rc       ! must not be optional
      end subroutine
    end interface
    integer,          intent(out), optional :: rc 
!
! !DESCRIPTION:
! Specialize a derived CplComp (i.e. Connector). If
! {\tt specPhaseLabel} is specified, the specialization only applies to
! the associated phase. Otherwise the specialization applies to all phases.
!EOP
  !-----------------------------------------------------------------------------
    ! local variables
    character(ESMF_MAXSTR)    :: name
    integer                   :: phaseIndex
    integer                   :: localrc
    logical                   :: isPresent, isSet

    if (present(rc)) rc = ESMF_SUCCESS

    ! query the Component for info
    call ESMF_CplCompGet(comp, name=name, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    
    ! sanity check whether this is a NUOPC derived component or not
    call NUOPC_CompAttributeGet(comp, name="Kind", isPresent=isPresent, &
      isSet=isSet, rc=localrc)
    if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
      line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    if (.not.isPresent .or. .not.isSet) then
      ! this does not look like a NUOPC derived component
      call ESMF_LogSetError(ESMF_RC_ARG_BAD, &
        msg="This does not look like a NUOPC derived component. "// &
          "Make sure NUOPC_CompDerive() is called before specializing.", &
        line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)
      return  ! bail out
    endif

    if (present(specPhaseLabel)) then
      ! Figure out the phase index
      call NUOPC_CompSearchPhaseMap(comp, methodflag=ESMF_METHOD_RUN, &
        phaseLabel=specPhaseLabel, phaseIndex=phaseIndex, rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
      if (phaseIndex < 0) then
        ! specPhaseLabel was not found
        call ESMF_LogSetError(ESMF_RC_ARG_BAD, &
          msg="specPhaseLabel could not be identified.", &
          line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)
        return  ! bail out
      endif
      ! add the method under the specific phase index
      call ESMF_MethodAddReplace(comp, label=specLabel, index=phaseIndex, &
        userRoutine=specRoutine, rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    else
      ! add the method under under no specific phase index
      call ESMF_MethodAddReplace(comp, label=specLabel, &
        userRoutine=specRoutine, rc=localrc)
      if (ESMF_LogFoundError(rcToCheck=localrc, msg=ESMF_LOGERR_PASSTHRU, &
        line=__LINE__, file=trim(name)//":"//FILENAME, rcToReturn=rc)) return  ! bail out
    endif
    
  end subroutine
  !-----------------------------------------------------------------------------

end module
