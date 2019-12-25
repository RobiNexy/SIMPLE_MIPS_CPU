`timescale 1ns / 1ps
`include "defines.vh"

module if_id(
    input wire clk,
    input wire rst,
    input wire [`InstAddrBus] if_pc,
    input wire [`InstBus ] if_inst,
    output reg [`InstAddrBus ] id_pc,
    output reg [`InstBus ] id_inst
    );
    always @(posedge clk) begin
        if(rst==`RstEnable ) begin
            id_pc<=`ZeroWord ;
            id_inst<=`ZeroWord ;
        end else begin
            id_pc<=if_pc;//直接向下传�?�pc和指�?
            id_inst<=if_inst;
        end
    end
endmodule : if_id
