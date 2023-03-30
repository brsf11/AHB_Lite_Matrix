//---------------------------------------------------------------------
// All rights reserved.
// Module Name  : cm_arb_mp.v
// Design Name  : Wu Yuhang
// Project Name : cm_arb_mp
// Create Date  : 2023/01/10
// Abstract     :
//---------------------------------------------------------------------
`ifndef CM_ARB_MP__V
`define CM_ARB_MP__V

module CM_ARB_MP
    #(
    parameter REQ_NUM                  = 2,
    parameter PRI_WIDTH                = 1,

    parameter PRI_NUM                  = 1 << PRI_WIDTH
    )
     (
     input                                       clk,
     input                                       rst_n,
     input                         [REQ_NUM-1:0] req,
     input               [PRI_WIDTH*REQ_NUM-1:0] pri,
     input                                       ready,
     output                        [REQ_NUM-1:0] gnt,
     output reg                    [REQ_NUM-1:0] last_gnt
     );

//---------------------------------------------------------------------
// Localparam Define
//---------------------------------------------------------------------

//---------------------------------------------------------------------
// Internal Signal Define
//---------------------------------------------------------------------
reg                                [REQ_NUM-1:0] req_tmp;
reg                              [PRI_WIDTH-1:0] pri_max;
wire                               [REQ_NUM-1:0] req_filter[PRI_NUM-1:0];
wire                               [REQ_NUM-1:0] gnt_pr  [PRI_NUM-1:0];
wire                               [REQ_NUM-1:0] last_gnt_pr  [PRI_NUM-1:0];
//---------------------------------------------------------------------
// Function Define
//---------------------------------------------------------------------

//---------------------------------------------------------------------
// Main Logic
//---------------------------------------------------------------------

CM_ARB_REQ_PRI
   #(
   .REQ_NUM                            (REQ_NUM                                ),
   .PRI_WIDTH                          (PRI_WIDTH                              )
    )
U_CM_ARB_REQ_PRI_0(
   .req                                (req                                    ),
   .pri                                (pri                                    ),
   .req_tmp                            (req_tmp                                ),
   .pri_max                            (pri_max                                )
   );

genvar ix;
generate
for(ix = 0;ix < PRI_NUM;ix = ix+1)
begin : CBB_ARB_PR_LOOP

assign req_filter[ix]   = (pri_max == ix[PRI_WIDTH-1:0]) ? req_tmp : {REQ_NUM{1'b0}};

CM_ARB_PR
#(
   .REQ_NUM                            (REQ_NUM                                ),
   .PRI_WIDTH                          (PRI_WIDTH                              )
)
U_CM_ARB_PR_0(
   .clk                                (clk                                    ),
   .rst_n                              (rst_n                                  ),
   .req                                (req_filter[ix]                         ),
   .pri                                ({PRI_WIDTH*REQ_NUM{1'b0}}              ),
   .mode                               (1'b0                                   ),
   .ready                              (ready                                  ),
   .gnt                                (gnt_pr[ix]                             ),
   .last_gnt                           (last_gnt_pr[ix]                        )
);
end
endgenerate

assign gnt              = gnt_pr[pri_max];

// -------------------------------------------------------------------
//integer i;
//always@(posedge clk or negedge rst_n)
//if (!rst_n)
//gnt <= {REQ_NUM{1'b0}};
//else for (i=0;i<PRI_NUM;i=i+1)
//gnt<=gnt_pr[i]|gnt;
// -------------------------------------------------------------------

always@(posedge clk or negedge rst_n)
begin:LAST_GRANT_PROC
  if (rst_n == 1'b0)
    last_gnt           <= {REQ_NUM{1'b0}};
  else if((req!={REQ_NUM {1'b0}}) && (ready == 1'b1) )
    last_gnt           <= gnt_pr[pri_max];
end



// -------------------------------------------------------------------
// Assertion Declarations
// -------------------------------------------------------------------
`ifdef SOC_ASSERT_ON

`endif
endmodule

`endif


//--------------------------------------------------------------------
// Modified Log
// 01/10/23 16:59:57  initial version
//--------------------------------------------------------------------
