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
    
    cpp.staticLibraries: [
        "gcc",
        "c",
        "m",
        "nosys",
    ]
    
    cpp.driverFlags: {
        var arr = [
                    "-nodefaultlibs",
                    "-mcpu=" + cpuName,
                    "-mthumb",
                    "-mabi=aapcs",
                    "-mfloat-abi=" + floatAbi,
                    "-fdata-sections",
                    "-ffunction-sections",
                    "-fno-strict-aliasing",
                    "-fno-builtin",
                    "-fno-exceptions",
                    "-specs=nosys.specs",
                    "-specs=nano.specs",
                    "-static",
                    "-ggdb",
                    "-Wdouble-promotion",
                ];

        if (fpuName && typeof(fpuName) === "string") {
            arr.push("-mfpu=" + fpuName);
        }

        return arr;
    }

    cpp.cxxFlags: [
        "-fno-rtti"
    ]

    cpp.linkerFlags: [
        "--gc-sections",
    ]

}

