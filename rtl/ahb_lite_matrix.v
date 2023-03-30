module ahb_lite_matrix(
    input             HCLK,
    input             HRESETn,
    //Master0
    input [31:0]      M0_HADDR,
    input [2:0]       M0_HBURST,
    input             M0_HMASTLOCK,
    input [3:0]       M0_HPROT,
    input [2:0]       M0_HSIZE,
    input [1:0]       M0_HTRANS,
    input [31:0]      M0_HWDATA,
    input             M0_HWRITE,
    output            M0_HREADY,
    output reg        M0_HRESP,

    input [1:0]       M0_Pri,
    //Master1
    input [31:0]      M1_HADDR,
    input [2:0]       M1_HBURST,
    input             M1_HMASTLOCK,
    input [3:0]       M1_HPROT,
    input [2:0]       M1_HSIZE,
    input [1:0]       M1_HTRANS,
    input [31:0]      M1_HWDATA,
    input             M1_HWRITE,
    output            M1_HREADY,
    output reg        M1_HRESP,

    input [1:0]       M1_Pri,

    //Master2
    input [31:0]      M2_HADDR,
    input [2:0]       M2_HBURST,
    input             M2_HMASTLOCK,
    input [3:0]       M2_HPROT,
    input [2:0]       M2_HSIZE,
    input [1:0]       M2_HTRANS,
    input [31:0]      M2_HWDATA,
    input             M2_HWRITE,
    output            M2_HREADY,
    output reg        M2_HRESP,

    input [1:0]       M2_Pri,

    //Master3
    input [31:0]      M3_HADDR,
    input [2:0]       M3_HBURST,
    input             M3_HMASTLOCK,
    input [3:0]       M3_HPROT,
    input [2:0]       M3_HSIZE,
    input [1:0]       M3_HTRANS,
    input [31:0]      M3_HWDATA,
    input             M3_HWRITE,
    output            M3_HREADY,
    output reg        M3_HRESP,

    input [1:0]       M3_Pri,


    //output signals
    output  [31:0] HADDR,
    output  [2:0]  HBURST,
    output         HMASTLOCK,
    output  [3:0]  HPROT,
    output  [2:0]  HSIZE,
    output  [1:0]  HTRANS,
    output  [31:0] HWDATA,
    output         HWRITE,

    //Hsel
    output           s0_HSEL,
    output           s1_HSEL,
    output           s2_HSEL,
    output           s3_HSEL,
    output           s4_HSEL,
    output           s5_HSEL,
    output           s6_HSEL,

    //Slave0 signals
    input [31:0]     s0_HRDATA,
    input            s0_HREADYOUT,
    input            s0_HRESP,
    output           s0_HREADY,
    //Slave1 signals
    input [31:0]     s1_HRDATA,
    input            s1_HREADYOUT,
    input            s1_HRESP,
    output           s1_HREADY,
    //Slave2 signals
    input [31:0]     s2_HRDATA,
    input            s2_HREADYOUT,
    input            s2_HRESP,
    output           s2_HREADY,
    //Slave3 signals
    input [31:0]     s3_HRDATA,
    input            s3_HREADYOUT,
    input            s3_HRESP,
    output           s3_HREADY,
    //Slave4 signals
    input [31:0]     s4_HRDATA,
    input            s4_HREADYOUT,
    input            s4_HRESP,
    output           s4_HREADY,
    //Slave5 signals
    input [31:0]     s5_HRDATA,
    input            s5_HREADYOUT,
    input            s5_HRESP,
    output           s5_HREADY,
    //Slave6 signals
    input [31:0]     s6_HRDATA,
    input            s6_HREADYOUT,
    input            s6_HRESP,
    output           s6_HREADY,

    //output signals
    output [31:0] HRDATA
);

wire HREADY,HRESP;

reg [1:0] Master_Sel_A,Master_Sel_D;
wire [3:0] Mst_req;
wire [3:0] Mst_grant,Mst_last_grant;
wire [7:0] Mst_pri;

wire [3:0] HREADY_MST;

assign Mst_pri = {M3_Pri,M2_Pri,M1_Pri,M0_Pri};
assign Mst_req[0] = |M0_HTRANS;
assign Mst_req[1] = |M1_HTRANS;
assign Mst_req[2] = |M2_HTRANS;
assign Mst_req[3] = |M3_HTRANS;

always @* begin
    case(Mst_grant)
        4'b0001: Master_Sel_A = 2'b00;
        4'b0001: Master_Sel_A = 2'b01;
        4'b0001: Master_Sel_A = 2'b10;
        4'b0001: Master_Sel_A = 2'b11;
        default: Master_Sel_A = 2'b00;
    endcase
end

always @* begin
    case(Mst_last_grant)
        4'b0001: Master_Sel_D = 2'b00;
        4'b0001: Master_Sel_D = 2'b01;
        4'b0001: Master_Sel_D = 2'b10;
        4'b0001: Master_Sel_D = 2'b11;
        default: Master_Sel_D = 2'b00;
    endcase
end

always @* begin
    M0_HRESP = 1'b0;
    M1_HRESP = 1'b0;
    M2_HRESP = 1'b0;
    M3_HRESP = 1'b0;
    case(Master_Sel_D)
        2'b00: M0_HRESP = HRESP;
        2'b01: M1_HRESP = HRESP;
        2'b10: M2_HRESP = HRESP;
        2'b11: M3_HRESP = HRESP;
    endcase
end

assign HREADY_MST = HREADY & (Mst_grant | Mst_last_grant);
assign M0_HREADY  = HREADY_MST[0];
assign M1_HREADY  = HREADY_MST[1];
assign M2_HREADY  = HREADY_MST[2];
assign M3_HREADY  = HREADY_MST[3];

CM_ARB_DP#(
    REQ_NUM                   (4),
    PRI_WIDTH                 (2)
    ) U_arbiter
    (
    .clk        (HCLK),
    .rst_n      (HRESETn),
    .req        (Mst_req),
    .pri        (Mst_pri),
    .ready      (HREADY),
    .gnt        (Mst_grant),
    .last_gnt   (Mst_last_grant)
    );

decoder U_decoder(
    .*
);

m2s_mux U_m2s_mux(    
    .*
);

s2m_mux U_s2m_mux(
    .*
);

endmodule