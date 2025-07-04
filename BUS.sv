module Bus (
    input logic [11:0] controlbus,
    input logic [3:0] address_out,
    input logic [3:0] instruction_out,
    input logic [7:0] sum_out,
    input logic [7:0] ram_out,
    input logic [7:0] acc_out2,
    output logic [7:0] databus
);

    always_comb begin
        case (controlbus)
            12'h1A3: databus = {4'b0000, address_out};
            12'h5E3: databus = {4'b0000, instruction_out};
            12'h3C7: databus = sum_out;
            12'h3CF: databus = sum_out;
            12'h263: databus = ram_out;
            12'h2C3: databus = ram_out;
            12'h2E1: databus = ram_out;
            12'h3F2: databus = acc_out2;
            12'h3F3: databus = 8'bzzzz;
            default: databus = 8'bzzzz;
        endcase
    end

endmodule
