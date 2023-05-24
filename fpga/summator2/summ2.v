module pushb_
(
	input clk,
	input key0,
	output push
);
reg key_r;
reg key_rr;
always @(posedge clk)
begin
	key_r <= key0;
	key_rr <= key_r;
end
	assign push = ~key_rr & key_r;
endmodule

module hex2sem
(
	input [3:0] hex,
	output [6:0] segm
);
assign segm = (hex == 4'h0) ? 7'b1000000 :
      		  (hex == 4'h1) ? 7'b1111001 :
    		  (hex == 4'h2) ? 7'b0100100 :
    		  (hex == 4'h3) ? 7'b0110000 :
    		  (hex == 4'h4) ? 7'b0011001 :
    		  (hex == 4'h5) ? 7'b0010010 :
    		  (hex == 4'h6) ? 7'b0000010 :
		      (hex == 4'h7) ? 7'b1111000 :
		      (hex == 4'h8) ? 7'b0000000 :
		      (hex == 4'h9) ? 7'b0010000 :
		      (hex == 4'ha) ? 7'b0001000 :
		      (hex == 4'hb) ? 7'b0000011 :
		      (hex == 4'hc) ? 7'b1000110 :
		      (hex == 4'hd) ? 7'b0100001 :
		      (hex == 4'he) ? 7'b0000110 :
		      (hex == 4'hf) ? 7'b0001110 : 7'b0001110;
endmodule


module summator2
(
	input clk,
	input key0,
	input key1,
	input [15:0] SW,
	output [6:0] HEX2,
	output [6:0] HEX3,
	output [6:0] HEX4,
	output [6:0] HEX5,
	output [6:0] HEX6,
	output [6:0] HEX7,
	output LEDG

);

wire push1;
wire push0;
reg [24:0] digits;


pushb_
push_1
(
	.clk	(clk),
	.key0	(key1),
	.push	(push1)
);

pushb_
push_0
(
    .clk    (clk),
    .key0   (key0),
    .push   (push0)
);

wire [6:0] HEX [5:0];
assign HEX2 = HEX[4][6:0];
assign HEX3 = HEX[5][6:0];
assign HEX4 = HEX[0][6:0];
assign HEX5 = HEX[1][6:0];
assign HEX6 = HEX[2][6:0];
assign HEX7 = HEX[3][6:0];

genvar i;
generate
for (i = 0; i < 6; i = i + 1)
begin: loop1
hex2sem
hex000
(
    .hex    (digits[(3 + i * 4):(i * 4)]),
    .segm   (HEX[i])
);
end
endgenerate

always @(posedge clk)
begin
    digits[15:8] <= SW[15:8];
    digits[7:0] <= SW[7:0];

    if (push0)
        digits[24:16] <= 0;
    else if (push1 & ~push0)
        digits[24:16] <= SW[15:8] + SW[7:0];
end

assign LEDG = digits[24];

endmodule 
