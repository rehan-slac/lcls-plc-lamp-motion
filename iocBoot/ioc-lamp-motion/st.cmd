#!/reg/g/pcds/epics/ioc/common/ads-ioc/R0.8.0/bin/rhel7-x86_64/adsIoc
################### AUTO-GENERATED DO NOT EDIT ###################
#
#         Project: lcls-plc-lamp-motion.tsproj
#        PLC name: lamp_motion (lamp_motion Instance)
# Generated using: pytmc 2.17.0
# Project version: 9931277
#    Project hash: 99312779b5115f1327964eb8eba6dcd762331ece
#     PLC IP/host: 172.21.132.58
#      PLC Net ID: 172.21.132.58.1.1
#  ** Production mode IOC **
#  Using /cds/data/iocData for autosave and archiver settings.
#
# Libraries:
#
#   LCLS General: * -> 2.12.0 (SLAC)
#   lcls-twincat-motion: * -> 4.2.0 (SLAC)
#   Tc2_MC2: * (Beckhoff Automation GmbH)
#   Tc2_Standard: * (Beckhoff Automation GmbH)
#   Tc2_System: * (Beckhoff Automation GmbH)
#   Tc2_Utilities: * (Beckhoff Automation GmbH)
#   Tc3_Module: * (Beckhoff Automation GmbH)
#
################### AUTO-GENERATED DO NOT EDIT ###################
< envPaths

epicsEnvSet("ADS_IOC_TOP", "$(TOP)" )

epicsEnvSet("ENGINEER", "rnazir" )
epicsEnvSet("LOCATION", "PLC:LAMP:MOTION" )
epicsEnvSet("IOCSH_PS1", "$(IOC)> " )
epicsEnvSet("ACF_FILE", "$(ADS_IOC_TOP)/iocBoot/templates/unrestricted.acf")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("$(ADS_IOC_TOP)/dbd/adsIoc.dbd")
adsIoc_registerRecordDeviceDriver(pdbbase)

epicsEnvSet("ASYN_PORT",        "ASYN_PLC")
epicsEnvSet("IPADDR",           "172.21.132.58")
epicsEnvSet("AMSID",            "172.21.132.58.1.1")
epicsEnvSet("AMS_PORT",         "851")
epicsEnvSet("ADS_MAX_PARAMS",   "1559")
epicsEnvSet("ADS_SAMPLE_MS",    "50")
epicsEnvSet("ADS_MAX_DELAY_MS", "100")
epicsEnvSet("ADS_TIMEOUT_MS",   "1000")
epicsEnvSet("ADS_TIME_SOURCE",  "0")

# Add a route to the PLC automatically:
system("${ADS_IOC_TOP}/scripts/add_route.sh 172.21.132.58 ^172.*")

# adsAsynPortDriverConfigure(portName, ipaddr, amsaddr, amsport,
#    asynParamTableSize, priority, noAutoConnect, defaultSampleTimeMS,
#    maxDelayTimeMS, adsTimeoutMS, defaultTimeSource)
# portName            Asyn port name
# ipAddr              IP address of PLC
# amsaddr             AMS Address of PLC
# amsport             Default AMS port in PLC (851 for first PLC)
# paramTableSize      Maximum parameter/variable count. (1000)
# priority            Asyn priority (0)
# noAutoConnect       Enable auto connect (0=enabled)
# defaultSampleTimeMS Default sample of variable (PLC ams router
#                     checks if variable changed, if changed then add to send buffer) (50ms)
# maxDelayTimeMS      Maximum delay before variable that has changed is sent to client
#                     (Linux). The variable can also be sent sooner if the ams router
#                     send buffer is filled (100ms)
# adsTimeoutMS        Timeout for adslib commands (1000ms)
# defaultTimeSource   Default time stamp source of changed variable (PLC=0):
#                     PLC=0: The PLC time stamp from when the value was
#                         changed is used and set as timestamp in the EPICS record
#                         (if record TSE field is set to -2=enable asyn timestamp).
#                         This is the preferred setting.
#                     EPICS=1: The time stamp will be made when the updated data
#                         arrives in the EPICS client.
adsAsynPortDriverConfigure("$(ASYN_PORT)", "$(IPADDR)", "$(AMSID)", "$(AMS_PORT)", "$(ADS_MAX_PARAMS)", 0, 0, "$(ADS_SAMPLE_MS)", "$(ADS_MAX_DELAY_MS)", "$(ADS_TIMEOUT_MS)", "$(ADS_TIME_SOURCE)")

cd "$(ADS_IOC_TOP)/db"


epicsEnvSet("MOTOR_PORT",     "PLC_ADS")
epicsEnvSet("PREFIX",         "PLC:LAMP:MOTION:")
epicsEnvSet("NUMAXES",        "16")
epicsEnvSet("MOVE_POLL_RATE", "200")
epicsEnvSet("IDLE_POLL_RATE", "1000")

EthercatMCCreateController("$(MOTOR_PORT)", "$(ASYN_PORT)", "$(NUMAXES)", "$(MOVE_POLL_RATE)", "$(IDLE_POLL_RATE)")

#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010
#define ASYN_TRACE_WARNING   0x0020
#define ASYN_TRACE_INFO      0x0040
asynSetTraceMask("$(ASYN_PORT)", -1, 0x41)

#define ASYN_TRACEIO_NODATA 0x0000
#define ASYN_TRACEIO_ASCII  0x0001
#define ASYN_TRACEIO_ESCAPE 0x0002
#define ASYN_TRACEIO_HEX    0x0004
asynSetTraceIOMask("$(ASYN_PORT)", -1, 2)

#define ASYN_TRACEINFO_TIME 0x0001
#define ASYN_TRACEINFO_PORT 0x0002
#define ASYN_TRACEINFO_SOURCE 0x0004
#define ASYN_TRACEINFO_THREAD 0x0008
asynSetTraceInfoMask("$(ASYN_PORT)", -1, 5)

#define AMPLIFIER_ON_FLAG_CREATE_AXIS  1
#define AMPLIFIER_ON_FLAG_WHEN_HOMING  2
#define AMPLIFIER_ON_FLAG_USING_CNEN   4

epicsEnvSet("AXIS_NO",         "1")
epicsEnvSet("MOTOR_PREFIX",    "TMO:LAMP:MMS:")
epicsEnvSet("MOTOR_NAME",      "01")
epicsEnvSet("DESC",            "Main.M1 / GasJetX")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "2")
epicsEnvSet("MOTOR_PREFIX",    "TMO:LAMP:MMS:")
epicsEnvSet("MOTOR_NAME",      "02")
epicsEnvSet("DESC",            "Main.M2 / GasJetY")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "3")
epicsEnvSet("MOTOR_PREFIX",    "TMO:LAMP:MMS:")
epicsEnvSet("MOTOR_NAME",      "03")
epicsEnvSet("DESC",            "Main.M3 / GasJetZ")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "4")
epicsEnvSet("MOTOR_PREFIX",    "TMO:LAMP:MMS:")
epicsEnvSet("MOTOR_NAME",      "04")
epicsEnvSet("DESC",            "Main.M4 / GasNeedleX")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "5")
epicsEnvSet("MOTOR_PREFIX",    "TMO:LAMP:MMS:")
epicsEnvSet("MOTOR_NAME",      "05")
epicsEnvSet("DESC",            "Main.M5 / GasNeedleY")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "6")
epicsEnvSet("MOTOR_PREFIX",    "TMO:LAMP:MMS:")
epicsEnvSet("MOTOR_NAME",      "06")
epicsEnvSet("DESC",            "Main.M6 / GasNeedleZ")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "7")
epicsEnvSet("MOTOR_PREFIX",    "TMO:LAMP:MMS:")
epicsEnvSet("MOTOR_NAME",      "07")
epicsEnvSet("DESC",            "Main.M7 / SamplePaddleX")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "8")
epicsEnvSet("MOTOR_PREFIX",    "TMO:LAMP:MMS:")
epicsEnvSet("MOTOR_NAME",      "08")
epicsEnvSet("DESC",            "Main.M8 / SamplePaddleY")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "9")
epicsEnvSet("MOTOR_PREFIX",    "TMO:LAMP:MMS:")
epicsEnvSet("MOTOR_NAME",      "09")
epicsEnvSet("DESC",            "Main.M9 / SamplePaddleZ")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "14")
epicsEnvSet("MOTOR_PREFIX",    "TMO:LAMP:MMS:")
epicsEnvSet("MOTOR_NAME",      "14")
epicsEnvSet("DESC",            "Main.M14 / TIXELX")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "15")
epicsEnvSet("MOTOR_PREFIX",    "TMO:LAMP:MMS:")
epicsEnvSet("MOTOR_NAME",      "15")
epicsEnvSet("DESC",            "Main.M15 / TIXELY")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")

epicsEnvSet("AXIS_NO",         "16")
epicsEnvSet("MOTOR_PREFIX",    "TMO:LAMP:MMS:")
epicsEnvSet("MOTOR_NAME",      "16")
epicsEnvSet("DESC",            "Main.M16 / TIXELZ")
epicsEnvSet("EGU",             "mm")
epicsEnvSet("PREC",            "3")
epicsEnvSet("AXISCONFIG",      "")
epicsEnvSet("ECAXISFIELDINIT", "")
epicsEnvSet("AMPLIFIER_FLAGS", "")

EthercatMCCreateAxis("$(MOTOR_PORT)", "$(AXIS_NO)", "$(AMPLIFIER_FLAGS)", "$(AXISCONFIG)")
dbLoadRecords("EthercatMC.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC), EGU=$(EGU) $(ECAXISFIELDINIT)")
dbLoadRecords("EthercatMCreadback.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), R=$(MOTOR_NAME)-, MOTOR_PORT=$(MOTOR_PORT), ASYN_PORT=$(ASYN_PORT), AXIS_NO=$(AXIS_NO), DESC=$(DESC), PREC=$(PREC) ")
dbLoadRecords("EthercatMCdebug.template", "PREFIX=$(MOTOR_PREFIX), MOTOR_NAME=$(MOTOR_NAME), MOTOR_PORT=$(MOTOR_PORT), AXIS_NO=$(AXIS_NO), PREC=3")


dbLoadRecords("iocSoft.db", "IOC=PLC:LAMP:MOTION")
dbLoadRecords("save_restoreStatus.db", "P=PLC:LAMP:MOTION:")
dbLoadRecords("caPutLog.db", "IOC=$(IOC)")

## TwinCAT task, application, and project information databases ##
dbLoadRecords("TwinCAT_TaskInfo.db", "PORT=$(ASYN_PORT),PREFIX=PLC:LAMP:MOTION,IDX=1,TASK_PORT=350")
dbLoadRecords("TwinCAT_AppInfo.db", "PORT=$(ASYN_PORT), PREFIX=PLC:LAMP:MOTION")

dbLoadRecords("TwinCAT_Project.db", "PREFIX=PLC:LAMP:MOTION,PROJECT=lcls-plc-lamp-motion.tsproj,HASH=9931277,VERSION=9931277,PYTMC=2.17.0,PLC_HOST=172.21.132.58")

#   LCLS General: * -> 2.12.0 (SLAC)
dbLoadRecords("TwinCAT_Dependency.db", "PREFIX=PLC:LAMP:MOTION,DEPENDENCY=LCLS_General,VERSION=2.12.0,VENDOR=SLAC")
#   lcls-twincat-motion: * -> 4.2.0 (SLAC)
dbLoadRecords("TwinCAT_Dependency.db", "PREFIX=PLC:LAMP:MOTION,DEPENDENCY=lcls-twincat-motion,VERSION=4.2.0,VENDOR=SLAC")
#   Tc2_MC2: * (Beckhoff Automation GmbH)
dbLoadRecords("TwinCAT_Dependency.db", "PREFIX=PLC:LAMP:MOTION,DEPENDENCY=Tc2_MC2,VERSION=*,VENDOR=Beckhoff Automation GmbH")
#   Tc2_Standard: * (Beckhoff Automation GmbH)
dbLoadRecords("TwinCAT_Dependency.db", "PREFIX=PLC:LAMP:MOTION,DEPENDENCY=Tc2_Standard,VERSION=*,VENDOR=Beckhoff Automation GmbH")
#   Tc2_System: * (Beckhoff Automation GmbH)
dbLoadRecords("TwinCAT_Dependency.db", "PREFIX=PLC:LAMP:MOTION,DEPENDENCY=Tc2_System,VERSION=*,VENDOR=Beckhoff Automation GmbH")
#   Tc2_Utilities: * (Beckhoff Automation GmbH)
dbLoadRecords("TwinCAT_Dependency.db", "PREFIX=PLC:LAMP:MOTION,DEPENDENCY=Tc2_Utilities,VERSION=*,VENDOR=Beckhoff Automation GmbH")
#   Tc3_Module: * (Beckhoff Automation GmbH)
dbLoadRecords("TwinCAT_Dependency.db", "PREFIX=PLC:LAMP:MOTION,DEPENDENCY=Tc3_Module,VERSION=*,VENDOR=Beckhoff Automation GmbH")

cd "$(IOC_TOP)"

## PLC Project Database files ##
dbLoadRecords("lamp_motion.db", "PORT=$(ASYN_PORT),PREFIX=PLC:LAMP:MOTION:,IOCNAME=$(IOC),IOC=$(IOC)")

# Total records: 559
callbackSetQueueSize(3118)

# Autosave and archive settings:
save_restoreSet_status_prefix("PLC:LAMP:MOTION:")
save_restoreSet_IncompleteSetsOk(1)
save_restoreSet_DatedBackupFiles(1)
set_pass0_restoreFile("info_positions.sav")
set_pass1_restoreFile("info_settings.sav")

# ** Production IOC Settings **
set_savefile_path("$(IOC_DATA)/$(IOC)/autosave")
set_requestfile_path("$(IOC_DATA)/$(IOC)/autosave")

# Production IOC autosave files go in iocData:
cd "$(IOC_DATA)/$(IOC)/autosave"

# Create info_positions.req and info_settings.req
makeAutosaveFiles()

cd "$(IOC_DATA)/$(IOC)/archive"

# Create $(IOC).archive
makeArchiveFromDbInfo("$(IOC).archive", "archive")
cd "$(IOC_TOP)"

# Configure access security: this is required for caPutLog.
asSetFilename("$(ACF_FILE)")

# Initialize the IOC and start processing records
iocInit()

# Enable logging
iocLogInit()

# Configure and start the caPutLogger after iocInit
epicsEnvSet(EPICS_AS_PUT_LOG_PV, "$(IOC):caPutLog:Last")

# caPutLogInit("HOST:PORT", config)
# config options:
#       caPutLogNone       -1: no logging (disable)
#       caPutLogOnChange    0: log only on value change
#       caPutLogAll         1: log all puts
#       caPutLogAllNoFilter 2: log all puts no filtering on same PV
caPutLogInit("$(EPICS_CAPUTLOG_HOST):$(EPICS_CAPUTLOG_PORT)", 0)

# Start autosave backups
create_monitor_set( "info_positions.req", 10, "" )
create_monitor_set( "info_settings.req", 60, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

