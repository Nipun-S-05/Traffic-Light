module Traffic_Combinational(
    input wire [1:0] i_G,     //THe gray code state input
    output reg o_Main_red,    //Output red light of the main traffic light
    output reg o_Main_yellow, //Output yellow light of the main traffic light
    output reg o_Main_green,  //Output green light of the main traffic light
    output reg o_Side_red,    //Ouput red light of the side traffic light
    output reg o_Side_yellow, //Output yellow light of the side traffic light
    output reg o_Side_green,  //Output green light of the side traffic light
    output reg o_Long_trigger, //Output long trigger 
    output reg o_Short_trigger //Output short trigger
    );
    parameter p_S0 = 2'b00, //The parameter gray code states
              p_S1 = 2'b01, 
              p_S2 = 2'b11, 
              p_S3 = 2'b10;

    always @(*) begin
        case (i_G)   //The case statement is used t mention the behavior of the combinational logic based on the FSM input recieved 
            p_S0: begin
                o_Main_red <= 0;
                o_Main_yellow <= 0;
                o_Main_green <= 1;
                o_Side_red <= 1;
                o_Side_yellow <= 0;
                o_Side_green <= 0;
                o_Long_trigger <= 1;
                o_Short_trigger <= 0;
            end
            p_S1: begin
                o_Main_red <= 0;
                o_Main_yellow <= 1;
                o_Main_green <= 0;
                o_Side_red <= 1;
                o_Side_yellow <= 0;
                o_Side_green <= 0;
                o_Long_trigger <= 0;
                o_Short_trigger <= 1;
            end
            p_S2: begin
                o_Main_red <= 1;
                o_Main_yellow <= 0;
                o_Main_green <= 0;
                o_Side_red <= 0;
                o_Side_yellow <= 0;
                o_Side_green <= 1;
                o_Long_trigger <= 1;
                o_Short_trigger <= 0;
            end
            p_S3: begin
                o_Main_red <= 1;
                o_Main_yellow <= 0;
                o_Main_green <= 0;
                o_Side_red <= 0;
                o_Side_yellow <= 1;
                o_Side_green <= 0;
                o_Long_trigger <= 0;
                o_Short_trigger <= 1;
            end
            default: begin
                o_Main_red <= 0;
                o_Main_yellow <= 0;
                o_Main_green <= 0;
                o_Side_red <= 0;
                o_Side_yellow <= 0;
                o_Side_green <= 0;
                o_Long_trigger <= 0;
                o_Short_trigger <= 0;
            end
        endcase
    end
endmodule
