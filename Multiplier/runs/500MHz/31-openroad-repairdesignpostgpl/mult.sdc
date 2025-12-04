###############################################################################
# Created by write_sdc
###############################################################################
current_design mult
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 2.0000 [get_ports {clk}]
set_clock_uncertainty -setup 0.0200 clk
set_clock_uncertainty -hold 0.0100 clk
set_input_delay 0.2000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {a[0]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {a[0]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {a[1]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {a[1]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {a[2]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {a[2]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {a[3]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {a[3]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {a[4]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {a[4]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {a[5]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {a[5]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {a[6]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {a[6]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {a[7]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {a[7]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {b[0]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {b[0]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {b[1]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {b[1]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {b[2]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {b[2]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {b[3]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {b[3]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {b[4]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {b[4]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {b[5]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {b[5]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {b[6]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {b[6]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {b[7]}]
set_input_delay 0.2000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {b[7]}]
set_false_path\
    -from [get_ports {rst}]
###############################################################################
# Environment
###############################################################################
###############################################################################
# Design Rules
###############################################################################
