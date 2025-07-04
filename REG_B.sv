module REGISTER_B (
    input logic clk,
    input logic load,
    input logic [7:0] data_in,
    output logic [7:0] data_out
);

    logic [7:0] b; // Changed from `reg b` to `logic [7:0] b`

    always_ff @(posedge clk) begin
        if (load) begin
            b <= data_in; 
        end
    end

    assign data_out = b;  

endmodule
