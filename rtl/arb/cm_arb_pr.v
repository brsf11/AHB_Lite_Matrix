//--------------------------------------------------------------------
//All rights reserved.
// Module Name  : cm_arb_pr.v
// Design Name  : Wu Yuhang
// Project Name : cm_arb_pr
// Create Date  : 2023/01/12
// Abstract     :
//--------------------------------------------------------------------
`ifndef CM_ARB_PR__V
`define CM_ARB_PR__V

module CM_ARB_PR
   #(
   parameter REQ_NUM                    = 2,
   parameter PRI_WIDTH                  = 1
   )
   (
   input                                         clk,
   input                                         rst_n,
   input                           [REQ_NUM-1:0] req,
   input                 [PRI_WIDTH*REQ_NUM-1:0] pri,
   input                                         ready,
   input                                         mode,
   output                          [REQ_NUM-1:0] gnt,
   output reg                      [REQ_NUM-1:0] last_gnt
   );

//--------------------------------------------------------------------
// parameter declaration
//--------------------------------------------------------------------

//--------------------------------------------------------------------
// Internal Signal Define
//--------------------------------------------------------------------
wire                     [PRI_WIDTH*REQ_NUM-1:0] pri_mode;
wire                               [REQ_NUM-1:0] nxt_req_point;
wire                               [REQ_NUM-1:0] unmask_req_pre;
wire                               [REQ_NUM-1:0] mask_req_pre;
wire                               [REQ_NUM-1:0] mask_req;
wire                               [REQ_NUM-1:0] unmask_gnt;
wire                               [REQ_NUM-1:0] mask_gnt;
reg                                [REQ_NUM-1:0] gnt_c;
reg                                [REQ_NUM-1:0] req_tmp;
reg                                [REQ_NUM-1:0] req_point;

//--------------------------------------------------------------------
// main code
//--------------------------------------------------------------------
assign pri_mode         = mode ? {PRI_WIDTH{1'b0}} : pri ;

CM_ARB_REQ_PRI
     #(
     .REQ_NUM                            (REQ_NUM                                ),
     .PRI_WIDTH                          (PRI_WIDTH                              )
     )
U_CM_ARB_REQ_PRI_0(
     .req                                (req                                    ),
     .pri                                (pri_mode                               ),
     .req_tmp                            (req_tmp                                ),
     .pri_max                            (                                       )
     );

always@(posedge clk or negedge rst_n)
begin : REQ_POINT_PROC
  if(rst_n == 1'b0)
    req_point           <= {REQ_NUM{1'b0}};
  else if ((req != {REQ_NUM{1'b0}}) && (ready == 1'b1) )
    req_point           <= nxt_req_point;
end

assign nxt_req_point         = (mask_req == {REQ_NUM{1'b0}}) ? unmask_req_pre : mask_req_pre;
assign unmask_req_pre[0]      = 1'b0;
assign mask_req_pre  [0]      = 1'b0;

genvar ix;
generate
for(ix = 1;ix < REQ_NUM;ix = ix+1)
begin : REQ_PE_LOOP
  assign unmask_req_pre[ix]   = |req_tmp    [ix-1:0];
  assign mask_req_pre  [ix]   = |mask_req   [ix-1:0];
end
endgenerate

assign mask_req         = req_point  & req_tmp;
assign unmask_gnt       = req_tmp    & (~unmask_req_pre);
assign mask_gnt         = mask_req   & (~mask_req_pre);

always@*
begin : GNT_C_PROC
  if(rst_n == 1'b0)
    gnt_c               <= {REQ_NUM{1'b0}};
  else if(mask_req == {REQ_NUM{1'b0}})
    gnt_c               <= unmask_gnt;
  else
    gnt_c               <= mask_gnt;
end

always@(posedge clk or negedge rst_n)
begin : LAST_GRANT_PROC
  if(rst_n == 1'b0)
    last_gnt            <= {REQ_NUM{1'b0}};
  else if ((last_gnt != gnt) &&(ready == 1'b1))
    last_gnt            <= gnt;
end

assign  gnt             = (ready == 1'b0)? {REQ_NUM{1'b0}} : gnt_c ;


// -------------------------------------------------------------------
// Assertion Declarations
// -------------------------------------------------------------------
`ifdef SOC_ASSERT_ON

`endif
endmodule

`endif

//--------------------------------------------------------------------
// Modified Log
// 01/12/23 09:52:53 initial version
//--------------------------------------------------------------------
