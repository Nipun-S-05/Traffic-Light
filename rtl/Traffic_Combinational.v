module Traffic_Combinational(
    input wire [1:0] i_G,        // The gray code state input representing the current FSM state
    output reg o_Main_red,       // Output signal for the main traffic light's red light
    output reg o_Main_yellow,    // Output signal for the main traffic light's yellow light
    output reg o_Main_green,     // Output signal for the main traffic light's green light
    output reg o_Side_red,       // Output signal for the side traffic light's red light
    output reg o_Side_yellow,    // Output signal for the side traffic light's yellow light
    output reg o_Side_green,     // Output signal for the side traffic light's green light
    output reg o_Long_trigger,   // Output signal to trigger the long timer (25 seconds)
    output reg o_Short_trigger   // Output signal to trigger the short timer (4 seconds)
    );

    // Defining the gray code states for the FSM
    parameter p_S0 = 2'b00, // State S0: Main green, Side red
              p_S1 = 2'b01, // State S1: Main yellow, Side red
              p_S2 = 2'b11, // State S2: Main red, Side green
              p_S3 = 2'b10; // State S3: Main red, Side yellow

    // Combinational logic based on the current FSM state
    always @(*) begin
        case (i_G)
            // State S0: Main road green, Side road red, Long timer active
            p_S0: begin
                o_Main_red <= 0;       // Main road red light off
                o_Main_yellow <= 0;    // Main road yellow light off
                o_Main_green <= 1;     // Main road green light on
                o_Side_red <= 1;       // Side road red light on
                o_Side_yellow <= 0;    // Side road yellow light off
                o_Side_green <= 0;     // Side road green light off
                o_Long_trigger <= 1;   // Long timer trigger active
                o_Short_trigger <= 0;  // Short timer trigger inactive
            end

            // State S1: Main road yellow, Side road red, Short timer active
            p_S1: begin
                o_Main_red <= 0;       // Main road red light off
                o_Main_yellow <= 1;    // Main road yellow light on
                o_Main_green <= 0;     // Main road green light off
                o_Side_red <= 1;       // Side road red light on
                o_Side_yellow <= 0;    // Side road yellow light off
                o_Side_green <= 0;     // Side road green light off
                o_Long_trigger <= 0;   // Long timer trigger inactive
                o_Short_trigger <= 1;  // Short timer trigger active
            end

            // State S2: Main road red, Side road green, Long timer active
            p_S2: begin
                o_Main_red <= 1;       // Main road red light on
                o_Main_yellow <= 0;    // Main road yellow light off
                o_Main_green <= 0;     // Main road green light off
                o_Side_red <= 0;       // Side road red light off
                o_Side_yellow <= 0;    // Side road yellow light off
                o_Side_green <= 1;     // Side road green light on
                o_Long_trigger <= 1;   // Long timer trigger active
                o_Short_trigger <= 0;  // Short timer trigger inactive
            end

            // State S3: Main road red, Side road yellow, Short timer active
            p_S3: begin
                o_Main_red <= 1;       // Main road red light on
                o_Main_yellow <= 0;    // Main road yellow light off
                o_Main_green <= 0;     // Main road green light off
                o_Side_red <= 0;       // Side road red light off
                o_Side_yellow <= 1;    // Side road yellow light on
                o_Side_green <= 0;     // Side road green light off
                o_Long_trigger <= 0;   // Long timer trigger inactive
                o_Short_trigger <= 1;  // Short timer trigger active
            end

            // Default state: All lights off, No timers triggered (Safety state)
            default: begin
                o_Main_red <= 0;       // Main road red light off
                o_Main_yellow <= 0;    // Main road yellow light off
                o_Main_green <= 0;     // Main road green light off
                o_Side_red <= 0;       // Side road red light off
                o_Side_yellow <= 0;    // Side road yellow light off
                o_Side_green <= 0;     // Side road green light off
                o_Long_trigger <= 0;   // Long timer trigger inactive
                o_Short_trigger <= 0;  // Short timer trigger inactive
            end
        endcase
    end
endmodule
