#!/bin/bash

# set feelpp home
export FEELPP_SRC_DIR=${HOME}/src
mkdir -p ${FEELPP_SRC_DIR}

export FEELPP_BUILD_DIR=${HOME}/build
mkdir -p ${FEELPP_BUILD_DIR}

export FEELPP_HOME=/usr/local
mkdir -p ${FEELPP_HOME}

export PATH=${FEELPP_HOME}/bin:${PATH}
export LD_LIBRARY_PATH=${FEELPP_HOME}/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=${FEELPP_HOME}/lib/pkgconfig:$PKG_CONFIG_PATH
export PYTHONPATH=${FEELPP_HOME}/lib/python2.7/site-packages:$PYTHONPATH
export MANPATH=${FEELPP_HOME}/share/man:$MANPATH

# bash functions
pull_feelpp ()
{
  echo "Pulling feelpp..."
  cd ${FEELPP_SRC_DIR}
  if [ -d feelpp ]
  then
	 cd feelpp
     git pull --depth 1 origin $1
  else
	 git clone --depth 1 https://www.github.com/feelpp/feelpp.git
     cd feelpp
     git pull --depth 1 origin $1
     git submodule update --init --recursive contrib/nlopt
     git submodule update --init --recursive quickstart
  fi
}
build_feelpp()
{
  echo "Building Feel++..."
  if [ -d ${FEELPP_SRC_DIR}/feelpp ]
  then
        # Get the number of jobs to be used
        NJOBS=$1
        shift
        # $* now contains possible additional cmake flags

        cd ${FEELPP_BUILD_DIR}
    	${FEELPP_SRC_DIR}/feelpp/configure -r --cmakeflags="-DFEELPP_ENABLE_VTK_INSITU=ON -DCMAKE_INSTALL_PREFIX=${FEELPP_HOME} $*"
        sudo make -j $NJOBS install-feelpp-lib
  else
	   echo "Feel++ source cannot be found. Please run pull_feelpp first."
  fi
}
clean_feelpp()
{
   rm -rf ${FEELPP_BUILD_DIR}
}
install_feelpp()
{
  if [[ $# -ge 1 ]]; then
      pull_feelpp $1
      shift 
  else
      pull_feelpp develop
  fi
  if [[ $# -ge 1 ]]; then
      build_feelpp $*
  else
      build_feelpp 16
  fi
  clean_feelpp
}
