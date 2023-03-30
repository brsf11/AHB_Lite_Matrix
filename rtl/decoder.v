module decoder(
    input [31:0] HADDR,

    output reg s0_HSEL,
    output reg s1_HSEL,
    output reg s2_HSEL,
    output reg s3_HSEL,
    output reg s4_HSEL,
    output reg s5_HSEL,
    output reg s6_HSEL
);

always @* begin
    s0_HSEL = 1'b0;
    s1_HSEL = 1'b0;
    s2_HSEL = 1'b0;
    s3_HSEL = 1'b0;
    s4_HSEL = 1'b0;
    s5_HSEL = 1'b0;
    s6_HSEL = 1'b0;
    case(HADDR[31:28])
        4'h0: s0_HSEL = 1'b1;
        4'h1: s1_HSEL = 1'b1;
        4'h2: s2_HSEL = 1'b1;
        4'h3: s3_HSEL = 1'b1;
        4'h4: s4_HSEL = 1'b1;
        4'h5: s5_HSEL = 1'b1;
        4'h6: s6_HSEL = 1'b1;
    endcase
end

endmodule