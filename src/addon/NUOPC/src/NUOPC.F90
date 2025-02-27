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
#define FILENAME "src/addon/NUOPC/src/NUOPC.F90"
!==============================================================================

module NUOPC

  !-----------------------------------------------------------------------------
  ! Generic code collection
  !-----------------------------------------------------------------------------

  use ESMF
  use NUOPC_FreeFormatDef
  use NUOPC_Base
  use NUOPC_Auxiliary
  use NUOPC_Comp

  implicit none
  
  private

  ! public
  public NUOPC_PhaseMapStringLength       ! parameter
  
  ! public FreeFormat API
  public NUOPC_FreeFormat                 ! type
  public NUOPC_FreeFormatLen              ! parameter
  public NUOPC_FreeFormatAdd              ! method
  public NUOPC_FreeFormatCreate           ! method
  public NUOPC_FreeFormatDestroy          ! method
  public NUOPC_FreeFormatGet              ! method
  public NUOPC_FreeFormatGetLine          ! method
  public NUOPC_FreeFormatLog              ! method
  public NUOPC_FreeFormatPrint            ! method

  ! public FieldDictionary API
  public NUOPC_FieldDictionary            ! variable
  public NUOPC_FieldDictionaryAddEntry    ! method
  public NUOPC_FieldDictionaryEgest       ! method
  public NUOPC_FieldDictionaryGetEntry    ! method
  public NUOPC_FieldDictionaryHasEntry    ! method
  public NUOPC_FieldDictionaryMatchSyno   ! method
  public NUOPC_FieldDictionarySetSyno     ! method
  public NUOPC_FieldDictionarySetup       ! method
  public NUOPC_FieldDictionarySetAutoAdd  ! method

  ! public generic Comp API
  public NUOPC_CompAreServicesSet         ! method
  public NUOPC_CompAttributeAdd           ! method
  public NUOPC_CompAttributeEgest         ! method
  public NUOPC_CompAttributeGet           ! method
  public NUOPC_CompAttributeIngest        ! method
  public NUOPC_CompAttributeInit          ! method
  public NUOPC_CompAttributeReset         ! method
  public NUOPC_CompAttributeSet           ! method
  public NUOPC_CompCheckSetClock          ! method
  public NUOPC_CompDerive                 ! method
  public NUOPC_CompGet                    ! method
  public NUOPC_CompFilterPhaseMap         ! method
  public NUOPC_CompSearchPhaseMap         ! method
  public NUOPC_CompSearchRevPhaseMap      ! method
  public NUOPC_CompSetClock               ! method
  public NUOPC_CompSetEntryPoint          ! method
  public NUOPC_CompSetInternalEntryPoint  ! method
  public NUOPC_CompSetServices            ! method
  public NUOPC_CompSetVM                  ! method
  public NUOPC_CompSpecialize             ! method
  public &
    label_ExternalAdvertise, &
    label_ExternalRealize, &
    label_ExternalDataInit, &
    label_ExternalReset

  ! public Utility API
  public NUOPC_AddNestedState             ! method
  public NUOPC_AddNamespace               ! method
  public NUOPC_AdjustClock                ! method
  public NUOPC_Advertise                  ! method
  public NUOPC_CheckSetClock              ! method
  public NUOPC_ChopString                 ! method, internal use only
  public NUOPC_GetAttribute               ! method
  public NUOPC_GetStateMemberLists        ! method
  public NUOPC_GetStateMemberCount        ! method
  public NUOPC_GetTimestamp               ! method
  public NUOPC_InitAttributes             ! method, internal use only
  public NUOPC_IngestPetList              ! method
  public NUOPC_IsAtTime                   ! method
  public NUOPC_IsConnected                ! method
  public NUOPC_IsUpdated                  ! method
  public NUOPC_LogIntro                   ! method, internal use only
  public NUOPC_LogExtro                   ! method, internal use only
  public NUOPC_LogPetList                 ! method, internal use only
  public NUOPC_NoOp                       ! method
  public NUOPC_Realize                    ! method
  public NUOPC_Reconcile                  ! method, internal use only 
  public NUOPC_SetAttribute               ! method
  public NUOPC_SetTimestamp               ! method
  public NUOPC_SetVM                      ! method, internal use only
  public NUOPC_UpdateTimestamp            ! method, internal use only

  ! public Auxiliary API
  public NUOPC_Write                      ! method

end module
