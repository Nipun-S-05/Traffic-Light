`timescale 1ns / 1ps  // Define the time unit and time precision for simulation

module Traffic_Sequential_tb();

  // Testbench signals
  reg Vs, clk, Tl, Ts, reset;  // Input signals: Vehicle sensor (Vs), Clock (clk), Long timer (Tl), Short timer (Ts), Reset (reset)
  wire [1:0] G;                // Output signal: Gray code state representing the current state of the FSM
  
  // Instantiate the Traffic_Sequential module under test (UUT)
  Traffic_Sequential uut (
    .i_Vs(Vs),        // Connect the Vehicle sensor input to UUT
    .i_clk(clk),      // Connect the Clock input to UUT
    .i_Tl(Tl),        // Connect the Long timer input to UUT
    .i_Ts(Ts),        // Connect the Short timer input to UUT
    .i_reset(reset),  // Connect the Reset input to UUT
    .o_G(G)           // Capture the Gray code state output from UUT
  );
  
  // Generate a clock signal with a period of 10 time units
  always begin
    #5 clk = ~clk;  // Toggle the clock every 5 time units
  end
  
  // Initial conditions and stimulus generation
  initial begin
    // Initialize signals to their default values
    clk = 0;
    reset = 0;
    Vs = 0;
    Tl = 0;
    Ts = 0;
    
    // Apply reset to initialize the FSM
    #10 reset = 1;
    #10 reset = 0;
    
    // Test Case 1: Initial state S0
    #20;  // Wait for 20 time units to stabilize the FSM
    // Check if the FSM is in state S0 (Gray code 00)
    if (G != 2'b00) $display("Test Case 1 Failed: Expected S0 (00), Got %b", G);
    else $display("Test Case 1 Passed");

    // Test Case 2: Transition to state S1
    Vs = 1;  // Vehicle detected on the side road
    Tl = 0;
    Ts = 1;  // Short timer active
    #20;  // Wait for 20 time units
    // Check if the FSM transitions to state S1 (Gray code 01)
    if (G != 2'b01) $display("Test Case 2 Failed: Expected S1 (01), Got %b", G);
    else $display("Test Case 2 Passed");
    
    // Test Case 3: Stay in state S1
    Ts = 0;
    Ts = 1;  // Re-assert short timer
    #20;  // Wait for 20 time units
    // Check if the FSM stays in state S1 (Gray code 01)
    if (G != 2'b01) $display("Test Case 3 Failed: Expected S1 (01), Got %b", G);
    else $display("Test Case 3 Passed");
    
    // Test Case 4: Transition to state S2
    Ts = 0;  // De-assert short timer
    #20;  // Wait for 20 time units
    // Check if the FSM transitions to state S2 (Gray code 11)
    if (G != 2'b11) $display("Test Case 4 Failed: Expected S2 (11), Got %b", G);
    else $display("Test Case 4 Passed");
    
    // Test Case 5: Stay in state S2
    Vs = 1;  // Vehicle detected on the side road
    Tl = 1;  // Long timer active
    #20;  // Wait for 20 time units
    // Check if the FSM stays in state S2 (Gray code 11)
    if (G != 2'b11) $display("Test Case 5 Failed: Expected S2 (11), Got %b", G);
    else $display("Test Case 5 Passed");
    
    // Test Case 6: Transition to state S3
    Vs = 0;  // No vehicle detected
    Tl = 0;  // Long timer de-asserted
    #20;  // Wait for 20 time units
    // Check if the FSM transitions to state S3 (Gray code 10)
    if (G != 2'b10) $display("Test Case 6 Failed: Expected S3 (10), Got %b", G);
    else $display("Test Case 6 Passed");
    
    // Test Case 7: Stay in state S3
    Ts = 1;  // Short timer active
    #20;  // Wait for 20 time units
    // Check if the FSM stays in state S3 (Gray code 10)
    if (G != 2'b10) $display("Test Case 7 Failed: Expected S3 (10), Got %b", G);
    else $display("Test Case 7 Passed");
    
    // Test Case 8: Transition back to state S0
    Ts = 0;  // De-assert short timer
    #20;  // Wait for 20 time units
    // Check if the FSM transitions back to state S0 (Gray code 00)
    if (G != 2'b00) $display("Test Case 8 Failed: Expected S0 (00), Got %b", G);
    else $display("Test Case 8 Passed");
    
    // Finish simulation
    $stop;  // Stop the simulation
  end
endmodule
