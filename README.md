# efm32-qbs-example

Example project showing how to use the Qbs build system with Silicon Labs EFM32 Gecko microcontrollers,
together with the Qt Creator IDE, including support for debugging.

## Configure Qt Creator

You need to install the GNU ARM toolchain, in essence you need
`arm-none-eabi-gcc`, `arm-none-eabi-g++`, etc.

You need the Bare Metal plugin in Qt Creator

* http://doc.qt.io/qtcreator/creator-developing-baremetal.html

Some useful articles (not about EFM32, but still useful):

* https://devzone.nordicsemi.com/blogs/956/nrf52-debugging-with-qtcreator-on-windows/
* https://github.com/skywavedesign/swd_nrf51_s110_qt_template

## How to debug

* Install the [J-Link Software and Documentation Pack](https://www.segger.com/downloads/jlink) by SEGGER
* Connect your EFM32. I use a Starter Kit from Silicon Labs, but any other J-Link device should work.
* Verify that you can connect to the EFM32 (eg. use JLinkExe, etc.)
* Start the J-Link GDB Server
* Hit the run button in Qt Creator

Example command line for J-Link GDB Server:

```
JLinkGDBServer -device EFM32HG310F64 -if SWD -endian little -speed 12000 -vd -port 2331 -swoport 2332 -halt
```

If you have multiple devices connected at the same time, use the `-select usb=<serial>` option
to distinguish between them by serial number.

You need to set `-port` to the same port you set to Qt Creator when you configured the debugger.

## Using in your own project

This example uses the [qbs build system](http://doc.qt.io/qbs/). It contains several
useful items for MCU project development. These are found in `qbs-custom/imports`.

There is some stuff you can use with any other ARM MCU:

* `ArmMcuProduct` contains the necessary compiler / linker options for building something for ARM Cortex-M MCUs.
* `ArmMcuApplication` inherits `ArmMcuProduct` and can be used to build executables. It also runs the usual
conversion tools to create `hex` and `bin` files from the output.

The following is EFM32 specific:

* `GeckoProject` contains settings for the Gecko MCU family. You should set its `deviceName` and `geckoSdkPlatformPath`
properties. The `deviceName` should be the full name of the MCU you use, eg. `EFM32HG310F64`, and `geckoSdkPlatformPath`
should point to the `platform` directory of the Gecko SDK, eg.
`/home/Timur/dev/silabs/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v1.0/platform` ― it should be an
absolute path without a trailing slash. The `GeckoProject` will then deduce the CPU and FPU type and float ABI
of your MCU from the device name, and the location of the necessary startup files and libraries.
* `GeckoDeviceInfo` is used by `GeckoProject`, you don't need to use it manually.
* `GeckoStartup` is a static library that contains the necessary startup files and sets the linker script. You need to
create such a product in your project and depend on it from your `GeckoApplication`.
* `GeckoEmlib` is a static library that contains emlib.
* `GeckoEmdrv` is a static library that contains emdrv. Exactly which parts of emdrv should be compiled depend on
your settings on your `GeckoProject` instance.
* `GeckoApplication` is the type you should use for your application. It automatically sets the CPU name, FPU name
and other stuff based on your `GeckoProject` settings.

Example:

```
import qbs
import qbs.FileInfo
import "qbs-custom/imports/GeckoProject.qbs" as GeckoProject
import "qbs-custom/imports/GeckoStartup.qbs" as GeckoStartup
import "qbs-custom/imports/GeckoEmlib.qbs" as GeckoEmlib
import "qbs-custom/imports/GeckoEmdrv.qbs" as GeckoEmdrv
import "qbs-custom/imports/GeckoApplication.qbs" as GeckoApplication

GeckoProject {

    name: "EFM32 Hello"
    
    // The name of your MCU device
    deviceName: "EFM32HG310F64"
    
    // Absolute path to the Gecko SDK platform folder
    geckoSdkPlatformPath: "/home/Timur/dev/silabs/SimplicityStudio_v4/developer/sdks/gecko_sdk_suite/v1.0/platform"
    
    // Configure emdrv NOT to have TEMPDRV
    emdrvHaveTempdrv: false

    // Sub-project grouping the Gecko SDK items
    Project {
        name: "Gecko platform"

        // Necessary startup files, compiled to a static library
        GeckoStartup { }

        // Optional emlib, compiled to a static library
        GeckoEmlib { }

        // Optional emdrv, compiled to a static library
        GeckoEmdrv { }
    }

    GeckoApplication {
        name: "hello app"
        
        // Configure dependencies for your project
        Depends { name: "startup" }
        Depends { name: "emlib" }
        Depends { name: "emdrv" }

        // Files of your project
        files: [
            "src/main.cpp",
        ]
    }

}
```


