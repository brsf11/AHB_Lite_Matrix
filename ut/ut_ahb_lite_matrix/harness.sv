// *****************************************************************************
// (c) Copyright 2022-2032 , Inc. All rights reserved.
// Module Name  :
// Design Name  :
// Project Name :
// Create Date  : 2022-12-21
// Description  :
//
// *****************************************************************************

module harness;

// -------------------------------------------------------------------
// Constant Parameter
// -------------------------------------------------------------------
parameter                                        PERIOD_HCLK = 10;

// -------------------------------------------------------------------
// Internal Signals Declarations
// -------------------------------------------------------------------
logic                                            HCLK;
logic                                            HRESETn;

logic [31:0]                                     M0_HADDR                          ;
logic [2:0]                                      M0_HBURST                         ;
logic                                            M0_HMASTLOCK                      ;
logic [3:0]                                      M0_HPROT                          ;
logic [2:0]                                      M0_HSIZE                          ;
logic [1:0]                                      M0_HTRANS                         ;
logic [31:0]                                     M0_HWDATA                         ;
logic                                            M0_HWRITE                         ;
logic                                            M0_HREADY                         ;
logic                                            M0_HRESP                          ;
logic [1:0]                                      M0_Pri                            ;
logic [31:0]                                     M1_HADDR                          ;
logic [2:0]                                      M1_HBURST                         ;
logic                                            M1_HMASTLOCK                      ;
logic [3:0]                                      M1_HPROT                          ;
logic [2:0]                                      M1_HSIZE                          ;
logic [1:0]                                      M1_HTRANS                         ;
logic [31:0]                                     M1_HWDATA                         ;
logic                                            M1_HWRITE                         ;
logic                                            M1_HREADY                         ;
logic                                            M1_HRESP                          ;
logic [1:0]                                      M1_Pri                            ;
logic [31:0]                                     M2_HADDR                          ;
logic [2:0]                                      M2_HBURST                         ;
logic                                            M2_HMASTLOCK                      ;
logic [3:0]                                      M2_HPROT                          ;
logic [2:0]                                      M2_HSIZE                          ;
logic [1:0]                                      M2_HTRANS                         ;
logic [31:0]                                     M2_HWDATA                         ;
logic                                            M2_HWRITE                         ;
logic                                            M2_HREADY                         ;
logic                                            M2_HRESP                          ;
logic [1:0]                                      M2_Pri                            ;
logic [31:0]                                     M3_HADDR                          ;
logic [2:0]                                      M3_HBURST                         ;
logic                                            M3_HMASTLOCK                      ;
logic [3:0]                                      M3_HPROT                          ;
logic [2:0]                                      M3_HSIZE                          ;
logic [1:0]                                      M3_HTRANS                         ;
logic [31:0]                                     M3_HWDATA                         ;
logic                                            M3_HWRITE                         ;
logic                                            M3_HREADY                         ;
logic                                            M3_HRESP                          ;
logic [1:0]                                      M3_Pri                            ;
logic [31:0]                                     HADDR                             ;
logic [2:0]                                      HBURST                            ;
logic                                            HMASTLOCK                         ;
logic [3:0]                                      HPROT                             ;
logic [2:0]                                      HSIZE                             ;
logic [1:0]                                      HTRANS                            ;
logic [31:0]                                     HWDATA                            ;
logic                                            HWRITE                            ;
logic                                            s0_HSEL                           ;
logic                                            s1_HSEL                           ;
logic                                            s2_HSEL                           ;
logic                                            s3_HSEL                           ;
logic                                            s4_HSEL                           ;
logic                                            s5_HSEL                           ;
logic                                            s6_HSEL                           ;
logic [31:0]                                     s0_HRDATA                         ;
logic                                            s0_HREADYOUT                      ;
logic                                            s0_HRESP                          ;
logic                                            s0_HREADY                         ;
logic [31:0]                                     s1_HRDATA                         ;
logic                                            s1_HREADYOUT                      ;
logic                                            s1_HRESP                          ;
logic                                            s1_HREADY                         ;
logic [31:0]                                     s2_HRDATA                         ;
logic                                            s2_HREADYOUT                      ;
logic                                            s2_HRESP                          ;
logic                                            s2_HREADY                         ;
logic [31:0]                                     s3_HRDATA                         ;
logic                                            s3_HREADYOUT                      ;
logic                                            s3_HRESP                          ;
logic                                            s3_HREADY                         ;
logic [31:0]                                     s4_HRDATA                         ;
logic                                            s4_HREADYOUT                      ;
logic                                            s4_HRESP                          ;
logic                                            s4_HREADY                         ;
logic [31:0]                                     s5_HRDATA                         ;
logic                                            s5_HREADYOUT                      ;
logic                                            s5_HRESP                          ;
logic                                            s5_HREADY                         ;
logic [31:0]                                     s6_HRDATA                         ;
logic                                            s6_HREADYOUT                      ;
logic                                            s6_HRESP                          ;
logic                                            s6_HREADY                         ;
logic [31:0]                                     HRDATA                            ;
// -------------------------------------------------------------------
// fadb wave
// -------------------------------------------------------------------
initial begin
  $fsdbDumpfile("harness.fsdb");
  $fsdbDumpvars(0,"harness");
  $fsdbDumpMDA();
end

function integer myclog2 (input integer n);
begin
  n                                              = n - 1;
  for (myclog2 = 0; n > 0; myclog2 = myclog2 + 1)
    n                                            = n >> 1;
end
endfunction

// -------------------------------------------------------------------
// clock & reset
// -------------------------------------------------------------------
initial begin
  HCLK                        = 1'b0;
  HRESETn                      = 1'b1;
  # 100 HRESETn = 1'b0;
  # 100 HRESETn = 1'b1;
end

always #(PERIOD_HCLK/2) HCLK = ~HCLK;

// -------------------------------------------------------------------
// Main Code
// -------------------------------------------------------------------

// -----------------> testcase load
`include "./testcase.sv"

// -----------------> DUT Instance

ahb_lite_matrix DUT(
    .HCLK                              (HCLK                                   ),
    .HRESETn                           (HRESETn                                ),
    //Master0
    .M0_HADDR                          (M0_HADDR                               ),
    .M0_HBURST                         (M0_HBURST                              ),
    .M0_HMASTLOCK                      (M0_HMASTLOCK                           ),
    .M0_HPROT                          (M0_HPROT                               ),
    .M0_HSIZE                          (M0_HSIZE                               ),
    .M0_HTRANS                         (M0_HTRANS                              ),
    .M0_HWDATA                         (M0_HWDATA                              ),
    .M0_HWRITE                         (M0_HWRITE                              ),
    .M0_HREADY                         (M0_HREADY                              ),
    .M0_HRESP                          (M0_HRESP                               ),

    .M0_Pri                            (M0_Pri                                 ),
    //Master1
    .M1_HADDR                          (M1_HADDR                               ),
    .M1_HBURST                         (M1_HBURST                              ),
    .M1_HMASTLOCK                      (M1_HMASTLOCK                           ),
    .M1_HPROT                          (M1_HPROT                               ),
    .M1_HSIZE                          (M1_HSIZE                               ),
    .M1_HTRANS                         (M1_HTRANS                              ),
    .M1_HWDATA                         (M1_HWDATA                              ),
    .M1_HWRITE                         (M1_HWRITE                              ),
    .M1_HREADY                         (M1_HREADY                              ),
    .M1_HRESP                          (M1_HRESP                               ),

    .M1_Pri                            (M1_Pri                                 ),

    //Master2
    .M2_HADDR                          (M2_HADDR                               ),
    .M2_HBURST                         (M2_HBURST                              ),
    .M2_HMASTLOCK                      (M2_HMASTLOCK                           ),
    .M2_HPROT                          (M2_HPROT                               ),
    .M2_HSIZE                          (M2_HSIZE                               ),
    .M2_HTRANS                         (M2_HTRANS                              ),
    .M2_HWDATA                         (M2_HWDATA                              ),
    .M2_HWRITE                         (M2_HWRITE                              ),
    .M2_HREADY                         (M2_HREADY                              ),
    .M2_HRESP                          (M2_HRESP                               ),

    .M2_Pri                            (M2_Pri                                 ),

    //Master3
    .M3_HADDR                          (M3_HADDR                               ),
    .M3_HBURST                         (M3_HBURST                              ),
    .M3_HMASTLOCK                      (M3_HMASTLOCK                           ),
    .M3_HPROT                          (M3_HPROT                               ),
    .M3_HSIZE                          (M3_HSIZE                               ),
    .M3_HTRANS                         (M3_HTRANS                              ),
    .M3_HWDATA                         (M3_HWDATA                              ),
    .M3_HWRITE                         (M3_HWRITE                              ),
    .M3_HREADY                         (M3_HREADY                              ),
    .M3_HRESP                          (M3_HRESP                               ),

    .M3_Pri                            (M3_Pri                                 ),


    //output signals
    .HADDR                             (HADDR                                  ),
    .HBURST                            (HBURST                                 ),
    .HMASTLOCK                         (HMASTLOCK                              ),
    .HPROT                             (HPROT                                  ),
    .HSIZE                             (HSIZE                                  ),
    .HTRANS                            (HTRANS                                 ),
    .HWDATA                            (HWDATA                                 ),
    .HWRITE                            (HWRITE                                 ),

    //Hsel
    .s0_HSEL                           (s0_HSEL                                ),
    .s1_HSEL                           (s1_HSEL                                ),
    .s2_HSEL                           (s2_HSEL                                ),
    .s3_HSEL                           (s3_HSEL                                ),
    .s4_HSEL                           (s4_HSEL                                ),
    .s5_HSEL                           (s5_HSEL                                ),
    .s6_HSEL                           (s6_HSEL                                ),

    //Slave0 signals
    .s0_HRDATA                         (s0_HRDATA                              ),
    .s0_HREADYOUT                      (s0_HREADYOUT                           ),
    .s0_HRESP                          (s0_HRESP                               ),
    .s0_HREADY                         (s0_HREADY                              ),
    //Slave1 signals
    .s1_HRDATA                         (s1_HRDATA                              ),
    .s1_HREADYOUT                      (s1_HREADYOUT                           ),
    .s1_HRESP                          (s1_HRESP                               ),
    .s1_HREADY                         (s1_HREADY                              ),
    //Slave2 signals
    .s2_HRDATA                         (s2_HRDATA                              ),
    .s2_HREADYOUT                      (s2_HREADYOUT                           ),
    .s2_HRESP                          (s2_HRESP                               ),
    .s2_HREADY                         (s2_HREADY                              ),
    //Slave3 signals
    .s3_HRDATA                         (s3_HRDATA                              ),
    .s3_HREADYOUT                      (s3_HREADYOUT                           ),
    .s3_HRESP                          (s3_HRESP                               ),
    .s3_HREADY                         (s3_HREADY                              ),
    //Slave4 signals
    .s4_HRDATA                         (s4_HRDATA                              ),
    .s4_HREADYOUT                      (s4_HREADYOUT                           ),
    .s4_HRESP                          (s4_HRESP                               ),
    .s4_HREADY                         (s4_HREADY                              ),
    //Slave5 signals
    .s5_HRDATA                         (s5_HRDATA                              ),
    .s5_HREADYOUT                      (s5_HREADYOUT                           ),
    .s5_HRESP                          (s5_HRESP                               ),
    .s5_HREADY                         (s5_HREADY                              ),
    //Slave6 signals
    .s6_HRDATA                         (s6_HRDATA                              ),
    .s6_HREADYOUT                      (s6_HREADYOUT                           ),
    .s6_HRESP                          (s6_HRESP                               ),
    .s6_HREADY                         (s6_HREADY                              ),

    //output signals
    .HRDATA                            (HRDATA                                 )
);

wire [7:0]  s0_BRAM_RDADDR;
wire [7:0]  s0_BRAM_WRADDR;
wire [31:0] s0_BRAM_RDATA; 
wire [31:0] s0_BRAM_WDATA; 
wire [3:0]  s0_BRAM_WRITE; 
AHBlite_Block_RAM #(
    .ADDR_WIDTH                        (8                                      ))
    U_S0
(
    .HCLK                              (HCLK                                   ),
    .HRESETn                           (HRESETn                                ),
    .HSEL                              (s0_HSEL                                ),
    .HADDR                             (HADDR                                  ),
    .HTRANS                            (HTRANS                                 ),
    .HSIZE                             (HSIZE                                  ),
    .HPROT                             (HPROT                                  ),
    .HWRITE                            (HWRITE                                 ),
    .HWDATA                            (HWDATA                                 ),
    .HREADY                            (s0_HREADY                              ),
    .HREADYOUT                         (s0_HREADYOUT                           ),
    .HRDATA                            (s0_HRDATA                              ),
    .HRESP                             (s0_HRESP                               ),
    .BRAM_RDADDR                       (s0_BRAM_RDADDR                         ),
    .BRAM_WRADDR                       (s0_BRAM_WRADDR                         ),
    .BRAM_RDATA                        (s0_BRAM_RDATA                          ),
    .BRAM_WDATA                        (s0_BRAM_WDATA                          ),
    .BRAM_WRITE                        (s0_BRAM_WRITE                          )
);

Block_RAM #(
    .ADDR_WIDTH                        (8                                      )
) U_BRAM0
(
    .clka                              (HCLK                                   ),
    .addra                             (s0_BRAM_WRADDR                         ),
    .addrb                             (s0_BRAM_RDADDR                         ),
    .dina                              (s0_BRAM_WDATA                          ),
    .wea                               (s0_BRAM_WRITE                          ),
    .doutb                             (s0_BRAM_RDATA                          )
);

wire [7:0]  s1_BRAM_RDADDR;
wire [7:0]  s1_BRAM_WRADDR;
wire [31:0] s1_BRAM_RDATA; 
wire [31:0] s1_BRAM_WDATA; 
wire [3:0]  s1_BRAM_WRITE; 
AHBlite_Block_RAM #(
    .ADDR_WIDTH                        (8                                      ))
    U_S1
(
    .HCLK                              (HCLK                                   ),
    .HRESETn                           (HRESETn                                ),
    .HSEL                              (s1_HSEL                                ),
    .HADDR                             (HADDR                                  ),
    .HTRANS                            (HTRANS                                 ),
    .HSIZE                             (HSIZE                                  ),
    .HPROT                             (HPROT                                  ),
    .HWRITE                            (HWRITE                                 ),
    .HWDATA                            (HWDATA                                 ),
    .HREADY                            (s1_HREADY                              ),
    .HREADYOUT                         (s1_HREADYOUT                           ),
    .HRDATA                            (s1_HRDATA                              ),
    .HRESP                             (s1_HRESP                               ),
    .BRAM_RDADDR                       (s1_BRAM_RDADDR                         ),
    .BRAM_WRADDR                       (s1_BRAM_WRADDR                         ),
    .BRAM_RDATA                        (s1_BRAM_RDATA                          ),
    .BRAM_WDATA                        (s1_BRAM_WDATA                          ),
    .BRAM_WRITE                        (s1_BRAM_WRITE                          )
);

Block_RAM #(
    .ADDR_WIDTH                        (8                                      )
) U_BRAM1
(
    .clka                              (HCLK                                   ),
    .addra                             (s1_BRAM_WRADDR                         ),
    .addrb                             (s1_BRAM_RDADDR                         ),
    .dina                              (s1_BRAM_WDATA                          ),
    .wea                               (s1_BRAM_WRITE                          ),
    .doutb                             (s1_BRAM_RDATA                          )
);

wire [7:0]  s2_BRAM_RDADDR;
wire [7:0]  s2_BRAM_WRADDR;
wire [31:0] s2_BRAM_RDATA; 
wire [31:0] s2_BRAM_WDATA; 
wire [3:0]  s2_BRAM_WRITE; 
AHBlite_Block_RAM #(
    .ADDR_WIDTH                        (8                                      ))
    U_S2
(
    .HCLK                              (HCLK                                   ),
    .HRESETn                           (HRESETn                                ),
    .HSEL                              (s2_HSEL                                ),
    .HADDR                             (HADDR                                  ),
    .HTRANS                            (HTRANS                                 ),
    .HSIZE                             (HSIZE                                  ),
    .HPROT                             (HPROT                                  ),
    .HWRITE                            (HWRITE                                 ),
    .HWDATA                            (HWDATA                                 ),
    .HREADY                            (s2_HREADY                              ),
    .HREADYOUT                         (s2_HREADYOUT                           ),
    .HRDATA                            (s2_HRDATA                              ),
    .HRESP                             (s2_HRESP                               ),
    .BRAM_RDADDR                       (s2_BRAM_RDADDR                         ),
    .BRAM_WRADDR                       (s2_BRAM_WRADDR                         ),
    .BRAM_RDATA                        (s2_BRAM_RDATA                          ),
    .BRAM_WDATA                        (s2_BRAM_WDATA                          ),
    .BRAM_WRITE                        (s2_BRAM_WRITE                          )
);

Block_RAM #(
    .ADDR_WIDTH                        (8                                      )
) U_BRAM2
(
    .clka                              (HCLK                                   ),
    .addra                             (s2_BRAM_WRADDR                         ),
    .addrb                             (s2_BRAM_RDADDR                         ),
    .dina                              (s2_BRAM_WDATA                          ),
    .wea                               (s2_BRAM_WRITE                          ),
    .doutb                             (s2_BRAM_RDATA                          )
);

wire [7:0]  s3_BRAM_RDADDR;
wire [7:0]  s3_BRAM_WRADDR;
wire [31:0] s3_BRAM_RDATA; 
wire [31:0] s3_BRAM_WDATA; 
wire [3:0]  s3_BRAM_WRITE; 
AHBlite_Block_RAM #(
    .ADDR_WIDTH                        (8                                      ))
    U_S3
(
    .HCLK                              (HCLK                                   ),
    .HRESETn                           (HRESETn                                ),
    .HSEL                              (s3_HSEL                                ),
    .HADDR                             (HADDR                                  ),
    .HTRANS                            (HTRANS                                 ),
    .HSIZE                             (HSIZE                                  ),
    .HPROT                             (HPROT                                  ),
    .HWRITE                            (HWRITE                                 ),
    .HWDATA                            (HWDATA                                 ),
    .HREADY                            (s3_HREADY                              ),
    .HREADYOUT                         (s3_HREADYOUT                           ),
    .HRDATA                            (s3_HRDATA                              ),
    .HRESP                             (s3_HRESP                               ),
    .BRAM_RDADDR                       (s3_BRAM_RDADDR                         ),
    .BRAM_WRADDR                       (s3_BRAM_WRADDR                         ),
    .BRAM_RDATA                        (s3_BRAM_RDATA                          ),
    .BRAM_WDATA                        (s3_BRAM_WDATA                          ),
    .BRAM_WRITE                        (s3_BRAM_WRITE                          )
);

Block_RAM #(
    .ADDR_WIDTH                        (8                                      )
) U_BRAM3
(
    .clka                              (HCLK                                   ),
    .addra                             (s3_BRAM_WRADDR                         ),
    .addrb                             (s3_BRAM_RDADDR                         ),
    .dina                              (s3_BRAM_WDATA                          ),
    .wea                               (s3_BRAM_WRITE                          ),
    .doutb                             (s3_BRAM_RDATA                          )
);

wire [7:0]  s4_BRAM_RDADDR;
wire [7:0]  s4_BRAM_WRADDR;
wire [31:0] s4_BRAM_RDATA; 
wire [31:0] s4_BRAM_WDATA; 
wire [3:0]  s4_BRAM_WRITE; 
AHBlite_Block_RAM #(
    .ADDR_WIDTH                        (8                                      ))
    U_S4
(
    .HCLK                              (HCLK                                   ),
    .HRESETn                           (HRESETn                                ),
    .HSEL                              (s4_HSEL                                ),
    .HADDR                             (HADDR                                  ),
    .HTRANS                            (HTRANS                                 ),
    .HSIZE                             (HSIZE                                  ),
    .HPROT                             (HPROT                                  ),
    .HWRITE                            (HWRITE                                 ),
    .HWDATA                            (HWDATA                                 ),
    .HREADY                            (s4_HREADY                              ),
    .HREADYOUT                         (s4_HREADYOUT                           ),
    .HRDATA                            (s4_HRDATA                              ),
    .HRESP                             (s4_HRESP                               ),
    .BRAM_RDADDR                       (s4_BRAM_RDADDR                         ),
    .BRAM_WRADDR                       (s4_BRAM_WRADDR                         ),
    .BRAM_RDATA                        (s4_BRAM_RDATA                          ),
    .BRAM_WDATA                        (s4_BRAM_WDATA                          ),
    .BRAM_WRITE                        (s4_BRAM_WRITE                          )
);

Block_RAM #(
    .ADDR_WIDTH                        (8                                      )
) U_BRAM4
(
    .clka                              (HCLK                                   ),
    .addra                             (s4_BRAM_WRADDR                         ),
    .addrb                             (s4_BRAM_RDADDR                         ),
    .dina                              (s4_BRAM_WDATA                          ),
    .wea                               (s4_BRAM_WRITE                          ),
    .doutb                             (s4_BRAM_RDATA                          )
);

wire [7:0]  s5_BRAM_RDADDR;
wire [7:0]  s5_BRAM_WRADDR;
wire [31:0] s5_BRAM_RDATA; 
wire [31:0] s5_BRAM_WDATA; 
wire [3:0]  s5_BRAM_WRITE; 
AHBlite_Block_RAM #(
    .ADDR_WIDTH                        (8                                      ))
    U_S5
(
    .HCLK                              (HCLK                                   ),
    .HRESETn                           (HRESETn                                ),
    .HSEL                              (s5_HSEL                                ),
    .HADDR                             (HADDR                                  ),
    .HTRANS                            (HTRANS                                 ),
    .HSIZE                             (HSIZE                                  ),
    .HPROT                             (HPROT                                  ),
    .HWRITE                            (HWRITE                                 ),
    .HWDATA                            (HWDATA                                 ),
    .HREADY                            (s5_HREADY                              ),
    .HREADYOUT                         (s5_HREADYOUT                           ),
    .HRDATA                            (s5_HRDATA                              ),
    .HRESP                             (s5_HRESP                               ),
    .BRAM_RDADDR                       (s5_BRAM_RDADDR                         ),
    .BRAM_WRADDR                       (s5_BRAM_WRADDR                         ),
    .BRAM_RDATA                        (s5_BRAM_RDATA                          ),
    .BRAM_WDATA                        (s5_BRAM_WDATA                          ),
    .BRAM_WRITE                        (s5_BRAM_WRITE                          )
);

Block_RAM #(
    .ADDR_WIDTH                        (8                                      )
) U_BRAM5
(
    .clka                              (HCLK                                   ),
    .addra                             (s5_BRAM_WRADDR                         ),
    .addrb                             (s5_BRAM_RDADDR                         ),
    .dina                              (s5_BRAM_WDATA                          ),
    .wea                               (s5_BRAM_WRITE                          ),
    .doutb                             (s5_BRAM_RDATA                          )
);

wire [7:0]  s6_BRAM_RDADDR;
wire [7:0]  s6_BRAM_WRADDR;
wire [31:0] s6_BRAM_RDATA; 
wire [31:0] s6_BRAM_WDATA; 
wire [3:0]  s6_BRAM_WRITE; 
AHBlite_Block_RAM #(
    .ADDR_WIDTH                        (8                                      ))
    U_S6
(
    .HCLK                              (HCLK                                   ),
    .HRESETn                           (HRESETn                                ),
    .HSEL                              (s6_HSEL                                ),
    .HADDR                             (HADDR                                  ),
    .HTRANS                            (HTRANS                                 ),
    .HSIZE                             (HSIZE                                  ),
    .HPROT                             (HPROT                                  ),
    .HWRITE                            (HWRITE                                 ),
    .HWDATA                            (HWDATA                                 ),
    .HREADY                            (s6_HREADY                              ),
    .HREADYOUT                         (s6_HREADYOUT                           ),
    .HRDATA                            (s6_HRDATA                              ),
    .HRESP                             (s6_HRESP                               ),
    .BRAM_RDADDR                       (s6_BRAM_RDADDR                         ),
    .BRAM_WRADDR                       (s6_BRAM_WRADDR                         ),
    .BRAM_RDATA                        (s6_BRAM_RDATA                          ),
    .BRAM_WDATA                        (s6_BRAM_WDATA                          ),
    .BRAM_WRITE                        (s6_BRAM_WRITE                          )
);

Block_RAM #(
    .ADDR_WIDTH                        (8                                      )
) U_BRAM6
(
    .clka                              (HCLK                                   ),
    .addra                             (s6_BRAM_WRADDR                         ),
    .addrb                             (s6_BRAM_RDADDR                         ),
    .dina                              (s6_BRAM_WDATA                          ),
    .wea                               (s6_BRAM_WRITE                          ),
    .doutb                             (s6_BRAM_RDATA                          )
);




// -------------------------------------------------------------------
// Assertion Declarations
// -------------------------------------------------------------------
`ifdef SOC_ASSERT_ON

`endif
endmodule
