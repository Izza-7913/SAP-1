module ADD_OR_NOT(
  input logic A,
  input logic B,
  input logic C,
  output logic sum,
  output logic carry
);
    assign sum = A ^ B ^ C;
    assign carry = (A & B) | (C & (A | B));
endmodule

module ALU(
    input logic [7:0] operand1,
    input logic [7:0] operand2,
    input logic mode,
    input logic enable,
    output logic [7:0] result_output
);

    wire co0, co1, co2, co3, co4, co5, co6, co7;
    logic [7:0] sum;

    ADD_OR_NOT FA0(operand1[0], (mode ? ~operand2[0] : operand2[0]), mode, sum[0], co0);
    ADD_OR_NOT FA1(operand1[1], (mode ? ~operand2[1] : operand2[1]), co0, sum[1], co1);
    ADD_OR_NOT FA2(operand1[2], (mode ? ~operand2[2] : operand2[2]), co1, sum[2], co2);
    ADD_OR_NOT FA3(operand1[3], (mode ? ~operand2[3] : operand2[3]), co2, sum[3], co3);
    ADD_OR_NOT FA4(operand1[4], (mode ? ~operand2[4] : operand2[4]), co3, sum[4], co4);
    ADD_OR_NOT FA5(operand1[5], (mode ? ~operand2[5] : operand2[5]), co4, sum[5], co5);
    ADD_OR_NOT FA6(operand1[6], (mode ? ~operand2[6] : operand2[6]), co5, sum[6], co6);
    ADD_OR_NOT FA7(operand1[7], (mode ? ~operand2[7] : operand2[7]), co6, sum[7], co7);

       assign result_output = enable ? sum : 8'bzzzzzz;          

endmodule
