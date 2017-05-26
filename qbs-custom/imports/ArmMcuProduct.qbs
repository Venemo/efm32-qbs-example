import qbs
import qbs.FileInfo

Product {
    property string floatAbi: "soft"
    property string cpuName: "cortex-m0plus"
    property string fpuName: "fpv4-sp-d16"
    
    type: "staticlibrary"

    Depends {
        name: "cpp"
    }

    FileTagger {
        patterns: "*.ld"
        fileTags: ["linkerscript"]
    }

    cpp.cLanguageVersion: "c11"
    cpp.cxxLanguageVersion: "c++11"
    cpp.positionIndependentCode: false
    cpp.optimization: "none"
    cpp.debugInformation: true
    cpp.enableExceptions: false
    cpp.enableRtti: false
    cpp.enableReproducibleBuilds: true
    cpp.treatSystemHeadersAsDependencies: true
    
    cpp.staticLibraries: [
        "gcc",
        "c",
        "m",
        "nosys",
    ]
    
    cpp.driverFlags: {
        var arr = [
                    "-mcpu=" + cpuName,
                    "-mfloat-abi=" + floatAbi,
                    "-mthumb",
                    "-mabi=aapcs",
                    "-mno-sched-prolog",
                    "-mabort-on-noreturn",
                    "-fdata-sections",
                    "-ffunction-sections",
                    "-fno-strict-aliasing",
                    "-fno-builtin",
                    "-specs=nosys.specs",
                    "-specs=nano.specs",
                    "-static",
                    "-nodefaultlibs",
                    "-Wdouble-promotion",
                    "-ggdb",
                    "-g3",
                ];

        if (fpuName && typeof(fpuName) === "string") {
            arr.push("-mfpu=" + fpuName);
        }

        return arr;
    }

    cpp.cxxFlags: [
    ]

    cpp.linkerFlags: [
        "--gc-sections",
    ]

}

