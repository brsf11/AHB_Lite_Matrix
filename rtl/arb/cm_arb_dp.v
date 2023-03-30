//----------------------------------------------------------------------
// All rights reserved.
// Module Name  : cm_arb_mp.v
// Design Name  : Wu Yuhang
// Project Name : cm_arb_mp
// Create Date  : 2023/01/10
// Abstract     :
//----------------------------------------------------------------------
`ifndef CM_ARB_DP__V
`define CM_ARB_DP__V

module CM_ARB_DP
  #(
   parameter REQ_NUM                   = 2,
   parameter PRI_WIDTH                 = 1
   )
   (
   input                                         clk,
   input                                         rst_n,
   input                           [REQ_NUM-1:0] req,
   input                 [PRI_WIDTH*REQ_NUM-1:0] pri,
   input                                         ready,
   output                          [REQ_NUM-1:0] gnt,
   output reg                      [REQ_NUM-1:0] last_gnt
   );
//----------------------------------------------------------------------
// Localparam Define
//----------------------------------------------------------------------

//----------------------------------------------------------------------
// Internal Signal Define
//----------------------------------------------------------------------
reg                                [REQ_NUM-1:0] req_tmp;
reg                                [REQ_NUM-1:0] gnt_c;

//----------------------------------------------------------------------
// Function Define
//----------------------------------------------------------------------

//----------------------------------------------------------------------
// Main Logic
//----------------------------------------------------------------------

CM_ARB_REQ_PRI
   #(
    .REQ_NUM                           (REQ_NUM                                ),
    .PRI_WIDTH                         (PRI_WIDTH                              )
    )
U_CM_ARB_REQ_PRI_0(
    .req                               (req                                    ),
    .pri                               (pri                                    ),
    .req_tmp                           (req_tmp                                ),
    .pri_max                           (                                       )
    );

always@*
begin : GRANT_C_PROC
    integer ix;
    gnt_c               = {REQ_NUM{1'b0}};
  if(rst_n == 1'b0)
    gnt_c               = {REQ_NUM{1'b0}};
  else
  begin
    for(ix = REQ_NUM-1; ix >= 0; ix=ix-1)
    begin
        if(req_tmp[ix] == 1'b1)
          gnt_c         = {{(REQ_NUM-1){1'b0}},1'b1} << ix;
    end
  end
end


always@(posedge clk or negedge rst_n)
begin : LAST_GRANT_PROC
    if(rst_n == 1'b0)
      last_gnt          <= {REQ_NUM{1'b0}};
    else if ((last_gnt != gnt) && (ready == 1'b1))
      last_gnt          <= gnt;
end

assign gnt              = (ready == 1'b0) ? {REQ_NUM{1'b0}} : gnt_c;

// ----------------------------------------------------------------------------
// Assertion Declarations
// ----------------------------------------------------------------------------
`ifdef SOC_ASSERT_ON

`endif
endmodule

`endif


//----------------------------------------------------------------------
// Modified Log
// 01/10/23 17:08:50   initial version
//----------------------------------------------------------------------
