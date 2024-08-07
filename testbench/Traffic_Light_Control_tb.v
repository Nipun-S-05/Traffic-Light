`timescale 1ns / 1ps
module Traffic_Light_Control_tb();

    // Testbench signals
    reg tb_clk;                  // Clock input
    reg tb_reset;                // Reset input
    reg tb_Vs;                   // Vehicle sensor input
    wire w_Main_red;            // Main road red light
    wire w_Main_yellow;         // Main road yellow light
    wire w_Main_green;          // Main road green light
    wire w_Side_red;            // Side road red light
    wire w_Side_yellow;         // Side road yellow light
    wire w_Side_green;          // Side road green light

    // Clock period definition
    parameter CLK_PERIOD = 10;

    // Instantiate the top-level module
    Traffic_Light_Control dut (
        .i_clk(tb_clk),
        .i_reset(tb_reset),
        .i_Vs(tb_Vs),
        .o_Main_red(w_Main_red),
        .o_Main_yellow(w_Main_yellow),
        .o_Main_green(w_Main_green),
        .o_Side_red(w_Side_red),
        .o_Side_yellow(w_Side_yellow),
        .o_Side_green(w_Side_green)
    );

    // Clock generation
    initial begin
        tb_clk = 0;
        forever #(CLK_PERIOD / 2) tb_clk = ~tb_clk;
    end

    // Testbench sequence
    initial begin
        // Initialize inputs
        tb_reset = 1;
        tb_Vs = 0;

        // Apply reset
        #(2 * CLK_PERIOD);
        tb_reset = 0;

        // Test case 1: No vehicle on side road, main road stays green
        tb_Vs = 0;
        #(50 * CLK_PERIOD);  

        // Test case 2: Vehicle detected on side road, main road transitions to yellow, then red
        tb_Vs = 1;
        #(10 * CLK_PERIOD);
        tb_Vs = 0;
        #(60 * CLK_PERIOD);  

        // Test case 3: Vehicle detected on side road, side road turns green
        tb_Vs = 1;
        #(10 * CLK_PERIOD);
        tb_Vs = 0;
        #(30 * CLK_PERIOD);  

        // Test case 4: No vehicle on side road, main road transitions back to green
        tb_Vs = 0;
        #(40 * CLK_PERIOD);  

        // End simulation
        $stop;
    end

    // Monitor the outputs
    initial begin
        $monitor("Time: %0t | Reset: %b | Vehicle Sensor: %b | Main Red: %b | Main Yellow: %b | Main Green: %b | Side Red: %b | Side Yellow: %b | Side Green: %b",
                  $time, tb_reset, tb_Vs, w_Main_red, w_Main_yellow, w_Main_green, w_Side_red, w_Side_yellow, w_Side_green);
    end

endmodule
