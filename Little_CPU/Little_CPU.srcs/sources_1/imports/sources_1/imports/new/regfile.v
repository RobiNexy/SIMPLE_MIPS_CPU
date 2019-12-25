`timescale 1ns / 1ps
//寄存器堆
module regfile(
	input wire clk,
    input wire rst,
	input wire we,re1,re2,//读写使能
	input wire[`RegAddrBus ] raddr1,raddr2,waddr,//读写地址
	output wire[`RegBus ] rdata1,rdata2,wdata//读写数据
    );
    reg [`RegBus ] regs[0:`RegNum-1];
    always @(posedge clk) begin //写数据
        if (rst==`RstDisable ) begin
            if ((we==`WriteEnable)&&(waddr!=`RegNumLog2'h0)) begin
                regs[waddr]<=wdata;
            end
        end
    end
    always @(*) begin //端口一读数据
        if (rst==`RstEnable ) begin
            rdata1<=`ZeroWord ;
        end
        else if (raddr1==`RegNumLog2'h0) begin
            rdata1<=`ZeroWord ;
        end
        else if ((raddr1==waddr)&&(we==`WriteEnable )&&(re1==`ReadEnable )) begin //如果读的端口和将要写的端口是同一个，直接将写的值作为输出
            rdata1<=wdata;
        end
        else if (re1==`ReadEnable ) begin//普通读
            rdata1<=regs[raddr1];
        end
        else begin
            rdata1<=`ZeroWord ;
        end
    end
        always @(*) begin //端口二读数据
        if (rst==`RstEnable ) begin
            rdata2<=`ZeroWord ;
        end
        else if (raddr2==`RegNumLog2'h0) begin
            rdata2<=`ZeroWord ;
        end
        else if ((raddr2==waddr)&&(we==`WriteEnable )&&(re2==`ReadEnable )) begin //如果读的端口和将要写的端口是同一个，直接将写的值作为输出
            rdata2<=wdata;
        end
        else if (re2==`ReadEnable ) begin//普通读
            rdata2<=regs[raddr2];
        end
        else begin
            rdata1<=`ZeroWord ;
        end
    end
endmodule : regfile