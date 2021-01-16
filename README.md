# customizable-pomodoro-timer
Implementation of a countdown/up clock on BASYS3 and VGA monitor

# About
In  this  project,  a  customizable  Pomodoro  timer  is  designed on VHDL for BASYS3, FPGA trainer board.  User  can  decide  not  only  to work/break  time  but  also,  they  can  change  the  counting method.  To  put  forward  the  design, some  motivational  quotes  were  added  into  the  simulation  and  used  a  buzzer  for  audio notification.

# Setup

## Pre-requisites

* [Vivado Design Suite](https://www.xilinx.com/products/design-tools/vivado.html) 
* [Basys 3 FPGA trainer board](https://store.digilentinc.com/basys-3-artix-7-fpga-trainer-board-recommended-for-introductory-users/)
* buzzer
* vga monitor

## Instructions

1. Import sources
2. Import constraints file

    * 9 user switches 
       - R2, T1, U1, W2 as second digit of desired minute (converted to binary)
       - R3, T2, T3, V2 as first digit of desired minute (converted to binary)
       - V17 as down counter activator
    * 5 user pushbuttons
       - W19 as left button to go back main menu
       - U19 as down buttonto set the break timer
       - T18 as up button to set the work timer
       - T17 as reset button to reset the timer or stop the buzzer
       - U18 as center button to start, stop, or reactivate the timer
    
    * 4-digit 7-segment display to show remaining or elapsed time
    * PMOD port-VCC, GND, and JB3 pins to connect buzzer
    * VGA connector

3. Run Synthesis
4. Run Implementation
5. Generate bitstream
