//-----------------------------------------------------------------------//
// All Rights Reserved
// Project Name :
// File Name    : cm_arb_rr.v
// Author       : kiko
// Email        :
// Data         : 2022/11/24
// Abstract     :
//-----------------------------------------------------------------------//
`ifndef CM_ARB_RR__V
`define CM_ARB_RR__V

module CM_ARB_RR
   #(
    parameter REQ_NUM                  = 2
    )
    (
    input                              clk,
    input                              rst_n,
    input                [REQ_NUM-1:0] req,
    input                              ready,
    input                              lock,
    output               [REQ_NUM-1:0] gnt
   );
//----------------------------------------------------------------------//
//Localparam Define
//----------------------------------------------------------------------//

//----------------------------------------------------------------------//
//Internal Signal Define
//----------------------------------------------------------------------//
reg                                [REQ_NUM-1:0] req_point;
wire                               [REQ_NUM-1:0] nxt_req_point;
wire                               [REQ_NUM-1:0] unmask_req_pe;
wire                               [REQ_NUM-1:0] mask_req_pe;
wire                               [REQ_NUM-1:0] mask_req;
wire                               [REQ_NUM-1:0] unmask_gnt;
wire                               [REQ_NUM-1:0] mask_gnt;
wire                               [REQ_NUM-1:0] gnt_c;
reg                                [REQ_NUM-1:0] last_gnt;
wire                                             lock_gnt;
//----------------------------------------------------------------------//
//Function Define
//----------------------------------------------------------------------//

//----------------------------------------------------------------------//
//Main Code
//----------------------------------------------------------------------//
assign nxt_req_point    = (mask_req == {REQ_NUM{1'b0}}) ? unmask_req_pe : mask_req_pe;
assign unmask_req_pe[0] = 1'b0;
assign mask_req_pe  [0] = 1'b0;

assign mask_req         = req_point & req;
assign mask_gnt         = mask_req & (~mask_req_pe);
assign unmask_gnt       = req & (~unmask_req_pe);
assign gnt_c            = (mask_req == {REQ_NUM{1'B0}}) ? unmask_gnt : mask_gnt;

assign lock_gnt         = |({REQ_NUM{lock}} & req & last_gnt);
assign gnt              = (ready == 1'b0) ? {REQ_NUM{1'b0}} : (lock_gnt == 1'b0) ? gnt_c : last_gnt;

genvar ix;
generate
for(ix = 1; ix < REQ_NUM; ix = ix + 1)
begin : REQ_PE_LOOP
  assign unmask_req_pe [ix]  = |req     [ix-1:0];
  assign  mask_req_pe  [ix]  = |mask_req[ix-1:0];
end
endgenerate

always @(posedge clk or negedge rst_n)
  begin : REQ_POINT_PROC
    if(rst_n == 1'b0)
	  req_point           <= {REQ_NUM{1'b0}};
	else if((req != {REQ_NUM{1'b0}}) && (ready == 1'b1) && (lock_gnt == 1'b0))
	  req_point           <= nxt_req_point;
  end

always @(posedge clk or negedge rst_n)
  begin : LAST_gnt_PROC
    if(rst_n == 1'b0)
	  last_gnt            <= {REQ_NUM{1'b0}};
	else if ((last_gnt != gnt) && (ready == 1'b1))
	  last_gnt            <= gnt;
  end

// -------------------------------------------------------------------
// Assertion Declarations
// -------------------------------------------------------------------
`ifdef SOC_ASSERT_ON

`endif
endmodule
`endif

//-----------------------------------------------------------------------//
// Modified Log
// 2022/11/24 initial version
//-----------------------------------------------------------------------//
