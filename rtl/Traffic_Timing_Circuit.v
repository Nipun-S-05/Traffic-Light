module Traffic_Timing_Circuit(
    input i_clk,                  //needed as a reference for the inside clock generation
    input i_reset,                //reset for the system
    input i_Long_time,            //long timer trigger input from combinational circuit
    input i_Short_time,           //short timer trigger input from combinational circuit
    output reg o_short_timer,     //output short timer 
    output reg o_long_timer,      //output long timer
    output reg o_clk              //output clock for sequential circuit
    );
     // Parameters for the number of clock cycles
    parameter p_LONG_CYCLES = 25;
    parameter p_SHORT_CYCLES = 4;

    // Counters for the timers
    reg [4:0] long_count;  //Counter for long timer
    reg [2:0] short_count; //Counter for short timer

    //Ouput clock generator
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
          if (long_count < p_LONG_CYCLES - 1) begin
                long_count <= long_count + 1;
                o_long_timer <= 1;
            end else begin
                long_count <= 0;
                o_long_timer <= 0;
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
          if (short_count < p_SHORT_CYCLES - 1) begin
                short_count <= short_count + 1;
                o_short_timer <= 1;
            end else begin
                short_count <= 0;
                o_short_timer <= 0;
            end
        end else begin
            short_count <= 0;
            o_short_timer <= 0;
        end
    end
end

endmodule
