// $Id$
//
// Earth System Modeling Framework
// Copyright (c) 2002-2025, University Corporation for Atmospheric Research,
// Massachusetts Institute of Technology, Geophysical Fluid Dynamics
// Laboratory, University of Michigan, National Centers for Environmental
// Prediction, Los Alamos National Laboratory, Argonne National Laboratory,
// NASA Goddard Space Flight Center.
// Licensed under the University of Illinois-NCSA License.
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// This file is part of the pure C public ESMC API
//-----------------------------------------------------------------------------

//-------------------------------------------------------------------------
// these lines prevent this file from being read more than once if it
// ends up being included multiple times

#ifndef ESMC_UTIL_H
#define ESMC_UTIL_H

#include "ESMC_Conf.h"

#ifdef __cplusplus
extern "C" {
#endif

  int ESMC_UtilGetArgIndex(int argc, char * const argv[], const char *value, int *rc);
  void ESMC_UtilVersionPrint (int Flag, int versionFlag, int *rc);

#ifdef __cplusplus
} // extern "C"
#endif

// ESMF platform-dependent data types
  typedef long long ESMC_I8;
  typedef int       ESMC_I4;
  typedef short     ESMC_I2;
  typedef char      ESMC_I1;
  typedef double    ESMC_R8;
  typedef float     ESMC_R4;
#if (ESMC_POINTER_SIZE == 4)
  // 32-bit machine
  typedef unsigned long ESMC_POINTER;
#else
  // 64-bit machine
  typedef unsigned long long ESMC_POINTER;
#endif

enum ESMC_CoordSys_Flag {ESMC_COORDSYS_INVALID=-2,
                    ESMC_COORDSYS_UNINIT,
                    ESMC_COORDSYS_CART,
                    ESMC_COORDSYS_SPH_DEG,
                    ESMC_COORDSYS_SPH_RAD};

enum ESMC_Decomp_Flag {ESMC_DECOMP_INVALID=0,
                       ESMC_DECOMP_BALANCED, ESMC_DECOMP_RESTFIRST,
                       ESMC_DECOMP_RESTLAST, ESMC_DECOMP_CYCLIC};

// end flag
typedef enum ESMC_End_Flag { ESMC_END_NORMAL=1,
                             ESMC_END_KEEPMPI,
                             ESMC_END_ABORT} ESMC_End_Flag;

enum ESMC_ExtrapMethod_Flag {ESMC_EXTRAPMETHOD_NONE=0,
                             ESMC_EXTRAPMETHOD_NEAREST_STOD,
                             ESMC_EXTRAPMETHOD_NEAREST_IDAVG,
                             ESMC_EXTRAPMETHOD_NEAREST_D,
                             ESMC_EXTRAPMETHOD_CREEP,
                             ESMC_EXTRAPMETHOD_CREEP_NRST_D};

enum ESMC_FileFormat_Flag {ESMC_FILEFORMAT_UNDEFINED, ESMC_FILEFORMAT_VTK,
                           ESMC_FILEFORMAT_SCRIP, ESMC_FILEFORMAT_ESMFMESH,
                           ESMC_FILEFORMAT_ESMCGRID, ESMC_FILEFORMAT_UGRID,
                           ESMC_FILEFORMAT_GRIDSPEC};

typedef enum ESMC_FileMode_Flag {ESMC_FILEMODE_BASIC, ESMC_FILEMODE_WITHAUX} ESMC_FileMode_Flag;

// File status flag (for IO write functions)
typedef enum ESMC_FileStatus_Flag { ESMC_FILESTATUS_UNKNOWN=0,
                            ESMC_FILESTATUS_OLD = 1,
                            ESMC_FILESTATUS_NEW = 2,
                            ESMC_FILESTATUS_REPLACE = 3} ESMC_FileStatus_Flag;

enum ESMC_GridItem_Flag {ESMC_GRIDITEM_INVALID=-2,
                         ESMC_GRIDITEM_UNINIT,
                         ESMC_GRIDITEM_MASK,
                         ESMC_GRIDITEM_AREA};

enum ESMC_GridStatus_Flag {ESMC_GRIDSTATUS_INVALID=-1,
                           ESMC_GRIDSTATUS_UNINIT,
                           ESMC_GRIDSTATUS_NOT_READY,
                           ESMC_GRIDSTATUS_SHAPE_READY};

// indexflag type
enum ESMC_IndexFlag { ESMC_INDEX_DELOCAL=0,
                      ESMC_INDEX_GLOBAL,
                      ESMC_INDEX_USER};

// io format type
typedef enum ESMC_IOFmt_Flag { //ESMF_IOFMT_BIN=0,
                       ESMF_IOFMT_NETCDF=1,
                       ESMF_IOFMT_NETCDF_64BIT_DATA,
                       ESMF_IOFMT_NETCDF_64BIT_OFFSET,
                       ESMF_IOFMT_NETCDF4,
                       ESMF_IOFMT_NETCDF4P,
                       ESMF_IOFMT_NETCDF4C,
                       ESMF_IOFMT_CONFIG,
                       ESMF_IOFMT_YAML} ESMC_IOFmt_Flag;

enum ESMC_LineType_Flag { ESMC_LINETYPE_CART=0,
                          ESMC_LINETYPE_GREAT_CIRCLE};

enum ESMC_Logical { ESMF_TRUE=1,
                    ESMF_FALSE };

// keep in sync with ESMF_LogKind_Flag
enum ESMC_LogKind_Flag{
                ESMC_LOGKIND_SINGLE         =1,
                ESMC_LOGKIND_MULTI          =2,
                ESMC_LOGKIND_MULTI_ON_ERROR =3,
                ESMC_LOGKIND_NONE           =4 };

// keep in sync with ESMF_LogMsg_Flag
enum ESMC_LogMsgType_Flag{
                ESMC_LOGMSG_INFO =1,
                ESMC_LOGMSG_WARN =2,
                ESMC_LOGMSG_ERROR=3,
                ESMC_LOGMSG_TRACE=4,
                ESMC_LOGMSG_DEBUG=5,
                ESMC_LOGMSG_JSON =6 };

enum ESMC_MeshLoc_Flag {ESMC_MESHLOC_NODE=0,
                        ESMC_MESHLOC_ELEMENT};

enum ESMC_MeshStatus_Flag {ESMC_MESHSTATUS_UNINIT=0,
                           ESMC_MESHSTATUS_EMPTY,
                           ESMC_MESHSTATUS_STRUCTCREATED,
                           ESMC_MESHSTATUS_NODESADDED,
                           ESMC_MESHSTATUS_COMPLETE};

enum ESMC_NormType_Flag {ESMC_NORMTYPE_DSTAREA=0,
                        ESMC_NORMTYPE_FRACAREA=1};

enum ESMC_PoleKind_Flag {ESMC_POLEKIND_NONE=0,
                         ESMC_POLEKIND_MONOPOLE=1,
                         ESMC_POLEKIND_BIPOLE=2};

enum ESMC_PoleMethod_Flag {ESMC_POLEMETHOD_NONE=0,
                                       ESMC_POLEMETHOD_ALLAVG,
                                       ESMC_POLEMETHOD_NPNTAVG,
                                       ESMC_POLEMETHOD_TEETH};

enum ESMC_Reduce_Flag { ESMC_REDUCE_SUM=1,
                        ESMC_REDUCE_MIN=2,
                        ESMC_REDUCE_MAX=3};

enum ESMC_Region_Flag { ESMC_REGION_TOTAL=0,
                        ESMC_REGION_SELECT,
                        ESMC_REGION_EMPTY};

enum ESMC_RegridMethod_Flag {ESMC_REGRIDMETHOD_BILINEAR=0,
                             ESMC_REGRIDMETHOD_PATCH,
                             ESMC_REGRIDMETHOD_CONSERVE,
                             ESMC_REGRIDMETHOD_NEAREST_STOD,
                             ESMC_REGRIDMETHOD_NEAREST_DTOS,
                             ESMC_REGRIDMETHOD_CONSERVE_2ND};

enum ESMC_StaggerLoc {ESMC_STAGGERLOC_INVALID=-2,
                      ESMC_STAGGERLOC_UNINIT,
                      ESMC_STAGGERLOC_CENTER,
                      ESMC_STAGGERLOC_EDGE1,
                      ESMC_STAGGERLOC_EDGE2,
                      ESMC_STAGGERLOC_CORNER,
                      ESMC_STAGGERLOC_CENTER_VCENTER=0,
                      ESMC_STAGGERLOC_EDGE1_VCENTER,
                      ESMC_STAGGERLOC_EDGE2_VCENTER,
                      ESMC_STAGGERLOC_CORNER_VCENTER,
                      ESMC_STAGGERLOC_CENTER_VFACE,
                      ESMC_STAGGERLOC_EDGE1_VFACE,
                      ESMC_STAGGERLOC_EDGE2_VFACE,
                      ESMC_STAGGERLOC_CORNER_VFACE};


enum ESMC_TypeKind_Flag {ESMC_TYPEKIND_I1=1,
                    ESMC_TYPEKIND_I2,
                    ESMC_TYPEKIND_I4,
                    ESMC_TYPEKIND_I8,
                    ESMC_TYPEKIND_R4,
                    ESMC_TYPEKIND_R8,
                    ESMF_C8,
                    ESMF_C16,
                    ESMC_TYPEKIND_LOGICAL,
                    ESMC_TYPEKIND_CHARACTER,
                    ESMF_NOKIND=99};

enum ESMC_UnmappedAction_Flag {ESMC_UNMAPPEDACTION_ERROR=0,
                               ESMC_UNMAPPEDACTION_IGNORE};

enum ESMC_PredefinedDynamicMask_Flag {ESMC_PREDEFINEDDYNAMICMASK_MASKSRC=0,
                                      ESMC_PREDEFINEDDYNAMICMASK_MASKDEST,
                                      ESMC_PREDEFINEDDYNAMICMASK_MASKSRCDEST,
                                      ESMC_PREDEFINEDDYNAMICMASK_MASKVOTE,
                                      ESMC_PREDEFINEDDYNAMICMASK_MASKSRCV,
                                      ESMC_PREDEFINEDDYNAMICMASK_MASKDESTV,
                                      ESMC_PREDEFINEDDYNAMICMASK_MASKSRCDESTV,
                                      ESMC_PREDEFINEDDYNAMICMASK_MASKVOTEV};


#endif  // ESMC_UTIL_H
