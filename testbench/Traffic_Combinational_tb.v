`timescale 1ns / 1ps  // Define the time unit and time precision for simulation

module Traffic_Combinational_tb();
  reg [1:0] G;               // Testbench register to hold the gray code state input
  wire M_red, M_yellow, M_green;  // Wires to capture the outputs for the main road lights
  wire S_red, S_yellow, S_green;  // Wires to capture the outputs for the side road lights
  wire Long_t, Short_t;      // Wires to capture the long and short timer triggers

  // Instantiate the Traffic_Combinational module
  Traffic_Combinational uut (
    .i_G(G),                 // Connect the gray code state input to the module's input
    .o_Main_red(M_red),      // Connect the main road's red light output to the module's output
    .o_Main_yellow(M_yellow), // Connect the main road's yellow light output to the module's output
    .o_Main_green(M_green),  // Connect the main road's green light output to the module's output
    .o_Side_red(S_red),      // Connect the side road's red light output to the module's output
    .o_Side_yellow(S_yellow), // Connect the side road's yellow light output to the module's output
    .o_Side_green(S_green),  // Connect the side road's green light output to the module's output
    .o_Long_trigger(Long_t), // Connect the long timer trigger output to the module's output
    .o_Short_trigger(Short_t) // Connect the short timer trigger output to the module's output
  );

  // Test sequence
  initial begin
    // Monitor the outputs in the simulation
    $monitor("Gin=%b, M_red=%b, M_yellow=%b, M_green=%b, S_red=%b, S_yellow=%b, S_green=%b, Long_t=%b, Short_t=%b", 
              G, M_red, M_yellow, M_green, S_red, S_yellow, S_green, Long_t, Short_t);
              
    // Apply test vectors to the input G and observe the outputs
    G = 2'b00; #10;  // State S0: Main green, Side red, Long timer trigger active
    G = 2'b01; #10;  // State S1: Main yellow, Side red, Short timer trigger active
    G = 2'b11; #10;  // State S2: Main red, Side green, Long timer trigger active
    G = 2'b10; #10;  // State S3: Main red, Side yellow, Short timer trigger active
    G = 2'bxx; #10;  // Test the default case (invalid state)
    G = 2'b11; #10;  // Return to State S2 to verify functionality after the default case
    
    // End the simulation
    $finish;
  end
endmodule

