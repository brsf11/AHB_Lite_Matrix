module s2m_mux(
    input            HCLK,
    input            HRESETn,

    //Hsel
    input            s0_HSEL,
    input            s1_HSEL,
    input            s2_HSEL,
    input            s3_HSEL,
    input            s4_HSEL,
    input            s5_HSEL,
    input            s6_HSEL,
    
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
    output reg [31:0] HRDATA,
    output reg        HREADY,
    output reg        HRESP
);

reg [2:0] sel;
reg [2:0] nxt_sel;

always @(posedge HCLK or negedge HRESETn) begin
    if(HRESETn == 1'b0)begin
        sel <= 3'b0;
    end
    else if(HREADY == 1'b1)begin
        sel <= nxt_sel;
    end
end

always @* begin
    case({s6_HSEL,s5_HSEL,s4_HSEL,s3_HSEL,s2_HSEL,s1_HSEL,s0_HSEL})
        7'b000_0001: nxt_sel = 3'b001;
        7'b000_0010: nxt_sel = 3'b010;
        7'b000_0100: nxt_sel = 3'b011;
        7'b000_1000: nxt_sel = 3'b100;
        7'b001_0000: nxt_sel = 3'b101;
        7'b010_0000: nxt_sel = 3'b110;
        7'b100_0000: nxt_sel = 3'b111;
        default:     nxt_sel = 3'b000;
    endcase
end

always @* begin
    case(sel)
        3'b000:begin
            HRDATA = 32'b0;
            HREADY = 1'b1;
            HRESP  = 1'b0;
        end
        3'b001:begin
            HRDATA = s0_HRDATA;
            HREADY = s0_HREADYOUT;
            HRESP  = s0_HRESP;
        end
        3'b010:begin
            HRDATA = s1_HRDATA;
            HREADY = s1_HREADYOUT;
            HRESP  = s1_HRESP;
        end
        3'b011:begin
            HRDATA = s2_HRDATA;
            HREADY = s2_HREADYOUT;
            HRESP  = s2_HRESP;
        end
        3'b100:begin
            HRDATA = s3_HRDATA;
            HREADY = s3_HREADYOUT;
            HRESP  = s3_HRESP;
        end
        3'b101:begin
            HRDATA = s4_HRDATA;
            HREADY = s4_HREADYOUT;
            HRESP  = s4_HRESP;
        end
        3'b110:begin
            HRDATA = s5_HRDATA;
            HREADY = s5_HREADYOUT;
            HRESP  = s5_HRESP;
        end
        3'b111:begin
            HRDATA = s6_HRDATA;
            HREADY = s6_HREADYOUT;
            HRESP  = s6_HRESP;
        end
        default:begin
            HRDATA = 32'b0;
            HREADY = 1'b1;
            HRESP  = 1'b0;
        end
    endcase
end

assign s0_HREADY = HREADY & s0_HSEL;
assign s1_HREADY = HREADY & s1_HSEL;
assign s2_HREADY = HREADY & s2_HSEL;
assign s3_HREADY = HREADY & s3_HSEL;
assign s4_HREADY = HREADY & s4_HSEL;
assign s5_HREADY = HREADY & s5_HSEL;
assign s6_HREADY = HREADY & s6_HSEL;

endmodule