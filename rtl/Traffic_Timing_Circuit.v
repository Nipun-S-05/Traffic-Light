module Traffic_Timing_Circuit(
    input i_clk,                  // Needed as a reference for the inside clock generation
    input i_reset,                // Reset for the system
    input i_Long_time,            // Long timer trigger input from combinational circuit
    input i_Short_time,           // Short timer trigger input from combinational circuit
    output reg o_short_timer,     // Output short timer 
    output reg o_long_timer,      // Output long timer
    output reg o_clk              // Output clock for sequential circuit
    );
    
    // Parameters for the number of clock cycles
    parameter LONG_CYCLES = 25;  // Adjust this to match the clock period for 25 ns
    parameter SHORT_CYCLES = 4;  // Adjust this to match the required short timer duration

    // Counters for the timers
    reg [4:0] long_count;
    reg [2:0] short_count;

    // Output clock generator
    always @(i_clk or posedge i_reset) begin
        o_clk <= (i_reset) ? 0 : i_clk;
    end
    
    // Long timer logic
    always @(posedge i_clk or posedge i_reset) begin
        if (i_reset) begin
            long_count <= 0;
            o_long_timer <= 0;
        end else begin
            if (i_Long_time) begin
                if (long_count < LONG_CYCLES - 1) begin
                    long_count <= long_count + 1;
                    o_long_timer <= 1;
                end else begin
                    long_count <= 0;
                    o_long_timer <= 0;   // Turn off the signal after 25 clock cycles
                end
            end else begin
                long_count <= 0;
                o_long_timer <= 0;
            end
        end
    end

    // Short timer logic
    always @(posedge i_clk or posedge i_reset) begin
        if (i_reset) begin
            short_count <= 0;
            o_short_timer <= 0;
        end else begin
            if (i_Short_time) begin
                if (short_count < SHORT_CYCLES - 1) begin
                    short_count <= short_count + 1;
                    o_short_timer <= 1;
                end else begin
                    short_count <= 0;
                    o_short_timer <= 0;  // Turn off the signal after 4 clock cycles
                end
            end else begin
                short_count <= 0;
                o_short_timer <= 0;
            end
        end
    end

endmodule
