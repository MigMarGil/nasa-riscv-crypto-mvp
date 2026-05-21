`timescale 1ns/1ps

module tb_rv_custom_ascon_if;
    logic clk;
    logic rst_n;
    logic valid_i;
    logic [31:0] insn_i;
    logic [31:0] rs1_i;
    logic [31:0] rs2_i;
    logic ready_o;
    logic done_o;
    logic [31:0] rd_o;
    logic fault_o;

    logic [31:0] ascon_insn;

    rv_custom_ascon_if dut (
        .clk(clk), .rst_n(rst_n), .valid_i(valid_i), .insn_i(insn_i),
        .rs1_i(rs1_i), .rs2_i(rs2_i), .ready_o(ready_o), .done_o(done_o),
        .rd_o(rd_o), .fault_o(fault_o)
    );

    always #5 clk = ~clk;

    task automatic issue_instr(input [31:0] insn, input [31:0] a, input [31:0] b);
        begin
            valid_i = 1'b1;
            insn_i  = insn;
            rs1_i   = a;
            rs2_i   = b;
            repeat (2) @(posedge clk);
            valid_i = 1'b0;
        end
    endtask

    integer timeout;
    initial begin
        clk = 0;
        rst_n = 0;
        valid_i = 0;
        insn_i = 32'h0;
        rs1_i = 32'h0;
        rs2_i = 32'h0;

        ascon_insn = {7'b0000001, 5'd3, 5'd2, 3'b001, 5'd1, 7'b0001011};

        repeat (2) @(posedge clk);
        rst_n = 1;
        @(posedge clk);

        issue_instr(ascon_insn, 32'h1234ABCD, 32'hDEADBEEF);

        timeout = 0;
        while (done_o !== 1'b1 && timeout < 100) begin
            @(posedge clk);
            timeout = timeout + 1;
        end

        if (timeout >= 100) $fatal(1, "Timeout waiting done_o in custom interface test");
        if (fault_o !== 1'b0) $fatal(1, "Unexpected fault");
        if (rd_o === 32'h0) $fatal(1, "rd_o should carry ASCON output data");

        $display("[PASS] rv_custom_ascon_if integration test completed");
        $finish;
    end
endmodule
