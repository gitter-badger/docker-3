#!/bin/bash

# Environment variables
#export PATH=${FEELPP_HOME}/bin:${PATH}
export LD_LIBRARY_PATH=${FEELPP_DEP_INSTALL_PREFIX}/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=${FEELPP_DEP_INSTALL_PREFIX}/lib/pkgconfig:$PKG_CONFIG_PATH
export PYTHONPATH=${FEELPP_DEP_INSTALL_PREFIX}/lib/python2.7/site-packages:${FEELPP_DEP_INSTALL_PREFIX}/lib/paraview-4.4/site-packages:$PYTHONPATH
export MANPATH=${FEELPP_DEP_INSTALL_PREFIX}/share/man:$MANPATH
