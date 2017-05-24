import qbs;

ArmMcuApplication {
    cpuName: info.cpu
    fpuName: info.fpu
    floatAbi: info.floatAbi
}
