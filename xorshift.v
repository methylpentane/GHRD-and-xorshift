module xorshift128(
    input clk,
    input rstn,
    output reg [31:0] rand
);

reg [31:0] x;
reg [31:0] y;
reg [31:0] z;
reg [31:0] w;
reg [31:0] t;

//async reset
always @ (posedge clk, posedge rstn)
begin
    if (rstn)
    begin
        x <= 123456789;
        y <= 3624360069;
        z <= 521288629;
        w <= 88675123;
        t <= 0;
        rand <= 0;
    end
    else
    begin
        t <= x ^ (x << 11);
        x <= y;
        y <= z;
        z <= w;
        w <= (w ^ (w >>19)) ^ (t ^ (t >> 8));
        rand <= w;
    end
end // always

endmodule
