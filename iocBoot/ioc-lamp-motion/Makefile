IOC_TOP = /reg/g/pcds/epics/ioc/common/ads-ioc/R0.3.1

IOC_INSTANCE_PATH := $(shell pwd)

# Set PRODUCTION_IOC to 1 to move from a testing to a production IOC:
PRODUCTION_IOC := 1

PROJECT_NAME = plc-lamp-motion
PROJECT_PATH := ../../lcls-plc-lamp-motion/lcls-plc-lamp-motion.tsproj
PLC = lamp_motion

PYTMC_OPTS :=
PREFIX = PLC:LAMP:MOTION

include $(IOC_TOP)/iocBoot/templates/Makefile.base

