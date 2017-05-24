import qbs;

ArmMcuProduct {

    Depends { name: "startup" }
    Depends { name: "emlib" }

    id: emdrv
    name: "emdrv"
    cpuName: info.cpu
    fpuName: info.fpu
    floatAbi: info.floatAbi

    property path emdrvLocation: geckoSdkPlatformPath + "/emdrv"

    property pathList emdrvIncludePaths: {
        var arr = [];

        arr.push(emdrvLocation + "/common/inc");

        if (emdrvHaveDmadrv) {
            arr.push(emdrvLocation + "/dmadrv/inc");
            if (emdrvHaveDmadrvDefaultConfig) {
                arr.push(emdrvLocation + "/dmadrv/config");
                arr.push(geckoSdkPlatformPath + "/../hardware/kit/common/drivers");
            }
        }
        if (emdrvHaveGpiointerrupt) {
            arr.push(emdrvLocation + "/gpiointerrupt/inc");
        }
        if (emdrvHaveNvm) {
            arr.push(emdrvLocation + "/nvm/inc");
            if (emdrvHaveNvmDefaultConfig) {
                arr.push(emdrvLocation + "/nvm/config");
            }
        }
        if (emdrvHaveRtcdrv) {
            arr.push(emdrvLocation + "/rtcdrv/inc");
            if (emdrvHaveRtcdrvDefaultConfig) {
                arr.push(emdrvLocation + "/rtcdrv/config");
            }
        }
        if (emdrvHaveSleep) {
            arr.push(emdrvLocation + "/sleep/inc");
        }
        if (emdrvHaveSpidrv) {
            arr.push(emdrvLocation + "/spidrv/inc");
            if (emdrvHaveSpidrvDefaultConfig) {
                arr.push(emdrvLocation + "/spidrv/config");
            }
        }
        if (emdrvHaveTempdrv) {
            arr.push(emdrvLocation + "/tempdrv/inc");
            if (emdrvHaveTempdrvDefaultConfig) {
                arr.push(emdrvLocation + "/tempdrv/config");
            }
        }
        if (emdrvHaveUartdrv) {
            arr.push(emdrvLocation + "/uartdrv/inc");
            if (emdrvHaveUartdrvDefaultConfig) {
                arr.push(emdrvLocation + "/uartdrv/config");
            }
        }
        if (emdrvHaveUstimer) {
            arr.push(emdrvLocation + "/ustimer/inc");
            if (emdrvHaveUstimerDefaultConfig) {
                arr.push(emdrvLocation + "/ustimer/config");
            }
        }

        return arr;
    }

    property pathList emdrvFiles: {
        var arr = [];

        arr.push(emdrvLocation + "/common/inc/*.h");

        if (emdrvHaveDmadrv) {
            arr.push(emdrvLocation + "/dmadrv/*/*.h");
            arr.push(emdrvLocation + "/dmadrv/src/*.c");
            if (emdrvHaveDmadrvDefaultConfig) {
                arr.push(emdrvLocation + "/dmadrv/config");
                arr.push(geckoSdkPlatformPath + "../hardware/kit/common/drivers/dmactrl.*");
            }
        }
        if (emdrvHaveGpiointerrupt) {
            arr.push(emdrvLocation + "/gpiointerrupt/*/*.h");
            arr.push(emdrvLocation + "/gpiointerrupt/src/*.c");
        }
        if (emdrvHaveNvm) {
            arr.push(emdrvLocation + "/nvm/*/*.h");
            arr.push(emdrvLocation + "/nvm/src/*.c");
        }
        if (emdrvHaveRtcdrv) {
            arr.push(emdrvLocation + "/rtcdrv/*/*.h");
            arr.push(emdrvLocation + "/rtcdrv/src/*.c");
        }
        if (emdrvHaveSleep) {
            arr.push(emdrvLocation + "/sleep/*/*.h");
            arr.push(emdrvLocation + "/sleep/src/*.c");
        }
        if (emdrvHaveSpidrv) {
            arr.push(emdrvLocation + "/spidrv/*/*.h");
            arr.push(emdrvLocation + "/spidrv/src/*.c");
        }
        if (emdrvHaveTempdrv) {
            arr.push(emdrvLocation + "/tempdrv/*/*.h");
            arr.push(emdrvLocation + "/tempdrv/src/*.c");
        }
        if (emdrvHaveUartdrv) {
            arr.push(emdrvLocation + "/uartdrv/*/*.h");
            arr.push(emdrvLocation + "/uartdrv/src/*.c");
        }
        if (emdrvHaveUstimer) {
            arr.push(emdrvLocation + "/ustimer/*/*.h");
            arr.push(emdrvLocation + "/ustimer/src/*.c");
        }

        return arr;
    }

    Export {
        Depends { name: "cpp" }
        cpp.includePaths: product.emdrvIncludePaths
    }

    cpp.includePaths: emdrvIncludePaths
    files: emdrvFiles

}
