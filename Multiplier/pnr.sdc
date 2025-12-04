#=====================================
# PNR SDC File
#=====================================

#Clock Definitions
set clk_period 2
set uncert_hold [expr 0.005 * $clk_period]
set uncert_setup [expr 0.01 * $clk_period]
set clk_max_latency [expr 0.02 * $clk_period]
set clk_min_latency [expr 0.015 * $clk_period]
set input_delay [expr 0.1 * $clk_period]
set output_delay [expr 0.1 * $clk_period]

create_clock -period $clk_period [get_ports clk]

set_clock_uncertainty -hold $uncert_hold [get_clocks clk]
set_clock_uncertainty -setup $uncert_setup [get_clocks clk]

#False path
set_false_path -from [get_ports rst]

#Input port delays
set_input_delay -max $input_delay -clock [get_clocks clk] [get_ports {a[*]}]
set_input_delay -max $input_delay -clock [get_clocks clk] [get_ports {b[*]}]

#Output port delays
set_output_delay -max $output_delay -clock [get_clocks clk] [get_ports {product[*]}]

