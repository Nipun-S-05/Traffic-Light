module Traffic_Sequential(
input i_Vs,    // The signal indicating the presence of a side vehicle
input i_clk,   // The input clock signal for the sequential circuit
input i_Tl,    // The Long timer signal (active for 25 seconds)
input i_Ts,    // The Short timer signal (active for 4 seconds)
input i_reset, // The asynchronous reset signal
output reg [1:0] o_G // The output representing the current traffic light state (G0 and G1)
    );

// Defining the gray code FSM states as 2-bit parameters
parameter p_S0 = 2'b00, p_S1 = 2'b01, p_S2 = 2'b10, p_S3 = 2'b11; 

// Declaring 2-bit registers for holding the present and next states
reg [1:0] present_state;  // The register to store the current state
reg [1:0] next_state;     // The register to store the next state

// Asynchronous reset and state update on the clock's rising edge
always @(posedge i_clk or posedge i_reset) begin
    if(i_reset)
        present_state <= p_S0;  // On reset, initialize to state S0
    else
        present_state <= next_state;  // Otherwise, update to the next state
end

// The combinational logic for the FSM state transitions
always @(*) begin
    case(present_state)
        p_S0: next_state = ((i_Tl) + (~i_Vs)) ? p_S0 : p_S1; // Transition logic from state S0
        p_S1: next_state = (i_Ts) ? p_S1 : p_S2;            // Transition logic from state S1
        p_S2: next_state = ((i_Tl) * (i_Vs)) ? p_S2 : p_S3; // Transition logic from state S2
        p_S3: next_state = (i_Ts) ? p_S3 : p_S0;            // Transition logic from state S3
        default: next_state = p_S0;  // Default transition state (typically on reset or unexpected conditions)
    endcase
end

// The output logic for the traffic light system based on the current state
always @(present_state) begin
    case(present_state)
        p_S0: o_G = 2'b00; // Main traffic light = GREEN, Side traffic light = RED
        p_S1: o_G = 2'b01; // Main traffic light = YELLOW, Side traffic light = RED
        p_S2: o_G = 2'b11; // Main traffic light = RED, Side traffic light = GREEN
        p_S3: o_G = 2'b10; // Main traffic light = RED, Side traffic light = YELLOW
        default: o_G = 2'b00; // Default state (typically represents an error or initial state)
    endcase
end

endmodule
