module m2s_mux(    
    input [1:0]       Master_Sel_A,
    input [1:0]       Master_Sel_D,

    //Master0
    input [31:0]      M0_HADDR,
    input [2:0]       M0_HBURST,
    input             M0_HMASTLOCK,
    input [3:0]       M0_HPROT,
    input [2:0]       M0_HSIZE,
    input [1:0]       M0_HTRANS,
    input [31:0]      M0_HWDATA,
    input             M0_HWRITE,
    //Master1
    input [31:0]      M1_HADDR,
    input [2:0]       M1_HBURST,
    input             M1_HMASTLOCK,
    input [3:0]       M1_HPROT,
    input [2:0]       M1_HSIZE,
    input [1:0]       M1_HTRANS,
    input [31:0]      M1_HWDATA,
    input             M1_HWRITE,
    //Master2
    input [31:0]      M2_HADDR,
    input [2:0]       M2_HBURST,
    input             M2_HMASTLOCK,
    input [3:0]       M2_HPROT,
    input [2:0]       M2_HSIZE,
    input [1:0]       M2_HTRANS,
    input [31:0]      M2_HWDATA,
    input             M2_HWRITE,
    //Master3
    input [31:0]      M3_HADDR,
    input [2:0]       M3_HBURST,
    input             M3_HMASTLOCK,
    input [3:0]       M3_HPROT,
    input [2:0]       M3_HSIZE,
    input [1:0]       M3_HTRANS,
    input [31:0]      M3_HWDATA,
    input             M3_HWRITE,

    //output signals
    output reg [31:0] HADDR,
    output reg [2:0]  HBURST,
    output reg        HMASTLOCK,
    output reg [3:0]  HPROT,
    output reg [2:0]  HSIZE,
    output reg [1:0]  HTRANS,
    output reg [31:0] HWDATA,
    output reg        HWRITE
);

always @* begin
    case(Master_Sel_A)
        2'b00:begin
            HADDR     = M0_HADDR;
            HBURST    = M0_HBURST;
            HMASTLOCK = M0_HMASTLOCK;
            HPROT     = M0_HPROT;
            HSIZE     = M0_HSIZE;
            HTRANS    = M0_HTRANS;
            HWRITE    = M0_HWRITE;
        end
        2'b01:begin
            HADDR     = M1_HADDR;
            HBURST    = M1_HBURST;
            HMASTLOCK = M1_HMASTLOCK;
            HPROT     = M1_HPROT;
            HSIZE     = M1_HSIZE;
            HTRANS    = M1_HTRANS;
            HWRITE    = M1_HWRITE;
        end
        2'b10:begin
            HADDR     = M2_HADDR;
            HBURST    = M2_HBURST;
            HMASTLOCK = M2_HMASTLOCK;
            HPROT     = M2_HPROT;
            HSIZE     = M2_HSIZE;
            HTRANS    = M2_HTRANS;
            HWRITE    = M2_HWRITE;
        end
        2'b11:begin
            HADDR     = M3_HADDR;
            HBURST    = M3_HBURST;
            HMASTLOCK = M3_HMASTLOCK;
            HPROT     = M3_HPROT;
            HSIZE     = M3_HSIZE;
            HTRANS    = M3_HTRANS;
            HWRITE    = M3_HWRITE;
        end
        default:begin
            HADDR     = M0_HADDR;
            HBURST    = M0_HBURST;
            HMASTLOCK = M0_HMASTLOCK;
            HPROT     = M0_HPROT;
            HSIZE     = M0_HSIZE;
            HTRANS    = M0_HTRANS;
            HWRITE    = M0_HWRITE;
        end
    endcase
end

always @* begin
    case(Master_Sel_D)
        2'b00:begin
            HWDATA = M0_HWDATA;
        end
        2'b01:begin
            HWDATA = M1_HWDATA;
        end
        2'b10:begin
            HWDATA = M2_HWDATA;
        end
        2'b11:begin
            HWDATA = M3_HWDATA;
        end
        default:begin
            HWDATA = M0_HWDATA;
        end
    endcase
end

endmodule