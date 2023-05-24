module push
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


module summator
(
	input clk,
	input key0,
	input key1,
	input [15:0] SW,
	output [15:0] LEDR,
	output [8:0] LEDG
);

wire push0, push1;
reg [8:0] sum;

push
push_0
(
	.clk	(clk),
	.key0	(key0),
	.push	(push0)
);

push
push_1
(
	.clk	(clk),
	.key0	(key1),
	.push	(push1)

);

always @(posedge clk)
begin
	if (push1 & ~key0)
		sum <= SW[15:8] + SW[7:0];
	else if (~key0)
		sum <= 0;
end

assign LEDR[7:0] = SW[7:0];
assign LEDR[15:8] = SW[15:8];
assign LEDG[8:0] = sum[8:0];

endmodule
