#  $Id$
#===============================================================================
#
#  GNUmake makefile - cannot be used with standard unix make!!
#
#  This file is included by all platforms and all builds, where all builds
#  include the ESMF Framework, the ESMF Implementation Report, and the
#  ESMF EVA codes.  Each of those builds has a separate ../makefile, so
#  any targets or rules which are specific to only a single build should
#  be in the top level makefile and not here.
#
#  If you have changes which only apply to a single platform, look in
#  ../build_config/<platform>/build_rules.mk  for the flags and libraries
#  which are included on a per-platform/compiler/specific-site basis.
#
#  Be very careful in making changes here; it is hard to make sure you
#  have not broken anything without testing all three build systems.
#  If you must, please look below for the comment section with the
#  label "HOWTO" before you dive in.
#
#===============================================================================

#-------------------------------------------------------------------------------
# Test for obsolete environment variables, print error and stop build here
#-------------------------------------------------------------------------------

ifeq ($(origin ESMF_ARCH), environment)
$(error Obsolete environment variable ESMF_ARCH detected. Please see ESMF README and/or User's Guide for a current list of ESMF environment variables.)
endif

ifeq ($(origin ESMF_PREC), environment)
$(error Obsolete environment variable ESMF_PREC detected. Please see ESMF README and/or User's Guide for a current list of ESMF environment variables.)
endif

ifeq ($(origin ESMF_TOP_DIR), environment)
$(error Obsolete environment variable ESMF_TOP_DIR detected. Please see ESMF README and/or User's Guide for a current list of ESMF environment variables.)
endif

ifeq ($(origin ESMF_NODES), environment)
$(error Obsolete environment variable ESMF_NODES detected. Please see ESMF README and/or User's Guide for a current list of ESMF environment variables.)
endif

ifeq ($(origin ESMF_C_COMPILER), environment)
$(error Obsolete environment variable ESMF_C_COMPILER detected. Please see ESMF README and/or User's Guide for a current list of ESMF environment variables.)
endif

ifeq ($(origin ESMF_C_LIBRARY), environment)
$(error Obsolete environment variable ESMF_C_LIBRARY detected. Please see ESMF README and/or User's Guide for a current list of ESMF environment variables.)
endif

ifeq ($(origin ESMF_CXX_LIBRARY_PATH), environment)
$(error Obsolete environment variable ESMF_CXX_LIBRARY_PATH detected. Please see ESMF README and/or User's Guide for a current list of ESMF environment variables.)
endif

ifeq ($(origin ESMF_CXX_LIBRARIES), environment)
$(error Obsolete environment variable ESMF_CXX_LIBRARIES detected. Please see ESMF README and/or User's Guide for a current list of ESMF environment variables.)
endif

ifeq ($(origin ESMF_COMPILER_VERSION), environment)
$(error Obsolete environment variable ESMF_COMPILER_VERSION detected. Please see ESMF README and/or User's Guide for a current list of ESMF environment variables.)
endif

ifeq ($(origin ESMF_STDCXX_LIBRARY), environment)
$(error Obsolete environment variable ESMF_STDCXX_LIBRARY detected. Please see ESMF README and/or User's Guide for a current list of ESMF environment variables.)
endif

ifeq ($(origin ESMF_F90_LIBRARY_PATH), environment)
$(error Obsolete environment variable ESMF_F90_LIBRARY_PATH detected. Please see ESMF README and/or User's Guide for a current list of ESMF environment variables.)
endif

ifeq ($(origin ESMF_F90_LIBRARIES), environment)
$(error Obsolete environment variable ESMF_F90_LIBRARIES detected. Please see ESMF README and/or User's Guide for a current list of ESMF environment variables.)
endif

ifeq ($(origin ESMF_NO_LD_LIBRARY_PATH), environment)
$(error Obsolete environment variable ESMF_NO_LD_LIBRARY_PATH detected. Please see ESMF README and/or User's Guide for a current list of ESMF environment variables.)
endif

ifeq ($(origin ESMF_PROJECT), environment)
$(error Obsolete environment variable ESMF_PROJECT detected. Please see ESMF README and/or User's Guide for a current list of ESMF environment variables.)
endif

ifeq ($(origin ESMF_LIB_INSTALL), environment)
$(error Obsolete environment variable ESMF_LIB_INSTALL detected. Please see ESMF README and/or User's Guide for a current list of ESMF environment variables.)
endif

ifeq ($(origin ESMF_MOD_INSTALL), environment)
$(error Obsolete environment variable ESMF_MOD_INSTALL detected. Please see ESMF README and/or User's Guide for a current list of ESMF environment variables.)
endif

ifeq ($(origin ESMF_H_INSTALL), environment)
$(error Obsolete environment variable ESMF_H_INSTALL detected. Please see ESMF README and/or User's Guide for a current list of ESMF environment variables.)
endif

ifeq ($(origin ESMF_NO_IOCODE), environment)
$(error Obsolete environment variable ESMF_NO_IOCODE detected. Please see ESMF README and/or User's Guide for a current list of ESMF environment variables.)
endif

ifeq ($(origin ESMF_EXHAUSTIVE), environment)
$(error Obsolete environment variable ESMF_EXHAUSTIVE detected. Please see ESMF README and/or User's Guide for a current list of ESMF environment variables.)
endif

ifeq ($(origin ESMF_BATCH), environment)
$(error Obsolete environment variable ESMF_BATCH detected. Please see ESMF README and/or User's Guide for a current list of ESMF environment variables.)
endif

ifeq ($(origin ESMF_BATCHOPTIONS), environment)
$(error Obsolete environment variable ESMF_BATCHOPTIONS detected. Please see ESMF README and/or User's Guide for a current list of ESMF environment variables.)
endif

ifeq ($(origin ESMF_MPI), environment)
$(error Obsolete environment variable ESMF_MPI detected. Please see ESMF README and/or User's Guide for a current list of ESMF environment variables.)
endif

ifeq ($(origin ESMF_MPIRUNOPTIONS), environment)
$(error Obsolete environment variable ESMF_MPIRUNOPTIONS detected. Please see ESMF README and/or User's Guide for a current list of ESMF environment variables.)
endif

ifeq ($(origin ESMF_TESTHARNESS), environment)
$(error Obsolete environment variable ESMF_TESTHARNESS detected. Please see ESMF README and/or User's Guide for a current list of ESMF environment variables.)
endif

#-------------------------------------------------------------------------------
# Set defaults for environment variables that are not set
#-------------------------------------------------------------------------------

ifndef ESMF_BUILD
export ESMF_BUILD = default
endif

ifndef ESMF_OS
export ESMF_OS = default
endif

ifndef ESMF_MACHINE
export ESMF_MACHINE = default
endif

ifndef ESMF_ABI
export ESMF_ABI = default
endif

ifndef ESMF_COMM
export ESMF_COMM = default
else
ifeq ($(ESMF_COMM),mpich3)
export ESMF_COMM = mpich
$(warning !!! For MPICH3 and up, please use ESMF_COMM=mpich !!!)
endif
endif

ifndef ESMF_COMPILER
export ESMF_COMPILER = default
endif

ifndef ESMF_BOPT
export ESMF_BOPT = default
else
ifneq ($(ESMF_BOPT),g)
ifneq ($(ESMF_BOPT),O)
$(error Not a valid ESMF_BOPT setting.)
endif
endif
endif

ifndef ESMF_OPTLEVEL
export ESMF_OPTLEVEL = default
endif

ifndef ESMF_SITE
export ESMF_SITE = default
endif

ifndef ESMF_PTHREADS
export ESMF_PTHREADS = $(ESMF_PTHREADSDEFAULT)
endif

ifndef ESMF_OPENMP
export ESMF_OPENMP = $(ESMF_OPENMPDEFAULT)
endif

ifndef ESMF_OPENACC
export ESMF_OPENACC = $(ESMF_OPENACCDEFAULT)
endif

ifndef ESMF_ARRAY_LITE
export ESMF_ARRAY_LITE = default
endif

ifndef ESMF_NO_INTEGER_1_BYTE
export ESMF_NO_INTEGER_1_BYTE = default
endif

ifndef ESMF_NO_INTEGER_2_BYTE
export ESMF_NO_INTEGER_2_BYTE = default
endif

ifndef ESMF_MAPPER_BUILD
export ESMF_MAPPER_BUILD = default
endif

ifndef ESMF_AUTO_LIB_BUILD
export ESMF_AUTO_LIB_BUILD = default
endif

ifndef ESMF_DEFER_LIB_BUILD
export ESMF_DEFER_LIB_BUILD = default
endif

ifndef ESMF_SHARED_LIB_BUILD
export ESMF_SHARED_LIB_BUILD = default
endif

ifndef ESMF_TRACE_LIB_BUILD
export ESMF_TRACE_LIB_BUILD = default
endif

ifndef ESMF_TRACE_PRELOAD_LINKED
export ESMF_TRACE_PRELOAD_LINKED = default
endif

ifndef ESMF_FORTRANSYMBOLS
export ESMF_FORTRANSYMBOLS = default
endif

ifndef ESMF_TESTEXHAUSTIVE
export ESMF_TESTEXHAUSTIVE = default
endif

ifndef ESMF_TESTPERFORMANCE
export ESMF_TESTPERFORMANCE = default
endif

ifndef ESMF_TESTCOMPTUNNEL
export ESMF_TESTCOMPTUNNEL = default
endif

ifndef ESMF_TESTWITHTHREADS
export ESMF_TESTWITHTHREADS = default
endif

ifndef ESMF_TESTMPMD
export ESMF_TESTMPMD = default
endif

ifndef ESMF_TESTSHAREDOBJ
export ESMF_TESTSHAREDOBJ = default
endif

ifndef ESMF_TESTFORCEOPENMP
export ESMF_TESTFORCEOPENMP = default
endif

ifndef ESMF_TESTFORCEOPENACC
export ESMF_TESTFORCEOPENACC = default
endif

ifndef ESMF_TESTHARNESS_ARRAY
export ESMF_TESTHARNESS_ARRAY = default
endif

ifndef ESMF_TESTHARNESS_FIELD
export ESMF_TESTHARNESS_FIELD = default
endif

ifndef ESMF_MOAB
export ESMF_MOAB = default
endif

ifndef ESMF_YAMLCPP
export ESMF_YAMLCPP = default
endif

ifndef ESMF_ACC_SOFTWARE_STACK
export ESMF_ACC_SOFTWARE_STACK = none
endif

ifndef ESMF_CXXSTD
export ESMF_CXXSTD = default
endif

ifndef ESMF_CSTD
export ESMF_CSTD = default
endif

#-------------------------------------------------------------------------------
# For some variables having the literal string "default" is ok;
# for others, look for this string and override it.
#-------------------------------------------------------------------------------

ifeq ($(ESMF_BUILD),default)
export ESMF_BUILD := $(ESMF_DIR)
endif

ifeq ($(ESMF_OS),default)
export ESMF_OS := $(shell $(ESMF_DIR)/scripts/esmf_os)
endif

ifeq ($(ESMF_OS),Linux)
# set ESMF_MACHINE for Linux
ifeq ($(ESMF_MACHINE),default)
export ESMF_MACHINE := $(shell uname -m)
endif
endif

ifeq ($(ESMF_OS),Cygwin)
# set ESMF_MACHINE for Cygwin
ifeq ($(ESMF_MACHINE),default)
export ESMF_MACHINE := $(shell uname -m)
endif
endif

ifeq ($(ESMF_OS),MinGW)
# set ESMF_MACHINE for MinGW
ifeq ($(ESMF_MACHINE),default)
export ESMF_MACHINE := $(shell uname -m)
endif
endif

ifeq ($(ESMF_OS),Darwin)
# set ESMF_MACHINE for Darwin
ifeq ($(ESMF_MACHINE),default)
export ESMF_MACHINE := $(shell uname -m)
# uname -m on Darwin (at least up to 8.11.1) is seriously broken and will
# always return i386 on any Intel system (it's hardcoded!)
ifeq ($(shell sysctl -n hw.optional.x86_64 2>&1),1)
export ESMF_MACHINE = x86_64
endif
endif
endif

ifeq ($(ESMF_OS),Unicos)
# set ESMF_MACHINE for Unicos
ifeq ($(ESMF_MACHINE),default)
export ESMF_MACHINE := $(shell uname -m)
endif
endif

ifeq ($(ESMF_ABI),default)
# start with 64-bit default for all architectures
export ESMF_ABI = 64

ifeq ($(ESMF_OS),Linux)
# default on Linux is 32-bit
export ESMF_ABI = 32
ifeq ($(ESMF_MACHINE),ia64)
# except for IA64
export ESMF_ABI = 64
endif
ifeq ($(ESMF_MACHINE),x86_64)
# and x86_64
export ESMF_ABI = 64
endif
ifeq ($(ESMF_MACHINE),ppc64)
# and ppc64
export ESMF_ABI = 64
endif
ifeq ($(ESMF_MACHINE),ppc64le)
# and ppc64 little endian
export ESMF_ABI = 64
endif
endif

ifeq ($(ESMF_OS),Darwin)
# default on Darwin is 32-bit
export ESMF_ABI = 32
ifeq ($(ESMF_MACHINE),x86_64)
# except x86_64
export ESMF_ABI = 64
endif
ifeq ($(ESMF_MACHINE),arm64)
# and arm64
export ESMF_ABI = 64
endif
endif

ifeq ($(ESMF_OS),Cygwin)
# default on Cygwin is 32-bit
export ESMF_ABI = 32
ifeq ($(ESMF_MACHINE),x86_64)
# and x86_64
export ESMF_ABI = 64
endif
endif

ifeq ($(ESMF_OS),MinGW)
# default on MinGW is 64-bit
export ESMF_ABI = 64
endif

endif

# by default ABISTRING is simply ABI
ESMF_ABISTRING = $(ESMF_ABI)

ifeq ($(ESMF_COMPILER),default)
ifeq ($(ESMF_OS),Cygwin)
export ESMF_COMPILER = gfortran
endif
ifeq ($(ESMF_OS),Darwin)
export ESMF_COMPILER = gfortranclang
endif
ifeq ($(ESMF_OS),Linux)
export ESMF_COMPILER = gfortran
endif
ifeq ($(ESMF_OS),MinGW)
export ESMF_COMPILER = gfortran
endif
ifeq ($(ESMF_OS),Unicos)
ifeq ($(ESMF_MACHINE),x86_64)
export ESMF_COMPILER = pgi
endif
endif
endif

ifeq ($(ESMF_BOPT),default)
export ESMF_BOPT = O
endif

ifneq ($(ESMF_ARRAY_LITE),TRUE)
export ESMF_ARRAY_LITE = FALSE
endif

ifneq ($(ESMF_NO_INTEGER_1_BYTE),FALSE)
export ESMF_NO_INTEGER_1_BYTE = TRUE
endif

ifneq ($(ESMF_NO_INTEGER_2_BYTE),FALSE)
export ESMF_NO_INTEGER_2_BYTE = TRUE
endif

ifneq ($(ESMF_TESTEXHAUSTIVE),ON)
export ESMF_TESTEXHAUSTIVE = OFF
endif

ifneq ($(ESMF_MAPPER_BUILD),ON)
export ESMF_MAPPER_BUILD = OFF
endif

ifneq ($(ESMF_AUTO_LIB_BUILD),OFF)
export ESMF_AUTO_LIB_BUILD = ON
endif

ifneq ($(ESMF_DEFER_LIB_BUILD),OFF)
export ESMF_DEFER_LIB_BUILD = ON
endif

ifneq ($(ESMF_SHARED_LIB_BUILD),OFF)
export ESMF_SHARED_LIB_BUILD = ON
endif

ifneq ($(ESMF_TRACE_LIB_BUILD),OFF)
export ESMF_TRACE_LIB_BUILD = ON
endif

ifneq ($(ESMF_TRACE_PRELOAD_LINKED),ON)
export ESMF_TRACE_PRELOAD_LINKED = OFF
endif

ifneq ($(ESMF_TESTPERFORMANCE),OFF)
export ESMF_TESTPERFORMANCE = ON
endif

ifneq ($(ESMF_TESTCOMPTUNNEL),OFF)
export ESMF_TESTCOMPTUNNEL = ON
endif

ifneq ($(ESMF_TESTWITHTHREADS),ON)
export ESMF_TESTWITHTHREADS = OFF
endif

ifneq ($(ESMF_TESTMPMD),ON)
export ESMF_TESTMPMD = OFF
endif

ifneq ($(ESMF_TESTSHAREDOBJ),ON)
export ESMF_TESTSHAREDOBJ = OFF
endif

ifneq ($(ESMF_TESTFORCEOPENMP),ON)
export ESMF_TESTFORCEOPENMP = OFF
endif

ifneq ($(ESMF_TESTFORCEOPENACC),ON)
export ESMF_TESTFORCEOPENACC = OFF
endif

ifeq ($(ESMF_MOAB),default)
export ESMF_MOAB = internal
endif

ifeq ($(ESMF_YAMLCPP),default)
export ESMF_YAMLCPP = internal
endif

#-------------------------------------------------------------------------------
# If INSTALL environment variables are not set give them default values
#-------------------------------------------------------------------------------

ifndef ESMF_INSTALL_PREFIX
ESMF_INSTALL_PREFIX := ./DEFAULTINSTALLDIR
endif
ESMF_INSTALL_PREFIX_ABSPATH := $(shell $(ESMF_DIR)/scripts/abspath $(ESMF_INSTALL_PREFIX))

ifndef ESMF_INSTALL_HEADERDIR
ESMF_INSTALL_HEADERDIR := include
endif
pathtype := $(shell $(ESMF_DIR)/scripts/pathtype $(ESMF_INSTALL_HEADERDIR))
ifeq ($(pathtype),rel)
export ESMF_INSTALL_HEADERDIR_ABSPATH = $(ESMF_INSTALL_PREFIX_ABSPATH)/$(ESMF_INSTALL_HEADERDIR)
else
export ESMF_INSTALL_HEADERDIR_ABSPATH = $(ESMF_INSTALL_HEADERDIR)
endif

ifndef ESMF_INSTALL_MODDIR
ESMF_INSTALL_MODDIR = mod/mod$(ESMF_BOPT)/$(ESMF_OS).$(ESMF_COMPILER).$(ESMF_ABI).$(ESMF_COMM).$(ESMF_SITE)
endif
pathtype := $(shell $(ESMF_DIR)/scripts/pathtype $(ESMF_INSTALL_MODDIR))
ifeq ($(pathtype),rel)
export ESMF_INSTALL_MODDIR_ABSPATH = $(ESMF_INSTALL_PREFIX_ABSPATH)/$(ESMF_INSTALL_MODDIR)
else
export ESMF_INSTALL_MODDIR_ABSPATH = $(ESMF_INSTALL_MODDIR)
endif

ifndef ESMF_INSTALL_LIBDIR
ESMF_INSTALL_LIBDIR = lib/lib$(ESMF_BOPT)/$(ESMF_OS).$(ESMF_COMPILER).$(ESMF_ABI).$(ESMF_COMM).$(ESMF_SITE)
endif
pathtype := $(shell $(ESMF_DIR)/scripts/pathtype $(ESMF_INSTALL_LIBDIR))
ifeq ($(pathtype),rel)
export ESMF_INSTALL_LIBDIR_ABSPATH = $(ESMF_INSTALL_PREFIX_ABSPATH)/$(ESMF_INSTALL_LIBDIR)
else
export ESMF_INSTALL_LIBDIR_ABSPATH = $(ESMF_INSTALL_LIBDIR)
endif

ifndef ESMF_INSTALL_BINDIR
ESMF_INSTALL_BINDIR = bin/bin$(ESMF_BOPT)/$(ESMF_OS).$(ESMF_COMPILER).$(ESMF_ABI).$(ESMF_COMM).$(ESMF_SITE)
endif
pathtype := $(shell $(ESMF_DIR)/scripts/pathtype $(ESMF_INSTALL_BINDIR))
ifeq ($(pathtype),rel)
export ESMF_INSTALL_BINDIR_ABSPATH = $(ESMF_INSTALL_PREFIX_ABSPATH)/$(ESMF_INSTALL_BINDIR)
else
export ESMF_INSTALL_BINDIR_ABSPATH = $(ESMF_INSTALL_BINDIR)
endif

ifndef ESMF_INSTALL_DOCDIR
ESMF_INSTALL_DOCDIR := doc
endif
pathtype := $(shell $(ESMF_DIR)/scripts/pathtype $(ESMF_INSTALL_DOCDIR))
ifeq ($(pathtype),rel)
export ESMF_INSTALL_DOCDIR_ABSPATH = $(ESMF_INSTALL_PREFIX_ABSPATH)/$(ESMF_INSTALL_DOCDIR)
else
export ESMF_INSTALL_DOCDIR_ABSPATH = $(ESMF_INSTALL_DOCDIR)
endif

ifndef ESMF_INSTALL_CMAKEDIR
ESMF_INSTALL_CMAKEDIR := cmake
endif
pathtype := $(shell $(ESMF_DIR)/scripts/pathtype $(ESMF_INSTALL_CMAKEDIR))
ifeq ($(pathtype),rel)
export ESMF_INSTALL_CMAKEDIR_ABSPATH = $(ESMF_INSTALL_PREFIX_ABSPATH)/$(ESMF_INSTALL_CMAKEDIR)
else
export ESMF_INSTALL_CMAKEDIR_ABSPATH = $(ESMF_INSTALL_CMAKEDIR)
endif

#-------------------------------------------------------------------------------
# Set ESMFMKFILE here in order to be available for installcheck target
#-------------------------------------------------------------------------------
ifneq ($(ESMF_TESTESMFMKFILE),ON)
export ESMFMKFILE = $(ESMF_INSTALL_LIBDIR_ABSPATH)/esmf.mk
endif


#-------------------------------------------------------------------------------
# If BENCHMARK directory, Tolerance, Threshold are  not set give them a default value
#-------------------------------------------------------------------------------

ifndef ESMF_BENCHMARK_PREFIX
ESMF_BENCHMARK_PREFIX := ./DEFAULTBENCHMARKDIR
endif
ESMF_BENCHMARK_PREFIX_ABSPATH := $(shell $(ESMF_DIR)/scripts/abspath $(ESMF_BENCHMARK_PREFIX))


ifndef ESMF_BENCHMARK_TOLERANCE
ESMF_BENCHMARK_TOLERANCE := 20%
endif

ifndef ESMF_BENCHMARK_THRESHOLD
ESMF_BENCHMARK_THRESHOLD_MSEC := 500
endif

#-------------------------------------------------------------------------------
# Set ESMF Version variables
#-------------------------------------------------------------------------------
ESMF_VERSION_STRING = `fgrep ESMF_VERSION_STRING $(ESMF_DIR)/src/Infrastructure/Util/include/ESMC_Macros.h | $(ESMF_SED) -e 's/.* \"//' -e 's/\"//' `

ESMF_VERSION_MAJOR = `fgrep ESMF_VERSION_MAJOR $(ESMF_DIR)/src/Infrastructure/Util/include/ESMC_Macros.h | $(ESMF_SED) -e 's/.* //' `

ESMF_VERSION_MINOR = `fgrep ESMF_VERSION_MINOR $(ESMF_DIR)/src/Infrastructure/Util/include/ESMC_Macros.h | $(ESMF_SED) -e 's/.* //' `

ESMF_VERSION_REVISION = `fgrep ESMF_VERSION_REVISION $(ESMF_DIR)/src/Infrastructure/Util/include/ESMC_Macros.h | $(ESMF_SED) -e 's/.* //' `

ESMF_VERSION_PATCHLEVEL = `fgrep ESMF_VERSION_PATCHLEVEL $(ESMF_DIR)/src/Infrastructure/Util/include/ESMC_Macros.h | $(ESMF_SED) -e 's/.* //' `

ESMF_VERSION_PUBLIC = `fgrep ESMF_VERSION_PUBLIC $(ESMF_DIR)/src/Infrastructure/Util/include/ESMC_Macros.h | $(ESMF_SED) -e 's/.* //' `

ESMF_VERSION_BETASNAPSHOT = `fgrep ESMF_VERSION_BETASNAPSHOT $(ESMF_DIR)/src/Infrastructure/Util/include/ESMC_Macros.h | $(ESMF_SED) -e 's/.* //' `

#-------------------------------------------------------------------------------
# TODO: in general ESMF_BUILD is respected - most generated files are created
# underneath ESMF_BUILD and not ESMF_DIR.  but there are exceptions.
# the ones i know about are:
# - in the build_config/platform-specific directories are config header files,
# so if these config files are moved, a -I flag will also have to be updated to
# point to the new location.  the complication is that since these are per-platform files
# and since we promise to support building for multiple architectures from
# the same source tree, these files cannot go into a generic include dir.
# - the 'storeh:' target copies include files into src/include under the
# distribution tree.
# - the system tests (not sure about the unit tests and examples)
# are compiled with the current dir set to the src dir (this is
# i think because if there are multiple .o files, it gets complicated to make
# them, get their names to link them, and then remove just them if you are
# working in the test or examples dir - but still, it should be fixed.)
#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
# Keep this variable for now until rules are fixed to work without.
export ESMF_BATCHDEPRECATED = false
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Common variables
#-------------------------------------------------------------------------------

# same as ESMF_LIBDIR
ESMF_LDIR	= $(ESMF_BUILD)/lib/lib$(ESMF_BOPT)/$(ESMF_OS).$(ESMF_COMPILER).$(ESMF_ABI).$(ESMF_COMM).$(ESMF_SITE)

# library directory
ESMF_LIBDIR     = $(ESMF_BUILD)/lib/lib$(ESMF_BOPT)/$(ESMF_OS).$(ESMF_COMPILER).$(ESMF_ABI).$(ESMF_COMM).$(ESMF_SITE)

# f90 module directory
ESMF_MODDIR     = $(ESMF_BUILD)/mod/mod$(ESMF_BOPT)/$(ESMF_OS).$(ESMF_COMPILER).$(ESMF_ABI).$(ESMF_COMM).$(ESMF_SITE)

# object directory
ifeq ($(ESMF_DEFER_LIB_BUILD),ON)
ESMF_OBJDIR     = $(ESMF_BUILD)/obj/obj$(ESMF_BOPT)/$(ESMF_OS).$(ESMF_COMPILER).$(ESMF_ABI).$(ESMF_COMM).$(ESMF_SITE)
else
ESMF_OBJDIR     = $(ESMF_MODDIR)
endif

# local obj dir
ESMF_LOCOBJDIR = $(ESMF_OBJDIR)/$(LOCDIR)

# test executable directory
ESMF_TESTDIR    = $(ESMF_BUILD)/test/test$(ESMF_BOPT)/$(ESMF_OS).$(ESMF_COMPILER).$(ESMF_ABI).$(ESMF_COMM).$(ESMF_SITE)

# example executable diretory
ESMF_EXDIR      = $(ESMF_BUILD)/examples/examples$(ESMF_BOPT)/$(ESMF_OS).$(ESMF_COMPILER).$(ESMF_ABI).$(ESMF_COMM).$(ESMF_SITE)

# apps executable directory
ESMF_APPSDIR     = $(ESMF_BUILD)/apps/apps$(ESMF_BOPT)/$(ESMF_OS).$(ESMF_COMPILER).$(ESMF_ABI).$(ESMF_COMM).$(ESMF_SITE)

# unified nuopc executable directory
ESMF_ESMXDIR     = $(ESMF_BUILD)/src/addon/ESMX

# cmake modules directory
ESMF_CMAKEDIR    = $(ESMF_DIR)/cmake

# include file directory
ESMF_INCDIR     = $(ESMF_BUILD)/src/include

# Infrastructure/Superstructure incs
ESMF_INTERNALINCDIRS  = -I$(ESMF_BUILD)/src/Infrastructure -I$(ESMF_BUILD)/src/Superstructure

# documentation directory
ESMF_DOCDIR	= $(ESMF_DIR)/doc

# benchmark directory
ESMF_UT_BM_DIR    = $(ESMF_BENCHMARK_PREFIX)/test/test$(ESMF_BOPT)/$(ESMF_OS).$(ESMF_COMPILER).$(ESMF_ABI).$(ESMF_COMM).$(ESMF_SITE)

# ???
ESMF_BUILD_DOCDIR = $(ESMF_BUILD)/build/doc

# system test source directory
ESMF_STDIR      = $(ESMF_DIR)/src/system_tests

# platform specific configuration directory
ESMF_CONFDIR    = $(ESMF_DIR)/build_config/$(ESMF_OS).$(ESMF_COMPILER).default

# site specific configuration directory
ESMF_SITEDIR    = $(ESMF_DIR)/build_config/$(ESMF_OS).$(ESMF_COMPILER).$(ESMF_SITE)

# use test cases source directory
ESMF_UTCDIR     = $(ESMF_DIR)/src/use_test_cases

# use test cases scripts directory
ESMF_UTCSCRIPTS = $(ESMF_DIR)/src/use_test_cases/scripts

# documentation scripts and tools
ESMF_TEMPLATES	= $(ESMF_DIR)/scripts/doc_templates/templates
PROTEX		= $(ESMF_TEMPLATES)/protex
CC_PROTEX       = $(ESMF_TEMPLATES)/scripts/do_ccprotex
CH_PROTEX       = $(ESMF_TEMPLATES)/scripts/do_chprotex
F_PROTEX        = $(ESMF_TEMPLATES)/scripts/do_fprotex
DO_LATEX	= $(ESMF_TEMPLATES)/scripts/do_latex
DO_L2H		= $(ESMF_TEMPLATES)/scripts/do_l2h

# test script variables
UNIT_TESTS_CONFIG   = $(ESMF_TESTDIR)/unit_tests.config
SYS_TESTS_CONFIG    = $(ESMF_TESTDIR)/sys_tests.config
EXAMPLES_CONFIG     = $(ESMF_EXDIR)/examples.config
TEST_HARNESS_LIST   = $(ESMF_TESTDIR)/test_harness.list
ESMF_TESTSCRIPTS    = $(ESMF_DIR)/scripts/test_scripts
DO_UT_RESULTS	    = $(ESMF_TESTSCRIPTS)/do_ut_results.pl -h $(ESMF_TESTSCRIPTS) -d $(ESMF_TESTDIR) -b $(ESMF_BOPT) -e $(ESMF_COMM)
DO_UT_ML_RESULTS    = $(ESMF_TESTSCRIPTS)/do_ut_ml_results.pl -h $(ESMF_TESTSCRIPTS) -d $(ESMF_TESTDIR) -b $(ESMF_BOPT)
DO_UT_BM_RESULTS    = $(ESMF_TESTSCRIPTS)/do_ut_bm_results.pl -h $(ESMF_TESTSCRIPTS) -d $(ESMF_TESTDIR) -e $(ESMF_UT_BM_DIR) -f $(ESMF_BENCHMARK_TOLERANCE) -g $(ESMF_BENCHMARK_THRESHOLD_MSEC) -i $(ESMF_BOPT)
DO_EX_RESULTS	    = $(ESMF_TESTSCRIPTS)/do_ex_results.pl -h $(ESMF_TESTSCRIPTS) -d $(ESMF_EXDIR) -b $(ESMF_BOPT) -e $(ESMF_COMM)
DO_EX_ML_RESULTS    = $(ESMF_TESTSCRIPTS)/do_ex_ml_results.pl -h $(ESMF_TESTSCRIPTS) -d $(ESMF_EXDIR) -b $(ESMF_BOPT)
DO_ST_RESULTS	    = $(ESMF_TESTSCRIPTS)/do_st_results.pl -h $(ESMF_TESTSCRIPTS) -d $(ESMF_TESTDIR) -b $(ESMF_BOPT) -e $(ESMF_COMM)
DO_ST_ML_RESULTS    = $(ESMF_TESTSCRIPTS)/do_st_ml_results.pl -h $(ESMF_TESTSCRIPTS) -d $(ESMF_TESTDIR) -b $(ESMF_BOPT)
DO_SUM_RESULTS	    = $(ESMF_TESTSCRIPTS)/do_summary.pl -h $(ESMF_TESTSCRIPTS) -d $(ESMF_TESTDIR) -e $(ESMF_EXDIR) -b $(ESMF_BOPT) -f $(ESMF_COMM)
DO_CK_SUM_RESULTS   = $(ESMF_TESTSCRIPTS)/do_ck_summary.pl -h $(ESMF_TESTSCRIPTS) -d $(ESMF_TESTDIR) -e $(ESMF_EXDIR) -b $(ESMF_BOPT) -f $(ESMF_COMM)
DO_UTC_RESULTS	    = $(ESMF_UTCSCRIPTS)/do_utc_results.pl -h $(ESMF_UTCSCRIPTS) -d $(ESMF_TESTDIR) -b $(ESMF_BOPT) -e $(ESMF_MAX_PROCS)

# C specific variables
ESMC_OBJDIR	= $(ESMF_OBJDIR)
ESMC_TESTDIR    = $(ESMF_TESTDIR)
ESMC_DOCDIR	= $(ESMF_DOCDIR)

#-------------------------------------------------------------------------------
# Add preprocessing flags according to environment variables
ifeq ($(ESMF_ARRAY_LITE),TRUE)
ESMF_CPPFLAGS += -DESMF_NO_GREATER_THAN_4D
endif
ifeq ($(ESMF_NO_INTEGER_1_BYTE),TRUE)
ESMF_CPPFLAGS += -DESMF_NO_INTEGER_1_BYTE
endif
ifeq ($(ESMF_NO_INTEGER_2_BYTE),TRUE)
ESMF_CPPFLAGS += -DESMF_NO_INTEGER_2_BYTE
endif
#-------------------------------------------------------------------------------

ifeq ($(shell $(ESMF_DIR)/scripts/available git),git)
export ESMF_VERSION_STRING_GIT := $(shell $(ESMF_DIR)/scripts/esmfversiongit)
endif

ifdef ESMF_VERSION_STRING_GIT
ESMF_CPPFLAGS += -DESMF_VERSION_STRING_GIT='"$(ESMF_VERSION_STRING_GIT)"'
endif

#-------------------------------------------------------------------------------
# default settings for common.mk
# the ESMF_xxxDEFAULT values are only used if ESMF_xxx is not defined in
# user's environment.
#-------------------------------------------------------------------------------
ESMF_PIODEFAULT             = internal
ESMF_PROJ4DEFAULT           = OFF
ESMF_PTHREADSDEFAULT        = ON
ESMF_OPENMPDEFAULT          = ON
ESMF_OPENACCDEFAULT         = OFF

ESMF_ARDEFAULT              = ar
ESMF_ARCREATEFLAGSDEFAULT   = cr
ESMF_ARCREATEPREFIX         =
ESMF_AREXTRACTDEFAULT       = $(ESMF_ARDEFAULT) -x
ESMF_RANLIBDEFAULT          = ranlib
ESMF_SEDDEFAULT             = sed
# The gcc preprocessor is used for partially preprocessing .cppF90 files.
# The -E option stops the gcc overcompiler after preprocessing, the -P
# option prevents putting #line directives in the output, and -x c states
# to use C-style preprocessing regardless of file name suffix. Option -C
# does not discard C++-style comments, preventing URL mangling. Finally
# for GCC range 4.8.5-4.9.x, -nostdinc is needed or else standard headers
# are included that mess up the Fortran source code.
ESMF_CPPDEFAULT             = gcc -E -P -x c -C -nostdinc

ESMF_RM                     = rm -rf
ESMF_MV                     = mv -f
ESMF_WC                     = wc
ESMF_GREPV                  = grep -v

# dummies here, expected to be overwritten in platform files if used
ESMF_F90RPATHPREFIX         = -L
ESMF_CXXRPATHPREFIX         = -L
ESMF_CRPATHPREFIX           = -L

ESMF_F90OPTFLAG_X           =
ESMF_CXXOPTFLAG_X           =
ESMF_COPTFLAG_X             =
ESMF_F90OPTFLAG_G           = -g
ESMF_CXXOPTFLAG_G           = -g
ESMF_COPTFLAG_G             = -g

# setting default optimization flags is platform dependent
ifneq ($(origin ESMF_OPTLEVEL), environment)
ESMF_OPTLEVEL = $(ESMF_OPTLEVELDEFAULT)
endif

ifneq ($(ESMF_OPTLEVEL),default)
# if NEC, insert option before -O
ifeq ($(ESMF_COMPILER),sxcross)
ESMF_F90OPTFLAG_O =  -Wf" -O $(ESMF_OPTLEVEL)"
else
ESMF_F90OPTFLAG_O =  -O$(ESMF_OPTLEVEL)
endif
ESMF_CXXOPTFLAG_O = -O$(ESMF_OPTLEVEL) -DNDEBUG
ESMF_COPTFLAG_O   = -O$(ESMF_OPTLEVEL) -DNDEBUG
else
# if NEC, insert option before -O
ifeq ($(ESMF_COMPILER),sxcross)
ESMF_F90OPTFLAG_O = -Wf -O
else
ESMF_F90OPTFLAG_O = -O
endif
ESMF_CXXOPTFLAG_O = -O2 -DNDEBUG
ESMF_COPTFLAG_O   = -O2 -DNDEBUG
endif


#-------------------------------------------------------------------------------
# Set default ESMF_ variables which may be appended to or overridden in
# platform specific build_rules.mk files.
#-------------------------------------------------------------------------------

# - F90COMPILER
ifneq ($(origin ESMF_F90COMPILER), environment)
ESMF_F90COMPILER = $(ESMF_F90COMPILERDEFAULT)
ESMF_F90COMPILERDEFAULT = $(ESMF_F90DEFAULT)
ifeq ($(origin ESMF_F90), environment)
ESMF_F90COMPILERDEFAULT = $(ESMF_F90)
endif
endif
ifneq ($(origin ESMF_F90IMOD), environment)
ESMF_F90IMOD = -I
endif
ifneq ($(origin ESMF_F90MODDIR), environment)
ESMF_F90MODDIR = $(ESMF_MODDIR)
endif
ifneq ($(origin ESMF_F90OPTFLAG), environment)
ESMF_F90OPTFLAG = $(ESMF_F90OPTFLAG_X)
ifeq ($(ESMF_BOPT),g)
ESMF_F90OPTFLAG = $(ESMF_F90OPTFLAG_G)
endif
ifeq ($(ESMF_BOPT),O)
ESMF_F90OPTFLAG = $(ESMF_F90OPTFLAG_O)
endif
endif
# - make sure environment variable gets prepended _once_
ifeq ($(origin ESMF_F90COMPILEOPTS), environment)
export ESMF_F90COMPILEOPTS_ENV := $(ESMF_F90COMPILEOPTS)
unexport ESMF_F90COMPILEOPTS
endif
ifeq ($(origin ESMF_F90COMPILEOPTS_ENV), environment)
ESMF_F90COMPILEOPTS = $(ESMF_F90COMPILEOPTS_ENV)
endif
ESMF_F90COMPILEOPTS += $(ESMF_F90OPTFLAG) $(ESMF_SO_F90COMPILEOPTS)
# - make sure environment variable gets prepended _once_
ifeq ($(origin ESMF_F90COMPILEPATHS), environment)
export ESMF_F90COMPILEPATHS_ENV := $(ESMF_F90COMPILEPATHS)
unexport ESMF_F90COMPILEPATHS
endif
ifeq ($(origin ESMF_F90COMPILEPATHS_ENV), environment)
ESMF_F90COMPILEPATHS = $(ESMF_F90COMPILEPATHS_ENV)
endif
ESMF_F90COMPILEPATHS     += $(ESMF_F90IMOD)$(ESMF_F90MODDIR)
ESMF_F90COMPILEPATHSLOCAL = -I$(ESMF_DIR)/$(LOCDIR)
ifneq ($(ESMF_SITE),default)
ESMF_F90COMPILEPATHSLOCAL += -I$(ESMF_SITEDIR)
endif
ESMF_F90COMPILEPATHSLOCAL += -I$(ESMF_CONFDIR) $(ESMF_INTERNALINCDIRS)
ESMF_F90COMPILEPATHS      += -I$(ESMF_INCDIR) $(ESMF_F90COMPILEPATHSTHIRD)
ESMF_F90COMPILEFREECPP    +=
ESMF_F90COMPILEFREENOCPP  +=
ESMF_F90COMPILEFIXCPP     +=
ESMF_F90COMPILEFIXNOCPP   +=
ESMF_F90COMPILECPPFLAGS   += $(ESMF_FPPFLAGS)

# - CXXCOMPILER
ifneq ($(origin ESMF_CXXCOMPILER), environment)
ESMF_CXXCOMPILER = $(ESMF_CXXCOMPILERDEFAULT)
ESMF_CXXCOMPILERDEFAULT = $(ESMF_CXXDEFAULT)
ifeq ($(origin ESMF_CXX), environment)
ESMF_CXXCOMPILERDEFAULT = $(ESMF_CXX)
endif
endif
ifneq ($(origin ESMF_CXXOPTFLAG), environment)
ESMF_CXXOPTFLAG = $(ESMF_CXXOPTFLAG_X)
ifeq ($(ESMF_BOPT),g)
ESMF_CXXOPTFLAG = $(ESMF_CXXOPTFLAG_G)
endif
ifeq ($(ESMF_BOPT),O)
ESMF_CXXOPTFLAG = $(ESMF_CXXOPTFLAG_O)
endif
endif
# - make sure environment variable gets prepended _once_
ifeq ($(origin ESMF_CXXCOMPILEOPTS), environment)
export ESMF_CXXCOMPILEOPTS_ENV := $(ESMF_CXXCOMPILEOPTS)
unexport ESMF_CXXCOMPILEOPTS
endif
ifeq ($(origin ESMF_CXXCOMPILEOPTS_ENV), environment)
ESMF_CXXCOMPILEOPTS = $(ESMF_CXXCOMPILEOPTS_ENV)
endif
ESMF_CXXCOMPILEOPTS += $(ESMF_CXXSTDFLAG) $(ESMF_CXXOPTFLAG) $(ESMF_SO_CXXCOMPILEOPTS)
# - make sure environment variable gets prepended _once_
ifeq ($(origin ESMF_CXXCOMPILEPATHS), environment)
export ESMF_CXXCOMPILEPATHS_ENV := $(ESMF_CXXCOMPILEPATHS)
unexport ESMF_CXXCOMPILEPATHS
endif
ifeq ($(origin ESMF_CXXCOMPILEPATHS_ENV), environment)
ESMF_CXXCOMPILEPATHS = $(ESMF_CXXCOMPILEPATHS_ENV)
endif
ESMF_CXXCOMPILEPATHS      +=
ESMF_CXXCOMPILEPATHSLOCAL  = -I$(ESMF_DIR)/$(LOCDIR)
ESMF_CXXCOMPILEPATHSLOCAL += -I$(ESMF_DIR)/$(LOCDIR)/../include
ifneq ($(ESMF_SITE),default)
ESMF_CXXCOMPILEPATHSLOCAL += -I$(ESMF_SITEDIR)
endif
ESMF_CXXCOMPILEPATHSLOCAL += -I$(ESMF_CONFDIR) $(ESMF_INTERNALINCDIRS)
ESMF_CXXCOMPILEPATHS      += -I$(ESMF_INCDIR)  $(ESMF_CXXCOMPILEPATHSTHIRD)
ESMF_CXXCOMPILECPPFLAGS   += $(ESMF_CPPFLAGS) -D__SDIR__='"$(LOCDIR)"'

# - CCOMPILER
ifneq ($(origin ESMF_CCOMPILER), environment)
ESMF_CCOMPILER = $(ESMF_CCOMPILERDEFAULT)
ESMF_CCOMPILERDEFAULT = $(ESMF_CDEFAULT)
ifeq ($(origin ESMF_C), environment)
ESMF_CCOMPILERDEFAULT = $(ESMF_C)
endif
endif
ifneq ($(origin ESMF_COPTFLAG), environment)
ESMF_COPTFLAG = $(ESMF_COPTFLAG_X)
ifeq ($(ESMF_BOPT),g)
ESMF_COPTFLAG = $(ESMF_COPTFLAG_G)
endif
ifeq ($(ESMF_BOPT),O)
ESMF_COPTFLAG = $(ESMF_COPTFLAG_O)
endif
endif
# - make sure environment variable gets prepended _once_
ifeq ($(origin ESMF_CCOMPILEOPTS), environment)
export ESMF_CCOMPILEOPTS_ENV := $(ESMF_CCOMPILEOPTS)
unexport ESMF_CCOMPILEOPTS
endif
ifeq ($(origin ESMF_CCOMPILEOPTS_ENV), environment)
ESMF_CCOMPILEOPTS = $(ESMF_CCOMPILEOPTS_ENV)
endif
ESMF_CCOMPILEOPTS += $(ESMF_CSTDFLAG) $(ESMF_COPTFLAG) $(ESMF_SO_CCOMPILEOPTS)
# - make sure environment variable gets prepended _once_
ifeq ($(origin ESMF_CCOMPILEPATHS), environment)
export ESMF_CCOMPILEPATHS_ENV := $(ESMF_CCOMPILEPATHS)
unexport ESMF_CCOMPILEPATHS
endif
ifeq ($(origin ESMF_CCOMPILEPATHS_ENV), environment)
ESMF_CCOMPILEPATHS = $(ESMF_CCOMPILEPATHS_ENV)
endif
ESMF_CCOMPILEPATHS      +=
ESMF_CCOMPILEPATHSLOCAL  = -I$(ESMF_DIR)/$(LOCDIR)
ESMF_CCOMPILEPATHSLOCAL += -I$(ESMF_DIR)/$(LOCDIR)/../include
ifneq ($(ESMF_SITE),default)
ESMF_CCOMPILEPATHSLOCAL += -I$(ESMF_SITEDIR)
endif
ESMF_CCOMPILEPATHSLOCAL += -I$(ESMF_CONFDIR) $(ESMF_INTERNALINCDIRS)
ESMF_CCOMPILEPATHS      += -I$(ESMF_INCDIR)  $(ESMF_CCOMPILEPATHSTHIRD)
ESMF_CCOMPILECPPFLAGS   += $(ESMF_CPPFLAGS) -D__SDIR__='"$(LOCDIR)"'

# - F90LINKER
ifneq ($(origin ESMF_F90LINKER), environment)
ESMF_F90LINKER = $(ESMF_F90LINKERDEFAULT)
ESMF_F90LINKERDEFAULT = $(ESMF_F90DEFAULT)
ifeq ($(origin ESMF_F90), environment)
ESMF_F90LINKERDEFAULT = $(ESMF_F90)
endif
endif
# - make sure environment variable gets prepended _once_
ifeq ($(origin ESMF_F90LINKOPTS), environment)
export ESMF_F90LINKOPTS_ENV := $(ESMF_F90LINKOPTS)
unexport ESMF_F90LINKOPTS
endif
ifeq ($(origin ESMF_F90LINKOPTS_ENV), environment)
ESMF_F90LINKOPTS = $(ESMF_F90LINKOPTS_ENV)
else
ifeq ($(ESMF_BOPT),g)
ESMF_F90LINKOPTS += $(ESMF_LINKOPTFLAG_G)
endif
ifeq ($(ESMF_BOPT),O)
ESMF_F90LINKOPTS += $(ESMF_LINKOPTFLAG_O)
endif
endif
ESMF_F90LINKOPTS     +=
# - make sure environment variable gets prepended _once_
ifeq ($(origin ESMF_F90LINKPATHS), environment)
export ESMF_F90LINKPATHS_ENV := $(ESMF_F90LINKPATHS)
unexport ESMF_F90LINKPATHS
endif
ifeq ($(origin ESMF_F90LINKPATHS_ENV), environment)
ESMF_F90LINKPATHS = $(ESMF_F90LINKPATHS_ENV)
endif
ESMF_F90LINKPATHS    += -L$(ESMF_LDIR) $(ESMF_F90LINKPATHSTHIRD)
# - make sure environment variable gets prepended _once_
ifeq ($(origin ESMF_F90LINKRPATHS), environment)
export ESMF_F90LINKRPATHS_ENV := $(ESMF_F90LINKRPATHS)
unexport ESMF_F90LINKRPATHS
endif
ifeq ($(origin ESMF_F90LINKRPATHS_ENV), environment)
ESMF_F90LINKRPATHS = $(ESMF_F90LINKRPATHS_ENV)
endif
ESMF_F90LINKRPATHS   += $(ESMF_F90RPATHPREFIX)$(ESMF_LDIR) $(ESMF_F90LINKRPATHSTHIRD)
# - make sure environment variable gets prepended _once_
ifeq ($(origin ESMF_F90LINKLIBS), environment)
export ESMF_F90LINKLIBS_ENV := $(ESMF_F90LINKLIBS)
unexport ESMF_F90LINKLIBS
endif
ifeq ($(origin ESMF_F90LINKLIBS_ENV), environment)
ESMF_F90LINKLIBS = $(ESMF_F90LINKLIBS_ENV)
endif
ESMF_F90LINKLIBS     += $(ESMF_F90LINKLIBSTHIRD)
ESMF_F90ESMFLINKLIBS += -lesmf $(ESMF_F90LINKLIBS)
ESMF_F90ESMFPRELOADLINKLIBS += -lesmf $(ESMF_TRACE_DYNAMICLINKLIBS) $(ESMF_F90LINKLIBS)

# - CXXLINKER
ifneq ($(origin ESMF_CXXLINKER), environment)
ESMF_CXXLINKER = $(ESMF_CXXLINKERDEFAULT)
ESMF_CXXLINKERDEFAULT = $(ESMF_CXXDEFAULT)
ifeq ($(origin ESMF_CXX), environment)
ESMF_CXXLINKERDEFAULT = $(ESMF_CXX)
endif
endif
# - make sure environment variable gets prepended _once_
ifeq ($(origin ESMF_CXXLINKOPTS), environment)
export ESMF_CXXLINKOPTS_ENV := $(ESMF_CXXLINKOPTS)
unexport ESMF_CXXLINKOPTS
endif
ifeq ($(origin ESMF_CXXLINKOPTS_ENV), environment)
ESMF_CXXLINKOPTS = $(ESMF_CXXLINKOPTS_ENV)
else
ifeq ($(ESMF_BOPT),g)
ESMF_CXXLINKOPTS += $(ESMF_LINKOPTFLAG_G)
endif
ifeq ($(ESMF_BOPT),O)
ESMF_CXXLINKOPTS += $(ESMF_LINKOPTFLAG_O)
endif
endif
ESMF_CXXLINKOPTS     +=
# - make sure environment variable gets prepended _once_
ifeq ($(origin ESMF_CXXLINKPATHS), environment)
export ESMF_CXXLINKPATHS_ENV := $(ESMF_CXXLINKPATHS)
unexport ESMF_CXXLINKPATHS
endif
ifeq ($(origin ESMF_CXXLINKPATHS_ENV), environment)
ESMF_CXXLINKPATHS = $(ESMF_CXXLINKPATHS_ENV)
endif
ESMF_CXXLINKPATHS    += -L$(ESMF_LDIR) $(ESMF_CXXLINKPATHSTHIRD)
# - make sure environment variable gets prepended _once_
ifeq ($(origin ESMF_CXXLINKRPATHS), environment)
export ESMF_CXXLINKRPATHS_ENV := $(ESMF_CXXLINKRPATHS)
unexport ESMF_CXXLINKRPATHS
endif
ifeq ($(origin ESMF_CXXLINKRPATHS_ENV), environment)
ESMF_CXXLINKRPATHS = $(ESMF_CXXLINKRPATHS_ENV)
endif
ESMF_CXXLINKRPATHS   += $(ESMF_CXXRPATHPREFIX)$(ESMF_LDIR) $(ESMF_CXXLINKRPATHSTHIRD)
# - make sure environment variable gets prepended _once_
ifeq ($(origin ESMF_CXXLINKLIBS), environment)
export ESMF_CXXLINKLIBS_ENV := $(ESMF_CXXLINKLIBS)
unexport ESMF_CXXLINKLIBS
endif
ifeq ($(origin ESMF_CXXLINKLIBS_ENV), environment)
ESMF_CXXLINKLIBS = $(ESMF_CXXLINKLIBS_ENV)
endif
ESMF_CXXLINKLIBS     += $(ESMF_CXXLINKLIBSTHIRD)
ESMF_CXXESMFLINKLIBS += -lesmf $(ESMF_CXXLINKLIBS)

# - CLINKER
ifneq ($(origin ESMF_CLINKER), environment)
ESMF_CLINKER = $(ESMF_CLINKERDEFAULT)
ESMF_CLINKERDEFAULT = $(ESMF_CDEFAULT)
ifeq ($(origin ESMF_C), environment)
ESMF_CLINKERDEFAULT = $(ESMF_C)
endif
endif
# - make sure environment variable gets prepended _once_
ifeq ($(origin ESMF_CLINKOPTS), environment)
export ESMF_CLINKOPTS_ENV := $(ESMF_CLINKOPTS)
unexport ESMF_CLINKOPTS
endif
ifeq ($(origin ESMF_CLINKOPTS_ENV), environment)
ESMF_CLINKOPTS = $(ESMF_CLINKOPTS_ENV)
else
ifeq ($(ESMF_BOPT),g)
ESMF_CLINKOPTS += $(ESMF_LINKOPTFLAG_G)
endif
ifeq ($(ESMF_BOPT),O)
ESMF_CLINKOPTS += $(ESMF_LINKOPTFLAG_O)
endif
endif
ESMF_CLINKOPTS     +=
# - make sure environment variable gets prepended _once_
ifeq ($(origin ESMF_CLINKPATHS), environment)
export ESMF_CLINKPATHS_ENV := $(ESMF_CLINKPATHS)
unexport ESMF_CLINKPATHS
endif
ifeq ($(origin ESMF_CLINKPATHS_ENV), environment)
ESMF_CLINKPATHS = $(ESMF_CLINKPATHS_ENV)
endif
ESMF_CLINKPATHS    += $(ESMF_CXXLINKPATHS) $(ESMF_F90LINKPATHS)
# - make sure environment variable gets prepended _once_
ifeq ($(origin ESMF_CLINKRPATHS), environment)
export ESMF_CLINKRPATHS_ENV := $(ESMF_CLINKRPATHS)
unexport ESMF_CLINKRPATHS
endif
ifeq ($(origin ESMF_CLINKRPATHS_ENV), environment)
ESMF_CLINKRPATHS = $(ESMF_CLINKRPATHS_ENV)
endif
ESMF_CLINKRPATHS   += $(addprefix $(ESMF_CXXRPATHPREFIX),$(subst -L,,$(filter -L%,$(ESMF_CLINKPATHS))))
# - make sure environment variable gets prepended _once_
ifeq ($(origin ESMF_CLINKLIBS), environment)
export ESMF_CLINKLIBS_ENV := $(ESMF_CLINKLIBS)
unexport ESMF_CLINKLIBS
endif
ifeq ($(origin ESMF_CLINKLIBS_ENV), environment)
ESMF_CLINKLIBS = $(ESMF_CLINKLIBS_ENV)
endif
ESMF_CLINKLIBS     += $(ESMF_CXXLINKLIBS) $(ESMF_F90LINKLIBS)
ESMF_CESMFLINKLIBS += -lesmf $(ESMF_CLINKLIBS)

# - tools: AR + RANLIB + ...
ifneq ($(origin ESMF_AR), environment)
ESMF_AR = $(ESMF_ARDEFAULT)
endif
ifneq ($(origin ESMF_ARCREATEFLAGS), environment)
ESMF_ARCREATEFLAGS = $(ESMF_ARCREATEFLAGSDEFAULT)
endif
ifneq ($(origin ESMF_AREXTRACT), environment)
ESMF_AREXTRACT = $(ESMF_AREXTRACTDEFAULT)
endif
ifneq ($(origin ESMF_RANLIB), environment)
ESMF_RANLIB = $(ESMF_RANLIBDEFAULT)
endif
ifneq ($(origin ESMF_CPP), environment)
ESMF_CPP = $(ESMF_CPPDEFAULT)
endif
ifneq ($(origin ESMF_SED), environment)
ESMF_SED = $(ESMF_SEDDEFAULT)
endif

#-------------------------------------------------------------------------------
# Add C++ standard string to compile options if non-system-default is chosen.
# The ESMF default is currently C++11 because parts of ESMF require it.
#-------------------------------------------------------------------------------
ifeq ($(ESMF_CXXSTD),default)
ESMF_CXXSTD = 11
endif

ifneq ($(ESMF_CXXSTD),sysdefault)
# Most compilers know the -std=c++XX flag. Overwrite in build_rules.mk if needed.
ESMF_CXXSTDFLAG         = -std=c++$(ESMF_CXXSTD)
ESMF_CXXCOMPILECPPFLAGS += -DESMF_CXXSTD=$(ESMF_CXXSTD)
endif

#-------------------------------------------------------------------------------
# Add C standard string to compile options if non-system-default is chosen.
# The ESMF default is currently C99.
#-------------------------------------------------------------------------------
ifeq ($(ESMF_CSTD),default)
ESMF_CSTD = 99
endif

ifneq ($(ESMF_CSTD),sysdefault)
# Most compilers know the -std=cXX flag. Overwrite in build_rules.mk if needed.
ESMF_CSTDFLAG         = -std=c$(ESMF_CSTD)
ESMF_CCOMPILECPPFLAGS += -DESMF_CSTD=$(ESMF_CSTD)
endif

# - Archive library
ESMF_LIB_SUFFIX       = a
ifeq ($(ESMF_OS),MinGW)
ESMF_LIB_SUFFIX       = lib
endif

# - Shared library
ESMF_SL_SUFFIX        = so
ifeq ($(ESMF_OS),Darwin)
ESMF_SL_SUFFIX        = dylib
endif
ifeq ($(ESMF_OS),Cygwin)
ESMF_SL_SUFFIX        = dll.a
endif
ifeq ($(ESMF_OS),MinGW)
ESMF_SL_SUFFIX        = dll
endif
ifeq ($(ESMF_SHARED_LIB_BUILD),ON)
ESMF_SL_LIBS_TO_MAKE  = libesmf
endif
ESMF_SL_LIBLINKER     = $(ESMF_CXXCOMPILER)
ESMF_SL_LIBOPTS      +=
ESMF_SL_LIBLIBS      +=

# - Shared objects
ESMF_SO_F90COMPILEOPTS  +=
ESMF_SO_F90LINKOPTS     +=
ESMF_SO_F90LINKOPTSEXE  +=
ESMF_SO_CXXCOMPILEOPTS  +=
ESMF_SO_CXXLINKOPTS     +=
ESMF_SO_CXXLINKOPTSEXE  +=
ESMF_SO_CCOMPILEOPTS    = $(ESMF_SO_CXXCOMPILEOPTS)
ESMF_SO_CLINKOPTS       = $(ESMF_SO_CXXLINKOPTS)
ESMF_SO_CLINKOPTSEXE    = $(ESMF_SO_CXXLINKOPTSEXE)

# - OpenMP compiler and linker flags
ESMF_OPENMP_F90COMPILEOPTS  +=
ESMF_OPENMP_F90LINKOPTS     +=
ESMF_OPENMP_CXXCOMPILEOPTS  +=
ESMF_OPENMP_CXXLINKOPTS     +=

# - OpenACC compiler and linker flags
ESMF_OPENACC_F90COMPILEOPTS  +=
ESMF_OPENACC_F90LINKOPTS     +=
ESMF_OPENACC_CXXCOMPILEOPTS  +=
ESMF_OPENACC_CXXLINKOPTS     +=

# - MPIRUN
ifneq ($(origin ESMF_MPIRUN), environment)
ESMF_MPIRUN = $(ESMF_MPIRUNDEFAULT)
endif

# - MPIMPMDRUN
ifneq ($(origin ESMF_MPIMPMDRUN), environment)
ESMF_MPIMPMDRUN = $(ESMF_MPIMPMDRUNDEFAULT)
endif

# Variable that controls the output option for object files.  Note that
# some compilers do not support specifying "-o" and "-c" together.  These
# platforms are specified by NO_OCFLAG_LIST defined below.  In those cases
# the object files are moved after the compile.
NO_OCFLAG_LIST := \
	IRIX64.default \
	Cygwin.intelgcc \
	Cygwin.intel \
	MinGW.intel \
	MinGW.intelcl
WINTEL_OFFLAG_LIST := \
	Cygwin.intelgcc \
	Cygwin.intel \
	MinGW.intel \
	MinGW.intelcl
ifeq (,$(findstring $(ESMF_OS).$(ESMF_COMPILER),$(NO_OCFLAG_LIST)))
  ESMF_OBJOUT_OPTION = -o $@
  ESMF_EXEOUT_OPTION = -o $@
else
ifeq (,$(findstring $(ESMF_OS).$(ESMF_COMPILER),$(WINTEL_OFFLAG_LIST)))
  ESMF_OBJOUT_OPTION = ; $(ESMF_MV) $*.o $@
  ESMF_EXEOUT_OPTION = -o $@
else
  ESMF_OBJOUT_OPTION = ; $(ESMF_MV) $*.obj $@
  ESMF_EXEOUT_OPTION = -Fe`$(ESMF_DIR)/scripts/path_mingw2win $@.exe`
endif
endif


#-------------------------------------------------------------------------------
# Up to here there have only been definitions, no targets.  This is the
# first (and therefore default) target.  The definition of what "all" is
# should be defined in the top level makefile and not here.  If a different
# default is desired, that can also be defined in the top level makefile,
# before common.mk is included.
#-------------------------------------------------------------------------------

default: lib

#-------------------------------------------------------------------------------
#  Set up all defaults before here.   Next, include both the system dependent
#  makefile fragment, and if present, the site-specific makefile fragment.
#  These files can += to add on to existing defaults, or override settings
#  by setting flags and variables with = to new values.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  Include the default platform-specific makefile fragment.
#-------------------------------------------------------------------------------

include $(ESMF_CONFDIR)/build_rules.mk


#-------------------------------------------------------------------------------
#  Include site specific makefile fragment.  If we want to suppress a warning
#  message if the site file is not found add a leading dash before the include
#  keyword.  (If the file is not found it is a warning, not a fatal error.)
#-------------------------------------------------------------------------------

ifneq ($(ESMF_SITE),default)
include $(ESMF_SITEDIR)/build_rules.mk
endif

#-------------------------------------------------------------------------------
#  Now all system-dependent files have been read.  Now anything
#  below here is again common code.  Variables should no longer be overwritten
#  with =, but should be appended to if neeeded with +=
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Mapper
#-------------------------------------------------------------------------------
ifeq ($(ESMF_MAPPER_BUILD),ON)
ESMF_CPPFLAGS             += -DESMF_MAPPER=1
endif

#-------------------------------------------------------------------------------
# 3rd Party libraries
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# MOAB
#-------------------------------------------------------------------------------
ifneq ($(ESMF_MOAB),OFF)
ifeq ($(ESMF_LAPACK),OFF)
$(error ESMF_MOAB cannot be built with ESMF_LAPACK=OFF.)
endif
endif

ifeq ($(ESMF_MOAB),standard)
ifneq ($(origin ESMF_MOAB_LIBS), environment)
ESMF_MOAB_LIBS = -lMOAB
endif
endif

ifneq ($(ESMF_MOAB),OFF)
ESMF_CPPFLAGS             += -DESMF_MOAB=1
ifdef ESMF_MOAB_INCLUDE
ESMF_CXXCOMPILEPATHSTHIRD += -I$(ESMF_MOAB_INCLUDE)
ESMF_F90COMPILEPATHSTHIRD += -I$(ESMF_MOAB_INCLUDE)
endif
ifdef ESMF_MOAB_LIBS
ESMF_CXXLINKLIBSTHIRD     += $(ESMF_MOAB_LIBS)
ESMF_CXXLINKRPATHSTHIRD   += $(addprefix $(ESMF_CXXRPATHPREFIX),$(subst -L,,$(filter -L%,$(ESMF_MOAB_LIBS))))
ESMF_F90LINKLIBSTHIRD     += $(ESMF_MOAB_LIBS)
ESMF_F90LINKRPATHSTHIRD   += $(addprefix $(ESMF_F90RPATHPREFIX),$(subst -L,,$(filter -L%,$(ESMF_MOAB_LIBS))))
endif
ifdef ESMF_MOAB_LIBPATH
ESMF_CXXLINKPATHSTHIRD    += -L$(ESMF_MOAB_LIBPATH)
ESMF_F90LINKPATHSTHIRD    += -L$(ESMF_MOAB_LIBPATH)
ESMF_CXXLINKRPATHSTHIRD   += $(ESMF_CXXRPATHPREFIX)$(ESMF_MOAB_LIBPATH)
ESMF_F90LINKRPATHSTHIRD   += $(ESMF_F90RPATHPREFIX)$(ESMF_MOAB_LIBPATH)
endif
endif

#-------------------------------------------------------------------------------
# LAPACK
#-------------------------------------------------------------------------------
ifndef ESMF_LAPACK
ifndef ESMF_LAPACK_OFF
ESMF_LAPACK = internal
endif
endif

ifeq ($(ESMF_LAPACK),OFF)
ESMF_LAPACK =
export ESMF_LAPACK_OFF = true
endif

ifeq ($(ESMF_LAPACK),internal)
ESMF_LAPACK_INTERNAL = 1
ESMF_LAPACK_LIBPATH =
ESMF_LAPACK_LIBS =
endif

ifeq ($(ESMF_LAPACK),system)
ifdef ESMF_LAPACKDEFAULT
ESMF_LAPACK = $(ESMF_LAPACKDEFAULT)
endif
endif

ifeq ($(ESMF_LAPACK),netlib)
ifndef ESMF_LAPACK_LIBS
ESMF_LAPACK_LIBS = -llapack -lblas
endif
endif

ifeq ($(ESMF_LAPACK),mkl)
ifndef ESMF_LAPACK_LIBS
ESMF_LAPACK_LIBS = -lmkl_lapack -lmkl
endif
endif

ifeq ($(ESMF_LAPACK),scsl)
ifndef ESMF_LAPACK_LIBS
ESMF_LAPACK_LIBS = -lscs
endif
endif

ifeq ($(ESMF_LAPACK),openblas)
ifndef ESMF_LAPACK_LIBS
ESMF_LAPACK_LIBS = -lopenblas
endif
endif

ifdef ESMF_LAPACK
ESMF_CPPFLAGS             += -DESMF_LAPACK=1
ifdef ESMF_LAPACK_INTERNAL
ESMF_CPPFLAGS             += -DESMF_LAPACK_INTERNAL=1
endif
ifdef ESMF_LAPACK_LIBS
ESMF_CXXLINKLIBSTHIRD     += $(ESMF_LAPACK_LIBS)
ESMF_CXXLINKRPATHSTHIRD   += $(addprefix $(ESMF_CXXRPATHPREFIX),$(subst -L,,$(filter -L%,$(ESMF_LAPACK_LIBS))))
ESMF_F90LINKLIBSTHIRD     += $(ESMF_LAPACK_LIBS)
ESMF_F90LINKRPATHSTHIRD   += $(addprefix $(ESMF_F90RPATHPREFIX),$(subst -L,,$(filter -L%,$(ESMF_LAPACK_LIBS))))
endif
ifdef ESMF_LAPACK_LIBPATH
ESMF_CXXLINKPATHSTHIRD    += -L$(ESMF_LAPACK_LIBPATH)
ESMF_F90LINKPATHSTHIRD    += -L$(ESMF_LAPACK_LIBPATH)
ESMF_CXXLINKRPATHSTHIRD   += $(ESMF_CXXRPATHPREFIX)$(ESMF_LAPACK_LIBPATH)
ESMF_F90LINKRPATHSTHIRD   += $(ESMF_F90RPATHPREFIX)$(ESMF_LAPACK_LIBPATH)
endif
endif

#-------------------------------------------------------------------------------
# ESMF Accelerator Framework
#-------------------------------------------------------------------------------
ifdef ESMF_ACC_SOFTWARE_STACK
# FIXME: Differentiate between
# 1. unsupported/unrecognized_framework
#    (framework specified but not supported)
# AND
# 2. no_framework (none)
ifeq ($(ESMF_ACC_SOFTWARE_STACK),opencl)
ESMF_CPPFLAGS             += -DESMF_ACC_SOFTWARE_STACK=1
endif
ifeq ($(ESMF_ACC_SOFTWARE_STACK),openacc)
ESMF_CPPFLAGS             += -DESMF_ACC_SOFTWARE_STACK=1
endif
ifeq ($(ESMF_ACC_SOFTWARE_STACK),intelmic)
ESMF_CPPFLAGS             += -DESMF_ACC_SOFTWARE_STACK=1
ESMF_ARDEFAULT 						= xiar
endif
ifeq ($(ESMF_ACC_SOFTWARE_STACK),openmp4)
ESMF_CPPFLAGS             += -DESMF_ACC_SOFTWARE_STACK=1
ifeq ($(ESMF_COMPILER),intel)
ESMF_ARDEFAULT 						= xiar
endif
endif
ifeq ($(ESMF_ACC_SOFTWARE_STACK),none)
ESMF_CPPFLAGS             += -DESMF_NO_ACC_SOFTWARE_STACK=1
endif
ifdef ESMF_ACC_SOFTWARE_STACK_INCLUDE
ESMF_CXXCOMPILEPATHSTHIRD += -I$(ESMF_ACC_SOFTWARE_STACK_INCLUDE)
ESMF_F90COMPILEPATHSTHIRD += -I$(ESMF_ACC_SOFTWARE_STACK_INCLUDE)
endif
ifdef ESMF_ACC_SOFTWARE_STACK_LIBS
ESMF_CXXLINKLIBSTHIRD     += $(ESMF_ACC_SOFTWARE_STACK_LIBS)
ESMF_CXXLINKRPATHSTHIRD   += $(addprefix $(ESMF_CXXRPATHPREFIX),$(subst -L,,$(filter -L%,$(ESMF_ACC_SOFTWARE_STACK_LIBS))))
ESMF_F90LINKLIBSTHIRD     += $(ESMF_ACC_SOFTWARE_STACK_LIBS)
ESMF_F90LINKRPATHSTHIRD   += $(addprefix $(ESMF_F90RPATHPREFIX),$(subst -L,,$(filter -L%,$(ESMF_ACC_SOFTWARE_STACK_LIBS))))
endif
ifdef ESMF_ACC_SOFTWARE_STACK_LIBPATH
ESMF_CXXLINKPATHSTHIRD    += -L$(ESMF_ACC_SOFTWARE_STACK_LIBPATH)
ESMF_F90LINKPATHSTHIRD    += -L$(ESMF_ACC_SOFTWARE_STACK_LIBPATH)
ESMF_CXXLINKRPATHSTHIRD   += $(ESMF_CXXRPATHPREFIX)$(ESMF_ACC_SOFTWARE_STACK_LIBPATH)
ESMF_F90LINKRPATHSTHIRD   += $(ESMF_F90RPATHPREFIX)$(ESMF_ACC_SOFTWARE_STACK_LIBPATH)
endif
endif

#-------------------------------------------------------------------------------
# NETCDF
#-------------------------------------------------------------------------------

# Check if ESMF_NETCDF may be pointing to nc-config with absolute path.
# For situations where PATH is not to be trusted for nc-config location.
pathtype := ""
ifdef ESMF_NETCDF
  pathtype := $(shell $(ESMF_DIR)/scripts/pathtype $(ESMF_NETCDF))
endif
ifeq ($(pathtype),abs)
  # use the $(ESMF_NETCDF) contents as nc-config
  ESMF_NCCONFIG = $(ESMF_NETCDF)
endif
ifeq ($(ESMF_NETCDF),nc-config)
  ESMF_NCCONFIG = $(ESMF_NETCDF)
endif
ifdef ESMF_NCCONFIG
  # Use nc-config, and potentially nf-config to determine correct NetCDF options
  ifneq ($(origin ESMF_NFCONFIG), environment)
    ifeq ($(pathtype),abs)
      # nc-config was provided via absolute path -> look for NFCONFIG there first
      ESMF_NFCONFIG := $(shell $(ESMF_NETCDF) --prefix)/bin/nf-config
      ifeq ($(shell $(ESMF_DIR)/scripts/exists $(ESMF_NFCONFIG)),$(ESMF_NFCONFIG))
        export ESMF_NFCONFIG
      endif
    endif
    ifndef ESMF_NFCONFIG
      ifeq ($(shell $(ESMF_DIR)/scripts/available nf-config),nf-config)
        # There is an nf-config command in the user's path, use it
        ESMF_NFCONFIG := nf-config
      else
        # Last attempt see if there is a nf-config command same place as nc-config
        ESMF_NFCONFIG := $(shell $(ESMF_NETCDF) --prefix)/bin/nf-config
        ifneq ($(shell $(ESMF_DIR)/scripts/exists $(ESMF_NFCONFIG)),$(ESMF_NFCONFIG))
          ESMF_NFCONFIG :=
        endif
      endif
    endif
    export ESMF_NFCONFIG
  endif
  # NetCDF C options -------------------------------------------------------------
  ifneq ($(origin ESMF_NETCDF_INCLUDE), environment)
    # query nc-config for the include path
    ESMF_NETCDF_INCLUDE := $(shell $(ESMF_NCCONFIG) --includedir)
    export ESMF_NETCDF_INCLUDE
  endif
  ifneq ($(origin ESMF_NETCDF_LIBS), environment)
    # query nc-config for the -lnetcdf* options
    ESMF_NETCDF_LIBS := $(filter -l%,$(shell $(ESMF_NCCONFIG) --libs))
    export ESMF_NETCDF_LIBS
  endif
  ifneq ($(origin ESMF_NETCDF_LIBPATH), environment)
    # query nc-config for the LIBPATH
    ESMF_NETCDF_LIBPATH := $(shell $(ESMF_NCCONFIG) --libdir)
    ifneq (,$(findstring unknown,$(ESMF_NETCDF_LIBPATH)))
      # older nc-config -> extract the -L options out of the --libs return value
      ESMF_NETCDF_LIBPATH := $(subst -L,,$(filter -L%,$(shell $(ESMF_NCCONFIG) --libs)))
    endif
    export ESMF_NETCDF_LIBPATH
  endif
  # NetCDF Fortran options -------------------------------------------------------
  ifneq ($(origin ESMF_NETCDFF_INCLUDE), environment)
    ifdef ESMF_NFCONFIG
      ifeq ($(shell $(ESMF_DIR)/scripts/nfconfigtest $(ESMF_NFCONFIG)),working)
        # a working nf-config -> access the include path
        ESMF_NETCDFF_INCLUDE := $(shell $(ESMF_NFCONFIG) --includedir)
      endif
      export ESMF_NETCDFF_INCLUDE
    endif
  endif
  ifneq ($(origin ESMF_NETCDFF_LIBS), environment)
    ifdef ESMF_NFCONFIG
      ifeq ($(shell $(ESMF_DIR)/scripts/nfconfigtest $(ESMF_NFCONFIG)),working)
        # a working nf-config -> use it to get -lnetcdf* options
        ESMF_NETCDFF_LIBS    := $(filter -l%,$(shell $(ESMF_NFCONFIG) --flibs))
      else
        # not a working nf-config -> try manually guessing the correct -lnetcdf* option
        ESMF_NETCDFF_LIBS    := -lnetcdff
      endif
    else
      # no nf-config available -> use nc-config to get -lnetcdf* options
      ESMF_NETCDFF_LIBS    := $(filter -l%,$(shell $(ESMF_NCCONFIG) --flibs))
    endif
    export ESMF_NETCDFF_LIBS
  endif
  ifneq ($(origin ESMF_NETCDFF_LIBPATH), environment)
    ifdef ESMF_NFCONFIG
      ifeq ($(shell $(ESMF_DIR)/scripts/nfconfigtest $(ESMF_NFCONFIG)),working)
        # a working nf-config -> extract the -L options out of the --flibs return value
        ESMF_NETCDFF_LIBPATH := $(subst -L,,$(filter -L%,$(shell $(ESMF_NFCONFIG) --flibs)))
      endif
      export ESMF_NETCDFF_LIBPATH
     endif
  endif
endif

ifeq ($(ESMF_NETCDF),standard)
ifneq ($(origin ESMF_NETCDF_LIBS), environment)
ESMF_NETCDF_LIBS = -lnetcdf
export ESMF_NETCDF_LIBS
endif
endif

ifeq ($(ESMF_NETCDF),split)
ifneq ($(origin ESMF_NETCDF_LIBS), environment)
ESMF_NETCDF_LIBS = -lnetcdff -lnetcdf
export ESMF_NETCDF_LIBS
endif
endif

ifdef ESMF_NETCDF
  ESMF_CPPFLAGS             += -DESMF_NETCDF=1
  ifdef ESMF_NETCDF_INCLUDE
    ESMF_CXXCOMPILEPATHSTHIRD += -I$(ESMF_NETCDF_INCLUDE)
    ESMF_F90COMPILEPATHSTHIRD += -I$(ESMF_NETCDF_INCLUDE)
  endif
  ifdef ESMF_NETCDFF_INCLUDE
    ESMF_F90COMPILEPATHSTHIRD += -I$(ESMF_NETCDFF_INCLUDE)
  endif
  ifdef ESMF_NETCDF_LIBS
    ESMF_CXXLINKLIBSTHIRD     += $(ESMF_NETCDF_LIBS)
    ESMF_F90LINKLIBSTHIRD     += $(ESMF_NETCDF_LIBS)
  endif
  ifdef ESMF_NETCDFF_LIBS
    ESMF_CXXLINKLIBSTHIRD     += $(ESMF_NETCDFF_LIBS)
    ESMF_F90LINKLIBSTHIRD     += $(ESMF_NETCDFF_LIBS)
  endif
  ifdef ESMF_NETCDF_LIBPATH
    ESMF_CXXLINKPATHSTHIRD    += $(addprefix -L,$(ESMF_NETCDF_LIBPATH))
    ESMF_F90LINKPATHSTHIRD    += $(addprefix -L,$(ESMF_NETCDF_LIBPATH))
    ESMF_CXXLINKRPATHSTHIRD   += $(addprefix $(ESMF_CXXRPATHPREFIX),$(ESMF_NETCDF_LIBPATH))
    ESMF_F90LINKRPATHSTHIRD   += $(addprefix $(ESMF_F90RPATHPREFIX),$(ESMF_NETCDF_LIBPATH))
  endif
  ifdef ESMF_NETCDFF_LIBPATH
    ESMF_CXXLINKPATHSTHIRD    += $(addprefix -L,$(ESMF_NETCDFF_LIBPATH))
    ESMF_F90LINKPATHSTHIRD    += $(addprefix -L,$(ESMF_NETCDFF_LIBPATH))
    ESMF_CXXLINKRPATHSTHIRD   += $(addprefix $(ESMF_CXXRPATHPREFIX),$(ESMF_NETCDFF_LIBPATH))
    ESMF_F90LINKRPATHSTHIRD   += $(addprefix $(ESMF_F90RPATHPREFIX),$(ESMF_NETCDFF_LIBPATH))
  endif
endif

#-------------------------------------------------------------------------------
# PNETCDF
#-------------------------------------------------------------------------------
ifeq ($(ESMF_PNETCDF),pnetcdf-config)
ESMF_PNETCDF_INCLUDE = $(shell pnetcdf-config --includedir)
ESMF_PNETCDF_LIBPATH = $(shell pnetcdf-config --libdir)
ESMF_PNETCDF_LIBS = -lpnetcdf
endif

ifeq ($(ESMF_PNETCDF),standard)
ifneq ($(origin ESMF_PNETCDF_LIBS), environment)
ESMF_PNETCDF_LIBS = -lpnetcdf
endif
endif

ifdef ESMF_PNETCDF
ESMF_CPPFLAGS             += -DESMF_PNETCDF=1
ifdef ESMF_PNETCDF_INCLUDE
ESMF_CXXCOMPILEPATHSTHIRD += -I$(ESMF_PNETCDF_INCLUDE)
ESMF_F90COMPILEPATHSTHIRD += -I$(ESMF_PNETCDF_INCLUDE)
endif
ifdef ESMF_PNETCDF_LIBS
ESMF_CXXLINKLIBSTHIRD     += $(ESMF_PNETCDF_LIBS)
ESMF_CXXLINKRPATHSTHIRD   += $(addprefix $(ESMF_CXXRPATHPREFIX),$(subst -L,,$(filter -L%,$(ESMF_PNETCDF_LIBS))))
ESMF_F90LINKLIBSTHIRD     += $(ESMF_PNETCDF_LIBS)
ESMF_F90LINKRPATHSTHIRD   += $(addprefix $(ESMF_F90RPATHPREFIX),$(subst -L,,$(filter -L%,$(ESMF_PNETCDF_LIBS))))
endif
ifdef ESMF_PNETCDF_LIBPATH
ESMF_CXXLINKPATHSTHIRD    += -L$(ESMF_PNETCDF_LIBPATH)
ESMF_F90LINKPATHSTHIRD    += -L$(ESMF_PNETCDF_LIBPATH)
ESMF_CXXLINKRPATHSTHIRD   += $(ESMF_CXXRPATHPREFIX)$(ESMF_PNETCDF_LIBPATH)
ESMF_F90LINKRPATHSTHIRD   += $(ESMF_F90RPATHPREFIX)$(ESMF_PNETCDF_LIBPATH)
endif
endif

#-------------------------------------------------------------------------------
# XERCES C++ XML API
#-------------------------------------------------------------------------------
ifeq ($(ESMF_XERCES),standard)
ifneq ($(origin ESMF_XERCES_LIBS), environment)
ESMF_XERCES_LIBS = -lxerces-c
endif
endif

ifdef ESMF_XERCES
ESMF_CPPFLAGS                += -DESMF_XERCES=1
ifdef ESMF_XERCES_INCLUDE
ESMF_CXXCOMPILEPATHSTHIRD    += -I$(ESMF_XERCES_INCLUDE)
ESMF_F90COMPILEPATHSTHIRD    += -I$(ESMF_XERCES_INCLUDE)
endif
ifdef ESMF_XERCES_LIBS
ESMF_CXXLINKLIBSTHIRD     += $(ESMF_XERCES_LIBS)
ESMF_CXXLINKRPATHSTHIRD   += $(addprefix $(ESMF_CXXRPATHPREFIX),$(subst -L,,$(filter -L%,$(ESMF_XERCES_LIBS))))
ESMF_F90LINKLIBSTHIRD     += $(ESMF_XERCES_LIBS)
ESMF_F90LINKRPATHSTHIRD   += $(addprefix $(ESMF_F90RPATHPREFIX),$(subst -L,,$(filter -L%,$(ESMF_XERCES_LIBS))))
endif
ifdef ESMF_XERCES_LIBPATH
ESMF_CXXLINKPATHSTHIRD    += -L$(ESMF_XERCES_LIBPATH)
ESMF_F90LINKPATHSTHIRD    += -L$(ESMF_XERCES_LIBPATH)
ESMF_CXXLINKRPATHSTHIRD   += $(ESMF_CXXRPATHPREFIX)$(ESMF_XERCES_LIBPATH)
ESMF_F90LINKRPATHSTHIRD   += $(ESMF_F90RPATHPREFIX)$(ESMF_XERCES_LIBPATH)
endif
endif

#-------------------------------------------------------------------------------
# yaml-cpp C++ YAML API
#-------------------------------------------------------------------------------
ifeq ($(ESMF_YAMLCPP),internal)
ESMF_YAMLCPP_PRESENT = TRUE
ESMF_CXXCOMPILEPATHS += -I$(ESMF_DIR)/src/prologue/yaml-cpp/include
ESMF_YAMLCPP_INCLUDE =
ESMF_YAMLCPP_LIBPATH =
ESMF_YAMLCPP_LIBS =
endif

ifeq ($(ESMF_YAMLCPP),standard)
ESMF_YAMLCPP_PRESENT = TRUE
ifneq ($(origin ESMF_YAMLCPP_LIBS), environment)
ESMF_YAMLCPP_LIBS = -lyaml-cpp
endif
endif

ifeq ($(ESMF_YAMLCPP_PRESENT),TRUE)
ESMF_CPPFLAGS                += -DESMF_YAMLCPP=1 -DESMF_YAML=1
ifdef ESMF_YAMLCPP_INCLUDE
ESMF_CXXCOMPILEPATHSTHIRD    += -I$(ESMF_YAMLCPP_INCLUDE)
ESMF_F90COMPILEPATHSTHIRD    += -I$(ESMF_YAMLCPP_INCLUDE)
endif
ifdef ESMF_YAMLCPP_LIBS
ESMF_CXXLINKLIBSTHIRD     += $(ESMF_YAMLCPP_LIBS)
ESMF_CXXLINKRPATHSTHIRD   += $(addprefix $(ESMF_CXXRPATHPREFIX),$(subst -L,,$(filter -L%,$(ESMF_YAMLCPP_LIBS))))
ESMF_F90LINKLIBSTHIRD     += $(ESMF_YAMLCPP_LIBS)
ESMF_F90LINKRPATHSTHIRD   += $(addprefix $(ESMF_F90RPATHPREFIX),$(subst -L,,$(filter -L%,$(ESMF_YAMLCPP_LIBS))))
endif
ifdef ESMF_YAMLCPP_LIBPATH
ESMF_CXXLINKPATHSTHIRD    += -L$(ESMF_YAMLCPP_LIBPATH)
ESMF_F90LINKPATHSTHIRD    += -L$(ESMF_YAMLCPP_LIBPATH)
ESMF_CXXLINKRPATHSTHIRD   += $(ESMF_CXXRPATHPREFIX)$(ESMF_YAMLCPP_LIBPATH)
ESMF_F90LINKRPATHSTHIRD   += $(ESMF_F90RPATHPREFIX)$(ESMF_YAMLCPP_LIBPATH)
endif
endif

#-------------------------------------------------------------------------------
# PIO
#-------------------------------------------------------------------------------
ifneq ($(origin ESMF_PIO), environment)
ifndef ESMF_PIO
export ESMF_PIO = $(ESMF_PIODEFAULT)
endif

ifeq ($(ESMF_PIO),internal)
ifndef ESMF_NETCDF
# PIO, starting with version 2, depends on NetCDF. Defaulting to internal needs
# be turned off if there is no NetCDF available. Externally set PIO will be let
# through, but will trigger the error down when actually attempting to build
# PIO internally.
ESMF_PIO = OFF
endif
endif

endif

ifeq ($(ESMF_PIO),OFF)
ESMF_PIO=
endif

ifdef ESMF_PIO
ESMF_CPPFLAGS                += -DESMF_PIO=1
ifneq ($(origin ESMF_PIO_LIBS), environment)
ESMF_PIO_LIBS = -lpioc
endif
ifdef ESMF_PIO_INCLUDE
ESMF_CXXCOMPILEPATHSTHIRD    += -I$(ESMF_PIO_INCLUDE)
ESMF_F90COMPILEPATHSTHIRD    += -I$(ESMF_PIO_INCLUDE)
endif
ifdef ESMF_PIO_LIBS
ESMF_CXXLINKLIBSTHIRD     := $(addprefix $(ESMF_PIO_LIBS) ,$(ESMF_CXXLINKLIBSTHIRD))
ESMF_CXXLINKRPATHSTHIRD   += $(addprefix $(ESMF_CXXRPATHPREFIX),$(subst -L,,$(filter -L%,$(ESMF_PIO_LIBS))))
ESMF_F90LINKLIBSTHIRD     := $(addprefix $(ESMF_PIO_LIBS) ,$(ESMF_F90LINKLIBSTHIRD))
ESMF_F90LINKRPATHSTHIRD   += $(addprefix $(ESMF_F90RPATHPREFIX),$(subst -L,,$(filter -L%,$(ESMF_PIO_LIBS))))
endif
ifdef ESMF_PIO_LIBPATH
ESMF_CXXLINKPATHSTHIRD    += -L$(ESMF_PIO_LIBPATH)
ESMF_F90LINKPATHSTHIRD    += -L$(ESMF_PIO_LIBPATH)
ESMF_CXXLINKRPATHSTHIRD   += $(ESMF_CXXRPATHPREFIX)$(ESMF_PIO_LIBPATH)
ESMF_F90LINKRPATHSTHIRD   += $(ESMF_F90RPATHPREFIX)$(ESMF_PIO_LIBPATH)
endif
endif

#-------------------------------------------------------------------------------
# Proj.4
#-------------------------------------------------------------------------------
ifneq ($(origin ESMF_PROJ4), environment)
ifdef ESMF_PROJ4DEFAULT
export ESMF_PROJ4 = $(ESMF_PROJ4DEFAULT)
endif
endif

ifeq ($(ESMF_PROJ4),OFF)
ESMF_PROJ4=
endif

ifeq ($(ESMF_PROJ4),external)
ifneq ($(origin ESMF_PROJ4_LIBS), environment)
ESMF_PROJ4_LIBS = -lproj
endif
endif

ifdef ESMF_PROJ4
ESMF_CPPFLAGS                += -DESMF_PROJ4=1
ifdef ESMF_PROJ4_INCLUDE
ESMF_CXXCOMPILEPATHSTHIRD    += -I$(ESMF_PROJ4_INCLUDE)
ESMF_F90COMPILEPATHSTHIRD    += -I$(ESMF_PROJ4_INCLUDE)
endif
ifdef ESMF_PROJ4_LIBS
ESMF_CXXLINKLIBSTHIRD     += $(ESMF_PROJ4_LIBS)
ESMF_CXXLINKRPATHSTHIRD   += $(addprefix $(ESMF_CXXRPATHPREFIX),$(subst -L,,$(filter -L%,$(ESMF_PROJ4_LIBS))))
ESMF_F90LINKLIBSTHIRD     += $(ESMF_PROJ4_LIBS)
ESMF_F90LINKRPATHSTHIRD   += $(addprefix $(ESMF_F90RPATHPREFIX),$(subst -L,,$(filter -L%,$(ESMF_PROJ4_LIBS))))
endif
ifdef ESMF_PROJ4_LIBPATH
ESMF_CXXLINKPATHSTHIRD    += -L$(ESMF_PROJ4_LIBPATH)
ESMF_F90LINKPATHSTHIRD    += -L$(ESMF_PROJ4_LIBPATH)
ESMF_CXXLINKRPATHSTHIRD   += $(ESMF_CXXRPATHPREFIX)$(ESMF_PROJ4_LIBPATH)
ESMF_F90LINKRPATHSTHIRD   += $(ESMF_F90RPATHPREFIX)$(ESMF_PROJ4_LIBPATH)
endif
endif

#-------------------------------------------------------------------------------
# Babeltrace
#-------------------------------------------------------------------------------
ifeq ($(ESMF_BABELTRACE),standard)
ifneq ($(origin ESMF_BABELTRACE_LIBS), environment)
ESMF_BABELTRACE_LIBS = -lbabeltrace-ctf
endif
endif

ifdef ESMF_BABELTRACE
ESMF_CPPFLAGS                += -DESMF_BABELTRACE=1
ifdef ESMF_BABELTRACE_INCLUDE
ESMF_CXXCOMPILEPATHSTHIRD    += -I$(ESMF_BABELTRACE_INCLUDE)
ESMF_F90COMPILEPATHSTHIRD    += -I$(ESMF_BABELTRACE_INCLUDE)
endif
ifdef ESMF_BABELTRACE_LIBS
ESMF_CXXLINKLIBSTHIRD     += $(ESMF_BABELTRACE_LIBS)
ESMF_CXXLINKRPATHSTHIRD   += $(addprefix $(ESMF_CXXRPATHPREFIX),$(subst -L,,$(filter -L%,$(ESMF_BABELTRACE_LIBS))))
ESMF_F90LINKLIBSTHIRD     += $(ESMF_BABELTRACE_LIBS)
ESMF_F90LINKRPATHSTHIRD   += $(addprefix $(ESMF_F90RPATHPREFIX),$(subst -L,,$(filter -L%,$(ESMF_BABELTRACE_LIBS))))
endif
ifdef ESMF_BABELTRACE_LIBPATH
ESMF_CXXLINKPATHSTHIRD    += -L$(ESMF_BABELTRACE_LIBPATH)
ESMF_F90LINKPATHSTHIRD    += -L$(ESMF_BABELTRACE_LIBPATH)
ESMF_CXXLINKRPATHSTHIRD   += $(ESMF_CXXRPATHPREFIX)$(ESMF_BABELTRACE_LIBPATH)
ESMF_F90LINKRPATHSTHIRD   += $(ESMF_F90RPATHPREFIX)$(ESMF_BABELTRACE_LIBPATH)
endif
endif

#-------------------------------------------------------------------------------
# NUMA
#-------------------------------------------------------------------------------
ifeq ($(ESMF_NUMA),OFF)
ESMF_NUMA=
endif

ifeq ($(ESMF_NUMA),ON)
ESMF_NUMA = standard
endif
ifeq ($(ESMF_NUMA),standard)
ifneq ($(origin ESMF_NUMA_LIBS), environment)
ESMF_NUMA_LIBS = -lnuma
endif
endif

ifdef ESMF_NUMA
ESMF_CPPFLAGS                += -DESMF_NUMA=1
ifdef ESMF_NUMA_INCLUDE
ESMF_CXXCOMPILEPATHSTHIRD    += -I$(ESMF_NUMA_INCLUDE)
ESMF_F90COMPILEPATHSTHIRD    += -I$(ESMF_NUMA_INCLUDE)
endif
ifdef ESMF_NUMA_LIBS
ESMF_CXXLINKLIBSTHIRD     += $(ESMF_NUMA_LIBS)
ESMF_CXXLINKRPATHSTHIRD   += $(addprefix $(ESMF_CXXRPATHPREFIX),$(subst -L,,$(filter -L%,$(ESMF_NUMA_LIBS))))
ESMF_F90LINKLIBSTHIRD     += $(ESMF_NUMA_LIBS)
ESMF_F90LINKRPATHSTHIRD   += $(addprefix $(ESMF_F90RPATHPREFIX),$(subst -L,,$(filter -L%,$(ESMF_NUMA_LIBS))))
endif
ifdef ESMF_NUMA_LIBPATH
ESMF_CXXLINKPATHSTHIRD    += -L$(ESMF_NUMA_LIBPATH)
ESMF_F90LINKPATHSTHIRD    += -L$(ESMF_NUMA_LIBPATH)
ESMF_CXXLINKRPATHSTHIRD   += $(ESMF_CXXRPATHPREFIX)$(ESMF_NUMA_LIBPATH)
ESMF_F90LINKRPATHSTHIRD   += $(ESMF_F90RPATHPREFIX)$(ESMF_NUMA_LIBPATH)
endif
endif

#-------------------------------------------------------------------------------
# NVML
#-------------------------------------------------------------------------------
ifeq ($(ESMF_NVML),OFF)
ESMF_NVML=
endif

ifeq ($(ESMF_NVML),ON)
ESMF_NVML = standard
endif
ifeq ($(ESMF_NVML),standard)
ifneq ($(origin ESMF_NVML_LIBS), environment)
ESMF_NVML_LIBS = -lnvidia-ml
endif
endif

ifdef ESMF_NVML
ESMF_CPPFLAGS                += -DESMF_NVML=1
ifdef ESMF_NVML_INCLUDE
ESMF_CXXCOMPILEPATHSTHIRD    += -I$(ESMF_NVML_INCLUDE)
ESMF_F90COMPILEPATHSTHIRD    += -I$(ESMF_NVML_INCLUDE)
endif
ifdef ESMF_NVML_LIBS
ESMF_CXXLINKLIBSTHIRD     += $(ESMF_NVML_LIBS)
ESMF_CXXLINKRPATHSTHIRD   += $(addprefix $(ESMF_CXXRPATHPREFIX),$(subst -L,,$(filter -L%,$(ESMF_NVML_LIBS))))
ESMF_F90LINKLIBSTHIRD     += $(ESMF_NVML_LIBS)
ESMF_F90LINKRPATHSTHIRD   += $(addprefix $(ESMF_F90RPATHPREFIX),$(subst -L,,$(filter -L%,$(ESMF_NVML_LIBS))))
endif
ifdef ESMF_NVML_LIBPATH
ESMF_CXXLINKPATHSTHIRD    += -L$(ESMF_NVML_LIBPATH)
ESMF_F90LINKPATHSTHIRD    += -L$(ESMF_NVML_LIBPATH)
ESMF_CXXLINKRPATHSTHIRD   += $(ESMF_CXXRPATHPREFIX)$(ESMF_NVML_LIBPATH)
ESMF_F90LINKRPATHSTHIRD   += $(ESMF_F90RPATHPREFIX)$(ESMF_NVML_LIBPATH)
endif
endif

#-------------------------------------------------------------------------------
# Set the correct MPIRUN command with appropriate options
#-------------------------------------------------------------------------------
ESMF_MPIRUNCOMMAND  = $(shell $(ESMF_DIR)/scripts/mpirun.command $(ESMF_DIR)/scripts $(ESMF_MPIRUN))
ifeq ($(ESMF_MPIRUNCOMMAND),esmfscript)
ESMF_MPIRUN := $(ESMF_DIR)/scripts/$(ESMF_MPIRUN) $(ESMF_MPISCRIPTOPTIONS)
endif

#-------------------------------------------------------------------------------
# ESMF_PTHREADS is passed (by CPP) into the library compilation to control the
# dependency of the ESMF library on Pthreads.
#-------------------------------------------------------------------------------
ifeq ($(ESMF_PTHREADS),OFF)
ESMF_CPPFLAGS       += -DESMF_NO_PTHREADS
endif
# even when compiling with ESMF_PTHREADS=ON we need to find common header
ESMF_CXXCOMPILEPATHSLOCAL += -I$(ESMF_DIR)/src/Infrastructure/stubs/pthread

#-------------------------------------------------------------------------------
# ESMF_OPENMP is passed (by CPP) into the library compilation to control the
# dependency of the ESMF library on OpenMP.
#-------------------------------------------------------------------------------
ifeq ($(ESMF_OPENMP),OFF)
ESMF_CPPFLAGS       += -DESMF_NO_OPENMP
endif

ifeq ($(ESMF_OPENMP),OMP4)
ESMF_CPPFLAGS       += -DESMF_OPENMP4
endif

ifneq ($(ESMF_OPENMP),OFF)
ESMF_F90COMPILEOPTS += $(ESMF_OPENMP_F90COMPILEOPTS)
ESMF_F90LINKOPTS    += $(ESMF_OPENMP_F90LINKOPTS)
ESMF_CXXCOMPILEOPTS += $(ESMF_OPENMP_CXXCOMPILEOPTS)
ESMF_CXXLINKOPTS    += $(ESMF_OPENMP_CXXLINKOPTS)
ESMF_CCOMPILEOPTS   += $(ESMF_OPENMP_CXXCOMPILEOPTS)
ESMF_CLINKOPTS      += $(ESMF_OPENMP_CXXLINKOPTS)
ESMF_SL_LIBOPTS     += $(ESMF_OPENMP_CXXLINKOPTS)
endif

#-------------------------------------------------------------------------------
# ESMF_OPENACC is passed (by CPP) into the library compilation to control the
# dependency of the ESMF library on OpenACC.
#-------------------------------------------------------------------------------
ifeq ($(ESMF_OPENACC),OFF)
ESMF_CPPFLAGS       += -DESMF_NO_OPENACC
endif

ifeq ($(ESMF_OPENACC),ON)
ESMF_F90COMPILEOPTS += $(ESMF_OPENACC_F90COMPILEOPTS)
ESMF_F90LINKOPTS    += $(ESMF_OPENACC_F90LINKOPTS)
ESMF_CXXCOMPILEOPTS += $(ESMF_OPENACC_CXXCOMPILEOPTS)
ESMF_CXXLINKOPTS    += $(ESMF_OPENACC_CXXLINKOPTS)
ESMF_CCOMPILEOPTS   += $(ESMF_OPENACC_CXXCOMPILEOPTS)
ESMF_CLINKOPTS      += $(ESMF_OPENACC_CXXLINKOPTS)
endif

#-------------------------------------------------------------------------------
# ESMF_TESTEXHAUSTIVE is passed (by CPP) into test programs to control the
# number of tests that a test program will do.
#-------------------------------------------------------------------------------
ifeq ($(ESMF_TESTEXHAUSTIVE),ON)
ESMF_CPPFLAGS       += -DESMF_TESTEXHAUSTIVE
endif

#-------------------------------------------------------------------------------
# ESMF_BOPT is passed (by CPP) into test programs to control any differences
# between the different BOPT modes.
#-------------------------------------------------------------------------------
ESMF_CPPFLAGS       += -DESMF_BOPT_$(ESMF_BOPT)

#-------------------------------------------------------------------------------
# ESMF_TESTPERFORMANCE is passed (by CPP) into test programs to control whether
# to run performance tests (these can be turned off on machines where
# performance tests are highly variable and can lead to spurious failures).
#-------------------------------------------------------------------------------
ifeq ($(ESMF_TESTPERFORMANCE),ON)
ESMF_CPPFLAGS       += -DESMF_TESTPERFORMANCE
endif

#-------------------------------------------------------------------------------
# ESMF_TESTCOMPTUNNEL is passed (by CPP) into test programs to control the
# dependency on ESMF-threading.
#-------------------------------------------------------------------------------
ifeq ($(ESMF_TESTCOMPTUNNEL),ON)
ESMF_CPPFLAGS       += -DESMF_TESTCOMPTUNNEL
endif

#-------------------------------------------------------------------------------
# ESMF_TESTWITHTHREADS is passed (by CPP) into test programs to control the
# dependency on ESMF-threading.
#-------------------------------------------------------------------------------
ifeq ($(ESMF_TESTWITHTHREADS),ON)
ESMF_CPPFLAGS       += -DESMF_TESTWITHTHREADS
endif

#-------------------------------------------------------------------------------
# Add ESMF_ABISTRING to preprocessor flags
#-------------------------------------------------------------------------------

ESMF_CPPFLAGS        +=-DS$(ESMF_ABISTRING)=1

#-------------------------------------------------------------------------------
# Add ESMF_OS to preprocessor flags
#-------------------------------------------------------------------------------

ESMF_CPPFLAGS        +=-DESMF_OS_$(ESMF_OS)=1

#-------------------------------------------------------------------------------
# Add ESMF_COMM to preprocessor flags
#-------------------------------------------------------------------------------

ESMF_CPPFLAGS        +=-DESMF_COMM=$(ESMF_COMM)

#-------------------------------------------------------------------------------
# Add ESMF_DIR to preprocessor flags
#-------------------------------------------------------------------------------

ESMF_CPPFLAGS        +=-DESMF_DIR=$(ESMF_DIR)

#-------------------------------------------------------------------------------
# construct precompiler flags to be used on Fortran sources
#-------------------------------------------------------------------------------

ESMF_FPPFLAGS        += $(addprefix $(ESMF_FPPPREFIX), $(ESMF_CPPFLAGS))

#-------------------------------------------------------------------------------
# common variables
LIBNAME		= $(ESMF_LIBDIR)/$(LIBBASE).$(ESMF_LIB_SUFFIX)
ESMFLIB		= $(ESMF_LIBDIR)/libesmf.$(ESMF_LIB_SUFFIX)
SOURCE		= $(SOURCEC) $(SOURCEF)
OBJS		= $(OBJSC) $(OBJSF)
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Test an installation pointed to by ESMFMKFILE
#-------------------------------------------------------------------------------

ifeq ($(ESMF_TESTESMFMKFILE),ON)
ifeq ("$(wildcard $(ESMFMKFILE))","")
$(error ESMF_TESTESMFMKFILE=ON, but the file indicated by ESMFMKFILE variable does not exist: $(ESMFMKFILE))
endif
include $(ESMFMKFILE)
ESMFLIB =
ESMF_LIBDIR = $(ESMF_LIBSDIR)
ESMF_APPSDIR = $(ESMF_BUILD)/apps/apps$(ESMF_BOPT)/$(ESMF_OS).$(ESMF_COMPILER).$(ESMF_ABI).$(ESMF_COMM).$(ESMF_SITE)
ESMF_INTERNALINCDIRS  += -I$(ESMF_BUILD)/src/Superstructure/WebServices/include
ESMF_INTERNALINCDIRS  += -I$(ESMF_BUILD)/src/Superstructure/ESMFMod/include
ESMF_INTERNALINCDIRS  += -I$(ESMF_BUILD)/src/Superstructure/State/include
ESMF_INTERNALINCDIRS  += -I$(ESMF_BUILD)/src/Infrastructure/Util/include
ESMF_INTERNALINCDIRS  += -I$(ESMF_BUILD)/src/Infrastructure/Base/include
ESMF_INTERNALINCDIRS  += -I$(ESMF_BUILD)/src/Infrastructure/Base/include/nlohmann/json
ESMF_INTERNALINCDIRS  += -I$(ESMF_BUILD)/src/Infrastructure/VM/include
ESMF_INTERNALINCDIRS  += -I$(ESMF_BUILD)/src/Infrastructure/Array/include
ESMF_INTERNALINCDIRS  += -I$(ESMF_BUILD)/src/Infrastructure/ArrayBundle/include
ESMF_INTERNALINCDIRS  += -I$(ESMF_BUILD)/src/Infrastructure/ArraySpec/include
ESMF_INTERNALINCDIRS  += -I$(ESMF_BUILD)/src/Infrastructure/DELayout/include
ESMF_INTERNALINCDIRS  += -I$(ESMF_BUILD)/src/Infrastructure/DistGrid/include
ESMF_INTERNALINCDIRS  += -I$(ESMF_BUILD)/src/Infrastructure/LocalArray/include
ESMF_INTERNALINCDIRS  += -I$(ESMF_BUILD)/src/Infrastructure/LogErr/include
ESMF_INTERNALINCDIRS  += -I$(ESMF_BUILD)/src/Infrastructure/Mesh/include
ESMF_INTERNALINCDIRS  += -I$(ESMF_BUILD)/src/Infrastructure/PointList/include
ESMF_INTERNALINCDIRS  += -I$(ESMF_BUILD)/src/Infrastructure/TimeMgr/include
ESMF_INTERNALINCDIRS  += -I$(ESMF_BUILD)/src/Infrastructure/Trace/include
ESMF_INTERNALINCDIRS  += -I$(ESMF_BUILD)/src/Infrastructure/Grid/include
ESMF_INTERNALINCDIRS  += -I$(ESMF_BUILD)/src/Infrastructure/GridUtil/include
ESMF_INTERNALINCDIRS  += -I$(ESMF_BUILD)/src/Infrastructure/Route/include
ESMF_INTERNALINCDIRS  += -I$(ESMF_BUILD)/src/Infrastructure/Field/include
ifeq ($(ESMF_COMM),mpiuni)
ESMF_INTERNALINCDIRS  += -I$(ESMF_BUILD)/src/Infrastructure/stubs/mpiuni
endif
ifeq ($(ESMF_PIO),internal)
ESMF_INTERNALINCDIRS  += -I$(ESMF_BUILD)/src/Infrastructure/IO/PIO/ParallelIO/src/clib
endif
ESMF_INTERNALINCDIRS  += -I$(ESMF_BUILD)/src/epilogue/include
export ESMF_AUTO_LIB_BUILD=OFF
ifeq ($(ESMF_TESTEXHAUSTIVE),ON)
ESMF_F90COMPILEOPTS   += -DESMF_TESTEXHAUSTIVE
ESMF_CXXCOMPILEOPTS   += -DESMF_TESTEXHAUSTIVE
ESMF_CCOMPILEOPTS     += -DESMF_TESTEXHAUSTIVE
endif

endif

#-------------------------------------------------------------------------------
# Build variables for static wrapping and preloading functions for ESMF trace
#-------------------------------------------------------------------------------

ESMF_TRACE_BUILD_SHARED := ON

ifeq ($(strip $(ESMF_SL_LIBS_TO_MAKE)),)
ESMF_TRACE_BUILD_SHARED := OFF
endif
ifneq (,$(findstring ESMF_NO_DLFCN,$(ESMF_CXXCOMPILECPPFLAGS)))
ESMF_TRACE_BUILD_SHARED := OFF
endif
ifeq ($(ESMF_OS),Cygwin)
# Cygwin does not support RTLD_NEXT needed by dlsym
ESMF_TRACE_BUILD_SHARED := OFF
endif

ifeq ($(ESMF_TRACE_BUILD_SHARED),ON)
ESMF_TRACE_LDPRELOAD := $(ESMF_LIBDIR)/libesmftrace_preload.$(ESMF_SL_SUFFIX)
ESMF_PRELOADSCRIPT = $(ESMF_LIBDIR)/preload.sh

ESMF_SL_PRELOAD_LIBLINKER = $(ESMF_CXXCOMPILER)
ESMF_SL_PRELOAD_LIBOPTS = $(ESMF_CXXLINKOPTS)
ESMF_SL_PRELOAD_LIBLIBS = $(ESMF_CXXLINKPATHS) $(ESMF_CXXLINKRPATHS) $(ESMF_CXXLINKLIBS)

ifeq ($(ESMF_OS),Darwin)
ESMF_ENV_PRELOAD          = DYLD_INSERT_LIBRARIES
ESMF_ENV_PRELOAD_DELIMIT  = ':'
ifeq ($(ESMF_COMM),openmpi)
# make sure to link in the Fortran MPI bindings
ESMF_SL_PRELOAD_LIBLINKER = $(ESMF_F90COMPILER)
# and since we're using the F90 compiler as the linker, make sure to use link
# options and libs appropriate for the F90 compiler instead of the C++ compiler
ESMF_SL_PRELOAD_LIBOPTS = $(ESMF_F90LINKOPTS)
ESMF_SL_PRELOAD_LIBLIBS = $(ESMF_F90LINKPATHS) $(ESMF_F90LINKRPATHS) $(ESMF_F90LINKLIBS)
endif
else
ESMF_ENV_PRELOAD          = LD_PRELOAD
ESMF_ENV_PRELOAD_DELIMIT  = ' '
endif

# MPI implementations do not pick up LD_PRELOAD
# so we pass a small script to each MPI task
ifneq (,$(findstring mpich,$(ESMF_COMM)))
ESMF_PRELOAD_SH = $(ESMF_PRELOADSCRIPT)
endif
ifeq ($(ESMF_COMM),openmpi)
ESMF_PRELOAD_SH = $(ESMF_PRELOADSCRIPT)
endif
ifeq ($(ESMF_COMM),mpi)
ESMF_PRELOAD_SH = $(ESMF_PRELOADSCRIPT)
endif
ifeq ($(ESMF_COMM),mpt)
ESMF_PRELOAD_SH = $(ESMF_PRELOADSCRIPT)
endif
ifneq (,$(findstring srun,$(ESMF_MPIRUN)))
ESMF_PRELOAD_SH = $(ESMF_PRELOADSCRIPT)
endif

endif

build_preload_script:
	-@echo "#!/bin/sh" > $(ESMF_PRELOADDIR)/preload.sh
	-@echo "# Script to preload ESMF dynamic trace library" >> $(ESMF_PRELOADDIR)/preload.sh
	-@echo 'if [ "$$$(ESMF_ENV_PRELOAD)" != "" ]; then' >> $(ESMF_PRELOADDIR)/preload.sh
	-@echo 'env $(ESMF_ENV_PRELOAD)="$$$(ESMF_ENV_PRELOAD)$(ESMF_ENV_PRELOAD_DELIMIT)$(ESMF_PRELOADDIR)/libesmftrace_preload.$(ESMF_SL_SUFFIX)" $$*' >> $(ESMF_PRELOADDIR)/preload.sh
	-@echo 'else' >> $(ESMF_PRELOADDIR)/preload.sh
	-@echo 'env $(ESMF_ENV_PRELOAD)="$(ESMF_PRELOADDIR)/libesmftrace_preload.$(ESMF_SL_SUFFIX)" $$*' >> $(ESMF_PRELOADDIR)/preload.sh
	-@echo 'fi' >> $(ESMF_PRELOADDIR)/preload.sh
	chmod 755 $(ESMF_PRELOADDIR)/preload.sh

ESMF_TRACE_DYNAMICLINKLIBS := -lesmftrace_preload

ESMF_TRACE_STATICLINKLIBS := -lesmftrace_static

ESMF_TRACE_WRAPPERS_IO  := write writev pwrite read open
ESMF_TRACE_WRAPPERS_MPI := MPI_Allgather MPI_Allgatherv MPI_Allreduce MPI_Alltoall
ESMF_TRACE_WRAPPERS_MPI += MPI_Alltoallv MPI_Alltoallw MPI_Barrier MPI_Bcast
ESMF_TRACE_WRAPPERS_MPI += MPI_Bsend MPI_Gather MPI_Gatherv MPI_Iprobe
ESMF_TRACE_WRAPPERS_MPI += MPI_Irecv MPI_Irsend MPI_Isend MPI_Issend
ESMF_TRACE_WRAPPERS_MPI += MPI_Probe MPI_Recv MPI_Reduce MPI_Rsend
ESMF_TRACE_WRAPPERS_MPI += MPI_Scan MPI_Scatter MPI_Scatterv MPI_Send
ESMF_TRACE_WRAPPERS_MPI += MPI_Sendrecv MPI_Test MPI_Testall MPI_Testany
ESMF_TRACE_WRAPPERS_MPI += MPI_Testsome MPI_Wait MPI_Waitall MPI_Waitany
ESMF_TRACE_WRAPPERS_MPI += MPI_Waitsome
ESMF_TRACE_WRAPPERS_MPI += mpi_allgather_ mpi_allgather__ mpi_allgatherv_ mpi_allgatherv__
ESMF_TRACE_WRAPPERS_MPI += mpi_allreduce_ mpi_allreduce__ mpi_alltoall_ mpi_alltoall__
ESMF_TRACE_WRAPPERS_MPI += mpi_alltoallv_ mpi_alltoallv__ mpi_alltoallw_ mpi_alltoallw__
ESMF_TRACE_WRAPPERS_MPI += mpi_barrier_ mpi_barrier__ mpi_bcast_ mpi_bcast__
ESMF_TRACE_WRAPPERS_MPI += mpi_bsend_ mpi_bsend__ mpi_exscan_ mpi_exscan__
ESMF_TRACE_WRAPPERS_MPI += mpi_gather_ mpi_gather__ mpi_gatherv_ mpi_gatherv__
ESMF_TRACE_WRAPPERS_MPI += mpi_iprobe_ mpi_iprobe__ mpi_irecv_ mpi_irecv__
ESMF_TRACE_WRAPPERS_MPI += mpi_irsend_ mpi_irsend__ mpi_isend_ mpi_isend__
ESMF_TRACE_WRAPPERS_MPI += mpi_issend_ mpi_issend__ mpi_probe_ mpi_probe__
ESMF_TRACE_WRAPPERS_MPI += mpi_recv_ mpi_recv__ mpi_reduce_ mpi_reduce__
ESMF_TRACE_WRAPPERS_MPI += mpi_reduce_scatter_ mpi_reduce_scatter__ mpi_rsend_ mpi_rsend__
ESMF_TRACE_WRAPPERS_MPI += mpi_scatter_ mpi_scatter__ mpi_scatterv_ mpi_scatterv__
ESMF_TRACE_WRAPPERS_MPI += mpi_scan_ mpi_scan__ mpi_send_ mpi_send__
ESMF_TRACE_WRAPPERS_MPI += mpi_sendrecv_ mpi_sendrecv__ mpi_test_ mpi_test__
ESMF_TRACE_WRAPPERS_MPI += mpi_testall_ mpi_testall__ mpi_testany_ mpi_testany__
ESMF_TRACE_WRAPPERS_MPI += mpi_testsome_ mpi_testsome__ mpi_wait_ mpi_wait__
ESMF_TRACE_WRAPPERS_MPI += mpi_waitall_ mpi_waitall__ mpi_waitany_ mpi_waitany__

COMMA := ,
ESMF_TRACE_STATICLINKOPTS := -static -Wl,--wrap=c_esmftrace_notify_wrappers -Wl,--wrap=c_esmftrace_isinitialized
ESMF_TRACE_STATICLINKOPTS += $(addprefix -Wl$(COMMA)--wrap=, $(ESMF_TRACE_WRAPPERS_IO))
ESMF_TRACE_STATICLINKOPTS += $(addprefix -Wl$(COMMA)--wrap=, $(ESMF_TRACE_WRAPPERS_MPI))

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
# HOWTO:  Warning: Here there be dragons.
#
# There is this file (build/common.mk), there are platform-dependent makefiles
# (build_config/<platform+compiler>/build_rules.mk), and there are
# makefiles in each subdir.  Needless to say, this makes things confusing
# when trying to decide where to make changes.
#
# Here are a few things to know about targets in this file:
#
# If you need to make a new target which should be called in each
# of the possible source subdirectories, you will typically have to
# add at least two targets:  "fred:" and "tree_fred:".  The plain
# target is the one you invoke, and it should look like this:
#
# fred:
# 	cd $(ESMF_DIR) ;\
# 	$(MAKE) ACTION=tree_fred tree
#
# "tree" is a preexisting target in this file which recursively descends
# the build tree (using the DIR= settings in each individual makefile
# to know which subdirs to descend into), and it calls 'make $ACTION'
# in each of the subdirs.   Since you do not want to replicate the target
# in each of the 100s of individual makefiles, typically you put the
# tree_target here in this file as well, and it feeds off variables
# which are set in the individual makefiles (e.g. SOURCEF, CLEANDIRS, etc).
# Look at some of the existing tree_<xxx> rules for ideas on how to
# add new targets.
#
# If you need to make a target which does not work on every subdirectory
# you can still put the target here, but do not change to the top level
# dir before executing the rule.
#
# Since the "clean" and "clobber" targets remove directories that are needed
# the next time you build, there are chkdir_<fred> targets which ensure the
# directories are created first, so the individual rules which follow can
# just assume that those directories succeed.  Notice that the rules use
# the -p option on mkdir which ensures intermediate directories are created
# if they do not exist.
#
# Some of the library rules below are complicated by the fact that some
# compilers will not let you control where .mod fortran module files are
# created; they are created in the current directory.  Rather than try to
# copy them into the target directory (which can be complicated by some
# systems making .MOD files and some making .mod files), we instead cd into
# the mod directory and then compile from there using full pathnames.
# This also ensures that if multiple builds are running for different
# target compilers they do not interfere with each other since each mod
# directory is separate based on the platform and compiler.
#
# Another complication: we have to support the ability to build in a
# different tree than the source files.  This might be used if the user
# has a shared copy of the source checked out and does not have write
# permission in those directories, or if the output has to appear in a
# different set of directories, for example to merge with a larger build
# system.  Users can set ESMF_BUILD to another location.  Any files which
# are created should use variables which feed off ESMF_BUILD for output,
# and use ESMF_DIR for files which were checked out of CVS and only
# used as input.  ESMF_DIR is set to be ESMF_DIR for the framework
# and EVA builds, and to ESMF_IMPL_DIR for the Implementation Report.
# ESMF_BUILD always defaults to the same location as ESMF_DIR.
#
# Good luck.
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Create various directories where files expect to be copied into.
#-------------------------------------------------------------------------------
chk_dir: chkdir_lib

chkdir_lib:
	@if [ ! -d $(ESMF_LIBDIR) ]; then \
	  echo Making directory $(ESMF_LIBDIR) for library; \
	  mkdir -p $(ESMF_LIBDIR) ; fi
	@if [ ! -d $(ESMF_MODDIR) ]; then \
	  echo Making directory $(ESMF_MODDIR) for *.mod files; \
	  mkdir -p $(ESMF_MODDIR) ; fi
ifeq ($(ESMF_DEFER_LIB_BUILD),ON)
	@if [ ! -d $(ESMF_OBJDIR) ]; then \
	  echo Making directory $(ESMF_OBJDIR) for *.o files; \
	  mkdir -p $(ESMF_OBJDIR) ; fi
endif

chkdir_doc:
	@if [ ! -d $(ESMF_DOCDIR) ]; then \
	  echo Making directory $(ESMF_DOCDIR) for documents; \
	  mkdir -p $(ESMF_DOCDIR) ; fi

chkdir_tests:
	@if [ ! -d $(ESMF_TESTDIR) ]; then \
	  echo Making directory $(ESMF_TESTDIR) for test output; \
	  mkdir -p $(ESMF_TESTDIR) ; fi

chkdir_include:
	@if [ ! -d $(ESMF_INCDIR) ]; then \
	  echo Making directory $(ESMF_INCDIR) for include files; \
	  mkdir -p $(ESMF_INCDIR) ; fi

chkdir_examples:
	@if [ ! -d $(ESMF_EXDIR) ]; then \
	  echo Making directory $(ESMF_EXDIR) for examples output; \
	  mkdir -p $(ESMF_EXDIR) ; fi

chkdir_apps:
	@if [ ! -d $(ESMF_APPSDIR) ]; then \
	  echo Making directory $(ESMF_APPSDIR) for apps output; \
	  mkdir -p $(ESMF_APPSDIR) ; fi

chkdir_locobj:
	@if [ ! -d $(ESMF_LOCOBJDIR) ]; then \
	  echo Making directory $(ESMF_LOCOBJDIR) for apps output; \
	  mkdir -p $(ESMF_LOCOBJDIR) ; fi

# use these targets if the libdir, testdir, etc. must be there already.
# this target prints a fail message and exits if not present.
reqdir_lib:
ifneq ($(ESMF_TESTESMFMKFILE),ON)
	@if [ ! -d $(ESMF_LIBDIR) ]; then \
	  echo "ESMF library directory not found:" ; \
	  echo " $(ESMF_LIBDIR) " ; \
	  echo "Library must be built first, or verify the current value of ESMF_BOPT" ; \
          echo " has the same setting as at library build time." ; \
	  echo "" ; \
          $(MAKE) err ; fi
	@if [ ! -d $(ESMF_MODDIR) ]; then \
	  echo "ESMF module directory not found:" ; \
	  echo " $(ESMF_MODDIR) " ; \
	  echo "Library must be built first, or verify the current value of ESMF_BOPT" ; \
          echo " has the same setting as at library build time." ; \
	  echo "" ; \
          $(MAKE) err ; fi
endif

reqdir_tests:
	@if [ ! -d $(ESMF_TESTDIR) ]; then \
	  echo "ESMF test directory not found:" ; \
	  echo " $(ESMF_TESTDIR) " ; \
	  echo "Tests must be built first, or verify the current value of ESMF_BOPT" ; \
          echo " has the same setting as at test build time." ; \
	  echo "" ; \
          $(MAKE) err ; fi

reqdir_examples:
	@if [ ! -d $(ESMF_EXDIR) ]; then \
	  echo "ESMF examples directory not found:" ; \
	  echo " $(ESMF_EXDIR) " ; \
	  echo "Examples must be built first, or verify the current value of ESMF_BOPT" ; \
          echo " has the same setting as at example build time." ; \
	  echo "" ; \
          $(MAKE) err ; fi

#-------------------------------------------------------------------------------
# test to see if this will help our lack of real dependencies.  require that
# the file libesmf.a exists in the lib dir; if not, build it.  if it is there,
# call it success, even if a source file is more recent than the lib.

reqfile_libesmf:
ifneq ($(ESMF_TESTESMFMKFILE),ON)
	@if [ ! -f $(ESMFLIB) ]; then \
	  $(MAKE) lib ; fi
endif

#-------------------------------------------------------------------------------
# This target used to check that variables which had to have settings
# were indeed set.  All have been removed now, but this target is still
# here keep from breaking other dependency rules.  At some point it can
# go away.
chkopts:
	@echo ""

# Does nothing; needed for some rules that require actions.
foo:

#-------------------------------------------------------------------------------
# Builds ESMF recursively.
#-------------------------------------------------------------------------------

# The GNUMake variable VPATH specifies a list of directories that make should
# search to find prerequisites and targets that are not in the current directory.
VPATH = $(ESMF_DIR)/$(LOCDIR) $(ESMF_DIR)/$(LOCDIR)/../include \
	$(ESMF_INCDIR) $(ESMF_CONFDIR) $(ESMF_SITEDIR)

ifeq ($(ESMF_DEFER_LIB_BUILD),ON)
libc: $(addprefix $(ESMF_OBJDIR)/,$(OBJSC))
libf: $(addprefix $(ESMF_OBJDIR)/,$(OBJSF))
else
libc:$(LIBNAME)($(OBJSC))
libf:$(LIBNAME)($(OBJSF))
endif

# TODO: the dependencies need fixing here.
# the goal here is to only rebuild libesmf.a when a source file has
# changed - but this rule invokes a traversal of the entire source
# tree each time.   i guess what really needs to be done is that a
# real 'make depend' rule needs to make libesmf.a dependent on all
# the constituent .h, .C, and .F90 files without doing a full tree
# traversal.  having this line commented in makes it try to call the
# build_libs rule each time the unit tests, examples, or system tests
# are built, whether it's needed or not.
#
## building the libesmf.a file
#$(ESMFLIB):  build_libs


# Build all of ESMF from the top.  This target can be called from any
# subdir and it will go up to the top dir and build from there.
lib: info
	@$(MAKE) build_libs
	@$(MAKE) build_tracelibs
	@$(MAKE) info_mk ESMF_CCOMPILEPATHS="$(ESMF_CCOMPILEPATHS) -I$(ESMF_CONFDIR)"
	@echo "ESMF library built successfully on "`date`
	@echo "To verify, build and run the unit and system tests with: $(MAKE) check"
	@echo " or the more extensive: $(MAKE) all_tests"

build_libs: chkdir_lib include
	cd $(ESMF_DIR) ; $(MAKE) ACTION=tree_lib tree
ifeq ($(ESMF_DEFER_LIB_BUILD),ON)
	cd $(ESMF_DIR) ; $(MAKE) defer
endif
	cd $(ESMF_DIR) ; $(MAKE) ranlib
ifneq ($(strip $(ESMF_SL_LIBS_TO_MAKE)),)
	cd $(ESMF_DIR) ; $(MAKE) shared
endif

build_tracelibs:
ifeq ($(ESMF_TRACE_LIB_BUILD),ON)
	cd $(ESMF_DIR)/src/Infrastructure/Trace/preload ;\
	$(MAKE) tracelib_static
ifeq ($(ESMF_TRACE_BUILD_SHARED),ON)
	cd $(ESMF_DIR)/src/Infrastructure/Trace/preload ;\
	$(MAKE) tracelib_preload
endif
endif

# Build only stuff in and below the current dir.
build_here: chkdir_lib chkdir_include
	$(MAKE) ACTION="tree_include" tree
	$(MAKE) ACTION=tree_lib tree
ifeq ($(ESMF_DEFER_LIB_BUILD),ON)
	$(MAKE) defer
endif
	$(MAKE) ranlib
ifneq ($(strip $(ESMF_SL_LIBS_TO_MAKE)),)
	$(MAKE) shared
endif

# Builds library - action for the 'tree' target.
tree_lib-default:
	dir=`pwd`; cd $(ESMF_MODDIR); $(MAKE) -f $${dir}/makefile MAKEFILE=$${dir}/makefile esmflib

%: %-default
	@ true

# Builds library
esmflib:: chkdir_lib $(SOURCE)
	@if [ "$(SOURCEC)" != "" ] ; then \
		$(MAKE) -f $(MAKEFILE) libc ; fi
	@if [ "$(SOURCEF)" != "" ] ; then \
		$(MAKE) -f $(MAKEFILE) libf ; fi

# copy private include files into src/include directory.
include: chkdir_include $(if $(findstring ON,$(ESMF_DEFER_LIB_BUILD)),chkdir_lib)
	cd $(ESMF_DIR) ;\
	$(MAKE) ACTION=tree_include tree

# action for 'tree' include target.
tree_include:
	@for hfile in ${STOREH} foo ; do \
	  if [ $$hfile != "foo" ]; then \
	    cp -fp ../include/$$hfile $(ESMF_INCDIR) ; \
	  fi ; \
	done

# extra indirection to allow build_libs to be turned off in targets using it
autobuild_libs:
ifeq ($(ESMF_AUTO_LIB_BUILD),OFF)
	$(MAKE) reqfile_libesmf
else
	$(MAKE) build_libs
endif

#-------------------------------------------------------------------------------
# Clean and clobber targets.
#
# The clean and clobber targets are controlled by the settings of the
# variables CLEANFILES, CLEANDIRS and CLOBBERDIRS.  These variables
# are set in the local makefiles.
#
#    CLEANFILES lists the files that should be removed during a clean.
#
#    CLEANDIRS lists the directories that should be removed during a
#    clean.
#
#    CLOBBERDIRS lists the directories that should be removed during a
#    clobber.
#
# The clean and clobber targets recursively call make with the tree
# target.  The current directory and directories below will be cleaned
# or clobbered.  The clobber target first calls gmake with the clean target
# before the clobber actions are taken.
# ------------------------------------------------------------------------------

# default list of files and dirs to clean (and surprisingly to me,
# you cannot enclose these in quotes - they are preserved and the quotes
# prevent the wildcards from being expanded.)

CLEAN_DEFDIRS = coredir.*
CLEAN_DEFAULTS = *.o *.$(ESMF_SL_SUFFIX) *.mod core ESM*.stdout ESM*.Log PET*.Log *ESMF_LogFile
CLEAN_TEXFILES = *.aux *.bbl *.blg *.log *.toc *.dvi *.ps *.ORIG *.out

clean:
	$(MAKE) ACTION=tree_clean tree

# the GNU standard target is 'distclean' but we have had clobber in here
# for a long time, so for backward compatibility, leave them both.

distclean: clobber

# figure out if the current dir is the same as ESMF_DIR.  set the inode
# makefile variables here first, because it is easier to parse out the
# first word of the output with makefile builtins rather than depend on
# awk or some other command which must then be identical on every system
# we try to support.   the -i on the ls command prints the numerical inode
# number of the directory; do it in this indirect way because the simple
# string comparison fails easily because of simple formatting differences
# (e.g. trailing slash vs not)

export INODE1 = $(word 1, $(shell ls -di .) )
export INODE2 = $(word 1, $(shell ls -di $(ESMF_DIR)) )

clobber:
	@if [ $(INODE1) != $(INODE2) ] ; then \
	  echo "" ; \
	  echo "Must run distclean or clobber from ESMF_DIR" ; \
	  echo "" ; \
	  echo "Current physical directory is `pwd -P`" ; \
	  echo "ESMF_DIR is $(ESMF_DIR)" ; \
	  echo "" ; \
	  echo "If dealing with symlinked directories, make sure that" ; \
	  echo "ESMF_DIR is assigned the physical location, e.g. via 'pwd -P'." ; \
	  echo "" ; \
	  $(MAKE) err ; \
	fi
	$(MAKE) clean
	@for DIR in $(CLOBBERDIRS) foo ; do \
	   if [ $$DIR != "foo" ] ; then \
	      $(ESMF_RM) -r $$DIR ;\
	   fi ;\
	done


# action for 'tree' target.
tree_clean:
	@for DIR in $(CLEANDIRS) $(CLEAN_DEFDIRS) foo ; do \
	   if [ $$DIR != "foo" ] ; then \
	      $(ESMF_RM) -r $$DIR ;\
	   fi ;\
	done
	$(ESMF_RM) $(CLEANFILES) $(CLEAN_DEFAULTS)

tree_cleanfiles:
	$(ESMF_RM) $(CLEANFILES) $(CLEAN_DEFAULTS)

# target which does a light cleaning - remove files only under the src dir
#  (logfiles, doc files, test output files, files made by preprocessing, etc)
#  leaves the libs, executables, etc alone.
mostlyclean:
	@cd $(ESMF_BUILD)/src ;\
	$(MAKE) ACTION=tree_mostlyclean tree

tree_mostlyclean:
	@for DIR in $(MOSTLYCLEANDIRS) foo ; do \
	   if [ $$DIR != "foo" ] ; then \
	      cd $$DIR; $(MAKE) ACTION=tree_clean tree ;\
	   fi ;\
	done

#-------------------------------------------------------------------------------
# Generic target for building and running all tests and examples
#-------------------------------------------------------------------------------

# vars used below in the all_tests target, because these are in the pattern
# (build, run), (build, run), ... not (build, build, ...) then (run, run, ...)

TEST_TARGETS = build_unit_tests run_unit_tests \
               build_system_tests run_system_tests

ALLTEST_TARGETS = $(TEST_TARGETS) \
                  build_examples run_examples

TEST_TARGETS_UNI = build_unit_tests run_unit_tests_uni \
                   build_system_tests run_system_tests_uni

ALLTEST_TARGETS_UNI = $(TEST_TARGETS_UNI) \
                      build_examples run_examples_uni


# TODO: a bit more on what eventually these targets should be:
#
# according to the GNU conventions, 'gmake check' should test the build.
# so check builds and runs the unit and system tests with TESTEXHAUSTIVE
# pinned off.  this does a cursory check, not a full, exhaustive check.
#
# 'gmake all_tests' makes and runs the full set of tests, respecting the user
# setting for TESTEXHAUSTIVE.  it runs the unit tests, system tests, and
# examples.
#
# 'gmake validate' should probably do some numerical validation to make
# sure we have something like bit reproducibility, that we are not going to
# have wordsize problems, etc.   for now, we have no tests like that so it
# just runs the unit tests.
#

# quick sanity check, defaulting to TESTEXHAUSTIVE OFF but respecting
# the user setting if it already has a value.
check: info
	@if [ $(ESMF_COMM) = "mpiuni" ] ; then \
	  $(MAKE) clean_check $(TEST_TARGETS_UNI) results_ck_summary ;\
	else \
	  $(MAKE) clean_check $(TEST_TARGETS) results_ck_summary ;\
        fi


build_check:
	$(MAKE) build_unit_tests build_system_tests


run_check:
	@if [ $(ESMF_COMM) = "mpiuni" ] ; then \
	  $(MAKE) run_unit_tests_uni run_system_tests_uni ; \
	else \
	  $(MAKE) run_unit_tests run_system_tests ;\
        fi


clean_check:
	$(MAKE) clean_unit_tests clean_system_tests


# all tests, respecting user setting of TESTEXHAUSTIVE
all_tests: info
	@if [ $(ESMF_COMM) = "mpiuni" ] ; then \
	  $(MAKE) $(ALLTEST_TARGETS_UNI) results_summary ;\
	else \
	  $(MAKE) $(ALLTEST_TARGETS) results_summary ;\
        fi

all_tests_uni: info
	$(MAKE) $(ALLTEST_TARGETS_UNI) results_summary

dust_all_tests: dust_unit_tests dust_system_tests dust_examples

build_all_tests: clean_if_exhaustive_flag_mismatch
	$(MAKE) build_unit_tests build_system_tests build_examples

run_all_tests:
	@if [ $(ESMF_COMM) = "mpiuni" ] ; then \
	  $(MAKE) run_unit_tests_uni run_system_tests_uni \
                  run_examples_uni results_summary ;\
	else \
	  $(MAKE) run_unit_tests run_system_tests \
                  run_examples results_summary ;\
        fi

run_all_tests_uni:
	$(MAKE) run_unit_tests_uni run_system_tests_uni \
          run_examples_uni results_summary

clean_all_tests:
	$(MAKE) clean_unit_tests clean_system_tests clean_examples


# TODO: reserved for running any numerical validation tests, wordsize and
# precision tests - things which might give wrong computational answers.
# (currently just run the unit tests because these are not written yet.)
validate:
	@if [ $(ESMF_COMM) = "mpiuni" ] ; then \
	  $(MAKE) unit_tests_uni ;\
	else \
	  $(MAKE) unit_tests ;\
        fi


build_validate:
	$(MAKE) build_unit_tests


run_validate:
	@if [ $(ESMF_COMM) = "mpiuni" ] ; then \
	  $(MAKE) run_unit_tests_uni ;\
	else \
	  $(MAKE) run_unit_tests ;\
        fi


clean_validate:
	$(MAKE) clean_unit_tests


#-------------------------------------------------------------------------------
# Targets for building apps.
#-------------------------------------------------------------------------------

#
# build_apps
#
build_apps: test_esmfmkfile reqfile_libesmf reqdir_lib
	cd $(ESMF_DIR)/src/apps; $(MAKE) ACTION=tree_build_apps tree
	@echo "ESMF apps built successfully."
# Notice: the cd into "$(ESMF_DIR)/src/apps" before the tree target above
# makes this a lot faster than a complete tree traversal starting at the root!

tree_build_apps: $(APPS_BUILD)

#
#  Link rule for apps, switch between C and Fortran
#
ifeq ($(APPS_MAINLANGUAGE),C)
$(ESMF_APPSDIR)/% : $(addprefix $(ESMF_LOCOBJDIR)/,$(APPS_OBJ)) $(ESMFLIB)
	$(MAKE) chkdir_apps
	$(ESMF_CLINKER) $(ESMF_EXE_CLINKOPTS) $(ESMF_CLINKOPTS) $(ESMF_CLINKPATHS) $(ESMF_CLINKRPATHS) $(ESMF_EXEOUT_OPTION) $(addprefix $(ESMF_LOCOBJDIR)/,$(APPS_OBJ)) $(ESMF_CESMFLINKLIBS)
else ifeq ($(APPS_MAINLANGUAGE),C++)
$(ESMF_APPSDIR)/% : $(addprefix $(ESMF_LOCOBJDIR)/,$(APPS_OBJ)) $(ESMFLIB)
	$(MAKE) chkdir_apps
	$(ESMF_CXXLINKER) $(ESMF_EXE_CXXLINKOPTS) $(ESMF_CXXLINKOPTS) $(ESMF_CXXLINKPATHS) $(ESMF_CXXLINKRPATHS) $(ESMF_EXEOUT_OPTION) $(addprefix $(ESMF_LOCOBJDIR)/,$(APPS_OBJ)) $(ESMF_CXXESMFLINKLIBS)
else ifeq ($(APPS_MAINLANGUAGE),script)
$(ESMF_APPSDIR)/% : $(APPS_OBJ)
	$(MAKE) chkdir_apps
	cp -f $(APPS_OBJ) $@
else
$(ESMF_APPSDIR)/% : $(addprefix $(ESMF_LOCOBJDIR)/,$(APPS_OBJ)) $(ESMFLIB)
	$(MAKE) chkdir_apps
	$(ESMF_F90LINKER) $(ESMF_EXE_F90LINKOPTS) $(ESMF_F90LINKOPTS) $(ESMF_F90LINKPATHS) $(ESMF_F90LINKRPATHS) $(ESMF_EXEOUT_OPTION) $(addprefix $(ESMF_LOCOBJDIR)/,$(APPS_OBJ)) $(ESMF_F90ESMFLINKLIBS)
endif

#-------------------------------------------------------------------------------
# Targets for building and running system tests.
#-------------------------------------------------------------------------------

system_tests: test_esmfmkfile chkdir_tests autobuild_libs dust_system_tests
	@if [ -d $(ESMF_STDIR) ] ; then cd $(ESMF_STDIR); fi; \
	if [ ! $(SYSTEM_TEST)foo = foo ] ; then \
	   if [ -d $(SYSTEM_TEST) ] ; then \
	       cd $(SYSTEM_TEST); \
           else \
               echo "SYSTEM_TEST $(SYSTEM_TEST) does not exist."; \
               exit; \
	   fi; \
	   echo current working directory is now `pwd` ; \
        fi; \
	if [ $(ESMF_COMM) = "mpiuni" ] ; then \
          echo "Cannot run multiprocessor system tests when ESMF_COMM is mpiuni;" ; \
	  echo "run system_tests_uni instead." ; \
	  echo "" ; \
	  $(MAKE) err ; \
          exit ; \
	fi ; \
	$(MAKE) MULTI="Multiprocessor" config_sys_tests update_sys_tests_flags; \
	$(MAKE) ACTION=tree_system_tests tree ; \
	$(MAKE) check_system_tests

tree_system_tests: tree_build_system_tests tree_run_system_tests

#
# system_tests_uni, build and run uni versions of the system tests
#
system_tests_uni: test_esmfmkfile chkdir_tests autobuild_libs dust_system_tests
	@if [ -d $(ESMF_STDIR) ] ; then cd $(ESMF_STDIR); fi; \
	if [ ! $(SYSTEM_TEST)foo = foo ] ; then \
	   if [ -d $(SYSTEM_TEST) ] ; then \
	       cd $(SYSTEM_TEST); \
           else \
              echo "SYSTEM_TEST $(SYSTEM_TEST) does not exist."; \
              exit; \
	   fi; \
	   echo current working directory is now `pwd` ; \
	fi ; \
	$(MAKE) MULTI="Uniprocessor" config_sys_tests update_sys_tests_flags
	$(MAKE) ACTION=tree_system_tests_uni tree ; \
	$(MAKE) check_system_tests

tree_system_tests_uni: tree_build_system_tests tree_run_system_tests_uni

#
# build_system_tests
#
build_system_tests: test_esmfmkfile reqfile_libesmf reqdir_lib chkdir_tests
	@if [ -d $(ESMF_STDIR) ] ; then cd $(ESMF_STDIR) ; fi; \
	if [ ! $(SYSTEM_TEST)foo = foo ] ; then \
	   if [ -d $(SYSTEM_TEST) ] ; then \
	       cd $(SYSTEM_TEST); \
           else \
              echo "SYSTEM_TEST $(SYSTEM_TEST) does not exist."; \
              exit; \
	   fi; \
	   echo current working directory is now `pwd` ; \
        fi ; \
	$(MAKE) config_sys_tests update_sys_tests_flags ;\
	$(MAKE) ACTION=tree_build_system_tests tree
	echo "ESMF system tests built successfully."

tree_build_system_tests: $(SYSTEM_TESTS_BUILD)


#
# TODO: the RM in the link rules below means that any system test which
# includes additional .o files (which most do) will always rebuild even if
# it is up-to-date.  but we remove the .o and .mod files because we also
# are required to be able to build multiple architectures from a single
# build tree.  we currently have a race-condition with the system tests
# in that we build with the current directory being the src dir, which
# means compilers can trample each others .o and .mod files.  the library
# cds into the lib or mod dir before compiling, so .o and .mod files
# are created in a compiler/platform directory and do not interfere with
# each other.
#
# the fix for this is either to cd into the test dir before compiling
# and linking, or to create a temp subdir based on the compiler/platform/
# BOPT/SITE settings - so compiles are truly independent.
#
# this also applies to the tests, and examples.
#

#
#  Link rule for Fortran system tests.
#
$(ESMF_TESTDIR)/ESMF_%STest : ESMF_%STest.o $(SYSTEM_TESTS_OBJ) $(addsuffix .$(ESMF_SL_SUFFIX), $(SYSTEM_TESTS_SHOBJ)) $(ESMFLIB)
	$(MAKE) chkdir_tests
	$(ESMF_F90LINKER) $(ESMF_EXE_F90LINKOPTS) $(ESMF_F90LINKOPTS) $(ESMF_F90LINKPATHS) $(ESMF_F90LINKRPATHS) $(ESMF_EXEOUT_OPTION) $(SYSTEM_TESTS_OBJ) $< $(ESMF_F90ESMFLINKLIBS)
	$(ESMF_RM) -f *.o *.mod

$(ESMF_TESTDIR)/ESMC_%STest : ESMC_%STest.o $(SYSTEM_TESTS_OBJ) $(addsuffix .$(ESMF_SL_SUFFIX), $(SYSTEM_TESTS_SHOBJ)) $(ESMFLIB)
	$(MAKE) chkdir_tests
	$(ESMF_CLINKER) $(ESMF_EXE_CLINKOPTS) $(ESMF_CLINKOPTS) $(ESMF_CLINKPATHS) $(ESMF_CLINKRPATHS) $(ESMF_EXEOUT_OPTION) $(SYSTEM_TESTS_OBJ) $< $(ESMF_CESMFLINKLIBS)
	$(ESMF_RM) -f *.o *.mod

# debugging aid:  link the executable, standard output, and log file to
# temporary names in the current directory (they are built in the test
# directory which is a long ways away from the source.  debuggers work
# better if the current directory is the source dir, not the executable dir.)
# example use:  gmake TNAME=FieldExcl system_test_links
system_test_links:
	$(ESMF_RM) t s l
	ln -s $(ESMF_TESTDIR)/ESMF_$(TNAME)STest t
	ln -s $(ESMF_TESTDIR)/ESMF_$(TNAME)STest.stdout s
	ln -s $(ESMF_TESTDIR)/ESMF_$(TNAME)STest.Log l

#
#  Link rule for Fortran system tests (MPMD).
#
$(ESMF_TESTDIR)/ESMF_%STestA : $(SYSTEM_TESTS_OBJ_A) $(ESMFLIB) ESMF_%STestA.o
	$(ESMF_F90LINKER) $(ESMF_EXE_F90LINKOPTS) $(ESMF_F90LINKOPTS) $(ESMF_F90LINKPATHS) $(ESMF_F90LINKRPATHS) $(ESMF_EXEOUT_OPTION) $(SYSTEM_TESTS_OBJ_A) ESMF_$*STestA.o $(ESMF_F90ESMFLINKLIBS)
$(ESMF_TESTDIR)/ESMF_%STestB : $(SYSTEM_TESTS_OBJ_B) $(ESMFLIB) ESMF_%STestB.o
	$(ESMF_F90LINKER) $(ESMF_EXE_F90LINKOPTS) $(ESMF_F90LINKOPTS) $(ESMF_F90LINKPATHS) $(ESMF_F90LINKRPATHS) $(ESMF_EXEOUT_OPTION) $(SYSTEM_TESTS_OBJ_B) ESMF_$*STestB.o $(ESMF_F90ESMFLINKLIBS)
$(ESMF_TESTDIR)/ESMF_%STestC : $(SYSTEM_TESTS_OBJ_C) $(ESMFLIB) ESMF_%STestC.o
	$(ESMF_F90LINKER) $(ESMF_EXE_F90LINKOPTS) $(ESMF_F90LINKOPTS) $(ESMF_F90LINKPATHS) $(ESMF_F90LINKRPATHS) $(ESMF_EXEOUT_OPTION) $(SYSTEM_TESTS_OBJ_C) ESMF_$*STestC.o $(ESMF_F90ESMFLINKLIBS)
$(ESMF_TESTDIR)/ESMF_%STestD : $(SYSTEM_TESTS_OBJ_D) $(ESMFLIB) ESMF_%STestD.o
	$(ESMF_F90LINKER) $(ESMF_EXE_F90LINKOPTS) $(ESMF_F90LINKOPTS) $(ESMF_F90LINKPATHS) $(ESMF_F90LINKRPATHS) $(ESMF_EXEOUT_OPTION) $(SYSTEM_TESTS_OBJ_D) ESMF_$*STestD.o $(ESMF_F90ESMFLINKLIBS)
$(ESMF_TESTDIR)/ESMF_%STestE : $(SYSTEM_TESTS_OBJ_E) $(ESMFLIB) ESMF_%STestE.o
	$(ESMF_F90LINKER) $(ESMF_EXE_F90LINKOPTS) $(ESMF_F90LINKOPTS) $(ESMF_F90LINKPATHS) $(ESMF_F90LINKRPATHS) $(ESMF_EXEOUT_OPTION) $(SYSTEM_TESTS_OBJ_E) ESMF_$*STestE.o $(ESMF_F90ESMFLINKLIBS)
MPMDCLEANUP:
	$(ESMF_RM) -f *.o *.mod

#
# dust_system_tests
#
dust_system_tests:
	$(ESMF_RM) $(ESMF_TESTDIR)/system_tests_results
	$(ESMF_RM) $(ESMF_TESTDIR)/system_tests_ml_results
	$(ESMF_RM) $(ESMF_TESTDIR)/*STest.Log
	$(ESMF_RM) $(ESMF_TESTDIR)/*STest.stdout
	$(ESMF_RM) $(ESMF_TESTDIR)/*.rc
	$(ESMF_RM) $(ESMF_TESTDIR)/*.nc
	$(ESMF_RM) $(ESMF_TESTDIR)/data

#
# run_system_tests
#
run_system_tests: test_esmfmkfile reqdir_tests update_sys_tests_flags
	@if [ $(ESMF_DIR) = `pwd` ] ; then \
	  $(MAKE) dust_system_tests ; \
	fi
	@if [ -d $(ESMF_STDIR) ] ; then cd $(ESMF_STDIR) ; fi; \
	if [ ! $(SYSTEM_TEST)foo = foo ] ; then \
	   if [ -d $(SYSTEM_TEST) ] ; then \
	       cd $(SYSTEM_TEST); \
           else \
              echo "SYSTEM_TEST $(SYSTEM_TEST) does not exist."; \
              exit; \
	   fi; \
	   echo current working directory is now `pwd` ; \
        fi; \
	if [ $(ESMF_COMM) = "mpiuni" ] ; then \
          echo "Cannot run multiprocessor system tests when ESMF_COMM is mpiuni;" ; \
	  echo "run run_system_tests_uni instead." ; \
	  echo "" ; \
	  $(MAKE) err ; \
          exit; \
	fi; \
        if [ -f $(SYS_TESTS_CONFIG) ] ; then \
           $(ESMF_SED) -e 's/ [A-Za-z][A-Za-z]*processor/ Multiprocessor/' $(SYS_TESTS_CONFIG) > $(SYS_TESTS_CONFIG).temp; \
           $(ESMF_MV) $(SYS_TESTS_CONFIG).temp $(SYS_TESTS_CONFIG); \
        fi; \
	$(MAKE) ACTION=tree_run_system_tests tree
	$(MAKE) check_system_tests

tree_run_system_tests: $(SYSTEM_TESTS_RUN)

#
# run_system_tests_uni
#
run_system_tests_uni: test_esmfmkfile reqdir_tests update_sys_tests_flags
	@if [ $(ESMF_DIR) = `pwd` ] ; then \
	  $(MAKE) dust_system_tests ; \
	fi
	@if [ -f $(SYS_TESTS_CONFIG) ] ; then \
           $(ESMF_SED) -e 's/ [A-Za-z][A-Za-z]*processor/ Uniprocessor/' $(SYS_TESTS_CONFIG) > $(SYS_TESTS_CONFIG).temp; \
           $(ESMF_MV) $(SYS_TESTS_CONFIG).temp $(SYS_TESTS_CONFIG); \
        fi; \
	if [ -d $(ESMF_STDIR) ] ; then cd $(ESMF_STDIR) ; fi; \
	if [ ! $(SYSTEM_TEST)foo = foo ] ; then \
	   if [ -d $(SYSTEM_TEST) ] ; then \
	       cd $(SYSTEM_TEST); \
           else \
              echo "SYSTEM_TEST $(SYSTEM_TEST) does not exist."; \
              exit; \
	   fi; \
	   echo current working directory is now `pwd` ; \
        fi; \
	$(MAKE) ACTION=tree_run_system_tests_uni tree
	$(MAKE) check_system_tests

tree_run_system_tests_uni: $(SYSTEM_TESTS_RUN_UNI)

#
# echo into a file how the tests were last run, multi or uni, so when the perl
# scripts run to check the results it can find the correct system tests.
# Assume Nontestmpmd and Nonsharedobj, they will be updated subsequently.
#
config_sys_tests:
	@echo "# This file used by test scripts, please do not delete." > $(SYS_TESTS_CONFIG)
ifeq ($(MULTI),)
	@echo "Last run Nontestmpmd Nontestsharedobj ;  Noprocessor" >> $(SYS_TESTS_CONFIG)
else
	@echo "Last run Nontestmpmd Nontestsharedobj ;" $(MULTI) >> $(SYS_TESTS_CONFIG)
endif



#
# verify that either there is no SYS_TESTS_CONFIG file, or if one exists that
# the string Testmpmd or Nontestmpmd matches the current setting of the
# ESMF_TESTMPMD environment variable and that the string Testsharedobj or
# Nontestsharedobj matches the current setting of the ESMF_TESTSHAREDOBJ
# environment variable.
#
update_sys_tests_flags:
ifeq ($(ESMF_TESTMPMD),ON)
	$(ESMF_SED) -e 's/ [A-Za-z][A-Za-z]*estmpmd/ Testmpmd/' $(SYS_TESTS_CONFIG) > $(SYS_TESTS_CONFIG).temp; \
	$(ESMF_MV) $(SYS_TESTS_CONFIG).temp $(SYS_TESTS_CONFIG);
else
	$(ESMF_SED) -e 's/ [A-Za-z][A-Za-z]*estmpmd/ Nontestmpmd/' $(SYS_TESTS_CONFIG) > $(SYS_TESTS_CONFIG).temp; \
	$(ESMF_MV) $(SYS_TESTS_CONFIG).temp $(SYS_TESTS_CONFIG);
endif
ifeq ($(ESMF_TESTSHAREDOBJ),ON)
	$(ESMF_SED) -e 's/ [A-Za-z][A-Za-z]*estsharedobj/ Testsharedobj/' $(SYS_TESTS_CONFIG) > $(SYS_TESTS_CONFIG).temp; \
	$(ESMF_MV) $(SYS_TESTS_CONFIG).temp $(SYS_TESTS_CONFIG);
else
	$(ESMF_SED) -e 's/ [A-Za-z][A-Za-z]*estsharedobj/ Nontestsharedobj/' $(SYS_TESTS_CONFIG) > $(SYS_TESTS_CONFIG).temp; \
	$(ESMF_MV) $(SYS_TESTS_CONFIG).temp $(SYS_TESTS_CONFIG);
endif


#
# run the systests, either redirecting the stdout from the command line, or
# relying on the mpirun script to redirect stdout from inside the batch script.
# the test macros open PETx.name.Log files by default (set when the tests
# call ESMF_Initialize()).  after the tests run, we cat all the per-pet
# files together into a single log file.
#
stest:
	-@cd $(ESMF_TESTDIR) ; \
	$(ESMF_RM) ./PET*$(TNAME)STest.Log ; \
	if [ $(ESMF_BATCHDEPRECATED) = "true" ] ; then \
	  echo $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMF_$(TNAME)STest ; \
	  $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMF_$(TNAME)STest ; \
	else \
	  echo $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMF_$(TNAME)STest 1\> ./ESMF_$(TNAME)STest.stdout 2\>\&1 ; \
	  $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMF_$(TNAME)STest 1> ./ESMF_$(TNAME)STest.stdout 2>&1 ; \
	fi ; \
	cat ./PET*$(TNAME)STest.Log> ./ESMF_$(TNAME)STest.Log ; \
	$(ESMF_RM) ./PET*$(TNAME)STest.Log

sctest:
	-@cd $(ESMF_TESTDIR) ; \
	$(ESMF_RM) ./PET*$(TNAME)STest.Log ; \
	if [ $(ESMF_BATCHDEPRECATED) = "true" ] ; then \
	  echo $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMC_$(TNAME)STest ; \
	  $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMC_$(TNAME)STest ; \
	else \
	  echo $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMC_$(TNAME)STest 1\> ./ESMC_$(TNAME)STest.stdout 2\>\&1 ; \
	  $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMC_$(TNAME)STest 1> ./ESMC_$(TNAME)STest.stdout 2>&1 ; \
	fi ; \
	cat ./PET*$(TNAME)STest.Log> ./ESMC_$(TNAME)STest.Log ; \
	$(ESMF_RM) ./PET*$(TNAME)STest.Log

#
# this target deletes only the system test related files from the test subdir
#
clean_system_tests:
	$(ESMF_RM) $(ESMF_TESTDIR)/*STest*  $(SYS_TESTS_CONFIG)
	$(ESMF_RM) $(ESMF_TESTDIR)/system_tests_results
	$(ESMF_RM) $(ESMF_TESTDIR)/system_tests_ml_results
	$(MAKE) ACTION=tree_cleanfiles tree

#
# report statistics on system tests
#
check_system_tests:
	@$(DO_ST_RESULTS)


#
# run the system tests memory leak report.
#
check_system_tests_ml:
	@$(DO_ST_ML_RESULTS)



#-------------------------------------------------------------------------------
# Targets for building and running use test cases
#-------------------------------------------------------------------------------

use_test_cases: test_esmfmkfile chkdir_tests
	@if [ -d $(ESMF_UTCDIR) ] ; then cd $(ESMF_UTCDIR); fi; \
	if [ ! $(USE_TEST_CASE)foo = foo ] ; then \
	   if [ -d $(USE_TEST_CASE) ] ; then \
	       cd $(USE_TEST_CASE); \
           else \
               echo "USE_TEST_CASE $(USE_TEST_CASE) does not exist."; \
               echo "Check out use_test_cases at the $(ESMF_DIR)/src directory."; \
               exit; \
	   fi; \
	   echo current working directory is now `pwd` ; \
        fi; \
	if [ $(ESMF_COMM) = "mpiuni" ] ; then \
          echo "Cannot run multiprocessor use test cases when ESMF_COMM is mpiuni;" ; \
	  echo "run use_test_cases_uni instead." ; \
	  echo "" ; \
	  $(MAKE) err ; \
          exit ; \
	fi; \
	$(MAKE) ACTION=tree_use_test_cases tree ; \
	$(MAKE) check_use_test_cases

tree_use_test_cases: tree_build_use_test_cases tree_dry_run_use_test_cases tree_run_use_test_cases

#
# use_test_cases_uni, build and run uni versions of the use test cases
#
use_test_cases_uni: test_esmfmkfile chkdir_tests
	@if [ -d $(ESMF_UTCDIR) ] ; then cd $(ESMF_UTCDIR); fi; \
	if [ ! $(USE_TEST_CASE)foo = foo ] ; then \
	   if [ -d $(USE_TEST_CASE) ] ; then \
	       cd $(USE_TEST_CASE); \
           else \
              echo "USE_TEST_CASE $(USE_TEST_CASE) does not exist."; \
              exit; \
	   fi; \
	   echo current working directory is now `pwd` ; \
	fi; \
	$(MAKE) ACTION=tree_use_test_cases_uni tree ; \
	$(MAKE) check_use_test_cases

tree_use_test_cases_uni: tree_build_use_test_cases tree_dry_run_use_test_cases tree_run_use_test_cases_uni

#
# build_use_test_cases
#
build_use_test_cases: test_esmfmkfile reqfile_libesmf reqdir_lib chkdir_tests
	@if [ -d $(ESMF_UTCDIR) ] ; then cd $(ESMF_UTCDIR) ; fi; \
	if [ ! $(USE_TEST_CASE)foo = foo ] ; then \
	   if [ -d $(USE_TEST_CASE) ] ; then \
	       cd $(USE_TEST_CASE); \
           else \
              echo "USE_TEST_CASE $(USE_TEST_CASE) does not exist."; \
              exit; \
	   fi; \
	   echo current working directory is now `pwd` ; \
        fi; \
	$(MAKE) ACTION=tree_build_use_test_cases tree ; \
	echo "ESMF use test cases built successfully."

tree_build_use_test_cases: chkdir_tests $(USE_TEST_CASES_BUILD)


#
# TODO: the RM in the link rules below means that any use test case which
# includes additional .o files (which most do) will always rebuild even if
# it is up-to-date.  but we remove the .o and .mod files because we also
# are required to be able to build multiple architectures from a single
# build tree.  we currently have a race-condition with the system tests
# in that we build with the current directory being the src dir, which
# means compilers can trample each others .o and .mod files.  the library
# cds into the lib or mod dir before compiling, so .o and .mod files
# are created in a compiler/platform directory and do not interfere with
# each other.
#
# the fix for this is either to cd into the test dir before compiling
# and linking, or to create a temp subdir based on the compiler/platform/
# BOPT/SITE settings - so compiles are truly independent.
#
# this also applies to the tests, and examples.
#

#
#  Link rule for Fortran use test cases.
#
$(ESMF_TESTDIR)/ESMF_%UseTestCase : ESMF_%UseTestCase.o $(USE_TEST_CASES_OBJ) $(ESMFLIB)
	$(ESMF_F90LINKER) $(ESMF_EXE_F90LINKOPTS) $(ESMF_F90LINKOPTS) $(ESMF_F90LINKPATHS) $(ESMF_F90LINKRPATHS) $(ESMF_EXEOUT_OPTION) $(USE_TEST_CASES_OBJ) $< $(ESMF_F90ESMFLINKLIBS)
	$(ESMF_RM) -f *.o *.mod


# debugging aid:  link the executable, standard output, and log file to
# temporary names in the current directory (they are built in the test
# directory which is a long ways away from the source.  debuggers work
# better if the current directory is the source dir, not the executable dir.)
# example use:  gmake TNAME=FieldExcl system_test_links
use_test_cases_links:
	$(ESMF_RM) t s l
	ln -s $(ESMF_TESTDIR)/ESMF_$(TNAME)UseTestCase t
	ln -s $(ESMF_TESTDIR)/ESMF_$(TNAME)UseTestCase.stdout s
	ln -s $(ESMF_TESTDIR)/ESMF_$(TNAME)UseTestCase.Log l

#
#  Link rule for Fortran use test cases (MPMD).
#
$(ESMF_TESTDIR)/ESMF_%UseTestCaseA : $(USE_TEST_CASES_OBJ_A) $(ESMFLIB) ESMF_%UseTestCaseA.o
	$(ESMF_F90LINKER) $(ESMF_EXE_F90LINKOPTS) $(ESMF_F90LINKOPTS) $(ESMF_F90LINKPATHS) $(ESMF_F90LINKRPATHS) $(ESMF_EXEOUT_OPTION) $(USE_TEST_CASES_OBJ_A) ESMF_$*UseTestCaseA.o $(ESMF_F90ESMFLINKLIBS)
$(ESMF_TESTDIR)/ESMF_%UseTestCaseB : $(USE_TEST_CASES_OBJ_B) $(ESMFLIB) ESMF_%UseTestCaseB.o
	$(ESMF_F90LINKER) $(ESMF_EXE_F90LINKOPTS) $(ESMF_F90LINKOPTS) $(ESMF_F90LINKPATHS) $(ESMF_F90LINKRPATHS) $(ESMF_EXEOUT_OPTION) $(USE_TEST_CASES_OBJ_B) ESMF_$*UseTestCaseB.o $(ESMF_F90ESMFLINKLIBS)
$(ESMF_TESTDIR)/ESMF_%UseTestCaseC : $(USE_TEST_CASES_OBJ_C) $(ESMFLIB) ESMF_%UseTestCaseC.o
	$(ESMF_F90LINKER) $(ESMF_EXE_F90LINKOPTS) $(ESMF_F90LINKOPTS) $(ESMF_F90LINKPATHS) $(ESMF_F90LINKRPATHS) $(ESMF_EXEOUT_OPTION) $(USE_TEST_CASES_OBJ_C) ESMF_$*UseTestCaseC.o $(ESMF_F90ESMFLINKLIBS)
$(ESMF_TESTDIR)/ESMF_%UseTestCaseD : $(USE_TEST_CASES_OBJ_D) $(ESMFLIB) ESMF_%UseTestCaseD.o
	$(ESMF_F90LINKER) $(ESMF_EXE_F90LINKOPTS) $(ESMF_F90LINKOPTS) $(ESMF_F90LINKPATHS) $(ESMF_F90LINKRPATHS) $(ESMF_EXEOUT_OPTION) $(USE_TEST_CASES_OBJ_D) ESMF_$*UseTestCaseD.o $(ESMF_F90ESMFLINKLIBS)
$(ESMF_TESTDIR)/ESMF_%UseTestCaseE : $(USE_TEST_CASES_OBJ_E) $(ESMFLIB) ESMF_%UseTestCaseE.o
	$(ESMF_F90LINKER) $(ESMF_EXE_F90LINKOPTS) $(ESMF_F90LINKOPTS) $(ESMF_F90LINKPATHS) $(ESMF_F90LINKRPATHS) $(ESMF_EXEOUT_OPTION) $(USE_TEST_CASES_OBJ_E) ESMF_$*UseTestCaseE.o $(ESMF_F90ESMFLINKLIBS)

#
# run_use_test_cases
#
run_use_test_cases: test_esmfmkfile reqdir_tests
	@if [ -d $(ESMF_UTCDIR) ] ; then cd $(ESMF_UTCDIR) ; fi; \
	if [ ! $(USE_TEST_CASE)foo = foo ] ; then \
	   if [ -d $(USE_TEST_CASE) ] ; then \
	       cd $(USE_TEST_CASE); \
           else \
              echo "USE_TEST_CASE $(USE_TEST_CASE) does not exist."; \
              echo "Check out use_test_cases at the $(ESMF_DIR)/src directory."; \
              exit; \
	   fi; \
	   echo current working directory is now `pwd` ; \
        fi; \
	if [ $(ESMF_COMM) = "mpiuni" ] ; then \
          echo "Cannot run multiprocessor use test cases when ESMF_COMM is mpiuni;" ; \
	  echo "run run_use_test_cases_uni instead." ; \
	  echo "" ; \
	  $(MAKE) err ; \
          exit ; \
	fi; \
	$(MAKE) ACTION=tree_run_use_test_cases tree ; \
	$(MAKE) check_use_test_cases

tree_run_use_test_cases: tree_dry_run_use_test_cases $(USE_TEST_CASES_RUN)

#
# run_use_test_cases_uni
#
run_use_test_cases_uni: test_esmfmkfile reqdir_tests
	@if [ -d $(ESMF_UTCDIR) ] ; then cd $(ESMF_UTCDIR) ; fi; \
	if [ ! $(USE_TEST_CASE)foo = foo ] ; then \
	   if [ -d $(USE_TEST_CASE) ] ; then \
	       cd $(USE_TEST_CASE); \
           else \
              echo "USE_TEST_CASE  $(USE_TEST_CASE) does not exist."; \
               echo "Checkout use_test_cases at the $(ESMF_DIR)/src directory."; \
              exit; \
	   fi; \
	   echo current working directory is now `pwd` ; \
        fi; \
	$(MAKE) ACTION=tree_run_use_test_cases_uni tree ; \
	$(MAKE) check_use_test_cases

tree_run_use_test_cases_uni: tree_dry_run_use_test_cases $(USE_TEST_CASES_RUN_UNI)


#
# dry_run_use_test_cases
#
dry_run_use_test_cases: test_esmfmkfile
	@if [ -d $(ESMF_UTCDIR) ] ; then cd $(ESMF_UTCDIR) ; fi; \
        if [ ! $(USE_TEST_CASE)foo = foo ] ; then \
           if [ -d $(USE_TEST_CASE) ] ; then \
               cd $(USE_TEST_CASE); \
           else \
              echo "USE_TEST_CASE  $(USE_TEST_CASE) does not exist."; \
               echo "Checkout use_test_cases at the $(ESMF_DIR)/src directory."; \
              exit; \
           fi; \
           echo current working directory is now `pwd` ; \
        fi; \
        $(MAKE) ACTION=tree_dry_run_use_test_cases tree

tree_dry_run_use_test_cases: $(USE_TEST_CASES_DRY_RUN)

#
# run the use test cases, either redirecting the stdout from the command line, or
# relying on the mpirun script to redirect stdout from inside the batch script.
#
uctest:
	-@if [ $(ESMF_BATCHDEPRECATED) = "true" ] ; then \
	  echo $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) $(ESMF_TESTDIR)/ESMF_$(TNAME)UseTestCase ; \
	  $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) $(ESMF_TESTDIR)/ESMF_$(TNAME)UseTestCase ; \
	else \
	  echo $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) $(ESMF_TESTDIR)/ESMF_$(TNAME)UseTestCase 1\> $(ESMF_TESTDIR)/ESMF_$(TNAME)UseTestCase.stdout 2\>\&1 ; \
	  $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) $(ESMF_TESTDIR)/ESMF_$(TNAME)UseTestCase 1> $(ESMF_TESTDIR)/ESMF_$(TNAME)UseTestCase.stdout 2>&1 ; \
	fi

#
# this target deletes only the use test cases related files from the test subdir
#
clean_use_test_cases:
	$(ESMF_RM) $(ESMF_TESTDIR)/*UseTestCase*

#
# report statistics on system tests
#
check_use_test_cases:
	@$(DO_UTC_RESULTS)


#-------------------------------------------------------------------------------
#  Targets for building and running unit tests.
#-------------------------------------------------------------------------------

# TODO: the run_unit_tests targets below a the dash before the make
# subcommand ( -$(MAKE) xxx ) to ignore the return code from the command.
# i would prefer to not do this, but on at least one important platform (AIX)
# we cannot force the fortran programs to exit with a zero return code if
# all is well (it comes out 128).  if this gets fixed in our code, the dashes
# can be removed and make can correctly stop on error.

unit_tests: test_esmfmkfile chkdir_tests autobuild_libs dust_unit_tests
	@if [ $(ESMF_COMM) = "mpiuni" ] ; then \
          echo "Cannot run multiprocessor unit tests when ESMF_COMM is mpiuni;" ; \
	  echo "run unit_tests_uni instead." ; \
	  echo "" ; \
	  $(MAKE) err ; \
	fi
	$(MAKE) MULTI="Multiprocessor" config_unit_tests
	-$(MAKE) ACTION=tree_unit_tests tree
	$(MAKE) check_unit_tests

tree_unit_tests: tree_build_unit_tests tree_run_unit_tests

#
# tests_uni
#
unit_tests_uni: test_esmfmkfile chkdir_tests autobuild_libs dust_unit_tests
	$(MAKE) MULTI="Uniprocessor" config_unit_tests
	-$(MAKE) ACTION=tree_unit_tests_uni tree
	$(MAKE) check_unit_tests

tree_unit_tests_uni: tree_build_unit_tests tree_run_unit_tests_uni

#
# build_unit_tests
#
build_unit_tests: test_esmfmkfile reqfile_libesmf reqdir_lib chkdir_tests verify_exhaustive_flag
	$(MAKE) config_unit_tests
	$(MAKE) ACTION=tree_build_unit_tests tree
	@echo "ESMF unit tests built successfully."

tree_build_unit_tests: $(TESTS_BUILD)


$(ESMF_TESTDIR)/ESMF_%UTest : ESMF_%UTest.o $(ESMFLIB)
	$(ESMF_F90LINKER) $(ESMF_EXE_F90LINKOPTS) $(ESMF_F90LINKOPTS) $(ESMF_F90LINKPATHS) $(ESMF_F90LINKRPATHS) $(ESMF_EXEOUT_OPTION) $(ESMF_UTEST_$(*)_OBJS) $(TESTS_OBJ) $< $(ESMF_F90ESMFLINKLIBS)
	$(ESMF_RM) -f *.o *.mod

$(ESMF_TESTDIR)/ESMCI_%UTest : ESMCI_%UTest.o $(ESMFLIB)
	$(ESMF_CXXLINKER) $(ESMF_EXE_CXXLINKOPTS) $(ESMF_CXXLINKOPTS) $(ESMF_CXXLINKPATHS) $(ESMF_CXXLINKRPATHS) $(ESMF_EXEOUT_OPTION) $(ESMCI_UTEST_$(*)_OBJS) $< $(ESMF_CXXESMFLINKLIBS)
	$(ESMF_RM) -f *.o *.mod

$(ESMF_TESTDIR)/ESMC_%UTest : ESMC_%UTest.o $(ESMFLIB)
	$(ESMF_CLINKER) $(ESMF_EXE_CLINKOPTS) $(ESMF_CLINKOPTS) $(ESMF_CLINKPATHS) $(ESMF_CLINKRPATHS) $(ESMF_EXEOUT_OPTION) $(ESMC_UTEST_$(*)_OBJS) $< $(ESMF_CESMFLINKLIBS)
	$(ESMF_RM) -f *.o *.mod

# debugging aid:  link the executable, standard output, and log file to
# temporary names in the current directory (they are built in the test
# directory which is a long ways away from the source.  debuggers work
# better if the current directory is the source dir, not the executable dir.)
# example use:  gmake TNAME=Field unit_test_links
unit_test_links:
	rm -f t s l
	ln -s $(ESMF_TESTDIR)/ESMF_$(TNAME)UTest t
	ln -s $(ESMF_TESTDIR)/ESMF_$(TNAME)UTest.stdout s
	ln -s $(ESMF_TESTDIR)/ESMF_$(TNAME)UTest.Log l

#
# dust_unit_tests
#
dust_unit_tests: dust_test_harness
	$(ESMF_RM) $(ESMF_TESTDIR)/unit_tests_results
	$(ESMF_RM) $(ESMF_TESTDIR)/*UTest.Log
	$(ESMF_RM) $(ESMF_TESTDIR)/*UTest.stdout
	$(ESMF_RM) $(ESMF_TESTDIR)/*.rc
	$(ESMF_RM) $(ESMF_TESTDIR)/*.nc
	$(ESMF_RM) $(ESMF_TESTDIR)/data

#
# run_unit_tests
#
run_unit_tests: test_esmfmkfile reqdir_tests verify_exhaustive_flag
	@if [ $(ESMF_COMM) = "mpiuni" ] ; then \
          echo "Cannot run multiprocessor unit tests when ESMF_COMM is mpiuni;" ; \
	  echo "run run_unit_tests_uni instead." ; \
	  echo "" ; \
	  $(MAKE) err ; \
	fi
	@if [ $(ESMF_DIR) = `pwd` ] ; then \
	  $(MAKE) dust_unit_tests ; \
	fi
	@if [ -f $(UNIT_TESTS_CONFIG) ] ; then \
	   $(ESMF_SED) -e 's/ [A-Za-z][A-Za-z]*processor/ Multiprocessor/' $(UNIT_TESTS_CONFIG) > $(UNIT_TESTS_CONFIG).temp; \
           $(ESMF_MV) $(UNIT_TESTS_CONFIG).temp $(UNIT_TESTS_CONFIG); \
        fi
	-$(MAKE) ACTION=tree_run_unit_tests tree
	$(MAKE) check_unit_tests

tree_run_unit_tests: $(TESTS_RUN)

#
# run_unit_tests_uni
#
run_unit_tests_uni: test_esmfmkfile reqdir_tests verify_exhaustive_flag
	@if [ $(ESMF_DIR) = `pwd` ] ; then \
	  $(MAKE) dust_unit_tests ; \
	fi
	@if [ -f $(UNIT_TESTS_CONFIG) ] ; then \
	   $(ESMF_SED) -e 's/ [A-Za-z][A-Za-z]*processor/ Uniprocessor/' $(UNIT_TESTS_CONFIG) > $(UNIT_TESTS_CONFIG).temp; \
           $(ESMF_MV) $(UNIT_TESTS_CONFIG).temp $(UNIT_TESTS_CONFIG); \
        fi
	-$(MAKE) ACTION=tree_run_unit_tests_uni tree
	$(MAKE) check_unit_tests

tree_run_unit_tests_uni: $(TESTS_RUN_UNI)

#
# echo into a file how the tests were last built and run, so when the perl
# scripts run to check the results it can compute the number of messages that
# should be found.  it needs to know exhaustive vs non to know how many total
# tests we expected to execute; it needs to know multi vs uni so it knows
# how many messages per test are generated.
#
config_unit_tests:
	@echo "# This file used by test scripts, please do not delete." > $(UNIT_TESTS_CONFIG)
ifeq ($(ESMF_TESTEXHAUSTIVE),ON)
ifeq ($(MULTI),)
	@echo "Last built Exhaustive ;  Last run Noprocessor" >> $(UNIT_TESTS_CONFIG)
else
	@echo "Last built Exhaustive ;  Last run" $(MULTI) >> $(UNIT_TESTS_CONFIG)
endif
else
ifeq ($(MULTI),)
	@echo "Last built Non-exhaustive ;  Last run Noprocessor" >> $(UNIT_TESTS_CONFIG)
else
	@echo "Last built Non-exhaustive ;  Last run" $(MULTI) >> $(UNIT_TESTS_CONFIG)
endif
endif

#
# verify that either there is no UNIT_TESTS_CONFIG file, or if one exists that
# the string Exhaustive or Non-exhaustive matches the current setting of the
# ESMF_TESTEXHAUSTIVE environment variable.  this is used when trying to run
# already-built unit tests, to be sure the user has not changed the setting
# of exhaustive and then assumed that it will take effect.  unfortunately at
# this time, the flag is compile-time and not run-time.
#
verify_exhaustive_flag:
ifeq ($(ESMF_TESTEXHAUSTIVE),ON)
	@$(MAKE) UNIT_TEST_STRING="Exhaustive" exhaustive_flag_check
else
	@$(MAKE) UNIT_TEST_STRING="Non-exhaustive" exhaustive_flag_check
endif

exhaustive_flag_check:
	@if [ -s $(UNIT_TESTS_CONFIG) -a \
	     `$(ESMF_SED) -ne '/$(UNIT_TEST_STRING)/p' $(UNIT_TESTS_CONFIG) | $(ESMF_WC) -l` -ne 1 ] ; then \
	  echo "The ESMF_TESTEXHAUSTIVE environment variable is a compile-time control for" ;\
          echo "whether a basic set or an exhaustive set of tests are built." ;\
	  echo "" ;\
	  echo "The current setting of ESMF_TESTEXHAUSTIVE is \"$(ESMF_TESTEXHAUSTIVE)\", which" ;\
	  echo "is not the same as when the unit tests were last built." ;\
	  echo "(This is based on the contents of the file:" ;\
          echo "$(UNIT_TESTS_CONFIG) ";\
	  echo "which contains: `$(ESMF_SED) -e '1d' $(UNIT_TESTS_CONFIG)` )." ;\
	  echo "" ;\
	  echo "To rebuild and run the unit tests with the current ESMF_TESTEXHAUSTIVE value, run:" ;\
	  echo "   $(MAKE) clean_unit_tests unit_tests"  ;\
	  echo "or change ESMF_TESTEXHAUSTIVE to ON or OFF to match the build-time value." ;\
	  echo "" ;\
	  $(MAKE) err ;\
	fi

# call clean only if flags do not match
clean_if_exhaustive_flag_mismatch:
ifeq ($(ESMF_TESTEXHAUSTIVE),ON)
	@$(MAKE) UNIT_TEST_STRING="Exhaustive" exhaustive_flag_clobber
else
	@$(MAKE) UNIT_TEST_STRING="Non-exhaustive" exhaustive_flag_clobber
endif

exhaustive_flag_clobber:
	@if [ -s $(UNIT_TESTS_CONFIG) -a \
	     `$(ESMF_SED) -ne '/$(UNIT_TEST_STRING)/p' $(UNIT_TESTS_CONFIG) | $(ESMF_WC) -l` -ne 1 ] ; then \
	  $(MAKE) clean_unit_tests ;\
	fi

#
# this target deletes only the unit test related files from the test subdir
# so we can rebuild them with the proper flags if that is what is needed.
#
clean_unit_tests:
	$(ESMF_RM) $(ESMF_TESTDIR)/*UTest* $(UNIT_TESTS_CONFIG) $(TEST_HARNESS_LIST)
	$(MAKE) ACTION=tree_cleanfiles tree

#
# install unit tests benchmark directory
#
install_unit_tests_benchmark: reqdir_tests
	-@echo " "
	-@echo "Installing unit tests benchmark directory"
	-@echo " "
	mkdir -p $(ESMF_BENCHMARK_PREFIX_ABSPATH)/test/test$(ESMF_BOPT)/$(ESMF_OS).$(ESMF_COMPILER).$(ESMF_ABI).$(ESMF_COMM).$(ESMF_SITE)
	cp -f $(ESMF_TESTDIR)/ESM*UTest.stdout $(ESMF_BENCHMARK_PREFIX_ABSPATH)/test/test$(ESMF_BOPT)/$(ESMF_OS).$(ESMF_COMPILER).$(ESMF_ABI).$(ESMF_COMM).$(ESMF_SITE)/.
	date > bm_timestamp
	mv -f bm_timestamp $(ESMF_BENCHMARK_PREFIX_ABSPATH)/test/test$(ESMF_BOPT)/$(ESMF_OS).$(ESMF_COMPILER).$(ESMF_ABI).$(ESMF_COMM).$(ESMF_SITE)/.

#
# run unit test benchmarking
#
run_unit_tests_benchmark:
	@$(DO_UT_BM_RESULTS)

#
# report statistics on tests
#
check_unit_tests:
	@$(DO_UT_RESULTS)

#
# report statistics on memoey leak tests
#
check_unit_tests_ml:
	@$(DO_UT_ML_RESULTS)


#
# internal targets used to actually run the fortran and c++ unit tests
#
#  the call in the local makefiles is something like:
#    $(MAKE) TNAME=testname NP=4 ftest
#
# running a test is:  remove any old existing per-process log files, then
# run the test with the right number of processors.  the standard output is
# captured in a .stdout file; the test macros open PETx.name.Log files by
# default (set when the tests call ESMF_Initialize()).  after the tests run,
# we cat all the per-pet files together into a single log file.  (after the
# log can collate output from different PETs all by itself, we can remove
# the cat step.)
#
ftest:
	-@cd $(ESMF_TESTDIR) ; \
	$(ESMF_RM) ./PET*$(TNAME)UTest.Log ; \
	if [ $(ESMF_BATCHDEPRECATED) = "true" ] ; then \
	  echo $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMF_$(TNAME)UTest ; \
	  $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMF_$(TNAME)UTest ; \
	else \
	  echo $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMF_$(TNAME)UTest 1\> ./ESMF_$(TNAME)UTest.stdout 2\>\&1 ; \
	  $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMF_$(TNAME)UTest 1> ./ESMF_$(TNAME)UTest.stdout 2>&1 ; \
	fi ; \
	cat ./PET*$(TNAME)UTest.Log > ./ESMF_$(TNAME)UTest.Log ; \
	$(ESMF_RM) ./PET*$(TNAME)UTest.Log


# same as ftest target above, except turns on profiling
# region timings appear at the end of the log files and a trace is generated
ftest_profile:
	-@cd $(ESMF_TESTDIR) ; \
	$(ESMF_RM) ./PET*$(TNAME)UTest.Log ; \
	$(ESMF_RM) -rf ./ESMF_$(TNAME)UTest_traceout ; \
	echo env ESMF_RUNTIME_TRACE=ON $(ESMF_MPIRUN) -np $(NP) ./ESMF_$(TNAME)UTest 1\> ./ESMF_$(TNAME)UTest.stdout 2\>\&1 ; \
	env ESMF_RUNTIME_TRACE=ON $(ESMF_MPIRUN) -np $(NP) ./ESMF_$(TNAME)UTest 1> ./ESMF_$(TNAME)UTest.stdout 2>&1 ; \
	cat ./PET*$(TNAME)UTest.Log > ./ESMF_$(TNAME)UTest.Log ; \
	$(ESMF_MV) ./traceout ./ESMF_$(TNAME)UTest_traceout ; \
	$(ESMF_RM) ./PET*$(TNAME)UTest.Log

# same as ftest_profile target above, except also uses
# LD_PRELOAD to override MPI/IO symbols and time them
ftest_profile_preload:
	-@cd $(ESMF_TESTDIR) ; \
	$(ESMF_RM) ./PET*$(TNAME)UTest.Log ; \
	$(ESMF_RM) -rf ./ESMF_$(TNAME)UTest_traceout ; \
	if [ -z $(ESMF_PRELOAD_SH) ] ; then \
	  echo env ESMF_RUNTIME_TRACE=ON $(ESMF_ENV_PRELOAD)=$(ESMF_TRACE_LDPRELOAD) $(ESMF_MPIRUN) -np $(NP) ./ESMF_$(TNAME)UTest 1\> ./ESMF_$(TNAME)UTest.stdout 2\>\&1 ; \
	  env ESMF_RUNTIME_TRACE=ON $(ESMF_ENV_PRELOAD)=$(ESMF_TRACE_LDPRELOAD) $(ESMF_MPIRUN) -np $(NP) ./ESMF_$(TNAME)UTest 1> ./ESMF_$(TNAME)UTest.stdout 2>&1 ; \
	else \
	  echo env ESMF_RUNTIME_TRACE=ON $(ESMF_MPIRUN) -np $(NP) $(ESMF_PRELOAD_SH) ./ESMF_$(TNAME)UTest 1\> ./ESMF_$(TNAME)UTest.stdout 2\>\&1 ; \
	  env ESMF_RUNTIME_TRACE=ON $(ESMF_MPIRUN) -np $(NP) $(ESMF_PRELOAD_SH) ./ESMF_$(TNAME)UTest 1> ./ESMF_$(TNAME)UTest.stdout 2>&1 ; \
	fi ; \
	cat ./PET*$(TNAME)UTest.Log > ./ESMF_$(TNAME)UTest.Log ; \
	$(ESMF_MV) ./traceout ./ESMF_$(TNAME)UTest_traceout ; \
	$(ESMF_RM) ./PET*$(TNAME)UTest.Log

htest:
	-@cd $(ESMF_TESTDIR) ; \
	$(ESMF_RM) ./PET*$(TNAME)UTest.Log ESMF_$(TNAME)UTest.stdout ; \
	if [ $(ESMF_BATCHDEPRECATED) = "true" ] ; then \
	  echo $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMF_$(TNAME)UTest -case $(TESTHARNESSCASE)_test.rc -xml $(TESTHARNESSCASE).xml; \
	  $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMF_$(TNAME)UTest -case $(TESTHARNESSCASE)_test.rc -xml $(TESTHARNESSCASE).xml ; \
	  if [ -f $(ESMF_TESTDIR)/ESMF_$(TNAME)UTest.stdout ] ; then \
		mv -f $(ESMF_TESTDIR)/ESMF_$(TNAME)UTest.stdout $(ESMF_TESTDIR)/ESMF_$(HNAME)UTest.stdout ; \
	  fi ; \
	else \
	  echo $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMF_$(TNAME)UTest -case $(TESTHARNESSCASE)_test.rc -xml $(TESTHARNESSCASE).xml; \
	  $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMF_$(TNAME)UTest -case $(TESTHARNESSCASE)_test.rc -xml $(TESTHARNESSCASE).xml 1> ./ESMF_$(HNAME)UTest.stdout 2>&1 ; \
	  if [ -f $(ESMF_TESTDIR)/ESMF_$(TNAME)UTest.stdout ] ; then \
		mv -f $(ESMF_TESTDIR)/ESMF_$(TNAME)UTest.stdout $(ESMF_TESTDIR)/ESMF_$(HNAME)UTest.stdout ; \
	   fi ; \
	fi ; \
	cat ./PET*$(TNAME)UTest.Log > ./ESMF_$(HNAME)UTest.Log ; \
	$(ESMF_RM) ./PET*$(TNAME)UTest.Log ; \
	if [ -f $(TESTHARNESSCASE).xml ] ; then \
		echo xsltproc -o $(TESTHARNESSCASE).html $(ESMF_DIR)/src/test_harness/src/HarnessHttp.xslt $(TESTHARNESSCASE).xml ; \
		xsltproc -o $(TESTHARNESSCASE).html $(ESMF_DIR)/src/test_harness/src/HarnessHttp.xslt $(TESTHARNESSCASE).xml ; \
	fi

### TNAME=TestHarness HNAME=$(TESTHARNESSCASE)_NP$(NP) TESTHARNESSPATH=$(PWD)

ctest:
	-@cd $(ESMF_TESTDIR) ; \
	$(ESMF_RM) ./PET*$(TNAME)UTest.Log ; \
	if [ $(ESMF_BATCHDEPRECATED) = "true" ] ; then \
	  echo $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMC_$(TNAME)UTest ; \
	  $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMC_$(TNAME)UTest ; \
	else \
	  echo $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMC_$(TNAME)UTest 1\> ./ESMC_$(TNAME)UTest.stdout 2\>\&1 ; \
	  $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMC_$(TNAME)UTest 1> ./ESMC_$(TNAME)UTest.stdout 2>&1 ; \
	fi ; \
	cat ./PET*$(TNAME)UTest.Log > ./ESMC_$(TNAME)UTest.Log ; \
	$(ESMF_RM) ./PET*$(TNAME)UTest.Log

citest:
	-@cd $(ESMF_TESTDIR) ; \
	$(ESMF_RM) ./PET*$(TNAME)UTest.Log ; \
	if [ $(ESMF_BATCHDEPRECATED) = "true" ] ; then \
	  echo $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMCI_$(TNAME)UTest ; \
	  $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMCI_$(TNAME)UTest ; \
	else \
	  echo $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMCI_$(TNAME)UTest 1\> ./ESMCI_$(TNAME)UTest.stdout 2\>\&1 ; \
	  $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMCI_$(TNAME)UTest 1> ./ESMCI_$(TNAME)UTest.stdout 2>&1 ; \
	fi ; \
	cat ./PET*$(TNAME)UTest.Log > ./ESMCI_$(TNAME)UTest.Log ; \
	$(ESMF_RM) ./PET*$(TNAME)UTest.Log

##########################
# prepare to run test harness
dust_test_harness:
	$(ESMF_RM) $(ESMF_TESTDIR)/test_harness.*

#
# run test harness
#    parameters
#        TESTHARNESSCASE    test case name
#        NP                 number of processors
#
#
#    internal
#        TNAME    test name (hardcoded TestHarness)
#        HNAME    unique name base on suite and number of processors
#
#    environment
#        MPIRUN        mpirun command
#        ESMF_TESTDIR  test directory
#
# need UNI case, NP=UNI?
#
#
run_test_harness:
	$(MAKE) TNAME=TestHarness HNAME=$(TESTHARNESSCASE)_NP$(NP) run_test_harness_sec

# target with expanded parameters
run_test_harness_sec:
	@if [ -f $(ESMF_TESTDIR)/test_harness.list ] ; then \
	  if ! grep ESMF_$(HNAME)UTest $(ESMF_TESTDIR)/test_harness.list ; then \
	    echo ESMF_$(HNAME)UTest >> $(ESMF_TESTDIR)/test_harness.list ; \
	  fi ; \
	else \
	  echo ESMF_$(HNAME)UTest > $(ESMF_TESTDIR)/test_harness.list ; \
	fi ; \
	if [ -d harness_config ] ; then \
	  if [ -f harness_config/$(TESTHARNESSCASE)_test.rc ] ; then \
	    cp -f harness_config/$(TESTHARNESSCASE)_*.rc $(ESMF_TESTDIR) ; \
            cp -f harness_config/$(TESTHARNESSCASE)_test.rc $(ESMF_TESTDIR)/test_harness.rc ; \
	    $(MAKE) htest ; \
	  else \
	    echo "FAIL: missing file - harness_config/$(TESTHARNESSCASE)_test.rc" ; \
	  fi ; \
	else \
	  echo "FAIL: missing directory - harness_config" ; \
	fi

#-------------------------------------------------------------------------------
#  Obsolete targets for building and running unit tests.  Echo an error
#  and point users to updated target names.
#-------------------------------------------------------------------------------

.PHONY: tests build_tests run_tests tests_uni run_tests_uni check_tests err

tests: ; $(error Obsolete target, use unit_tests now)

build_tests: ; $(error Obsolete target, use build_unit_tests now)

run_tests: ; $(error Obsolete target, use run_unit_tests now)

tests_uni: ; $(error Obsolete target, use unit_tests_uni now)

run_tests_uni: ; $(error Obsolete target, use run_unit_tests_uni now)

check_tests: ; $(error Obsolete target, use check_unit_tests now)

err: ; $(error gnumake exiting)


#-------------------------------------------------------------------------------
# Targets for building and running examples
#
#  The example targets depend on variables set in the
#  makefile in the example source code directory.  The
#  variables are:
#
#      EXAMPLES_BUILD should list the full path all of the
#      example executables to be made.  The example executables
#      have to be built in $(ESMF_EXDIR).
#
#      EXAMPLES_RUN and EXAMPLES_RUN_UNI list the run targets
#      of the individual executables.  The run targets are defined
#      in the source code makefiles.  EXAMPLES_RUN list the targets
#      that run the examples on multiply processors.  EXAMPLES_RUN_UNI
#      lists the targets that run the examples on single processors.
#
#-------------------------------------------------------------------------------

#
# examples
#
examples: test_esmfmkfile chkdir_examples autobuild_libs dust_examples
	@if [ $(ESMF_COMM) = "mpiuni" ] ; then \
          echo "Cannot run multiprocessor examples when ESMF_COMM is mpiuni;" ; \
	  echo "run examples_uni instead." ; \
	  echo "" ; \
	  $(MAKE) err ; \
	fi
	$(MAKE) MULTI="Multiprocessor" config_examples
	-$(MAKE) ACTION=tree_examples tree
	$(MAKE) check_examples


tree_examples: tree_build_examples tree_run_examples

#
# examples_uni
#
examples_uni: test_esmfmkfile chkdir_examples autobuild_libs dust_examples
	$(MAKE) MULTI="Uniprocessor" config_examples
	-$(MAKE) ACTION=tree_examples_uni tree
	$(MAKE) check_examples

tree_examples_uni: tree_build_examples tree_run_examples_uni

#
# build_examples
#
build_examples: test_esmfmkfile reqfile_libesmf reqdir_lib chkdir_examples
	$(MAKE) config_examples
	$(MAKE) ACTION=tree_build_examples tree
	@echo "ESMF examples built successfully."

tree_build_examples: $(EXAMPLES_BUILD)

#
#  Examples Link commands
#
$(ESMF_EXDIR)/ESMF_%Ex : ESMF_%Ex.o $(ESMFLIB)
	$(ESMF_F90LINKER) $(ESMF_EXE_F90LINKOPTS) $(ESMF_F90LINKOPTS) $(ESMF_F90LINKPATHS) $(ESMF_F90LINKRPATHS) $(ESMF_EXEOUT_OPTION) $(ESMF_EXAMPLE_$(*)_OBJS) $< $(ESMF_F90ESMFLINKLIBS)
	$(ESMF_RM) -f *.o *.mod

$(ESMF_EXDIR)/ESMCI_%Ex: ESMCI_%Ex.o $(ESMFLIB)
	$(ESMF_CXXLINKER) $(ESMF_EXE_CXXLINKOPTS) $(ESMF_CXXLINKOPTS) $(ESMF_CXXLINKPATHS) $(ESMF_CXXLINKRPATHS) $(ESMF_EXEOUT_OPTION) $(ESMC_EXAMPLE_$(*)_OBJS) $< $(ESMF_CXXESMFLINKLIBS)
	$(ESMF_RM) $<

$(ESMF_EXDIR)/ESMC_%Ex: ESMC_%Ex.o $(ESMFLIB)
	$(ESMF_CLINKER) $(ESMF_EXE_CLINKOPTS) $(ESMF_CXXLINKOPTS) $(ESMF_CLINKPATHS) $(ESMF_CLINKRPATHS) $(ESMF_EXEOUT_OPTION) $(ESMC_EXAMPLE_$(*)_OBJS) $< $(ESMF_CESMFLINKLIBS)
	$(ESMF_RM) $<

#
# dust_examples
#
dust_examples:
	$(ESMF_RM) $(ESMF_EXDIR)/examples_results
	$(ESMF_RM) $(ESMF_EXDIR)/*Ex.Log
	$(ESMF_RM) $(ESMF_EXDIR)/*Ex.stdout
	$(ESMF_RM) $(ESMF_EXDIR)/*.rc
	$(ESMF_RM) $(ESMF_EXDIR)/*.nc
	$(ESMF_RM) $(ESMF_EXDIR)/data

#
# run_examples
#
run_examples: test_esmfmkfile reqdir_examples
	@if [ $(ESMF_COMM) = "mpiuni" ] ; then \
          echo "Cannot run multiprocessor examples when ESMF_COMM is mpiuni;" ; \
	  echo "run run_examples_uni instead." ; \
	  echo "" ; \
	  $(MAKE) err ; \
	fi
	@if [ $(ESMF_DIR) = `pwd` ] ; then \
	  $(MAKE) dust_examples ; \
	fi
	@if [ -f $(EXAMPLES_CONFIG) ] ; then \
	   $(ESMF_SED) -e 's/ [A-Za-z][A-Za-z]*processor/ Multiprocessor/' $(EXAMPLES_CONFIG) > $(EXAMPLES_CONFIG).temp; \
	   $(ESMF_MV) $(EXAMPLES_CONFIG).temp $(EXAMPLES_CONFIG); \
	fi
	-$(MAKE) ACTION=tree_run_examples tree
	$(MAKE) check_examples

tree_run_examples: $(EXAMPLES_RUN)


# run_examples_uni
#
run_examples_uni: test_esmfmkfile reqdir_examples
	@if [ $(ESMF_DIR) = `pwd` ] ; then \
	  $(MAKE) dust_examples ; \
	fi
	@if [ -f $(EXAMPLES_CONFIG) ] ; then \
	   $(ESMF_SED) -e 's/ [A-Za-z][A-Za-z]*processor/ Uniprocessor/' $(EXAMPLES_CONFIG) > $(EXAMPLES_CONFIG).temp; \
	$(ESMF_MV) $(EXAMPLES_CONFIG).temp $(EXAMPLES_CONFIG); \
        fi
	-$(MAKE) ACTION=tree_run_examples_uni tree
	$(MAKE) check_examples

tree_run_examples_uni: $(EXAMPLES_RUN_UNI)


#
# echo into a file how the examples were run, so when the perl scripts run
# it needs to know multi vs uni so it knows what examples were run.
#
config_examples:
	@echo "# This file used by test scripts, please do not delete." > $(EXAMPLES_CONFIG)
ifeq ($(MULTI),)
	@echo " Last run Noprocessor" >> $(EXAMPLES_CONFIG)
else
	@echo " Last run" $(MULTI) >> $(EXAMPLES_CONFIG)
endif


#
# run the examples, either redirecting the stdout from the command line, or
# relying on the mpirun script to redirect stdout from inside the batch script.
#
exfrun:
	-@cd $(ESMF_EXDIR) ; \
	$(ESMF_RM) ./PET*$(EXNAME)Ex.Log ; \
	if [ $(ESMF_BATCHDEPRECATED) = "true" ] ; then \
	  echo $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMF_$(EXNAME)Ex ; \
	  $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMF_$(EXNAME)Ex ; \
	else \
	  echo $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMF_$(EXNAME)Ex \> ./ESMF_$(EXNAME)Ex.stdout 2\>\&1 ; \
	  $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMF_$(EXNAME)Ex > ./ESMF_$(EXNAME)Ex.stdout 2>&1 ; \
	fi ; \
	cat ./PET*$(EXNAME)Ex*.Log> ./ESMF_$(EXNAME)Ex.Log ; \
	$(ESMF_RM) ./PET*$(EXNAME)Ex*.Log

excirun:
	-@cd $(ESMF_EXDIR) ; \
	$(ESMF_RM) ./PET*$(EXNAME)Ex.Log ; \
	if [ $(ESMF_BATCHDEPRECATED) = "true" ] ; then \
	  echo $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMCI_$(EXNAME)Ex ; \
	  $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMCI_$(EXNAME)Ex ; \
	else \
	  echo $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMCI_$(EXNAME)Ex \> ./ESMCI_$(EXNAME)Ex.stdout 2\>\&1 ; \
	  $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMCI_$(EXNAME)Ex > ./ESMCI_$(EXNAME)Ex.stdout 2>&1 ; \
	fi ; \
	cat ./PET*$(EXNAME)Ex*.Log> ./ESMCI_$(EXNAME)Ex.Log ; \
	$(ESMF_RM) ./PET*$(EXNAME)Ex*.Log

excrun:
	-@cd $(ESMF_EXDIR) ; \
	$(ESMF_RM) ./PET*$(EXNAME)Ex.Log ; \
	if [ $(ESMF_BATCHDEPRECATED) = "true" ] ; then \
	  echo $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMC_$(EXNAME)Ex ; \
	  $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMC_$(EXNAME)Ex ; \
	else \
	  echo $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMC_$(EXNAME)Ex \> ./ESMC_$(EXNAME)Ex.stdout 2\>\&1 ; \
	  $(ESMF_MPIRUN) -np $(NP) $(ESMF_TOOLRUN) ./ESMC_$(EXNAME)Ex > ./ESMC_$(EXNAME)Ex.stdout 2>&1 ; \
	fi ; \
	cat ./PET*$(EXNAME)Ex*.Log> ./ESMC_$(EXNAME)Ex.Log ; \
	$(ESMF_RM) ./PET*$(EXNAME)Ex*.Log


#
# this target deletes only the example related files from the example subdir
#
clean_examples:
	$(ESMF_RM) $(ESMF_EXDIR)/*
	$(MAKE) ACTION=tree_cleanfiles tree

#
# report statistics on examples
#
check_examples:
	@$(DO_EX_RESULTS)


#
# report memory leak statistics on examples
#
check_examples_ml:
	@$(DO_EX_ML_RESULTS)

#-------------------------------------------------------------------------------
# Targets for checking the builds
#-------------------------------------------------------------------------------

check_results: check_unit_tests check_examples check_system_tests

results_summary:
	@$(DO_SUM_RESULTS)

results_ck_summary:
	@$(DO_CK_SUM_RESULTS)

#-------------------------------------------------------------------------------
# Quickstart targets
#-------------------------------------------------------------------------------

build_quick_start:
	$(MAKE) ACTION=tree_build_quick_start tree

tree_build_quick_start:
	@if [ "$(QUICKSTARTDIR)" = "YES" ] ; then \
		$(MAKE); fi

#-------------------------------------------------------------------------------
#  Doc targets
#-------------------------------------------------------------------------------

doc:  chkdir_doc
	@echo "========================================="
	@echo "doc rule from common.mk"
	@echo "========================================="
	@if [ ! -d $(ESMF_DIR)/src/doc ] ; then \
          echo "*** This version of the ESMF source tree does not contain documentation files. Please see http://www.earthsystemmodeling.org/ for ESMF documentation." ; \
          $(ESMF_RM) $(ESMF_DOCDIR) ; \
          $(MAKE) err; \
        fi;
	cd $(ESMF_DIR)/src/doc ;\
	$(MAKE) dvi html pdf
	@echo "Build doc completed."

# 'doc' and 'alldoc' do identical things now.
alldoc: doc

# this new target should be called from an individual
# subsystem doc directory and will build only that doc.
# this is also the default if you call make from a doc subdir.

localdoc:
	@if [ "$(GRAPHFILES)"foo != foo ] ; then \
          cp $(addprefix $(ESMF_BUILD)/src/doc/,$(GRAPHFILES)) .;\
	fi;
	$(MAKE) $(TEXFILES_TO_MAKE)
	@if [ "$(DVIFILES)"foo != foo ] ; then \
          $(MAKE) $(DVIFILES);\
	fi;
	@if [ "$(PDFFILES)"foo != foo ] ; then \
          $(MAKE) $(PDFFILES);\
	fi;
	@if [ "$(HTMLFILES)"foo != foo ] ; then \
          $(MAKE) $(HTMLFILES);\
	fi;

onedoc: chkdir_doc include tex
	@echo "========================================="
	@echo "Building Single Document"
	@echo "========================================="
	@$(MAKE) dvi pdf html
	@echo "Build onedoc completed."

tex: chkdir_doc include
	cd $(ESMF_DIR) ;\
	$(MAKE) ACTION=tree_tex tree

tree_tex: $(TEXFILES_TO_MAKE)

dvi: chkdir_doc include tex
	@echo "========================================="
	@echo "dvi rule from common.mk, Building .dvi files"
	@echo "dvi files are:" $(DVIFILES)
	@echo "========================================="
	$(MAKE) $(DVIFILES)

tree_dvi: chkdir_doc $(DVIFILES)


pdf: chkdir_doc
	@echo "========================================="
	@echo "pdf rule from common.mk, Building .pdf files"
	@echo "pdf files are:" $(PDFFILES)
	@echo "========================================="
	$(MAKE) $(PDFFILES)

tree_pdf: chkdir_doc $(PDFFILES)


html: chkdir_doc include tex
	@echo "========================================="
	@echo "html rule from common.mk, Building .html files"
	@echo "html files are:" $(HTMLFILES)
	@echo "========================================="
	$(MAKE) $(HTMLFILES)

tree_html:chkdir_doc $(HTMLFILES)

clean_doc:
	@cd $(ESMF_BUILD)/src/doc ;\
	$(MAKE) tree_clean ; \
        $(ESMF_RM) $(ESMF_BUILD)/doc

#-------------------------------------------------------------------------------
# Recursive calls
#-------------------------------------------------------------------------------

# TODO: old tree target explicitly exited if the return code was not 0 but
# this defeats the -k makeflag which ignores errors and continues as far
# as possible.
#tree: $(ACTION)
#	@if [ "$(DIRS)" != "" ]; then \
#	  for dir in $(DIRS) foo ; do \
#            if [ -d $$dir ]; then \
#              (cd $$dir ; \
#              echo $(ACTION) in: `pwd`; \
#              $(MAKE) -f makefile tree ACTION=$(ACTION));\
#              if [ "$$?" != 0 ]; then \
#                exit 1; \
#              fi; \
#            fi; \
#	  done; \
#        fi

# TODO: maybe this can be simpler somehow - but it seems to work this way.
# the findstring looks for the -k flag, which says to ignore errors.
# if present, then do not test for the return of make, and let it
# continue as far as it can.  without -k, if there is an error in the
# call to make, exit from the tree command with a non-zero exit code
# so the calling make rule will exit.
tree: $(ACTION)
ifeq (,$(findstring k,$(MAKEFLAGS)))
	@if [ "$(DIRS)" != "" ]; then \
	  for dir in $(DIRS) foo ; do \
            if [ -d $$dir ]; then \
              (cd $$dir ; \
              echo "$(ACTION)" in: `pwd`; \
              $(MAKE) -f makefile tree ACTION="$(ACTION)");\
              if [ "$$?" != 0 ]; then \
                exit 1; \
              fi; \
            fi; \
	  done; \
        fi
else
	@if [ "$(DIRS)" != "" ]; then \
	  for dir in $(DIRS) foo ; do \
            if [ -d $$dir ]; then \
              (cd $$dir ; \
              echo "$(ACTION)" in: `pwd`; \
              $(MAKE) -f makefile tree ACTION="$(ACTION)");\
            fi; \
	  done; \
        fi
endif


#-------------------------------------------------------------------------------
# Suffixes
#-------------------------------------------------------------------------------
.SUFFIXES: .f .f90 .F .F90 .cppF90 .C .$(ESMF_SL_SUFFIX) .$(ESMF_LIB_SUFFIX) .cpp .cc .c .r .rm .sh

#-------------------------------------------------------------------------------
#  Compile rules for F90, C++, and c files for both to .o and .a files
#-------------------------------------------------------------------------------

# TODO more: add CXXFLAGS
ESMF_F90COMPILEFREECPP_CMD = $(ESMF_F90COMPILER) -c $(ESMF_F90COMPILEOPTS) \
			     $(ESMF_F90COMPILEPATHSLOCAL) $(ESMF_F90COMPILEPATHS) \
			     $(ESMF_F90COMPILEFREECPP) $(ESMF_F90COMPILECPPFLAGS)
ESMF_F90COMPILEFREENOCPP_CMD = $(ESMF_F90COMPILER) -c $(ESMF_F90COMPILEOPTS) \
			       $(ESMF_F90COMPILEPATHSLOCAL) $(ESMF_F90COMPILEPATHS) \
			       $(ESMF_F90COMPILEFREENOCPP)
ESMF_F90COMPILEFIXCPP_CMD = $(ESMF_F90COMPILER) -c $(ESMF_F90COMPILEOPTS) \
			    $(ESMF_F90COMPILEPATHSLOCAL) $(ESMF_F90COMPILEPATHS) \
			    $(ESMF_F90COMPILEFIXCPP) $(ESMF_F90COMPILECPPFLAGS)
ESMF_F90COMPILEFIXNOCPP_CMD = $(ESMF_F90COMPILER) -c $(ESMF_F90COMPILEOPTS) \
			      $(ESMF_F90COMPILEPATHSLOCAL) $(ESMF_F90COMPILEPATHS) \
			      $(ESMF_F90COMPILEFIXNOCPP)
ESMF_CXXCOMPILE_CMD = $(ESMF_CXXCOMPILER) -c $(ESMF_CXXCOMPILEOPTS) \
		      $(ESMF_CXXCOMPILEPATHSLOCAL) $(ESMF_CXXCOMPILEPATHS) \
		      $(ESMF_CXXCOMPILECPPFLAGS)

ESMF_CCOMPILE_CMD = $(ESMF_CCOMPILER) -c $(ESMF_CCOMPILEOPTS) \
		      $(ESMF_CCOMPILEPATHSLOCAL) $(ESMF_CCOMPILEPATHS) \
		      $(ESMF_CCOMPILECPPFLAGS)

$(ESMF_OBJDIR)/%.o : %.F90
	$(ESMF_F90COMPILEFREECPP_CMD) $< $(ESMF_OBJOUT_OPTION)

$(ESMF_OBJDIR)/%.o : %.f90
	$(ESMF_F90COMPILEFREENOCPP_CMD) $< $(ESMF_OBJOUT_OPTION)

$(ESMF_OBJDIR)/%.o : %.F
	$(ESMF_F90COMPILEFIXCPP_CMD) $< $(ESMF_OBJOUT_OPTION)

$(ESMF_OBJDIR)/%.o : %.f
	$(ESMF_F90COMPILEFIXNOCPP_CMD) $< $(ESMF_OBJOUT_OPTION)

$(ESMF_OBJDIR)/%.o : %.c
	$(ESMF_CCOMPILE_CMD) $< $(ESMF_OBJOUT_OPTION)

$(ESMF_OBJDIR)/%.o : %.C
	$(ESMF_CXXCOMPILE_CMD) $< $(ESMF_OBJOUT_OPTION)

$(ESMF_OBJDIR)/%.o : %.cpp
	$(ESMF_CXXCOMPILE_CMD) $< $(ESMF_OBJOUT_OPTION)

$(ESMF_LOCOBJDIR)/%.o : %.F90
	$(MAKE) chkdir_locobj
	$(ESMF_F90COMPILEFREECPP_CMD) $< $(ESMF_OBJOUT_OPTION)

$(ESMF_LOCOBJDIR)/%.o : %.f90
	$(MAKE) chkdir_locobj
	$(ESMF_F90COMPILEFREENOCPP_CMD) $< $(ESMF_OBJOUT_OPTION)

$(ESMF_LOCOBJDIR)/%.o : %.F
	$(MAKE) chkdir_locobj
	$(ESMF_F90COMPILEFIXCPP_CMD) $< $(ESMF_OBJOUT_OPTION)

$(ESMF_LOCOBJDIR)/%.o : %.f
	$(MAKE) chkdir_locobj
	$(ESMF_F90COMPILEFIXNOCPP_CMD) $< $(ESMF_OBJOUT_OPTION)

$(ESMF_LOCOBJDIR)/%.o : %.c
	$(MAKE) chkdir_locobj
	$(ESMF_CCOMPILE_CMD) $< $(ESMF_OBJOUT_OPTION)

$(ESMF_LOCOBJDIR)/%.o : %.C
	$(MAKE) chkdir_locobj
	$(ESMF_CXXCOMPILE_CMD) $< $(ESMF_OBJOUT_OPTION)

$(ESMF_LOCOBJDIR)/%.o : %.cpp
	$(MAKE) chkdir_locobj
	$(ESMF_CXXCOMPILE_CMD) $< $(ESMF_OBJOUT_OPTION)

.F90.o:
	$(ESMF_F90COMPILEFREECPP_CMD) $< $(ESMF_OBJOUT_OPTION)

.f90.o:
	$(ESMF_F90COMPILEFREENOCPP_CMD) $<

.F.o:
	$(ESMF_F90COMPILEFIXCPP_CMD) $<

.f.o:
	$(ESMF_F90COMPILEFIXNOCPP_CMD) $<

.c.o:
	$(ESMF_CCOMPILE_CMD) $<

.C.o:
	$(ESMF_CXXCOMPILE_CMD) $< $(ESMF_OBJOUT_OPTION)

.cpp.o:
	$(ESMF_CXXCOMPILE_CMD) $< $(ESMF_OBJOUT_OPTION)

.F90.$(ESMF_SL_SUFFIX):
	$(ESMF_F90COMPILEFREECPP_CMD) $(ESMF_SO_F90COMPILEOPTS) $<
	$(ESMF_F90LINKER) $(ESMF_SO_F90LINKOPTS) $(ESMF_F90LINKOPTS) $(ESMF_F90LINKPATHS) $(ESMF_F90LINKRPATHS) -o $@ $*.o $(ESMF_F90ESMFLINKLIBS)

.F90.$(ESMF_LIB_SUFFIX):
	$(ESMF_F90COMPILEFREECPP_CMD) $<
	$(ESMF_AR) $(ESMF_ARCREATEFLAGS) $(ESMF_ARCREATEPREFIX)$(LIBNAME) $*.o
	$(ESMF_RM) $*.o

.f90.$(ESMF_LIB_SUFFIX):
	$(ESMF_F90COMPILEFREENOCPP_CMD) $<
	$(ESMF_AR) $(ESMF_ARCREATEFLAGS) $(ESMF_ARCREATEPREFIX)$(LIBNAME) $*.o
	$(ESMF_RM) $*.o

.F.$(ESMF_LIB_SUFFIX):
	$(ESMF_F90COMPILEFIXCPP_CMD) $<
	$(ESMF_AR) $(ESMF_ARCREATEFLAGS) $(ESMF_ARCREATEPREFIX)$(LIBNAME) $*.o
	$(ESMF_RM) $*.o

.f.$(ESMF_LIB_SUFFIX):
	$(ESMF_F90COMPILEFIXNOCPP_CMD) $<
	$(ESMF_AR) $(ESMF_ARCREATEFLAGS) $(ESMF_ARCREATEPREFIX)$(LIBNAME) $*.o
	$(ESMF_RM) $*.o

.c.$(ESMF_LIB_SUFFIX):
	$(ESMF_CCOMPILE_CMD) $<
	$(ESMF_AR) $(ESMF_ARCREATEFLAGS) $(ESMF_ARCREATEPREFIX)$(LIBNAME) $*.o
	$(ESMF_RM) $*.o

.C.$(ESMF_LIB_SUFFIX):
	$(ESMF_CXXCOMPILE_CMD) $<
	$(ESMF_AR) $(ESMF_ARCREATEFLAGS) $(ESMF_ARCREATEPREFIX)$(LIBNAME) $*.o
	$(ESMF_RM) $*.o

# The rules below generate a valid Fortran file using gcc for the first stage
# of preprocessing.  The 'tr' command substitutes one-for-one, translating:
#   @ into newline to separate lines in multiline macros (the output
#     of the preprocessor is a single line which must be separated again)
#   ^ into # so that other preprocessor commands are ready to be processed by
#     the second runthrough of the preprocessor during the actual compile
#     (These lines are: ^include "fred.h" in the original source to shield
#     them from the first preprocess pass.)
#   | into ' to be able to use single apostrophes in comments.
# The 'sed' command removes any lines which start #pragma GCC . These are
# generated by a couple versions of gcc and confuse the fortran compiler when
# trying to compile the newly generated file.
# The dir, notdir macros below are to be sure to create the .F90 file in the
# original source directory, since the makefile has already changed dirs into
# the mod dir to build.

ifeq ($(origin ESMF_CPPRULES),undefined)
.cppF90.F90:
	$(ESMF_CPP) -I$(ESMF_INCDIR) $< | tr "@^|" "\n#'" | $(ESMF_SED) -e '/^#pragma GCC/d' > $(dir $<)$(notdir $@)
endif


#-------------------------------------------------------------------------------
#  Build shared library from regular archive
#
#     On systems where we know how to build shared libraries we go and do it. On
#     those systems where we do not know how to build shared libraries the
#     ESMF_SL_LIBS_TO_MAKE must be blanked out in the platform specific
#     build_rules.mk file, which will essentially turn the "shared" target below
#     into a noop.
#
#     We are building two shared ESMF libraries:
#       - libesmf.so
#       - libesmf_fullylinked.so
#
#     The "libesmf.so" only links in the bare minimum. Its purpose is to be
#     linked into an executable, i.e. there is one more linking step that will
#     ensure that all symbols are satisfied in the final executable. Prelinking
#     libesmf.so with only the minimum of libraries has these advantages:
#       1) It does NOT require that all of the dependency libraries are
#          available in position-independent-code (PIC) format.
#       2) It allows maximum flexibility in the final linking step, e.g.
#          a backward compatible version of a library may be chosen by the
#          executable.
#       3) It leads to greater symmetry between linking an executable against
#          the static library (or archive) version, libesmf.a, and libesmf.so.
#
#     The "libesmf_fullylinked.so" version links in everything that would be
#     specified in the final link step when building an executable. This
#     produces a fully self-contained shared library, which has the advantage
#     of being suitable to be loaded e.g. by the Python layer on top of ESMF.
#     However, it does require that ALL dependencies, including all of the
#     3rd party libraries that are specified, MUST be available as
#     position-independent-code (PIC). This can be difficult to ensure.
#
#-------------------------------------------------------------------------------
shared:
	@if [ "$(ESMF_SL_LIBS_TO_MAKE)" != "" ] ; then \
		echo making shared libraries in $(ESMF_LDIR); \
		cd $(ESMF_LDIR) ; \
		$(ESMF_RM) -r tmp_* ; \
		for NEXTLIB in $(ESMF_SL_LIBS_TO_MAKE) foo ;\
		do \
		if [ -f $$NEXTLIB.$(ESMF_LIB_SUFFIX) ] ; then \
		    $(ESMF_RM) $$NEXTLIB.$(ESMF_SL_SUFFIX) ; \
		    echo Converting $$NEXTLIB.a to $$NEXTLIB.$(ESMF_SL_SUFFIX) ;\
		    mkdir tmp_$$NEXTLIB ;\
		    cd tmp_$$NEXTLIB  ;\
	                $(ESMF_AREXTRACT) ../$$NEXTLIB.$(ESMF_LIB_SUFFIX) ;\
                    echo $(ESMF_SL_LIBLINKER) $(ESMF_SL_LIBOPTS) -o $(ESMF_LDIR)/$$NEXTLIB.$(ESMF_SL_SUFFIX) *.o $(ESMF_SL_LIBLIBS) ;\
		    $(ESMF_SL_LIBLINKER) $(ESMF_SL_LIBOPTS) -o $(ESMF_LDIR)/$$NEXTLIB.$(ESMF_SL_SUFFIX) *.o $(ESMF_SL_LIBLIBS) ;\
		    echo Converting $$NEXTLIB.$(ESMF_SL_SUFFIX) to $$NEXTLIB\_fullylinked.$(ESMF_SL_SUFFIX) ;\
                    echo $(ESMF_SL_LIBLINKER) $(ESMF_SL_LIBOPTS) -o $(ESMF_LDIR)/$$NEXTLIB\_fullylinked.$(ESMF_SL_SUFFIX) *.o $(ESMF_CXXLINKOPTS) $(ESMF_CXXLINKPATHS) $(ESMF_CXXLINKRPATHS) $(ESMF_CXXLINKLIBS) ;\
		    $(ESMF_SL_LIBLINKER) $(ESMF_SL_LIBOPTS) -o $(ESMF_LDIR)/$$NEXTLIB\_fullylinked.$(ESMF_SL_SUFFIX) *.o $(ESMF_CXXLINKOPTS) $(ESMF_CXXLINKPATHS) $(ESMF_CXXLINKRPATHS) $(ESMF_CXXLINKLIBS) ;\
		    cd .. ;\
		    $(ESMF_RM) -r tmp_$$NEXTLIB ;\
		fi ;\
		done ; \
	fi


#-------------------------------------------------------------------------------
#  Build (deferred) static library from all objects
#-------------------------------------------------------------------------------
defer:
ifeq ($(ESMF_OS),MinGW)
	cd $(ESMF_OBJDIR) ; \
	$(ESMF_AR) $(ESMF_ARCREATEFLAGS) $(ESMF_ARCREATEPREFIX)`$(ESMF_DIR)/scripts/path_mingw2win $(ESMFLIB)` \
		$(notdir $(wildcard $(ESMF_OBJDIR)/*.o))
else
	cd $(ESMF_OBJDIR) ; \
	$(ESMF_AR) $(ESMF_ARCREATEFLAGS) $(ESMFLIB) \
		$(notdir $(wildcard $(ESMF_OBJDIR)/*.o))
endif


#-------------------------------------------------------------------------------
# Pattern rules for making Tex files using protex script.  Input to
# protex script is Fortran, C or .h source code.
#-------------------------------------------------------------------------------

%_fapi.tex : $(TEXFILES_TO_MAKE_XDIR)/interface/%.F90
	export PROTEX=$(PROTEX) ;\
	$(F_PROTEX) $* $<

%_fapi.tex : ../src/%.F
	export PROTEX=$(PROTEX) ;\
	$(F_PROTEX) $* $<

%_fapi.tex : ../src/%.F90
	export PROTEX=$(PROTEX) ;\
	$(F_PROTEX) $* $<

%_fapi.tex : ../src/%.f
	export PROTEX=$(PROTEX) ;\
	$(F_PROTEX) $* $<

%_fapi.tex : ../src/%.f90
	export PROTEX=$(PROTEX) ;\
	$(F_PROTEX) $* $<

%_fapi.tex : ../interface/%.F
	export PROTEX=$(PROTEX) ;\
	$(F_PROTEX) $* $<

%_fapi.tex : ../interface/%.F90
	export PROTEX=$(PROTEX) ;\
	$(F_PROTEX) $* $<

%_fapi.tex : ../interface/%.f
	export PROTEX=$(PROTEX) ;\
	$(F_PROTEX) $* $<

%_fapi.tex : ../interface/%.f90
	export PROTEX=$(PROTEX) ;\
	$(F_PROTEX) $* $<

%_chapi.tex : ../include/%.h
	export PROTEX=$(PROTEX) ;\
	$(CH_PROTEX) $* $<

%_chapi.tex : ../include/%.inc
	export PROTEX=$(PROTEX) ;\
	$(CH_PROTEX) $* $<

%_ccapi.tex : ../src/%.C
	export PROTEX=$(PROTEX) ;\
	$(CC_PROTEX) $* $<

%_ccapi.tex : ../interface/%.C
	export PROTEX=$(PROTEX) ;\
	$(CC_PROTEX) $* $<

%_fapi.tex : ../examples/%.F
	export PROTEX=$(PROTEX) ;\
	$(F_PROTEX) $* $<

%_fapi.tex : ../examples/%.F90
	export PROTEX=$(PROTEX) ;\
	$(F_PROTEX) $* $<

%_fapi.tex : ../examples/%.f
	export PROTEX=$(PROTEX) ;\
	$(F_PROTEX) $* $<

%_fapi.tex : ../examples/%.f90
	export PROTEX=$(PROTEX) ;\
	$(F_PROTEX) $* $<

%_ccapi.tex : ../examples/%.C
	export PROTEX=$(PROTEX) ;\
	$(CC_PROTEX) $* $<

%_fapi.tex : $(TEXFILES_TO_MAKE_XDIR)/src/%.F
	export PROTEX=$(PROTEX) ;\
	$(F_PROTEX) $* $<

%_fapi.tex : $(TEXFILES_TO_MAKE_XDIR)/src/%.F90
	export PROTEX=$(PROTEX) ;\
	$(F_PROTEX) $* $<

%_fapi.tex : $(TEXFILES_TO_MAKE_XDIR)/src/%.f
	export PROTEX=$(PROTEX) ;\
	$(F_PROTEX) $* $<

%_fapi.tex : $(TEXFILES_TO_MAKE_XDIR)/src/%.f90
	export PROTEX=$(PROTEX) ;\
	$(F_PROTEX) $* $<

%_fapi.tex : $(TEXFILES_TO_MAKE_XDIR)/interface/%.F
	export PROTEX=$(PROTEX) ;\
	$(F_PROTEX) $* $<

%_fapi.tex : $(TEXFILES_TO_MAKE_XDIR)/interface/%.F90
	export PROTEX=$(PROTEX) ;\
	$(F_PROTEX) $* $<

%_fapi.tex : $(TEXFILES_TO_MAKE_XDIR)/interface/%.f
	export PROTEX=$(PROTEX) ;\
	$(F_PROTEX) $* $<

%_fapi.tex : $(TEXFILES_TO_MAKE_XDIR)/interface/%.f90
	export PROTEX=$(PROTEX) ;\
	$(F_PROTEX) $* $<

%_chapi.tex : $(TEXFILES_TO_MAKE_XDIR)/include/%.h
	export PROTEX=$(PROTEX) ;\
	$(CH_PROTEX) $* $<

%_chapi.tex : $(TEXFILES_TO_MAKE_XDIR)/include/%.inc
	export PROTEX=$(PROTEX) ;\
	$(CH_PROTEX) $* $<

%_ccapi.tex : $(TEXFILES_TO_MAKE_XDIR)/src/%.C
	export PROTEX=$(PROTEX) ;\
	$(CC_PROTEX) $* $<

%_ccapi.tex : $(TEXFILES_TO_MAKE_XDIR)/interface/%.C
	export PROTEX=$(PROTEX) ;\
	$(CC_PROTEX) $* $<

%_fapi.tex : $(TEXFILES_TO_MAKE_XDIR)/examples/%.F
	export PROTEX=$(PROTEX) ;\
	$(F_PROTEX) $* $<

%_fapi.tex : $(TEXFILES_TO_MAKE_XDIR)/examples/%.F90
	export PROTEX=$(PROTEX) ;\
	$(F_PROTEX) $* $<

%_fapi.tex : $(TEXFILES_TO_MAKE_XDIR)/examples/%.f
	export PROTEX=$(PROTEX) ;\
	$(F_PROTEX) $* $<

%_fapi.tex : $(TEXFILES_TO_MAKE_XDIR)/examples/%.f90
	export PROTEX=$(PROTEX) ;\
	$(F_PROTEX) $* $<

%_ccapi.tex : $(TEXFILES_TO_MAKE_XDIR)/examples/%.C
	export PROTEX=$(PROTEX) ;\
	$(CC_PROTEX) $* $<

# special for the AppDriver dir.
%SeqPrF_fapi.tex : ../seq_pairwise_fdriver_spmd/%.F90
	export PROTEX=$(PROTEX) ;\
	$(F_PROTEX) $* $< SeqPrF



#-------------------------------------------------------------------------------
# Pattern rules for making dvi, pdf and html files.
#-------------------------------------------------------------------------------

# The variable TEXINPUTS_VALUE can be set in the makefiles of the
# source code tree to list the directory paths of the .tex and
# graphics files included by .tex sources files.  The paths listed in
# TEXINPUTS_VALUE should be colon separated.  If TEXINPUTS_VALUE is
# set, then the first path should a period for the local directory.  A
# colon should trail the last path listed. If TEXINPUTS_VALUE is not
# set, then only files in the local directory will be found by the
# \input and \includegraphics LaTeX commands.
#

TEXINPUTS_VALUE = ".:$(ESMF_DIR)/src/doc:$(ESMF_BUILD_DOCDIR):"
export TEXINPUTS_VALUE


#-------------------------------------------------------------------------------
#  dvi rules
#-------------------------------------------------------------------------------

%_refdoc.dvi : %_refdoc.ctex $(REFDOC_DEP_FILES)
	@echo "========================================="
	@echo "_refdoc.dvi rule from common.mk"
	@echo "========================================="
	export TEXINPUTS=$(TEXINPUTS_VALUE) ;\
	$(DO_LATEX) $* ref

%_crefdoc.dvi : %_crefdoc.ctex $(REFDOC_DEP_FILES)
	@echo "========================================="
	@echo "_crefdoc.dvi rule from common.mk"
	@echo "========================================="
	export TEXINPUTS=$(TEXINPUTS_VALUE) ;\
	$(DO_LATEX) $* cref

#-------------------------------------------------------------------------------
#  pdf rules
#-------------------------------------------------------------------------------

$(ESMF_DOCDIR)/%.pdf: %.dvi
	@echo "========================================="
	@echo "ESMF_DOCDIR %pdf from %.dvi rule from common.mk"
	@echo "========================================="
	export TEXINPUTS=$(TEXINPUTS_VALUE) ;\
	dvipdf $< $@

%.pdf: %.dvi
	@echo "========================================="
	@echo "%pdf from %.dvi rule from common.mk"
	@echo "========================================="
	export TEXINPUTS=$(TEXINPUTS_VALUE) ;\
	dvipdf $< $@

#-------------------------------------------------------------------------------
#  html rules
#-------------------------------------------------------------------------------

$(ESMF_DOCDIR)/%_refdoc: %_refdoc.ctex $(REFDOC_DEP_FILES)
	@echo "========================================="
	@echo "ESMF_DOCDIR _refdoc html rule from common.mk"
	@echo "========================================="
	@if [ $(TEXINPUTS_VALUE)foo != foo ] ; then \
	  echo '$$TEXINPUTS = $(TEXINPUTS_VALUE)' > .latex2html-init ;\
	fi;
	$(DO_L2H) $* ref
	$(ESMF_RM) .latex2html-init
	$(ESMF_MV) $(@F) $(ESMF_DOCDIR)

$(ESMF_DOCDIR)/%_crefdoc: %_crefdoc.ctex $(REFDOC_DEP_FILES)
	@echo "========================================="
	@echo "ESMF_DOCDIR _crefdoc html rule from common.mk"
	@echo "========================================="
	@if [ $(TEXINPUTS_VALUE)foo != foo ] ; then \
	  echo '$$TEXINPUTS = $(TEXINPUTS_VALUE)' > .latex2html-init ;\
	fi;
	$(DO_L2H) $* cref
	$(ESMF_RM) .latex2html-init
	$(ESMF_MV) $(@F) $(ESMF_DOCDIR)

%_refdoc: %_refdoc.ctex $(REFDOC_DEP_FILES)
	@echo "========================================="
	@echo "_refdoc html rule from common.mk"
	@echo "========================================="
	@if [ $(TEXINPUTS_VALUE)foo != foo ] ; then \
	  echo '$$TEXINPUTS = $(TEXINPUTS_VALUE)' > .latex2html-init ;\
	fi;
	$(DO_L2H) $* ref
	$(ESMF_RM) .latex2html-init

%_crefdoc: %_crefdoc.ctex $(REFDOC_DEP_FILES)
	@echo "========================================="
	@echo "_crefdoc html rule from common.mk"
	@echo "========================================="
	@if [ $(TEXINPUTS_VALUE)foo != foo ] ; then \
	  echo '$$TEXINPUTS = $(TEXINPUTS_VALUE)' > .latex2html-init ;\
	fi;
	$(DO_L2H) $* cref
	$(ESMF_RM) .latex2html-init

#-------------------------------------------------------------------------------
#  These rules are for compiling the test examples.
#-------------------------------------------------------------------------------
.cc.rm .C.rm .F.rm .f.rm .c.rm:
	-@$(ESMF_RM) $* *.o *.$(ESMF_SL_SUFFIX) $*.mon.* gmon.out mon.out


#-------------------------------------------------------------------------------
# Keep .o and .$(ESMF_SL_SUFFIX) files
#-------------------------------------------------------------------------------
.PRECIOUS: %.o %.$(ESMF_SL_SUFFIX) $(addprefix $(ESMF_LOCOBJDIR)/,$(APPS_OBJ))


#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
# This section is for automatic generation of dependencies.
#
# During the tree_include phase the files defined by the SOURCE[CF] variables
# in the class local makefile are parsed for module and include dependencies.
# Only the include dependencies that are local (i.e., defined by SOURCEH or
# located in ../include) are kept in the dependency list.  The dependencies
# are written to a class local makefile fragment that is included (if it exists)
# in the top-level makefile.
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
# Class local dependency makefile fragment
ifeq ($(ESMF_DEFER_LIB_BUILD),ON)
  # Uniquely named file generated in ESMF_OBJDIR directory
  LOCAL_DEPEND_FILE = $(ESMF_OBJDIR)/$(subst /,_,$(LOCDIR))_depend.mk
else
  # Commonly named file generated in LOCDIR directory
  LOCAL_DEPEND_FILE = $(ESMF_DIR)/$(LOCDIR)/depend.mk
  CLEAN_DEFAULTS += $(LOCAL_DEPEND_FILE)
endif

# Function for extracting an ESMF module dependency list from a Fortran source
# file.  It is assumed that the module name occurs on the same line as the use
# keyword.  Multiple use statements on the same line are not recognized.
define MOD_FUNC
$(filter-out $(addsuffix .o,$(basename $(1))), \
 $(subst ESMF_.o,ESMF.o, \
  $(sort \
   $(addsuffix .o, \
      $(shell awk  '/^ *use  *ESMF_/' $(1) \
            | sed 's/^ *use  *ESMF_/ESMF_/' \
            | sed 's/Mod.*$$//' \
       ) \
      $(shell awk  '/^ *use  *NUOPC/' $(1) \
            | sed 's/^ *use  *NUOPC/NUOPC/' \
            | sed 's/,.*$$//' \
       ) \
      $(shell awk  '/^ *use  *pio/' $(1) \
            | sed 's/^ *use  *pio/pio/' \
            | sed 's/,.*$$//' \
       ) \
     ) \
   ) \
  ) \
 )
endef

# Function for extracting an include dependency list.
# - paths are stripped from include file names
define INC_FUNC
$(notdir $(sort \
  $(shell awk  '/^ *[#\^] *include *["<]/' $(1) \
        | sed 's/^ *[#\^] *include *["<]//' \
        | sed 's/[">].*$$//' \
   ) \
 ))
endef

# Function for generating the dependency list for a regular Fortran source file.
# - filter include dependencies for local files
ifeq ($(ESMF_DEFER_LIB_BUILD),ON)
  define SOURCEF_DEPEND_FUNC
  $(addprefix $(ESMF_OBJDIR)/,$(addsuffix .o,$(basename $(1)))) : \
	$(addprefix $(ESMF_OBJDIR)/,$(call MOD_FUNC,$(1))) \
	$(filter $(LOCAL_INCLUDE_FILES),$(call INC_FUNC,$(1)))
  endef
else
  define SOURCEF_DEPEND_FUNC
  $(addsuffix .o,$(basename $(1))) : \
	$(call MOD_FUNC,$(1)) \
	$(filter $(LOCAL_INCLUDE_FILES),$(call INC_FUNC,$(1)))
  endef
endif

# Function for generating the dependency list for an autogen Fortran source file.
# - the autogenerated file is included in the prerequisite list
# - filter include dependencies for local files
ifeq ($(ESMF_DEFER_LIB_BUILD),ON)
  define AUTOGEN_DEPEND_FUNC
  $(addprefix $(ESMF_OBJDIR)/,$(addsuffix .o,$(basename $(1)))) : $(1) \
	$(addprefix $(ESMF_OBJDIR)/,$(call MOD_FUNC,$(1))) \
	$(filter $(LOCAL_INCLUDE_FILES),$(call INC_FUNC,$(1)))
  endef
else
  define AUTOGEN_DEPEND_FUNC
  $(addsuffix .o,$(basename $(1))) : $(1) \
	$(call MOD_FUNC,$(1)) \
	$(filter $(LOCAL_INCLUDE_FILES),$(call INC_FUNC,$(1)))
  endef
endif

# Function for generating the dependency list for a C/C++ source file.
# - filter include dependencies for local files
ifeq ($(ESMF_DEFER_LIB_BUILD),ON)
  define SOURCEC_DEPEND_FUNC
  $(addprefix $(ESMF_OBJDIR)/,$(addsuffix .o,$(basename $(1)))) : \
	$(filter $(LOCAL_INCLUDE_FILES),$(call INC_FUNC,$(1)))
  endef
else
  define SOURCEC_DEPEND_FUNC
  $(addsuffix .o,$(basename $(1))) : \
	$(filter $(LOCAL_INCLUDE_FILES),$(call INC_FUNC,$(1)))
  endef
endif

# Generate local dependency file during tree_include action
# - if SOURCEF or SOURCEC are non-empty
# - define LOCAL_INCLUDE_FILES based on SOURCEH and ../include
# - Fortran autogen source files are assumed to be named with the .cppF90 suffix
ifneq (,$(findstring tree_include,"$(ACTION)"))
  ifneq (,$(strip $(SOURCEF) $(SOURCEC)))
    LOCAL_INCLUDE_FILES = $(strip $(SOURCEH) $(notdir $(wildcard ../include/*)))
    $(foreach f,$(filter-out $(AUTOGEN),$(SOURCEF)),\
      $(shell echo '$(call SOURCEF_DEPEND_FUNC,$(f))' >> $(LOCAL_DEPEND_FILE)))
    $(foreach f,$(addsuffix .cppF90,$(basename $(AUTOGEN))),\
      $(shell echo '$(call AUTOGEN_DEPEND_FUNC,$(f))' >> $(LOCAL_DEPEND_FILE)))
    $(foreach f,$(SOURCEC),\
      $(shell echo '$(call SOURCEC_DEPEND_FUNC,$(f))' >> $(LOCAL_DEPEND_FILE)))
  endif
endif
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
