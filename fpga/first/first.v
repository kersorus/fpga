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

module first
(
    input clk,
    input key0,
    input key1,
    input key2,
    output [6:0] HEX
);

reg [3:0] sum;
wire push2, push1, push0;

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

hex2sem
hex
(
    .hex(sum),
    .segm(HEX)   
);

always @(posedge clk)
begin
    if (push0)
        sum <= 0;  
    else 
    if (push1)
        begin
        if (sum == 4'h9)
            sum <= 0;
        else       
            sum <= sum + 1;
        end
    else
    if (push2)
        begin 
        if (sum == 0)
            sum <= 4'h9;
        else
            sum <= sum - 1;
        end
end

endmodule
