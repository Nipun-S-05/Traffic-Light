`timescale 1ns / 1ps
module Traffic_Sequential_tb();
  reg Vs, clk, Tl, Ts, reset;
  wire [1:0] G;
    Traffic_Sequential uut (
    .i_Vs(Vs),
    .i_clk(clk),
    .i_Tl(Tl),
    .i_Ts(Ts),
    .i_reset(reset),
    .o_G(G)
  );
  
  // Generate clock signal
  always begin
    #5 clk = ~clk;
  end
  
  // Initial conditions and stimulus
  initial begin
    // Initialize signals
    clk = 0;
    reset = 0;
    Vs = 0;
    Tl = 0;
    Ts = 0;
    
    // Apply reset
    #10 reset = 1;
    #10 reset = 0;
    
    // Test Case 1: Initial state S0
    #20;
    // Ensure state is S0
    if (G != 2'b00) $display("Test Case 1 Failed: Expected S0 (00), Got %b", G);
    else $display("Test Case 1 Passed");

    // Test Case 2: Transition to S1
    Vs = 1;
    Tl = 0;
    Ts = 1;
    #20;
    // Ensure state is S1
    if (G != 2'b01) $display("Test Case 2 Failed: Expected S1 (01), Got %b", G);
    else $display("Test Case 2 Passed");
    
    // Test Case 3: Stay in S1
    Ts = 0;
    Ts = 1;
    #20;
    // Ensure state is S1
    if (G != 2'b01) $display("Test Case 3 Failed: Expected S1 (01), Got %b", G);
    else $display("Test Case 3 Passed");
    
    // Test Case 4: Transition to S2
    Ts = 0;
    #20;
    // Ensure state is S2
    if (G != 2'b11) $display("Test Case 4 Failed: Expected S2 (11), Got %b", G);
    else $display("Test Case 4 Passed");
    
    // Test Case 5: Stay in S2
    Vs = 1;
    Tl = 1;
    #20;
    // Ensure state is S2
    if (G != 2'b11) $display("Test Case 5 Failed: Expected S2 (11), Got %b", G);
    else $display("Test Case 5 Passed");
    
    // Test Case 6: Transition to S3
    Vs = 0;
    Tl = 0;
    #20;
    // Ensure state is S3
    if (G != 2'b10) $display("Test Case 6 Failed: Expected S3 (10), Got %b", G);
    else $display("Test Case 6 Passed");
    
    // Test Case 7: Stay in S3
    Ts = 1;
    #20;
    // Ensure state is S3
    if (G != 2'b10) $display("Test Case 7 Failed: Expected S3 (10), Got %b", G);
    else $display("Test Case 7 Passed");
    
    // Test Case 8: Transition back to S0
    Ts = 0;
    #20;
    // Ensure state is S0
    if (G != 2'b00) $display("Test Case 8 Failed: Expected S0 (00), Got %b", G);
    else $display("Test Case 8 Passed");
    
    // Finish simulation
    $stop;
  end
endmodule
