`timescale 1ns / 1ps

module Traffic_TIming_Generator_tb();

    // Testbench signals
    reg i_clk;            // Clock input
    reg i_reset;          // Reset input
    reg i_Long_time;      // Long time trigger input
    reg i_Short_time;     // Short time trigger input
    wire o_short_timer;   // Short timer output
    wire o_long_timer;    // Long timer output
    wire o_clk;           // Modified clock output

    // Instantiate the Traffic_Timing_Circuit module
    Traffic_Timing_Circuit uut (
        .i_clk(i_clk),              // Connect clock input to UUT
        .i_reset(i_reset),          // Connect reset input to UUT
        .i_Long_time(i_Long_time),  // Connect long time trigger to UUT
        .i_Short_time(i_Short_time),// Connect short time trigger to UUT
        .o_short_timer(o_short_timer), // Capture short timer output from UUT
        .o_long_timer(o_long_timer),   // Capture long timer output from UUT
        .o_clk(o_clk)               // Capture modified clock output from UUT
    );

    // Clock generation
    parameter CLOCK_PERIOD = 10; // Define clock period in simulation time units

    initial begin
        i_clk = 0;  // Initialize clock to 0
        forever #(CLOCK_PERIOD / 2) i_clk = ~i_clk; // Toggle clock every half period to generate a clock signal
    end

    // Test sequence
    initial begin
        // Initialize inputs
        i_reset = 1;        // Apply reset initially
        i_Long_time = 0;    // Initialize long time trigger to 0
        i_Short_time = 0;   // Initialize short time trigger to 0

        // Apply reset
        #20;
        i_reset = 0;  // De-assert reset after 20 time units

        // Test case 1: Long time trigger
        #30;
        i_Long_time = 1; // Assert long time trigger
        #25;
        i_Long_time = 0; // De-assert long time trigger after 25 time units
         
        // Test case 2: Short time trigger
        #1;
        i_Short_time = 1; // Assert short time trigger
        #4;
        i_Short_time = 0; // De-assert short time trigger after 4 time units

        // Finish simulation after a sufficient period to observe outputs
        #10000;
        $finish; // Terminate the simulation
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %t | o_clk: %b | o_long_timer: %b | o_short_timer: %b", 
                  $time, o_clk, o_long_timer, o_short_timer); 
        // Monitor the values of the output signals over time
    end
endmodule

endmodule
