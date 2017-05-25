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

    property variant dmadrvDmaIrqPriority: undefined
    property variant dmadrvDmaChPriority: undefined
    property variant dmadrvDmaChCount: undefined
    property variant dmadrvUseNativeApi: undefined

    property variant ezradiodrvCommCtsRetry: undefined
    property variant ezradiodrvCommUseGpio1ForCts: undefined
    property variant ezradiodrvDisablePti: undefined
    property variant ezradiodrvSpi4WireMode: undefined

    property variant rtcdrvNumTimers: undefined
    property variant rtcdrvWallclockConfig: undefined
    property variant rtcdrvSleepdrvIntegration: undefined
    property variant rtcdrvUseLfRco: undefined

    property variant spidrvIncludeSlave: undefined

    property variant uartdrvMaxConcurrentTxBufs: undefined
    property variant uartdrvMaxConcurrentRxBufs: undefined
    property variant uartdrvFlowControlEnable: undefined
    property variant uartdrvMaxDriverInstances: undefined
    property variant uartdrvFcSwXon: undefined
    property variant uartdrvFcSwXoff: undefined

    property variant ustimerTimer: undefined

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
        if (emdrvHaveEzradiodrv) {
            arr.push(emdrvLocation + "/ezradiodrv/common/inc");
            arr.push(emdrvLocation + "/ezradiodrv/common/inc/si" + emdrvEzradiodrvRadioInfo.commonInc);
            arr.push(emdrvLocation + "/ezradiodrv/si" + emdrvEzradiodrvRadioInfo.deviceInc + "/inc");

            if (emdrvEzradiodrvHavePlugins) {
                arr.push(emdrvLocation + "/ezradiodrv/plugins/inc");
            }
            if (emdrvHaveEzradiodrvDefaultConfig) {
                arr.push(emdrvLocation + "/ezradiodrv/config");
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
        if (emdrvHaveEzradiodrv) {
            arr.push(emdrvLocation + "/ezradiodrv/common/inc/*.h");
            arr.push(emdrvLocation + "/ezradiodrv/common/src/*.c");
            arr.push(emdrvLocation + "/ezradiodrv/common/inc/si" + emdrvEzradiodrvRadioInfo.commonInc + "/*.h");
            arr.push(emdrvLocation + "/ezradiodrv/common/src/si" + emdrvEzradiodrvRadioInfo.commonInc + "/*.c");
            arr.push(emdrvLocation + "/ezradiodrv/si" + emdrvEzradiodrvRadioInfo.deviceInc + "/inc/*.h");

            if (emdrvEzradiodrvHavePlugins) {
                arr.push(emdrvLocation + "/ezradiodrv/plugins/inc/*.h");
                arr.push(emdrvLocation + "/ezradiodrv/plugins/src/*.c");
            }
            if (emdrvHaveEzradiodrvDefaultConfig) {
                arr.push(emdrvLocation + "/ezradiodrv/config/*.h");
            }
        }

        return arr;
    }



    property stringList emdrvDefines: {
        var arr = [];

        var addDefine = function (cond, prop, define) {
            if (cond && (typeof(prop) !== "undefined")) {
                arr.push(define + "=" + String(prop));
            }
        }

        addDefine(emdrvHaveDmadrv, dmadrvDmaIrqPriority, "EMDRV_DMADRV_DMA_IRQ_PRIORITY");
        addDefine(emdrvHaveDmadrv, dmadrvDmaChPriority, "EMDRV_DMADRV_DMA_CH_PRIORITY");
        addDefine(emdrvHaveDmadrv, dmadrvDmaChCount, "EMDRV_DMADRV_DMA_CH_COUNT");
        addDefine(emdrvHaveDmadrv, dmadrvUseNativeApi, "EMDRV_DMADRV_USE_NATIVE_API");

        addDefine(emdrvHaveEzradiodrv, ezradiodrvCommCtsRetry, "EZRADIODRV_COMM_CTS_RETRY");
        addDefine(emdrvHaveEzradiodrv, ezradiodrvCommUseGpio1ForCts, "EZRADIODRV_COMM_USE_GPIO1_FOR_CTS");
        addDefine(emdrvHaveEzradiodrv, ezradiodrvDisablePti, "EZRADIODRV_DISABLE_PTI");
        addDefine(emdrvHaveEzradiodrv, ezradiodrvSpi4WireMode, "EZRADIODRV_SPI_4WIRE_MODE");
        addDefine(emdrvHaveEzradiodrv && emdrvEzradiodrvFullSupport, "1", "EZRADIO_DRIVER_EXTENDED_SUPPORT");
        addDefine(emdrvHaveEzradiodrv && emdrvEzradiodrvFullSupport, "1", "EZRADIO_DRIVER_FULL_SUPPORT");

        addDefine(emdrvHaveRtcdrv, rtcdrvNumTimers, "EMDRV_RTCDRV_NUM_TIMERS");
        addDefine(emdrvHaveRtcdrv, rtcdrvWallclockConfig, "EMDRV_RTCDRV_WALLCLOCK_CONFIG");
        addDefine(emdrvHaveRtcdrv, rtcdrvSleepdrvIntegration, "EMDRV_RTCDRV_SLEEPDRV_INTEGRATION");
        addDefine(emdrvHaveRtcdrv, rtcdrvUseLfRco, "EMDRV_RTCDRV_USE_LFRCO");

        addDefine(emdrvHaveSpidrv, spidrvIncludeSlave, "EMDRV_SPIDRV_INCLUDE_SLAVE");

        addDefine(emdrvHaveUartdrv, uartdrvMaxConcurrentRxBufs, "EMDRV_UARTDRV_MAX_CONCURRENT_RX_BUFS");
        addDefine(emdrvHaveUartdrv, uartdrvMaxConcurrentTxBufs, "EMDRV_UARTDRV_MAX_CONCURRENT_TX_BUFS");
        addDefine(emdrvHaveUartdrv, uartdrvFlowControlEnable, "EMDRV_UARTDRV_FLOW_CONTROL_ENABLE");
        addDefine(emdrvHaveUartdrv, uartdrvMaxDriverInstances, "EMDRV_UARTDRV_MAX_DRIVER_INSTANCES");
        addDefine(emdrvHaveUartdrv, uartdrvFcSwXon, "UARTDRV_FC_SW_XON");
        addDefine(emdrvHaveUartdrv, uartdrvFcSwXoff, "UARTDRV_FC_SW_XOFF");

        addDefine(emdrvHaveUstimer, ustimerTimer, "USTIMER_TIMER");

        return arr;
    }

    Export {
        Depends { name: "cpp" }
        cpp.includePaths: product.emdrvIncludePaths
        cpp.defines: product.emdrvDefines
    }

    cpp.includePaths: emdrvIncludePaths
    cpp.defines: emdrvDefines
    files: emdrvFiles

}
