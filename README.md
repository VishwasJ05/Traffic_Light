

# Traffic Light Controller (Verilog)

This project implements a simple multi-lane traffic light controller using Verilog HDL, designed for educational purposes and demonstration of finite state machine (FSM) logic in digital systems. The controller manages two-lane traffic flow (North-South and East-West) with a timed light cycle and an emergency override feature. The design demonstrates how state-based scheduling, light control, and interrupt-style behavior (via emergency input) can be handled at the hardware level.

The controller simulates real-world traffic logic by cycling through predefined states, assigning red, yellow, and green signals to each lane. It incorporates a timer-driven FSM and is built using fundamental Verilog constructs such as counters, sequential logic, and combinational outputs. Emergency inputs allow immediate override of normal behavior, prioritizing a fixed lane and ensuring safety, before automatically resuming the original sequence.

Key components include the FSM-based state logic, light output encoder, timer/counter, and override logic, all integrated into a single module for simulation and testing.

The design has been tested with a simulation testbench that validates:

* Proper state transitions: NS\_GREEN → NS\_YELLOW → EW\_GREEN → EW\_YELLOW
* Correct output of 3-bit light signals (RED, YELLOW, GREEN)
* Emergency override that forces North-South green and East-West red
* Automatic return to normal cycle after emergency ends

This controller is ideal for beginners exploring FSM design, traffic control logic, and simulation in Verilog. It also serves as a base for expanding into more advanced systems like 4-way intersections, pedestrian buttons, or programmable timing.

Future enhancements may include support for variable timing, pedestrian sensors, priority scheduling (e.g., bus lanes), 7-segment countdown displays, or real-time FPGA deployment. Contributions and customization for more complex intersections are encouraged.
