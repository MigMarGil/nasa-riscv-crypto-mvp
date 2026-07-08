`timescale 1ns/1ps

module tb_visual_demo;
    logic clk = 0;
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

    initial begin
        // init
        rst_n = 0;
        start_i = 0;
        fault_inject_en_i = 0;
        fault_bit_i = 0;
        state_i = 320'h0123_4567_89AB_CDEF_FEDC_BA98_7654_3210_0011_2233_4455_6677_8899_AABB_CCDD_EEFF_0F0E_0D0C_0B0A_0908;
        round_i = 4'd1;

        repeat (2) @(posedge clk);
        rst_n = 1;

        $display("\n=== ASCON Coprocessor Visual Demo ===");
        $display("Time    Action                 Busy Done FaultOut");
        $display("%0t   Starting nominal op...", $time);

        // Nominal operation
        launch_op(1'b0, 9'd0);
        $display("%0t   Launched nominal        %0b   %0b   -", $time, busy_o, done_o);
        wait_done();
        $display("%0t   Done. state_out = %0h", $time, state_o);
        $display("%0t   fault_detected = %0b\n", $time, fault_detected_o);

        // Fault injection
        $display("%0t   Launching with fault inject bit 17...", $time);
        launch_op(1'b1, 9'd17);
        wait_done();
        $display("%0t   Done. state_out = %0h", $time, state_o);
        $display("%0t   fault_detected = %0b\n", $time, fault_detected_o);

        $display("[INFO] visual demo completed");
        $finish;
    end
endmodule
