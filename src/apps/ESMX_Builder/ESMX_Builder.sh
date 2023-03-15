#!/bin/bash -e

# usage instructions
usage () {
  printf "\n"
  printf "Usage: $0 [OPTIONS]... ESMX_BUILD_FILE\n"
  printf "\n"
  printf "ARGUMENTS\n"
  printf "  ESMX_BUILD_FILE\n"
  printf "      ESMX build configuration file\n"
  printf "      (default: esmxBuild.yaml)\n"
  printf "\n"
  printf "OPTIONS\n"
  printf "  --esmx-dir=ESMF_ESMXDIR\n"
  printf "      ESMX source directory\n"
  printf "      (default: use ESMF_ESMXDIR in ESMFMKFILE)\n"
  printf "  --esmfmkfile=ESMFMKFILE\n"
  printf "      ESMF makefile fragment\n"
  printf "      (default: use environment)\n"
  printf "  --build-dir=BUILD_DIR\n"
  printf "      build directory\n"
  printf "      (default: build)\n"
  printf "  --prefix=INSTALL_PREFIX\n"
  printf "      installation prefix\n"
  printf "      (default: install)\n"
  printf "  --build-type=BUILD_TYPE\n"
  printf "      build type; valid options are 'debug', 'release',\n"
  printf "      'relWithDebInfo'\n"
  printf "      (default: release)\n"
  printf "  --build-args=BUILD_ARGS\n"
  printf "      cmake arguments (e.g. -DARG=VAL)\n"
  printf "  --jobs=JOBS\n"
  printf "      number of jobs used for building esmx and components\n"
  printf "  --load-modulefile=MODULEFILE\n"
  printf "      load modulefile before building\n"
  printf "  --load-bashenv=BASHENV\n"
  printf "      load bash environment file before building\n"
  printf "  --verbose, -v\n"
  printf "      build with verbose output\n"
  printf "\n"
}

# print settings
settings () {
  printf "Settings:\n"
  printf "\n"
  printf "  ESMX_BUILD_FILE=${ESMX_BUILD_FILE}\n"
  printf "  ESMF_ESMXDIR=${ESMF_ESMXDIR}\n"
  printf "  ESMFMKFILE=${ESMFMKFILE}\n"
  printf "  BUILD_DIR=${BUILD_DIR}\n"
  printf "  INSTALL_PREFIX=${INSTALL_PREFIX}\n"
  printf "  BUILD_TYPE=${BUILD_TYPE}\n"
  printf "  BUILD_ARGS=${BUILD_ARGS}\n"
  printf "  JOBS=${JOBS}\n"
  printf "  MODULEFILE=${MODULEFILE}\n"
  printf "  BASHENV=${BASHENV}\n"
  printf "  VERBOSE=${VERBOSE}\n"
  printf "\n"
}

# default settings
CWD="${PWD}"
ESMFMKFILE="${ESMFMKFILE:-esmf.mk}"
ESMX_BUILD_FILE="esmxBuild.yaml"
ESMF_ESMXDIR=""
BUILD_TYPE="release"
BUILD_ARGS=""
JOBS=""
BUILD_DIR="${CWD}/build"
INSTALL_PREFIX="${CWD}/install"
MODULEFILE=""
BASHENV=""
VERBOSE=false

# required arguments
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
  usage
  exit 0
fi

# process arguments
POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
  case $1 in
    --help|-h) usage; exit 0 ;;
    --esmx-dir=?*) ESMF_ESMXDIR=${1#*=} ;;
    --esmx-dir) printf "ERROR: $1 requires an argument.\n"; usage; exit 1 ;;
    --esmx-dir=) printf "ERROR: $1 requires an argument.\n"; usage; exit 1 ;;
    --esmfmkfile=?*) ESMFMKFILE=${1#*=} ;;
    --esmfmkfile) printf "ERROR: $1 requires an argument.\n"; usage; exit 1 ;;
    --esmfmkfile=) printf "ERROR: $1 requires an argument.\n"; usage; exit 1 ;;
    --build-dir=?*) BUILD_DIR=${1#*=} ;;
    --build-dir) printf "ERROR: $1 requires an argument.\n"; usage; exit 1 ;;
    --build-dir=) printf "ERROR: $1 requires an argument.\n"; usage; exit 1 ;;
    --prefix=?*) INSTALL_PREFIX=${1#*=} ;;
    --prefix) printf "ERROR: $1 requires an argument.\n"; usage; exit 1 ;;
    --prefix=) printf "ERROR: $1 requires an argument.\n"; usage; exit 1 ;;
    --build-type=?*) BUILD_TYPE=${1#*=} ;;
    --build-type) printf "ERROR: $1 requires an argument.\n"; usage; exit 1 ;;
    --build-type=) printf "ERROR: $1 requires an argument.\n"; usage; exit 1 ;;
    --build-args=?*) BUILD_ARGS=${1#*=} ;;
    --build-args) printf "ERROR: $1 requires an argument.\n"; usage; exit 1 ;;
    --build-args=) printf "ERROR: $1 requires an argument.\n"; usage; exit 1 ;;
    --jobs=?*) JOBS=${1#*=} ;;
    --jobs) printf "ERROR: $1 requires an argument.\n"; usage; exit 1 ;;
    --jobs=) printf "ERROR: $1 requires an argument.\n"; usage; exit 1 ;;
    --load-modulefile=?*) MODULEFILE=${1#*=} ;;
    --load-modulefile) printf "ERROR: $1 requires an argument.\n"; usage; exit 1 ;;
    --load-modulefile=) printf "ERROR: $1 requires an argument.\n"; usage; exit 1 ;;
    --load-bashenv=?*) BASHENV=${1#*=} ;;
    --load-bashenv) printf "ERROR: $1 requires an argument.\n"; usage; exit 1 ;;
    --load-bashenv=) printf "ERROR: $1 requires an argument.\n"; usage; exit 1 ;;
    --verbose|-v) VERBOSE=true ;;
    --verbose=?*) printf "ERROR: $1 argument ignored.\n"; usage; exit 1 ;;
    --verbose=) printf "ERROR: $1 argument ignored.\n"; usage; exit 1 ;;
    -?*) printf "ERROR: Unknown option $1\n"; usage; exit 1 ;;
    *) POSITIONAL_ARGS+=("${1}") ;;
  esac
  shift
done
set -- "${POSITIONAL_ARGS[@]}"

set -eu

if [ ! -z "${MODULEFILE}" ] ; then
  if [ ! -f "${MODULEFILE}" ]; then
    printf "ERROR: MODULEFILE does not exist.\n"
    usage; exit 1 ;
  fi
  module use $(cd $(dirname ${MODULEFILE}) && pwd)
  module load $(basename ${MODULEFILE})
fi

if [ ! -z "${BASHENV}" ] ; then
  if [ ! -f "${BASHENV}" ]; then
    printf "ERROR: BASHENV does not exist.\n"
    usage; exit 1 ;
  fi
  source ${BASHENV}
fi

# read ESMX build file from positional arguments
if [[ $# -ge 1 ]]; then
  ESMX_BUILD_FILE="${1}"
else
  ESMX_BUILD_FILE="esmxBuild.yaml"
fi

# set ESMF_ESMXDIR using ESMFMKFILE
if [ -z ${ESMF_ESMXDIR} ]; then
  if [ ! -f "${ESMFMKFILE}" ]; then
    echo "ERROR: Cannot locate ESMX directory."
    usage; exit 1
  fi
  ESMF_ESMXDIR=`grep "ESMF_ESMXDIR" ${ESMFMKFILE} || true;`
  if [ -z ${ESMF_ESMXDIR} ]; then
    echo "ERROR: ESMF_ESMXDIR is not listed in ESMFMKFILE."
    echo "       Please check ESMF version"
    usage; exit 1
  fi
  ESMF_ESMXDIR=${ESMF_ESMXDIR#*=}
fi

# check ESMF_ESMXDIR
if [ ! -d "${ESMF_ESMXDIR}" ]; then
  echo "ERROR: ESMF_ESMXDIR directory is missing: ${ESMF_ESMXDIR}"
  usage; exit 1
fi

# check ESMX_BUILD_FILE
if [ ! -f "${ESMX_BUILD_FILE}" ]; then
  echo "ERROR: ESMX_BUILD_FILE is missing: ${ESMX_BUILD_FILE}"
  usage; exit 1
fi

# print settings
if [ "${VERBOSE}" = true ] ; then
  settings
fi

# cmake settings
CMAKE_SETTINGS=("")
if [ ! -z "${ESMX_BUILD_FILE}" ]; then
  CMAKE_SETTINGS+=("-DESMX_BUILD_FILE=${ESMX_BUILD_FILE}")
fi
if [ ! -z "${INSTALL_PREFIX}" ]; then
  CMAKE_SETTINGS+=("-DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX}")
fi
if [ ! -z "${BUILD_TYPE}" ]; then
  CMAKE_SETTINGS+=("-DCMAKE_BUILD_TYPE=${BUILD_TYPE}")
fi
if [ "${VERBOSE}" = true ]; then
  CMAKE_SETTINGS+=("-DVERBOSE=1")
fi
if [ ! -z "${JOBS}" ]; then
  CMAKE_SETTINGS+=("-DJOBS=${JOBS}")
fi
if [ ! -z "${BUILD_ARGS}" ]; then
  CMAKE_SETTINGS+=("${BUILD_ARGS}")
fi

# make settings
BUILD_SETTINGS=("")
if [ "${VERBOSE}" = true ]; then
  BUILD_SETTINGS+=("-v")
fi
if [ ! -z "${JOBS}" ]; then
  BUILD_SETTINGS+=("-j ${JOBS}")
fi

# install settings
INSTALL_SETTINGS=("")

# build and install
cmake -S${ESMF_ESMXDIR} -B${BUILD_DIR} ${CMAKE_SETTINGS[@]}
cmake --build ${BUILD_DIR} ${BUILD_SETTINGS[@]}
cmake --install ${BUILD_DIR} ${INSTALL_SETTINGS[@]}
