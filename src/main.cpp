
#include "em_chip.h"
#include "em_device.h"
#include "em_gpio.h"
#include "em_cmu.h"
#include "ustimer.h"

#include <cstdint>

int main() {
    CHIP_Init();

    CMU_ClockEnable(cmuClock_GPIO, true);

    GPIO_DriveModeSet(gpioPortD, gpioDriveModeHigh);
    GPIO_PinModeSet(gpioPortD, 5, gpioModePushPullDrive, 0);

    for (;;) {

        for (uint32_t i = 0; i < 2e4; i++) { }
        GPIO_PinOutToggle(gpioPortD, 5);

    }

    return 0;
}
