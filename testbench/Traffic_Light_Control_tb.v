`timescale 1ns / 1ps  // Define the time unit and time precision for simulation

module Traffic_Light_Control_tb();

    // Testbench signals
    reg tb_clk;                  // Clock input for driving the circuit
    reg tb_reset;                // Reset input for initializing the circuit
    reg tb_Vs;                   // Vehicle sensor input indicating vehicle presence on the side road
    wire w_Main_red;            // Main road red light output
    wire w_Main_yellow;         // Main road yellow light output
    wire w_Main_green;          // Main road green light output
    wire w_Side_red;            // Side road red light output
    wire w_Side_yellow;         // Side road yellow light output
    wire w_Side_green;          // Side road green light output

    // Clock period definition 
    parameter CLK_PERIOD = 10;

    // Instantiate the top-level Traffic Light Control module
    Traffic_Light_Control dut (
        .i_clk(tb_clk),            // Connect the clock signal
        .i_reset(tb_reset),        // Connect the reset signal
        .i_Vs(tb_Vs),              // Connect the vehicle sensor signal
        .o_Main_red(w_Main_red),   // Connect the main road red light output
        .o_Main_yellow(w_Main_yellow), // Connect the main road yellow light output
        .o_Main_green(w_Main_green),  // Connect the main road green light output
        .o_Side_red(w_Side_red),   // Connect the side road red light output
        .o_Side_yellow(w_Side_yellow), // Connect the side road yellow light output
        .o_Side_green(w_Side_green)  // Connect the side road green light output
    );

    // Clock generation process
    initial begin
        tb_clk = 0;  // Initialize clock signal
        forever #(CLK_PERIOD / 2) tb_clk = ~tb_clk;  // Toggle clock every half period
    end

    // Testbench sequence to simulate different scenarios
    initial begin
        // Initialize inputs
        tb_reset = 1;  // Assert reset
        tb_Vs = 0;     // No vehicle detected initially

        // Apply reset and hold for 2 clock periods
        #(2 * CLK_PERIOD);
        tb_reset = 0;  // Deassert reset

        // Test case 1: No vehicle on side road, main road stays green
        tb_Vs = 0;  // No vehicle detected
        #(50 * CLK_PERIOD);  // Wait for 50 clock periods

        // Test case 2: Vehicle detected on sid
