# $Id$

# leave alone.
ALL: build_here 

# Workaround an MPICH2 issue
ESMF_CXXCOMPILECPPFLAGS += -DMPICH_IGNORE_CXX_SEEK

SOURCEC	  = \
            ESMCI_ClumpPnts.C \
            ESMCI_MathUtil.C \
            ESMCI_Mesh_Glue.C \
            ESMCI_FileIO_Util.C \
            ESMCI_ESMFMesh_Util.C \
            ESMCI_UGRID_Util.C \
            ESMCI_Mesh_FileIO.C \
            ESMCI_GToM_Util.C \
            ESMCI_Mesh_GToM_Glue.C \
            ESMCI_Mesh_Vector_Regrid.C \
            ESMCI_Mesh_Regrid_Glue.C \
            ESMCI_Mesh_XGrid_Glue.C \
            ESMCI_Mesh.C \
            ESMCI_MeshCap.C \
            ESMCI_MeshCXX.C \
            ESMCI_MeshDual.C \
            ESMCI_MeshRedist.C \
            ESMCI_OTree.C \
            ESMCI_Regrid_Nearest.C \
            ESMCI_Rendez_Nearest.C \
            ESMCI_Search_Nearest.C \
            ESMCI_Search_NearestNPnts.C \
            ESMCI_XGridUtil.C


ifneq ($(ESMF_MOAB),OFF)
SOURCEC	  += ESMCI_MBMesh.C \
             ESMCI_MBMesh_BBox.C \
             ESMCI_MBMesh_Bilinear.C \
             ESMCI_MBMesh_Conserve.C \
             ESMCI_MBMesh_Dual.C \
             ESMCI_MBMesh_Extrapolation.C \
             ESMCI_MBMesh_Glue.C \
             ESMCI_MBMesh_GToM_Glue.C \
             ESMCI_MBMesh_Mapping.C \
             ESMCI_MBMesh_Patch.C \
             ESMCI_MBMesh_Redist.C \
             ESMCI_MBMesh_Regrid_Glue.C \
             ESMCI_MBMesh_Rendez_Elem.C \
             ESMCI_MBMesh_Rendez_EtoP.C \
             ESMCI_MBMesh_Search_EtoE.C \
             ESMCI_MBMesh_Search_EtoP.C \
             ESMCI_MBMesh_ShapeFunc.C \
             ESMCI_MBMesh_Util.C

endif

SOURCEH	  = ESMCI_MeshCXX.h

# List all .h files which should be copied to common include dir
STOREH	  = ESMCI_MeshCXX.h

OBJSC     = $(addsuffix .o, $(basename $(SOURCEC)))
OBJSF     = $(addsuffix .o, $(basename $(SOURCEF)))

LIBBASE	  = libesmf
LOCDIR	  = src/Infrastructure/Mesh/src

CLEANDIRS   =
CLEANFILES  = 
CLOBBERDIRS =

include ${ESMF_DIR}/makefile

ifeq ($(ESMF_MOAB),internal)
ESMF_CXXCOMPILECPPFLAGS += -I$(ESMF_DIR)/$(LOCDIR)/Moab \
                           -I$(ESMF_DIR)/$(LOCDIR)/Moab/parallel \
                           -I$(ESMF_DIR)/$(LOCDIR)/Moab/LocalDiscretization
endif


DIRS	  = Legacy Regridding Zoltan
ifeq ($(ESMF_LAPACK),internal)
DIRS	 += Lapack BLAS
STOREH   += ESMF_LapackBlas.inc
endif
ifeq ($(ESMF_MOAB),internal)
DIRS     += Moab
endif

