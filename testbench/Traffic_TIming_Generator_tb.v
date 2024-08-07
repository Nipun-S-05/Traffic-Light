`timescale 1ns / 1ps
module Traffic_TIming_Generator_tb();
    // Testbench signals
    reg i_clk;
    reg i_reset;
    reg i_Long_time;
    reg i_Short_time;
    wire o_short_timer;
    wire o_long_timer;
    wire o_clk;

    // Instantiate the Traffic_Timing_generator module
    Traffic_Timing_Circuit uut (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_Long_time(i_Long_time),
        .i_Short_time(i_Short_time),
        .o_short_timer(o_short_timer),
        .o_long_timer(o_long_timer),
        .o_clk(o_clk)
    );

    // Clock generation
    parameter CLOCK_PERIOD = 10; // Period of the clock in simulation time units

    initial begin
        i_clk = 0;
        forever #(CLOCK_PERIOD / 2) i_clk = ~i_clk;
    end

    // Test sequence
    initial begin
        // Initialize inputs
        i_reset = 1;
        i_Long_time = 0;
        i_Short_time = 0;

        // Apply reset
        #20;
        i_reset = 0;

        // Test case 1: Long time trigger
        #30;
        i_Long_time = 1;
        #25;
        i_Long_time = 0;
         
        // Test case 2: Short time trigger
        //#1;
        i_Short_time = 1;
        #4;
        i_Short_time = 0;

        // Finish simulation
        #10000;
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %t | o_clk: %b | o_long_timer: %b | o_short_timer: %b", 
                  $time, o_clk, o_long_timer, o_short_timer);
    end
endmodule
