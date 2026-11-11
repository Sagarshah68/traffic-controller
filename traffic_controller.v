`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.10.2026 17:28:05
// Design Name: 
// Module Name: traffic_cntroller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module traffic_cntroller(
 input wire clk, 
 input wire reset,
 
 output reg ns_red , 
 output reg ns_yellow, 
 output reg ns_green,
 
 output reg ew_red,
 output reg ew_yellow,
 output reg ew_green

    );
    
    localparam NS_GREEN = 2'b00;
    localparam NS_YELLOW = 2'b01;
    localparam EW_GREEN = 2'b10;
    localparam EW_YELLOW = 2'b11;
    
    reg [1:0] state;
    reg [3:0] count;
    
    always @ ( posedge clk ) begin 
        if (reset) begin 
           state<= NS_GREEN;
           count<= 0;
           end 
           
           else begin 
           if(count == 4'd9)begin
           count<=0;
           
           case(state)
           NS_GREEN: state<=NS_YELLOW;
           NS_YELLOW: state<=EW_GREEN;
           EW_GREEN: state<=EW_YELLOW;
           EW_YELLOW: state<=NS_GREEN;
           
           endcase 
           end
           else begin 
           count<= count+1'b1;
           end
           end 
           end 
           
           always @(*) begin
           ns_red =0;
           ns_yellow =0;
           ns_green = 0;
           
           ew_red=0;
           ew_yellow=0;
           ew_green=0;
           
           case (state)
           NS_GREEN: begin
           ns_green = 1;
           ew_red =1;
           end
           
           NS_YELLOW: begin
           ns_yellow =1;
           ew_red=1;
           end 
           
           EW_GREEN: begin
           ew_green = 1;
           ns_red =1;
           end
           
           EW_YELLOW: begin
           ew_yellow =1;
           ns_red =1;
           end
           
           default: begin
           ns_red=1;
           ew_red=1;
           end
           endcase
           end
           
           
endmodule
