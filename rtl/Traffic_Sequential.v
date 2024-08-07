module Traffic_Sequential(
input i_Vs,    //The signal for presence of side vehicle 
input i_clk,   //The input clock for the sequential circuit
input i_Tl,    //The Long timer signal(25 seconds)
input i_Ts,    //The Short timer signal(4 seconds)
input i_reset, //The reset signal (Asynchronous reset)
output reg [1:0] o_G //The output of the sequential logic representing G0 and G1 (mentioned in the diagram)
    );
  parameter p_S0 = 2'b00, p_S1 = 2'b01, p_S2 = 2'b10, p_S3 = 2'b11; // the gray code FSM states
  
  reg [1:0] present_state;  //The present state 2-bit register
  reg [1:0] next_state;     //The next state 2-bit register
  
  //Asynchornous reset and assignment of next state
  always @(posedge i_clk or posedge i_reset) begin  //asynchronous reset (reset happens at positive edge)
    if(i_reset)
      present_state <= p_S0;
    else
      present_state <= next_state;
  end
  
  // The FSM state machine executed as per the mentioned state diagram
  always @(*) begin
    case(present_state)
      p_S0: next_state = ((i_Tl)+(~i_Vs)) ? p_S0 : p_S1; 
      p_S1: next_state = (i_Ts) ? p_S1 : p_S2;
      p_S2: next_state = ((i_Tl)*(i_Vs)) ? p_S2 : p_S3;
      p_S3: next_state = (i_Ts) ? p_S3 : p_S0;
      default: next_state = p_S0;
     endcase
  end
    
  // output of the sequential logic in traffic light system 
  always @(present_state) begin
      case(present_state)
        p_S0: o_G = 2'b00; //represent Main_traffic light = GREEN and Side_traffic_light = RED
        p_S1: o_G = 2'b01; //represent Main_traffic light = YELLOW and Side_traffic_light = RED
        p_S2: o_G = 2'b11; //represent Main_traffic light = RED and Side_traffic_light = GREEN
        p_S3: o_G = 2'b10; //represent Main_traffic light = RED and Side_traffic_light = YELLOW
        default: o_G = 2'b00; //The intial case or the default case is provided.
      endcase
  end
endmodule
