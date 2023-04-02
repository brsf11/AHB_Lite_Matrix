initial begin
    M0_HADDR     = 32'b0;
    M0_HBURST    = 3'b0;
    M0_HMASTLOCK = 1'b0;
    M0_HPROT     = 4'b0;
    M0_HSIZE     = 3'b010;
    M0_HTRANS    = 2'b0;
    M0_HWRITE    = 1'b0;
    M0_Pri       = 2'b11;

    M1_HADDR     = 32'b0;
    M1_HBURST    = 3'b0;
    M1_HMASTLOCK = 1'b0;
    M1_HPROT     = 4'b0;
    M1_HSIZE     = 3'b010;
    M1_HTRANS    = 2'b0;
    M1_HWRITE    = 1'b0;
    M1_Pri       = 2'b10;

    M2_HADDR     = 32'b0;
    M2_HBURST    = 3'b0;
    M2_HMASTLOCK = 1'b0;
    M2_HPROT     = 4'b0;
    M2_HSIZE     = 3'b010;
    M2_HTRANS    = 2'b0;
    M2_HWRITE    = 1'b0;
    M2_Pri       = 2'b01;

    M3_HADDR     = 32'b0;
    M3_HBURST    = 3'b0;
    M3_HMASTLOCK = 1'b0;
    M3_HPROT     = 4'b0;
    M3_HSIZE     = 3'b010;
    M3_HTRANS    = 2'b0;
    M3_HWRITE    = 1'b0;
    M3_Pri       = 2'b00;
end

task m0_ahb_w(input [31:0] addr,input [31:0] wdata);
    M0_HADDR  = addr;
    M0_HTRANS = 2'b10;
    M0_HWRITE = 1'b1;
    @(posedge HCLK);
    while(M0_HREADY == 1'b0)begin
        @(posedge HCLK);
    end
    #1;
    M0_HWDATA = wdata;
    M0_HTRANS = 2'b00;
    M0_HWRITE = 1'b0;
endtask

task m0_ahb_r(input [31:0] addr,output [31:0] rdata);
    M0_HADDR  = addr;
    M0_HTRANS = 2'b10;
    M0_HWRITE = 1'b0;
    @(posedge HCLK);
    while(M0_HREADY == 1'b0)begin
        @(posedge HCLK);
    end
    #1;
    M0_HTRANS = 2'b0;
    @(posedge HCLK);
    while(M0_HREADY == 1'b0)begin
        @(posedge HCLK);
    end
    rdata = HRDATA;
endtask

task m1_ahb_w(input [31:0] addr,input [31:0] wdata);
    M1_HADDR  = addr;
    M1_HTRANS = 2'b10;
    M1_HWRITE = 1'b1;
    @(posedge HCLK);
    while(M1_HREADY == 1'b0)begin
        @(posedge HCLK);
    end
    #1;
    M1_HWDATA = wdata;
    M1_HTRANS = 2'b00;
    M1_HWRITE = 1'b0;
endtask

task m1_ahb_r(input [31:0] addr,output [31:0] rdata);
    M1_HADDR  = addr;
    M1_HTRANS = 2'b10;
    M1_HWRITE = 1'b0;
    @(posedge HCLK);
    while(M1_HREADY == 1'b0)begin
        @(posedge HCLK);
    end
    #1;
    M1_HTRANS = 2'b0;
    @(posedge HCLK);
    while(M1_HREADY == 1'b0)begin
        @(posedge HCLK);
    end
    rdata = HRDATA;
endtask

task m2_ahb_w(input [31:0] addr,input [31:0] wdata);
    M2_HADDR  = addr;
    M2_HTRANS = 2'b10;
    M2_HWRITE = 1'b1;
    @(posedge HCLK);
    while(M2_HREADY == 1'b0)begin
        @(posedge HCLK);
    end
    #1;
    M2_HWDATA = wdata;
    M2_HTRANS = 2'b00;
    M2_HWRITE = 1'b0;
endtask

task m2_ahb_r(input [31:0] addr,output [31:0] rdata);
    M2_HADDR  = addr;
    M2_HTRANS = 2'b10;
    M2_HWRITE = 1'b0;
    @(posedge HCLK);
    while(M2_HREADY == 1'b0)begin
        @(posedge HCLK);
    end
    #1;
    M2_HTRANS = 2'b0;
    @(posedge HCLK);
    while(M2_HREADY == 1'b0)begin
        @(posedge HCLK);
    end
    rdata = HRDATA;
endtask

task m3_ahb_w(input [31:0] addr,input [31:0] wdata);
    M3_HADDR  = addr;
    M3_HTRANS = 2'b10;
    M3_HWRITE = 1'b1;
    @(posedge HCLK);
    while(M3_HREADY == 1'b0)begin
        @(posedge HCLK);
    end
    #1;
    M3_HWDATA = wdata;
    M3_HTRANS = 2'b00;
    M3_HWRITE = 1'b0;
endtask

task m3_ahb_r(input [31:0] addr,output [31:0] rdata);
    M3_HADDR  = addr;
    M3_HTRANS = 2'b10;
    M3_HWRITE = 1'b0;
    @(posedge HCLK);
    while(M3_HREADY == 1'b0)begin
        @(posedge HCLK);
    end
    #1;
    M3_HTRANS = 2'b0;
    @(posedge HCLK);
    while(M3_HREADY == 1'b0)begin
        @(posedge HCLK);
    end
    rdata = HRDATA;
endtask

task m0_test(input [31:0] addr);
    bit [31:0] rdata;
    m0_ahb_w(addr,addr);
    m0_ahb_r(addr,rdata);
    $display("%t:Request from Master 0:",$time());
    $display("%t:Write and read data %H",$time(),rdata);
endtask

task m1_test(input [31:0] addr);
    bit [31:0] rdata;
    m1_ahb_w(addr,addr);
    m1_ahb_r(addr,rdata);
    $display("%t:Request from Master 1:",$time());
    $display("%t:Write and read data %H",$time(),rdata);
endtask

task m2_test(input [31:0] addr);
    bit [31:0] rdata;
    m2_ahb_w(addr,addr);
    m2_ahb_r(addr,rdata);
    $display("%t:Request from Master 2:",$time());
    $display("%t:Write and read data %H",$time(),rdata);
endtask

task m3_test(input [31:0] addr);
    bit [31:0] rdata;
    m3_ahb_w(addr,addr);
    m3_ahb_r(addr,rdata);
    $display("%t:Request from Master 3:",$time());
    $display("%t:Write and read data %H",$time(),rdata);
endtask