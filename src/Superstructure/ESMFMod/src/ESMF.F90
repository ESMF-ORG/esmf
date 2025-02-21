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


module ESMF

    use ESMF_UtilTypesMod
    use ESMF_UtilSortMod
    use ESMF_UtilStringMod
    use ESMF_UtilCubedSphereMod
    use ESMF_UtilMod

    use ESMF_LogErrMod
    use ESMF_LogPublicMod
    use ESMF_InitMacrosMod
    use ESMF_TraceMod
    use ESMF_TraceAPIMod

    use ESMF_F90InterfaceMod
    use ESMF_FortranWordsizeMod
    use ESMF_TypeKindGetMod

    use ESMF_BaseMod
    use ESMF_IOUtilMod

    use ESMF_FractionMod
    use ESMF_CalendarMod
    use ESMF_TimeIntervalMod
    use ESMF_TimeMod
    use ESMF_AlarmMod
    use ESMF_ClockMod

    use ESMF_AttributeMod

    use ESMF_ArraySpecMod
    use ESMF_LocalArrayMod

    use ESMF_VMMod
    use ESMF_DELayoutMod
    use ESMF_DistGridMod
    use ESMF_DynamicMaskMod
    use ESMF_ArrayMod
    use ESMF_ArrayBundleMod

    use ESMF_HConfigMod
    use ESMF_ConfigMod

    use ESMF_XGridGeomBaseMod
    use ESMF_XGridMod
    use ESMF_XGridCreateMod
    use ESMF_XGridGetMod

    use ESMF_GridMod
    use ESMF_GridUtilMod
!    use ESMF_PntListMod
    use ESMF_StaggerLocMod
    use ESMF_PredefinedDynamicMaskMod

    use ESMF_LocStreamMod

    use ESMF_GeomMod

    use ESMF_RHandleMod

    use ESMF_FieldMod
    use ESMF_FieldPrMod
    use ESMF_FieldWrMod
    use ESMF_FieldGetMod
    use ESMF_FieldGetAllocBoundsMod
    use ESMF_FieldCreateMod
    use ESMF_FieldEmptyMod
    use ESMF_FieldRegridMod
    use ESMF_FieldSetMod
    use ESMF_RegridMod

    use ESMF_FieldGatherMod
    use ESMF_FieldScatterMod
    use ESMF_FieldRedistMod
    use ESMF_FieldSMMMod
    use ESMF_FieldHaloMod

    use ESMF_FieldBundleMod

    use ESMF_MeshMod

    use ESMF_StateTypesMod
    use ESMF_StateVaMod
    use ESMF_StateMod
    use ESMF_StateReconcileMod
    use ESMF_CompMod
    use ESMF_GridCompMod
    use ESMF_CplCompMod
    use ESMF_SciCompMod

    use ESMF_InternalStateMod

    use ESMF_AttachMethodsMod

    use ESMF_ContainerMod

    use ESMF_InitMod

    use ESMFIOMod

    use ESMF_IO_YAMLMod

    use ESMF_IOScripMod, only: ESMF_SparseMatrixWrite

#ifdef ESMF_MAPPER
    use & ! prevent MOD_FUNC from grabbing this dependency during build
      ESMF_MapperMod
    use & ! prevent MOD_FUNC from grabbing this dependency during build
      ESMF_MapperUtilMod
#endif

    use ESMF_InfoMod
    use ESMF_InfoDescribeMod
    use ESMF_InfoSyncMod

    use ESMF_NamedAliasMod

    use ESMF_RegridWeightGenMod

end module ESMF
