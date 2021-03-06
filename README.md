# Miskatino Basic

This project was created to simplify teaching electronics in the school. It is a simple implementation of [**BASIC**](https://en.wikipedia.org/wiki/BASIC) programming language to control **Arduino Mini (2k)** or **STM32F103** microcontrollers. It is exposed via serial interface (e.g. UART) and so MCU could be programmed either from computer **or smartphone with the help of bluetooth module**. Now you can try it in [**web-emulator**](https://miskatino.github.io/miskatino-basic) also!

_Demo videos - on programming with smartphone and on using web-emulator:_  
[![Screenshot of a demo video for Miskatino Controller being programmed via Bluetooth with smartphone](https://i.imgur.com/0Shl33w.png)](https://www.youtube.com/watch?v=q9JcWGs_VaI)
[![Screenshot of BASIC for Arduino in web-emulator](https://i.imgur.com/sMgJ9OB.png)](https://www.youtube.com/watch?v=3CcLqFlPLAU)

### Supported MCUs

The target hardware is really 32-bit ARM controllers, preferably STM32F103, which are cheaper than 8-bit Arduinos, but provide over 10 times more memory and 5 (or 10 with quartz) times faster execution, along with 32-bit integers instead of 16-bit. In future the project is supposed to be extended to cover LPC13xx and LPC21xx chips of NXP and probably Raspberry Pi.

- Arduino Mini 2k - 700 bytes for code, 300 for variables (also Arduino Micro / Leonardo / Duemilanove etc.)
- STM32F103 - code and data could take up to 20 kBytes, 32-bit variables, 100000 lines per second (work in progress)

### Setup

Build the project, upload firmware. Set your communication line (either Bluetooth UART module or USB-UART bridge, like FTDI) to 115200 baud (or change the speed in the code before building). Plug in, press reset - you should see some greeting like `Miskatino v1.0`.

Alternatively there is [**web-emulator**](https://miskatino.github.io/miskatino-basic) where anyone can play with the project on virtual Arduino Nano board with LEDs, switches and potentiometer.

### Recognized commands and functions

(see more thorough list at [Miskatino Basic Manual](https://github.com/Miskatino/miskatino-basic/wiki/Miskatino-Basic-Manual))

**Commands**

- `PRINT` - prints integer value or constant string (double-quoted) to serial console
- `INPUT` - allows to read integer value
- `REM` - just a comment line
- `IF` - conditional execution, i.e. `if x<0; goto 50` (note semicolon instead of "then")
- `GOTO` - jump to line number
- `GOSUB` - subroutine call to line number
- `RETURN` - return from subroutine
- `END` - stop execution (e.g. end main code to prevent running into subroutine lines)
- `DIM` - allocate an array (integer or byte)
- `DATA` - load values to previously allocated array
- `PIN` - to control the pin output signal (0, 1) or make it input (-1)
- `EMIT` - send character to UART
- `POKE` - to put data byte into memory address (register, or io-port)
- assignment to variables via `X = 5*Y+ADC(3)` form, two first letters of variable are recognized

**functions**

- `ABS` - absolute value of argument
- `PIN` - read logical signal (0, 1) from the given pin
- `ADC` - read voltage from given analog input
- `PEEK` - read byte from given memory address (register, or io-port)
- `KEY` - reads character from UART, non-blocking

### Speed test

(current implementation optimizes interpretation of tokens,
but does not hard link variables and labels yet)

simple code used:

    10 x = 100000
    20 if x%5000=0;print x
    30 x = x-1
    40 if x>=0; goto 20

i.e. about 4 statements per iteration

- on STM32 with -O0: 10 sec
- on STM32 with -O1: 6 sec
- on STM32 with -O2: 5 sec
- on STM32 with -O3: 4 sec
- on Arduino Micro (x=30000): 7 sec (i.e. 23 for 100000)

i.e. roughly 100000 statements per second on STM32 achievable
