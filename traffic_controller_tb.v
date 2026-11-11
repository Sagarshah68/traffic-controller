
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.10.2026 18:01:32
// Design Name: 
// Module Name: traffic_cntroller_tb
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

`timescale 1ns / 1ps

module traffic_light_tb;

    // Testbench inputs 
    reg clk;
    reg reset;

    // Outputs from the traffic light controller
    wire ns_red;
    wire ns_yellow;
    wire ns_green;

    wire ew_red;
    wire ew_yellow;
    wire ew_green;

    // Instantiate the design under test (DUT)
    traffic_cntroller uut (
        .clk(clk),
        .reset(reset),

        .ns_red(ns_red),
        .ns_yellow(ns_yellow),
        .ns_green(ns_green),

        .ew_red(ew_red),
        .ew_yellow(ew_yellow),
        .ew_green(ew_green)
    );

    // Generate a clock with a 10 ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Apply reset and run the simulation
    initial begin
        reset = 1;

        #12;
        reset = 0;

        // Run long enough to observe all four states
        #420;

        $finish;
    end

    // Display the outputs in the simulation console
    initial begin
        $monitor(
            "Time=%0t | State=%b | Count=%0d | NS(RYG)=%b%b%b | EW(RYG)=%b%b%b",
            $time,
            uut.state,
            uut.count,
            ns_red, ns_yellow, ns_green,
            ew_red, ew_yellow, ew_green
        );
    end

endmodule


