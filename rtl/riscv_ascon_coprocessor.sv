module riscv_ascon_coprocessor (
    input  logic         clk,
    input  logic         rst_n,
    input  logic         start_i,
    input  logic [319:0] state_i,
    input  logic [3:0]   round_i,
    input  logic         fault_inject_en_i,
    input  logic [8:0]   fault_bit_i,
    output logic         busy_o,
    output logic         done_o,
    output logic [319:0] state_o,
    output logic         fault_detected_o
);
    logic [319:0] state_round_a;
    logic [319:0] state_round_b;
    logic [319:0] state_faulted;

    logic [319:0] state_i_b;
    logic [3:0]   round_i_b;

    typedef enum logic [1:0] {IDLE, EXEC_A, EXEC_B, DONE} st_t;
    st_t st_q;

    ascon_round_core u_core_a (
        .state_i(state_i),
        .round_i(round_i),
        .state_o(state_round_a)
    );

    ascon_round_core u_core_b (
        .state_i(state_i_b),
        .round_i(round_i_b),
        .state_o(state_round_b)
    );

    assign state_faulted = fault_inject_en_i ? (state_round_a ^ (320'h1 << fault_bit_i)) : state_round_a;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            st_q <= IDLE;
            busy_o <= 1'b0;
            done_o <= 1'b0;
            state_o <= '0;
            fault_detected_o <= 1'b0;
            state_i_b <= '0;
            round_i_b <= '0;
        end else begin
            done_o <= 1'b0;

            case (st_q)
                IDLE: begin
                    busy_o <= 1'b0;
                    if (start_i) begin
                        busy_o <= 1'b1;
                        st_q <= EXEC_A;
                    end
                end

                EXEC_A: begin
                    state_i_b <= state_i;
                    round_i_b <= round_i;
                    state_o <= state_faulted;
                    st_q <= EXEC_B;
                end

                EXEC_B: begin
                    fault_detected_o <= (state_faulted != state_round_b);
                    st_q <= DONE;
                end

                DONE: begin
                    busy_o <= 1'b0;
                    done_o <= 1'b1;
                    st_q <= IDLE;
                end

                default: begin
                    st_q <= IDLE;
                    busy_o <= 1'b0;
                end
            endcase
        end
    end
endmodule
