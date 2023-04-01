################################################################################
# Clock period setting
################################################################################
set CLK0_PERIOD              1.0
set CLK1_PERIOD              1.2

################################################################################
# Common variables
################################################################################
set CLK0_SETUP_UNCERTAINTY   [expr $CLK0_PERIOD * 0.1]
set CLK0_HOLD_UNCERTAINTY    0.04
set CLK1_SETUP_UNCERTAINTY   [expr $CLK1_PERIOD * 0.1]
set CLK1_HOLD_UNCERTAINTY    0.04
set CLK_PERIOD_SCALE_RATIO   0.7
set INPUT_DELAY_SCALE_RATIO  0.6
set OUTPUT_DELAY_SCALE_RATIO 0.6
set CLK0_SCALE_PERIOD        [expr $CLK0_PERIOD * $CLK_PERIOD_SCALE_RATIO]
set CLK1_SCALE_PERIOD        [expr $CLK1_PERIOD * $CLK_PERIOD_SCALE_RATIO]

#################################################################################
# Basic Clock Constraints
#################################################################################
# create_clock
create_clock [get_ports HCLK] -name CLK0_NAME -period $CLK0_SCALE_PERIOD

# virtual clock
create_clock -name V_CLK0_NAME -period $CLK0_SCALE_PERIOD

##If there are more than one clock, please modify the below setting and un-comment it
## create_clock1
#create_clock [get_ports *clk] -name CLK1_NAME -period $CLK1_SCALE_PERIOD

## virtual clock1
#create_clock -name V_CLK1_NAME -period $CLK1_SCALE_PERIOD

################################################################################
# IO Delay Setting
################################################################################
set_input_delay  -max [expr $CLK0_SCALE_PERIOD * $INPUT_DELAY_SCALE_RATIO] -clock CLK0_NAME [remove_from_collection [all_inputs] [get_ports {*HCLK* *HRESETn*}]]

set_input_delay  -min 0 -clock CLK0_NAME [remove_from_collection [all_inputs] [get_ports {*HCLK* *HRESETn*}]]

set_output_delay -min 0 -clock CLK0_NAME [all_outputs]

#set_output_delay -max [expr $CLK1_SCALE_PERIOD * $OUTPUT_DELAY_SCALE_RATIO] -clock CLK0_NAME [all_outputs]

#If there are more than one clock, please set the input/output delay for different clock individually

################################################################################
# Clock Group & uncertainty Setting
################################################################################
set_clock_groups -asynchronous -name clock_grp_0 -group {CLK0_NAME V_CLK0_NAME}
#If there are more than one clock, please modify the below setting and un-comment it
#set_clock_groups -asynchronous -name clock_grp_1 -group {CLK1_NAME V_CLK1_NAME}

set_clock_uncertainty -setup $CLK0_SETUP_UNCERTAINTY [get_clocks {V_CLK0_NAME CLK0_NAME}]
set_clock_uncertainty -hold  $CLK0_HOLD_UNCERTAINTY  [get_clocks {V_CLK0_NAME CLK0_NAME}]
#If there are more than one clock, please modify the below setting and un-comment it
#set_clock_uncertainty -setup $CLK1_SETUP_UNCERTAINTY [get_clocks {V_CLK1_NAME CLK1_NAME}]
#set_clock_uncertainty -hold  $CLK1_HOLD_UNCERTAINTY  [get_clocks {V_CLK1_NAME CLK1_NAME}]

################################################################################
# Multicycle Clock Setting
################################################################################
# set_multicycle_path -from [get_pins exp_start_reg/CK] -to [get_pins exp_end_reg/CK] \
# -setup 2 -end

################################################################################
# FalsPath Setting
################################################################################
# set_false_path -hold -from  [get_clocks [list $CPU_CLOCK_NAME V_SYS_CLK V_CPU_CLK]] -to [get_clocks *JTG_CLK]

#set_false_path -from  [get_ports {src_rst_n dst_rst_n}] -to *
