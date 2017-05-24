import qbs
import qbs.FileInfo
import "qbs-custom/imports/GeckoProject.qbs" as GeckoProject
import "qbs-custom/imports/GeckoStartup.qbs" as GeckoStartup
import "qbs-custom/imports/GeckoEmlib.qbs" as GeckoEmlib
import "qbs-custom/imports/GeckoEmdrv.qbs" as GeckoEmdrv
import "qbs-custom/imports/GeckoApplication.qbs" as GeckoApplication

GeckoProject {

    id: proj
    name: "EFM32 Hello"
    deviceName: "EFM32HG310F64"
    deviceHeapSize: 0
    geckoSdkPlatformPath: path + "/dependencies/platform"
    emdrvHaveTempdrv: false

    Project {
        name: "Gecko platform"

        GeckoStartup {
            cpp.optimization: "fast"
        }

        GeckoEmlib {
        }

        GeckoEmdrv {
        }
    }

    GeckoApplication {
        name: "hello app"

        Depends { name: "startup" }
        Depends { name: "emlib" }
        Depends { name: "emdrv" }

        files: [
            "src/main.cpp",
        ]

        cpp.linkerFlags: [
            "--wrap=malloc",
            "--wrap=calloc",
            "--wrap=free",
        ].concat(base)
    }

}
