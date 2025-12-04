module mult (clk,
    rst,
    a,
    b,
    product_out);
 input clk;
 input rst;
 input [7:0] a;
 input [7:0] b;
 output [15:0] product_out;

 wire \PPs_r2[0][0] ;
 wire \PPs_r2[1][1] ;
 wire \PPs_r2[2][2] ;
 wire \PPs_r2[3][3] ;
 wire \PPs_r2[4][4] ;
 wire \PPs_r2[5][5] ;
 wire \PPs_r2[6][6] ;
 wire \PPs_r2[7][7] ;
 wire \PPs_r3_remain[0][6] ;
 wire \PPs_r3_remain[1][7] ;
 wire \PPs_w[0][0] ;
 wire \PPs_w[1][1] ;
 wire \PPs_w[2][2] ;
 wire \PPs_w[3][3] ;
 wire \PPs_w[4][4] ;
 wire \PPs_w[5][5] ;
 wire \PPs_w[6][6] ;
 wire \PPs_w[7][7] ;
 wire \S_r3[0][0] ;
 wire \S_r3[0][1] ;
 wire \S_r3[0][2] ;
 wire \S_r3[1][3] ;
 wire \S_r3[1][4] ;
 wire \S_r3[1][5] ;
 wire \S_r4[0] ;
 wire \S_r4[1] ;
 wire \S_r4[2] ;
 wire \S_r4[3] ;
 wire \S_r4[4] ;
 wire \S_r4[5] ;
 wire \S_r4[6] ;
 wire \S_r4[7] ;
 wire \a_r1[0] ;
 wire \a_r1[1] ;
 wire \a_r1[2] ;
 wire \a_r1[3] ;
 wire \a_r1[4] ;
 wire \a_r1[5] ;
 wire \a_r1[6] ;
 wire \a_r1[7] ;
 wire \b_r1[0] ;

 sky130_fd_sc_hd__and2_2 _00_ (.A(\a_r1[6] ),
    .B(\b_r1[0] ),
    .X(\PPs_w[6][6] ));
 sky130_fd_sc_hd__and2_2 _01_ (.A(\b_r1[0] ),
    .B(\a_r1[5] ),
    .X(\PPs_w[5][5] ));
 sky130_fd_sc_hd__and2_2 _02_ (.A(\b_r1[0] ),
    .B(\a_r1[4] ),
    .X(\PPs_w[4][4] ));
 sky130_fd_sc_hd__and2_2 _03_ (.A(\b_r1[0] ),
    .B(\a_r1[3] ),
    .X(\PPs_w[3][3] ));
 sky130_fd_sc_hd__and2_2 _04_ (.A(\b_r1[0] ),
    .B(\a_r1[2] ),
    .X(\PPs_w[2][2] ));
 sky130_fd_sc_hd__and2_2 _05_ (.A(\b_r1[0] ),
    .B(\a_r1[1] ),
    .X(\PPs_w[1][1] ));
 sky130_fd_sc_hd__and2_2 _06_ (.A(\b_r1[0] ),
    .B(\a_r1[0] ),
    .X(\PPs_w[0][0] ));
 sky130_fd_sc_hd__and2_2 _07_ (.A(\b_r1[0] ),
    .B(\a_r1[7] ),
    .X(\PPs_w[7][7] ));
 sky130_fd_sc_hd__dfrtp_2 _08_ (.CLK(clk),
    .D(\S_r3[0][0] ),
    .RESET_B(rst),
    .Q(\S_r4[0] ));
 sky130_fd_sc_hd__dfrtp_2 _09_ (.CLK(clk),
    .D(\S_r3[0][1] ),
    .RESET_B(rst),
    .Q(\S_r4[1] ));
 sky130_fd_sc_hd__dfrtp_2 _10_ (.CLK(clk),
    .D(\S_r3[0][2] ),
    .RESET_B(rst),
    .Q(\S_r4[2] ));
 sky130_fd_sc_hd__dfrtp_2 _11_ (.CLK(clk),
    .D(\S_r3[1][3] ),
    .RESET_B(rst),
    .Q(\S_r4[3] ));
 sky130_fd_sc_hd__dfrtp_2 _12_ (.CLK(clk),
    .D(\S_r3[1][4] ),
    .RESET_B(rst),
    .Q(\S_r4[4] ));
 sky130_fd_sc_hd__dfrtp_2 _13_ (.CLK(clk),
    .D(\S_r3[1][5] ),
    .RESET_B(rst),
    .Q(\S_r4[5] ));
 sky130_fd_sc_hd__dfrtp_2 _14_ (.CLK(clk),
    .D(\PPs_r3_remain[0][6] ),
    .RESET_B(rst),
    .Q(\S_r4[6] ));
 sky130_fd_sc_hd__dfrtp_2 _15_ (.CLK(clk),
    .D(\PPs_r3_remain[1][7] ),
    .RESET_B(rst),
    .Q(\S_r4[7] ));
 sky130_fd_sc_hd__dfrtp_2 _16_ (.CLK(clk),
    .D(\PPs_r2[6][6] ),
    .RESET_B(rst),
    .Q(\PPs_r3_remain[0][6] ));
 sky130_fd_sc_hd__dfrtp_2 _17_ (.CLK(clk),
    .D(\PPs_r2[7][7] ),
    .RESET_B(rst),
    .Q(\PPs_r3_remain[1][7] ));
 sky130_fd_sc_hd__dfrtp_2 _18_ (.CLK(clk),
    .D(\PPs_w[0][0] ),
    .RESET_B(rst),
    .Q(\PPs_r2[0][0] ));
 sky130_fd_sc_hd__dfrtp_2 _19_ (.CLK(clk),
    .D(\PPs_w[1][1] ),
    .RESET_B(rst),
    .Q(\PPs_r2[1][1] ));
 sky130_fd_sc_hd__dfrtp_2 _20_ (.CLK(clk),
    .D(\PPs_w[2][2] ),
    .RESET_B(rst),
    .Q(\PPs_r2[2][2] ));
 sky130_fd_sc_hd__dfrtp_2 _21_ (.CLK(clk),
    .D(\PPs_w[3][3] ),
    .RESET_B(rst),
    .Q(\PPs_r2[3][3] ));
 sky130_fd_sc_hd__dfrtp_2 _22_ (.CLK(clk),
    .D(\S_r4[0] ),
    .RESET_B(rst),
    .Q(product_out[0]));
 sky130_fd_sc_hd__dfrtp_2 _23_ (.CLK(clk),
    .D(\S_r4[1] ),
    .RESET_B(rst),
    .Q(product_out[1]));
 sky130_fd_sc_hd__dfrtp_2 _24_ (.CLK(clk),
    .D(\S_r4[2] ),
    .RESET_B(rst),
    .Q(product_out[2]));
 sky130_fd_sc_hd__dfrtp_2 _25_ (.CLK(clk),
    .D(\S_r4[3] ),
    .RESET_B(rst),
    .Q(product_out[3]));
 sky130_fd_sc_hd__dfrtp_2 _26_ (.CLK(clk),
    .D(\S_r4[4] ),
    .RESET_B(rst),
    .Q(product_out[4]));
 sky130_fd_sc_hd__dfrtp_2 _27_ (.CLK(clk),
    .D(\S_r4[5] ),
    .RESET_B(rst),
    .Q(product_out[5]));
 sky130_fd_sc_hd__dfrtp_2 _28_ (.CLK(clk),
    .D(\S_r4[6] ),
    .RESET_B(rst),
    .Q(product_out[6]));
 sky130_fd_sc_hd__dfrtp_2 _29_ (.CLK(clk),
    .D(\S_r4[7] ),
    .RESET_B(rst),
    .Q(product_out[7]));
 sky130_fd_sc_hd__dfrtp_2 _30_ (.CLK(clk),
    .D(\PPs_w[4][4] ),
    .RESET_B(rst),
    .Q(\PPs_r2[4][4] ));
 sky130_fd_sc_hd__dfrtp_2 _31_ (.CLK(clk),
    .D(\PPs_w[5][5] ),
    .RESET_B(rst),
    .Q(\PPs_r2[5][5] ));
 sky130_fd_sc_hd__dfrtp_2 _32_ (.CLK(clk),
    .D(\PPs_w[6][6] ),
    .RESET_B(rst),
    .Q(\PPs_r2[6][6] ));
 sky130_fd_sc_hd__dfrtp_2 _33_ (.CLK(clk),
    .D(\PPs_w[7][7] ),
    .RESET_B(rst),
    .Q(\PPs_r2[7][7] ));
 sky130_fd_sc_hd__dfrtp_2 _34_ (.CLK(clk),
    .D(\PPs_r2[0][0] ),
    .RESET_B(rst),
    .Q(\S_r3[0][0] ));
 sky130_fd_sc_hd__dfrtp_2 _35_ (.CLK(clk),
    .D(\PPs_r2[1][1] ),
    .RESET_B(rst),
    .Q(\S_r3[0][1] ));
 sky130_fd_sc_hd__dfrtp_2 _36_ (.CLK(clk),
    .D(\PPs_r2[2][2] ),
    .RESET_B(rst),
    .Q(\S_r3[0][2] ));
 sky130_fd_sc_hd__dfrtp_2 _37_ (.CLK(clk),
    .D(\PPs_r2[3][3] ),
    .RESET_B(rst),
    .Q(\S_r3[1][3] ));
 sky130_fd_sc_hd__dfrtp_2 _38_ (.CLK(clk),
    .D(\PPs_r2[4][4] ),
    .RESET_B(rst),
    .Q(\S_r3[1][4] ));
 sky130_fd_sc_hd__dfrtp_2 _39_ (.CLK(clk),
    .D(\PPs_r2[5][5] ),
    .RESET_B(rst),
    .Q(\S_r3[1][5] ));
 sky130_fd_sc_hd__dfrtp_2 _40_ (.CLK(clk),
    .D(a[0]),
    .RESET_B(rst),
    .Q(\a_r1[0] ));
 sky130_fd_sc_hd__dfrtp_2 _41_ (.CLK(clk),
    .D(a[1]),
    .RESET_B(rst),
    .Q(\a_r1[1] ));
 sky130_fd_sc_hd__dfrtp_2 _42_ (.CLK(clk),
    .D(a[2]),
    .RESET_B(rst),
    .Q(\a_r1[2] ));
 sky130_fd_sc_hd__dfrtp_2 _43_ (.CLK(clk),
    .D(a[3]),
    .RESET_B(rst),
    .Q(\a_r1[3] ));
 sky130_fd_sc_hd__dfrtp_2 _44_ (.CLK(clk),
    .D(a[4]),
    .RESET_B(rst),
    .Q(\a_r1[4] ));
 sky130_fd_sc_hd__dfrtp_2 _45_ (.CLK(clk),
    .D(a[5]),
    .RESET_B(rst),
    .Q(\a_r1[5] ));
 sky130_fd_sc_hd__dfrtp_2 _46_ (.CLK(clk),
    .D(a[6]),
    .RESET_B(rst),
    .Q(\a_r1[6] ));
 sky130_fd_sc_hd__dfrtp_2 _47_ (.CLK(clk),
    .D(a[7]),
    .RESET_B(rst),
    .Q(\a_r1[7] ));
 sky130_fd_sc_hd__dfrtp_2 _48_ (.CLK(clk),
    .D(b[0]),
    .RESET_B(rst),
    .Q(\b_r1[0] ));
 sky130_fd_sc_hd__conb_1 _49_ (.LO(product_out[8]));
 sky130_fd_sc_hd__conb_1 _50_ (.LO(product_out[9]));
 sky130_fd_sc_hd__conb_1 _51_ (.LO(product_out[10]));
 sky130_fd_sc_hd__conb_1 _52_ (.LO(product_out[11]));
 sky130_fd_sc_hd__conb_1 _53_ (.LO(product_out[12]));
 sky130_fd_sc_hd__conb_1 _54_ (.LO(product_out[13]));
 sky130_fd_sc_hd__conb_1 _55_ (.LO(product_out[14]));
 sky130_fd_sc_hd__conb_1 _56_ (.LO(product_out[15]));
endmodule
