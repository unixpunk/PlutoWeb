#!/bin/bash
export CROSS_COMPILE=arm-xilinx-linux-gnueabi-
export PATH=$PATH:/opt/Xilinx/SDK/2016.4/gnu/arm/lin/bin
export VIVADO_SETTINGS=/opt/Xilinx/Vivado/2016.4/settings64.sh
# Below is needed for Ubuntu 16.04
export SWT_GTK3=0
export DISPLAY=:0
