# Custom USB-HID Keyboard Controller ASIC

A custom keyboard controller designed in SystemVerilog, featuring a robust debouncing mechanism and a planned USB 2.0 interface. This project is intended for implementation on an FPGA and eventual tape out as an ASIC.

## Key Features
* **Modular Debounce Logic:** Utilizes a parameterized counter (`flexcounter`) to reliably detect stable key presses and filter out mechanical switch bouncing.
* **Low Latency Architecture:** The design is architected to achieve a target latency of under 5ms from key press to data reporting.
* **FPGA Prototyping:** Initially prototyped on a TangNano20k FPGA.
* **Planned USB 2.0 HID Compliance:** Architected for a full USB 2.0 Low-Speed implementation for communication with a host computer.

## Current Status: In-Progress
This project is an active work-in-progress. As of October 2025, the following components are complete:

* **Keyboard Controller RTL:** The core logic in `keyboard_controller.sv` for scanning keys and managing the debouncing state machine is implemented and functional.
* **Basic Testbench:** A simple, direct-stimulus testbench (`tb_keyboard_controller.sv`) exists to verify the debouncing functionality.
* **USB Controller Skeleton:** The state machine and I/O for the `usb_controller.sv` module have been defined as a structural placeholder for future implementation.

## Project Roadmap
**The primary architectural and verification goals for this project include:**

* **Full USB 2.0 Controller Implementation:** Build out the logic for all states in the USB controller to handle SYNC, PID, DATA, and EOP packets according to the USB 2.0 specification.
* **Advanced Verification with UVM:** Develop a complete UVM testbench to achieve over 95% functional coverage. This will include randomized stimulus, a scoreboard, and a functional coverage model.
* **SystemVerilog Assertions (SVA):** Integrate SVA to formally verify critical properties of the USB protocol and internal state machines.
