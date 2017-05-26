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

    property pathList startupFiles: [
        deviceFilesLocation + "/Source/system_" + infoShort + ".c",
        deviceFilesLocation + "/Source/GCC/startup_" + infoShort + ".c",
        deviceLinkerScript,
    ]

    property string deviceNameLowerCase: deviceName.toLowerCase()
    property string infoShortLowerCase: infoShort.toUpperCase()
    property string infoShortUpperCase: infoShort.toUpperCase()

    Group {
        name: product.infoShortUpperCase + " headers"
        files: {
            var arr = [];
            arr.push(product.deviceFilesIncludePath + "/" + product.infoShortLowerCase + "_*.h");
            arr.push(product.deviceFilesIncludePath + "/" + product.deviceNameLowerCase + "*.h");
            return arr;
        }
    }

    Group {
        name: product.infoShortUpperCase + " startup files"
        files: product.startupFiles
    }

    Group {
        name: "CMSIS headers"
        files: [
            product.cmsisIncludePath + "/*.h"
        ]
    }

    cpp.includePaths: deviceIncludePaths
    cpp.defines: deviceDefines

    Export {
        Depends { name: "cpp" }
        cpp.includePaths: product.deviceIncludePaths
        cpp.defines: product.deviceDefines
        cpp.linkerFlags: [ "-T" + product.deviceLinkerScript ]
    }

}
