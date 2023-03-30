//-------------------------------------------------------------------
// All rights reserved.
// Module Name  : cm_arb_req_pri.v
// Design Name  : Wu Yuhang
// Project Name :
// Create Date  : 2023.01.16
// Abstract     :
//
//-------------------------------------------------------------------
`ifndef CM_ARB_REQ_PRI__V
`define CM_ARB_REQ_PRI__V

module CM_ARB_REQ_PRI
   #(
   parameter REQ_NUM                 = 2,
   parameter PRI_WIDTH               = 1,
   parameter PRI_NUM                 = 1 << PRI_WIDTH
   )
   (
   input                           [REQ_NUM-1:0] req,
   input                 [PRI_WIDTH*REQ_NUM-1:0] pri,
   output                          [REQ_NUM-1:0] req_tmp,
   output reg                    [PRI_WIDTH-1:0] pri_max
   );

//--------------------------------------------------------------------
// Localparam Define
//--------------------------------------------------------------------

//--------------------------------------------------------------------
// Internal Signal Define
//--------------------------------------------------------------------
reg                                              find_one;
reg                      [PRI_WIDTH*REQ_NUM-1:0] pri_tmp;
reg                                [REQ_NUM-1:0] req_pri[PRI_WIDTH:0];
//--------------------------------------------------------------------
// Function Define
//--------------------------------------------------------------------

//--------------------------------------------------------------------
// Main Logic
//--------------------------------------------------------------------
always@*
begin : REQ_PRI_PROC
  integer ix,iy;
  req_pri[PRI_WIDTH]    = req;
  pri_tmp               = pri;
  pri_max               = {PRI_WIDTH{1'b0}};
  for(ix = PRI_WIDTH-1;ix >= 0;ix = ix-1)
  begin
    find_one = 1'b0;
    for(iy = REQ_NUM-1;iy >= 0;iy = iy-1)
    begin
      find_one          = (pri_tmp[iy*PRI_WIDTH+ix] & req_pri[ix+1][iy]) | find_one;
	    if (find_one == 1'b1)
      begin
        req_pri[ix][iy] = (pri_tmp[iy*PRI_WIDTH+ix] & req_pri[ix+1][iy]);
	      pri_max[ix]     = 1'b1;
      end
	    else
	    begin
	      req_pri[ix]     = req_pri[ix+1]; //if find_one is not 1'b1, assign the hingest to the lowest
      end
	  end
  end
end

assign req_tmp          = req_pri[0];

// -------------------------------------------------------------------
// Assertion Declarations
// -------------------------------------------------------------------
`ifdef SOC_ASSERT_ON

`endif
endmodule

`endif
//--------Modify Logs-------------------------------------------------
// Initial Version
// 01/16/23 14:35:14
//--------------------------------------------------------------------
