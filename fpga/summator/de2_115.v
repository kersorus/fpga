/*
 * Template file that can be used in many projects
 */

`ifdef ICARUS_VERILOG
`include "lib/library.v"
`endif

`include "summ.v"

module de2_115
(
  input  wire        CLOCK_50, // Clock
  input  wire [17:0] SW,       // Switches
  input  wire [3:0]  KEY,      // Buttons, 1 when unpressed
  output wire [17:0] LEDR,     // Red leds
  output wire [8:0]  LEDG,     // Green leds
  output wire [6:0]  HEX0,     // 7-segment displays
  output wire [6:0]  HEX1,
  output wire [6:0]  HEX2,
  output wire [6:0]  HEX3,
  output wire [6:0]  HEX4,
  output wire [6:0]  HEX5,
  output wire [6:0]  HEX6,
  output wire [6:0]  HEX7,
  output wire [7:0]  VGA_R,    // VGA
  output wire [7:0]  VGA_G,
  output wire [7:0]  VGA_B,
  output wire        VGA_HS,
  output wire        VGA_VS,
  output wire        VGA_BLANK_N,
  output wire        VGA_SYNC_N
);

  summator
  summ_0
  (
    .clk(CLOCK_50),
    .key0(KEY[0]),
    .key1(KEY[1]),
    .SW(SW[15:0]),
    .LEDR(LEDR[15:0]),
    .LEDG(LEDG[8:0])
  );

endmodule
