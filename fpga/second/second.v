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

module second
(
    input clk,
    input key0,
    input key1,
    input key2,
    output [7:0] LEDG
);

reg [2:0] sum;
wire push2, push1, push0;
wire [7:0] led;

assign LEDG = led;

pushb_
push_2
(
    .clk(clk),
    .key0(key2),
    .push(push2)
);

pushb_
push_1
(
    .clk(clk),
    .key0(key1),
    .push(push1)
);

pushb_
push_0
(
    .clk(clk),
    .key0(key0),
    .push(push0)
);

localparam FREQ_SEC = 50000000;

genvar i;
reg [25:0] count;
reg [2:0] res;

always @(posedge clk)
begin
    count <= (count == FREQ_SEC - 1) ? 0 : count + 1;

    if (push0)
        sum <= 0;
    else
    if (push1)
        sum <= sum + 1;
    else
    if (push2)
        sum <= sum - 1;
end

generate
for (i = 0; i < 7; i = i + 1)
begin: loop
    assign led[i] = (i < sum) & (count < FREQ_SEC / 2);
end
endgenerate

endmodule
