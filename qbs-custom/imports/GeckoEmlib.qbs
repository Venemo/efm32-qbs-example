import qbs;

ArmMcuProduct {

    Depends { name: "startup" }

    id: emlib
    name: "emlib"
    cpuName: info.cpu
    fpuName: info.fpu
    floatAbi: info.floatAbi

    property variant efmDebugging: undefined

    property path emlibLocation: geckoSdkPlatformPath + "/emlib"
    property path emlibIncludePath: emlibLocation + "/inc"
    property pathList emlibFiles: [
        emlibLocation + "/src/em_*.c",
        emlibIncludePath + "/em_*.h",
    ]
    property pathList emlibDeprecatedFiles: [
        emlibLocation + "/*/em_int.*",
    ]

    files: emlibFiles
    excludeFiles: emlibDeprecatedFiles

    property pathList emlibIncludePaths: [
        emlibIncludePath
    ]

    property stringList emlibDefines: {
        var arr = [];

        if (efmDebugging === true) {
            arr.push("DEBUG_EFM");
        }
        else if (efmDebugging === "user") {
            arr.push("DEBUG_EFM_USER");
        }

        return arr;
    }

    Export {
        Depends { name: "cpp" }
        Depends { name: "startup" }
        cpp.includePaths: product.emlibIncludePaths
        cpp.defines: product.emlibDefines
    }

    cpp.includePaths: emlibIncludePaths
    cpp.defines: emlibDefines

}
