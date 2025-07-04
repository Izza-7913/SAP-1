module IR(
    input logic [7:0] instruction_in,  
    input logic ir_load,
    input logic ir_enable,
    input logic clk,  
    input logic reset,                 
    output logic [3:0] ir_opcode,
    output logic [3:0] ir_operand
);
    logic [3:0] ir_op_t;
    logic [3:0] ir_ad_t;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            ir_op_t <= 4'b0;
            ir_ad_t <= 4'b0;
        end else if (ir_load) begin
            ir_op_t <= instruction_in[7:4];
            ir_ad_t <= instruction_in[3:0];
        end
    end

    assign ir_opcode = ir_op_t;
    assign ir_operand = ir_enable ? ir_ad_t : 4'bz;
endmodule
