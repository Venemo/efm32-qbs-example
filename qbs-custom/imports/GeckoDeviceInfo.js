
function cpuName(productLine, deviceFamily) {

    switch (productLine) {
        case "EFM32":
        case "EZR32":
            break;
        case "EFR32":
            return "cortex-m4";
        default:
            throw new Error("Unsupported product line.");
    }

    switch (deviceFamily) {
        case "ZG":
        case "HG":
            return "cortex-m0plus";
        case "WG":
        case "PG":
            return "cortex-m4";
        default:
            return "cortex-m3";
    }

}

function fpuName(cpu) {
    switch (cpu) {
    case "cortex-m4":
        return "fpv4-sp-d16";
    default:
        return undefined;
    }
}

function parse(deviceName) {

    if (typeof(deviceName) !== "string") {
        throw new Error("deviceName should be a string, but isn't.");
    }

    var regex = new RegExp("(E[A-Z][A-Z]32)([A-Z]+[A-Z0-9]*[A-Z])([0-9]*)F([0-9]*)", "i");
    var arr = deviceName.match(regex);

    if (arr === null) {
        throw new Error("deviceName could not be parsed.");
    }
    if (arr.index !== 0) {
        throw new Error("deviceName is invalid, contains invalid characters.");
    }

    var cpu = cpuName(arr[1], arr[2]);
    var fpu = fpuName(cpu);
    var floatAbi = fpu ? "hard" : "soft";

    return {
        productLine: arr[1],
        deviceFamily: arr[2],
        featureSetCode: arr[3],
        flashSize: arr[4],
        cpu: cpu,
        fpu: fpu,
        floatAbi: floatAbi
    };
}

function parseRadioType(radio) {
    if (typeof(radio) === "undefined") {
        return undefined;
    }

    if (typeof(radio) !== "string" || radio.length !== 4) {
        throw new Error("Invalid radio type specified. Should be like 4455, 4467, etc.");
    }

    var commonInc;
    var deviceInc;

    if (radio.startsWith("445")) {
        commonInc = "4x55";
        deviceInc = "4455";
    }
    else if (radio.startsWith("446")) {
        commonInc = "4x6x";
        if (radio.endsWith("7") || radio.endsWith("8"))
            deviceInc = "4468";
        else
            deviceInc = "4460";
    }
    else {
        throw new Error("Unknown radio type. Should be like 4455, 4467, etc.");
    }

    return {
        commonInc: commonInc,
        deviceInc: deviceInc
    };
}

