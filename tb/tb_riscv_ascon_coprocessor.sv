`timescale 1ns/1ps

module tb_riscv_ascon_coprocessor;
    logic clk;
    logic rst_n;
    logic start_i;
    logic [319:0] state_i;
    logic [3:0] round_i;
    logic fault_inject_en_i;
    logic [8:0] fault_bit_i;
    logic busy_o;
    logic done_o;
    logic [319:0] state_o;
    logic fault_detected_o;

    logic [319:0] last_nominal;

    riscv_ascon_coprocessor dut (
        .clk(clk),
        .rst_n(rst_n),
        .start_i(start_i),
        .state_i(state_i),
        .round_i(round_i),
        .fault_inject_en_i(fault_inject_en_i),
        .fault_bit_i(fault_bit_i),
        .busy_o(busy_o),
        .done_o(done_o),
        .state_o(state_o),
        .fault_detected_o(fault_detected_o)
    );

    always #5 clk = ~clk;

    task automatic launch_op(input logic fi_en, input logic [8:0] fi_bit);
        begin
            fault_inject_en_i = fi_en;
            fault_bit_i = fi_bit;
            start_i = 1'b1;
            @(posedge clk);
            start_i = 1'b0;
        end
    endtask

    task automatic wait_done;
        begin
            while (done_o !== 1'b1) @(posedge clk);
            @(posedge clk);
        end
    endtask

    integer i;
    initial begin
        clk = 0;
        rst_n = 0;
        start_i = 0;
        state_i = 320'h0123_4567_89AB_CDEF_FEDC_BA98_7654_3210_0011_2233_4455_6677_8899_AABB_CCDD_EEFF_0F0E_0D0C_0B0A_0908;
        round_i = 4'd1;
        fault_inject_en_i = 0;
        fault_bit_i = 0;

        repeat (2) @(posedge clk);
        rst_n = 1;

        launch_op(1'b0, 9'd0);
        wait_done();
        if (fault_detected_o !== 1'b0) $fatal(1, "Unexpected fault in nominal case");
        last_nominal = state_o;

        launch_op(1'b1, 9'd17);
        wait_done();
        if (fault_detected_o !== 1'b1) $fatal(1, "Fault not detected for bit flip injection");
        if (state_o === last_nominal) $fatal(1, "Injected output should differ from nominal output");

        for (i = 0; i < 32; i = i + 1) begin
            state_i = state_i ^ (320'h1 << i);
            round_i = i[3:0];
            launch_op(1'b0, 9'd0);
            wait_done();
            if (fault_detected_o !== 1'b0) $fatal(1, "False positive in regression case %0d", i);
        end

        $display("[PASS] Extended regression completed");
        $finish;
    end
endmodule
