`timescale 1ns/1ps

module rv_custom_ascon_if (
    input  logic         clk,
    input  logic         rst_n,
    input  logic         valid_i,
    input  logic [31:0]  insn_i,
    input  logic [31:0]  rs1_i,
    input  logic [31:0]  rs2_i,
    output logic         ready_o,
    output logic         done_o,
    output logic [31:0]  rd_o,
    output logic         fault_o
);
    localparam logic [6:0] OPCODE_CUSTOM0 = 7'b0001011;
    localparam logic [2:0] F3_ASCON_ROUND = 3'b001;

    logic [319:0] state_reg;
    logic [319:0] state_next;
    logic [319:0] cp_state_o;
    logic [3:0]   round_sel;

    logic cp_start;
    logic cp_busy;
    logic cp_done;
    logic cp_fault;

    assign round_sel = insn_i[31:28];

    wire is_custom0 = (insn_i[6:0] == OPCODE_CUSTOM0);
    wire is_ascon_round = is_custom0 && (insn_i[14:12] == F3_ASCON_ROUND);

    riscv_ascon_coprocessor u_cp (
        .clk(clk),
        .rst_n(rst_n),
        .start_i(cp_start),
        .state_i(state_reg),
        .round_i(round_sel),
        .fault_inject_en_i(1'b0),
        .fault_bit_i('0),
        .busy_o(cp_busy),
        .done_o(cp_done),
        .state_o(cp_state_o),
        .fault_detected_o(cp_fault)
    );

    assign state_next = {
        state_reg[319:64],
        state_reg[63:0] ^ {rs1_i, rs2_i}
    };

    typedef enum logic [1:0] {S_IDLE, S_LAUNCH, S_RUN, S_WB} st_t;
    st_t st_q;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            st_q <= S_IDLE;
            state_reg <= 320'h0;
            rd_o <= 32'h0;
            ready_o <= 1'b1;
            done_o <= 1'b0;
            fault_o <= 1'b0;
            cp_start <= 1'b0;
        end else begin
            done_o <= 1'b0;
            cp_start <= 1'b0;

            case (st_q)
                S_IDLE: begin
                    ready_o <= 1'b1;
                    if (valid_i && is_ascon_round) begin
                        state_reg <= state_next;
                        ready_o <= 1'b0;
                        st_q <= S_LAUNCH;
                    end
                end

                S_LAUNCH: begin
                    cp_start <= 1'b1;
                    st_q <= S_RUN;
                end

                S_RUN: begin
                    if (cp_done) begin
                        state_reg <= cp_state_o;
                        rd_o <= cp_state_o[31:0];
                        fault_o <= cp_fault;
                        st_q <= S_WB;
                    end
                end

                S_WB: begin
                    done_o <= 1'b1;
                    ready_o <= 1'b1;
                    st_q <= S_IDLE;
                end

                default: st_q <= S_IDLE;
            endcase
        end
    end
endmodule