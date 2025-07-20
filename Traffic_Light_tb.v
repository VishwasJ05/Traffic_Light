`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.07.2025 19:26:24
// Design Name: 
// Module Name: Traffic_Light_tb
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

module Traffic_Light_Controller_tb;

    reg clk;
    reg rst;
    reg emergency;

    wire [2:0] NS_light;
    wire [2:0] EW_light;

    // Instantiate the Traffic Light Controller
    Traffic_Light_Controller DUT (
        .clk(clk),
        .rst(rst),
        .emergency(emergency),
        .NS_light(NS_light),
        .EW_light(EW_light)
    );

    // Clock generation: toggle every 5ns → 10ns clock period
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        emergency = 0;

        // Dump waveform
        $dumpfile("traffic.vcd");
        $dumpvars(0, Traffic_Light_Controller_tb);

        // Initial reset
        #10 rst = 0;

        // Let FSM run normally for a few cycles
        #100;

        // Trigger emergency
        $display(">>> Emergency Activated!");
        emergency = 1;
        #30;

        // Deactivate emergency
        $display(">>> Emergency Cleared!");
        emergency = 0;
        #100;

        #600 $finish;
    end

    // Monitor the outputs during simulation
    initial begin
        $monitor("Time=%0t | NS_light=%b | EW_light=%b | Emergency=%b | State=%0d", 
                 $time, NS_light, EW_light, emergency, DUT.state);
    end

endmodule

