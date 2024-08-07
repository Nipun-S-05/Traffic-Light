`timescale 1ns / 1ps
module Traffic_Combinational_tb();
  reg [1:0] G;
  wire M_red, M_yellow, M_green;
  wire S_red, S_yellow, S_green;
  wire Long_t, Short_t;


  // Instantiate the traffic_comb module
  Traffic_Combinational uut (
    .i_G(G),
    .o_Main_red(M_red),
    .o_Main_yellow(M_yellow),
    .o_Main_green(M_green),
    .o_Side_red(S_red),
    .o_Side_yellow(S_yellow),
    .o_Side_green(S_green),
    .o_Long_trigger(Long_t),
    .o_Short_trigger(Short_t)
  );

  initial begin
    $monitor("Gin=%b, M_red=%b, M_yellow=%b, M_green=%b, S_red=%b, S_yellow=%b, S_green=%b, Long_t=%b, Short_t=%b", 
              G, M_red, M_yellow, M_green, S_red, S_yellow, S_green, Long_t, Short_t);
              
    G = 2'b00; #10;
    G = 2'b01; #10;
    G = 2'b11; #10;
    G = 2'b10; #10;
    G = 2'bxx; #10;
    G = 2'b11; #10;
    // Test the default case
    
    $finish;
  end
endmodule
