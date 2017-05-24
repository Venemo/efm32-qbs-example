import qbs;

ArmMcuProduct {

    id: startup
    name: "startup"
    cpuName: info.cpu
    fpuName: info.fpu
    floatAbi: info.floatAbi

    property path cmsisLocation: geckoSdkPlatformPath + "/CMSIS"
    property path cmsisIncludePath: cmsisLocation + "/Include"

    property path deviceFilesLocation: geckoSdkPlatformPath + "/Device/SiliconLabs/" + info.productLine + info.deviceFamily
    property path deviceFilesIncludePath: deviceFilesLocation + "/Include"
    property pathList startupFiles: [
        deviceFilesLocation + "/Source/system_" + infoShort + ".c",
        deviceFilesLocation + "/Source/GCC/startup_" + infoShort + ".c",
        deviceFilesLocation + "/Source/GCC/" + infoShort + ".ld",
    ]
    property path deviceLinkerScript: deviceFilesLocation + "/Source/GCC/" + infoShort + ".ld"
    property stringList deviceDefines: {
        var arr = [deviceName.toUpperCase()];
        if (typeof(deviceHeapSize) !== "undefined") {
            arr.push("__HEAP_SIZE=" + String(deviceHeapSize));
        }
        return arr;
    }

    property pathList deviceIncludePaths: [
        cmsisIncludePath,
        deviceFilesIncludePath,
    ]

    files: startupFiles

    cpp.includePaths: deviceIncludePaths

    cpp.defines: deviceDefines

    Export {
        Depends { name: "cpp" }
        cpp.includePaths: product.deviceIncludePaths
        cpp.defines: product.deviceDefines
        cpp.linkerFlags: [ "-T" + product.deviceLinkerScript ]
    }

}
