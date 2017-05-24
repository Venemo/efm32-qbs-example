import qbs
import qbs.FileInfo
import "GeckoDeviceInfo.js" as GeckoDeviceInfo

Project {

    id: proj
    minimumQbsVersion: "1.6"

    property string deviceName: ""
    property variant info: GeckoDeviceInfo.parse(deviceName)
    property string infoShort: info ? (info.productLine + info.deviceFamily).toLowerCase() : ""

    property path geckoSdkPlatformPath: ""

    property int deviceHeapSize: undefined

    property bool emdrvHaveDmadrv: true
    property bool emdrvHaveGpiointerrupt: true
    property bool emdrvHaveNvm: true
    property bool emdrvHaveRtcdrv: true
    property bool emdrvHaveSleep: true
    property bool emdrvHaveSpidrv: true
    property bool emdrvHaveTempdrv: false
    property bool emdrvHaveUartdrv: true
    property bool emdrvHaveUstimer: true
    property bool emdrvHaveEzradiodrv: false
    property bool emdrvHaveDmadrvDefaultConfig: true
    property bool emdrvHaveNvmDefaultConfig: true
    property bool emdrvHaveRtcdrvDefaultConfig: true
    property bool emdrvHaveSpidrvDefaultConfig: true
    property bool emdrvHaveTempdrvDefaultConfig: true
    property bool emdrvHaveUartdrvDefaultConfig: true
    property bool emdrvHaveUstimerDefaultConfig: true
    property bool emdrvHaveEzradiodrvDefaultConfig: true

    property bool emdrvEzradiodrvHavePlugins: false
    property bool emdrvEzradiodrvFullSupport: true
    property string emdrvEzradiodrvRadioType: "4467"
    property variant emdrvEzradiodrvRadioInfo: GeckoDeviceInfo.parseRadioType(emdrvEzradiodrvRadioType)
}

