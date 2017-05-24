import qbs;

ArmMcuProduct {

    Depends { name: "startup" }

    id: emlib
    name: "emlib"
    cpuName: info.cpu
    fpuName: info.fpu
    floatAbi: info.floatAbi

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

    Export {
        Depends { name: "cpp" }
        Depends { name: "startup" }
        cpp.includePaths: product.emlibIncludePaths
    }

    cpp.includePaths: emlibIncludePaths

}
