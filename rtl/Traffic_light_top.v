module Traffic_light_top(
    input i_clk,                  // Clock input
    input i_reset,                // Reset input
    input i_Vs,                   // Vehicle sensor input
    output o_Main_red,            // Main road red light
    output o_Main_yellow,         // Main road yellow light
    output o_Main_green,          // Main road green light
    output o_Side_red,            // Side road red light
    output o_Side_yellow,         // Side road yellow light
    output o_Side_green           // Side road green light
    );
     // Internal signals
    wire [1:0] w_G;               // Gray code output from sequential logic
    wire w_Long_trigger;          // Long timer trigger from combinational logic
    wire w_Short_trigger;         // Short timer trigger from combinational logic
    wire w_long_timer;            // Long timer signal from timing circuit
    wire w_short_timer;           // Short timer signal from timing circuit
    wire w_clk;                   // Clock for sequential circuit

    // Sequential logic instance
    Traffic_Sequential seq_logic (
        .i_Vs(i_Vs),
        .i_clk(w_clk),
        .i_Tl(w_long_timer),
        .i_Ts(w_short_timer),
        .i_reset(i_reset),
        .o_G(w_G)
    );

    // Combinational logic instance
    Traffic_Combinational comb_logic (
        .i_G(w_G),
        .o_Main_red(o_Main_red),
        .o_Main_yellow(o_Main_yellow),
        .o_Main_green(o_Main_green),
        .o_Side_red(o_Side_red),
        .o_Side_yellow(o_Side_yellow),
        .o_Side_green(o_Side_green),
        .o_Long_trigger(w_Long_trigger),
        .o_Short_trigger(w_Short_trigger)
    );

    // Timing circuit instance
    Traffic_Timing_Circuit timing_circuit (
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_Long_time(w_Long_trigger),
        .i_Short_time(w_Short_trigger),
        .o_short_timer(w_short_timer),
        .o_long_timer(w_long_timer),
        .o_clk(w_clk)
    );
endmodule
