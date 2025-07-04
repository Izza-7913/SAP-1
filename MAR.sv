module MAR(
    input logic [3:0] w_bus,
    input logic load,
    input logic clk,
    input logic reset,
    output logic [3:0] mar_address
);
    logic [3:0] mar_temp;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            mar_temp <= 4'b0000;
        end 
        else if (load) begin
            mar_temp <= w_bus;
        end
    end

    assign mar_address = mar_temp;
endmodule
