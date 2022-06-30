module rand_pio (
            input wire        reset,
            input wire        clk,
            input wire [1:0]  address,
            input wire        read,
            output reg [31:0] readdata,
            input wire        write,
            input wire [31:0] writedata
);

    wire [31:0] rand_out;
    reg [31:0] rand_value;

    xorshift128 xorshift128(clk, reset, rand_out);

    always @ (posedge clk, posedge reset) begin
        if (reset) begin
            rand_value <= 32'd0;
        end
        else begin
            rand_value <= rand_out;
            if (write) begin
                case (address)
                    2'b00: rand_value <= writedata;
                endcase
            end
            if (read) begin
                case (address)
                    2'b00: readdata <= rand_value;
                endcase
            end
        end
    end

endmodule
