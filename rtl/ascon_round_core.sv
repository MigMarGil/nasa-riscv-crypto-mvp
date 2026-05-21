module ascon_round_core (
    input  logic [319:0] state_i,
    input  logic [3:0]   round_i,
    output logic [319:0] state_o
);
    logic [63:0] x0, x1, x2, x3, x4;
    logic [63:0] y0, y1, y2, y3, y4;
    logic [63:0] c;

    function automatic [63:0] rotr64(input [63:0] v, input int sh);
        rotr64 = (v >> sh) | (v << (64 - sh));
    endfunction

    always_comb begin
        x0 = state_i[319:256];
        x1 = state_i[255:192];
        x2 = state_i[191:128];
        x3 = state_i[127:64];
        x4 = state_i[63:0];

        c  = 64'h0000_0000_0000_00F0 ^ (round_i * 64'h0000_0000_0000_000F);
        x2 = x2 ^ c;

        x0 = x0 ^ x4;
        x4 = x4 ^ x3;
        x2 = x2 ^ x1;

        y0 = x0 ^ (~x1 & x2);
        y1 = x1 ^ (~x2 & x3);
        y2 = x2 ^ (~x3 & x4);
        y3 = x3 ^ (~x4 & x0);
        y4 = x4 ^ (~x0 & x1);

        y1 = y1 ^ y0;
        y0 = y0 ^ y4;
        y3 = y3 ^ y2;
        y2 = ~y2;

        y0 = y0 ^ rotr64(y0, 19) ^ rotr64(y0, 28);
        y1 = y1 ^ rotr64(y1, 61) ^ rotr64(y1, 39);
        y2 = y2 ^ rotr64(y2,  1) ^ rotr64(y2,  6);
        y3 = y3 ^ rotr64(y3, 10) ^ rotr64(y3, 17);
        y4 = y4 ^ rotr64(y4,  7) ^ rotr64(y4, 41);

        state_o = {y0, y1, y2, y3, y4};
    end
endmodule
