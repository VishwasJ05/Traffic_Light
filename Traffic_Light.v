`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.07.2025 19:25:48
// Design Name: 
// Module Name: Traffic_Light
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


module Traffic_Light_Controller (
    input clk,
    input rst,
    input emergency,              // Emergency override input
    output reg [2:0] NS_light,    // North-South light output
    output reg [2:0] EW_light     // East-West light output
);

    // FSM states
    parameter NS_GREEN   = 2'd0,
              NS_YELLOW  = 2'd1,
              EW_GREEN   = 2'd2,
              EW_YELLOW  = 2'd3;

    // Light color encodings
    parameter RED    = 3'b100,
              GREEN  = 3'b010,
              YELLOW = 3'b001;

    reg [1:0] state, next_state;
    reg [3:0] timer;  // 4-bit timer (counts 0–15)

    // --- Sequential logic (clock-driven FSM + timer) ---
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= NS_GREEN;
            timer <= 0;
        end else if (emergency) begin
            state <= NS_GREEN;
            timer <= 0;
        end else begin
            if (timer == 4'd9) begin    // 10 clock cycles per state
                state <= next_state;
                timer <= 0;
            end else begin
                timer <= timer + 1;
            end
        end
    end

    // --- Next state combinational logic ---
    always @(*) begin
        case (state)
            NS_GREEN:   next_state = NS_YELLOW;
            NS_YELLOW:  next_state = EW_GREEN;
            EW_GREEN:   next_state = EW_YELLOW;
            EW_YELLOW:  next_state = NS_GREEN;
            default:    next_state = NS_GREEN;
        endcase
    end

    // --- Output logic: control traffic lights ---
    always @(*) begin
        if (emergency) begin
            NS_light = GREEN;
            EW_light = RED;
        end else begin
            case (state)
                NS_GREEN: begin
                    NS_light = GREEN;
                    EW_light = RED;
                end
                NS_YELLOW: begin
                    NS_light = YELLOW;
                    EW_light = RED;
                end
                EW_GREEN: begin
                    NS_light = RED;
                    EW_light = GREEN;
                end
                EW_YELLOW: begin
                    NS_light = RED;
                    EW_light = YELLOW;
                end
                default: begin
                    NS_light = RED;
                    EW_light = RED;
                end
            endcase
        end
    end

endmodule

