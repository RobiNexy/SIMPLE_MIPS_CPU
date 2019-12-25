`timescale 1ns / 1ps
`include "defines.vh"

module pc_reg(
    inout wire clk,
    inout wire rst,
    output reg[`InstAddrBus] pc,
    output reg ce
    );
    always @ (posedge clk) begin
        if(rst==`RstEnable) begin
            ce<=`ChipDisable;
        end else begin
            ce<=`ChipEnable;
        end
    end
    always @ (posedge clk) begin
        if(ce==`ChipDisable) begin
            pc<=32'h00000000;
        end else begin
            pc<=pc+4'h4;
        end
    end
endmodule : pc_reg
