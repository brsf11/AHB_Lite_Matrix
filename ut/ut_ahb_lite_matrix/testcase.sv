// *****************************************************************************
// (c) Copyright 2022-2032 , Inc. All rights reserved.
// Module Name  :
// Design Name  :
// Project Name :
// Create Date  : 2022-12-21
// Description  :
//
// *****************************************************************************

// -------------------------------------------------------------------
// Constant Parameter
// -------------------------------------------------------------------

// -------------------------------------------------------------------
// Internal Signals Declarations
// -------------------------------------------------------------------

// -------------------------------------------------------------------
// initial
// -------------------------------------------------------------------
initial begin
  #2000  $finish;
end

initial begin
  inc = 1'b0;
  tree_num = 9'd10;
  buff_addr_bias = 9'd0;
  #300;
  inc = 1'b1;
  @(posedge clk);
  inc = 1'b0;

end



// -------------------------------------------------------------------
// Main Code
// -------------------------------------------------------------------



// -------------------------------------------------------------------
// Assertion Declarations
// -------------------------------------------------------------------
`ifdef SOC_ASSERT_ON

`endif
