`include "PC.sv"
`include "MAR.sv"
`include "IR.sv"
`include "ACC.sv"
`include "SEQUENCER.sv"
`include "ALU.sv"
`include "RAM.sv"
`include "BUS.sv"
`include "OUT_PLUS_B_REG.sv"

module SAP1 (
    input logic clk,
    input logic reset,
  	output logic [7:0] sappie_out,
    output logic halt
);

    logic [7:0] Wbus; // Internal bus
    logic [11:0] control_bus;
  	logic [7:0] accumulator_data, alu_output_data, reg_b_data, ram_output;
  	logic [3:0] ir_output, address_where, opcode, address_out;
    logic [7:0] x; 
	logic clk_out;
  	logic reset_out;

    // SAP1 Controller
    sap1_controller controller_inst(
        .clk(clk),
        .reset(reset),
      	.opcode(opcode),
      	.data_outie(control_bus),
      	.clk_out(clk_out),
      	.clr_out(reset_out),
      	.halt(halt)
    );

    // Program Counter module
    PC pc_inst(
        .CLK(clk),
        .CLR(reset),
        .PE_in(control_bus[11]),
      	.PE_enable(control_bus[10]),
      	.address(ir_output)
    );

   
    MAR mar_inst(
      	.w_bus(Wbus[3:0]),
      	.load(~control_bus[9]),
        .clk(clk),
        .reset(reset),
      	.mar_address(address_where)
    );

    // Instruction Register module
    IR ir_inst(
        .instruction_in(Wbus),
      	.ir_load(~control_bus[7]),
      	.ir_enable(~control_bus[6]),
        .clk(clk),
        .reset(reset),
      	.ir_opcode(opcode),
      	.ir_operand(address_out)
    );

    // Accumulator module
    ACC accumulator_inst(
        .data_in(Wbus),
        .clk(clk),
      	.reset(reset),
      	.load(~control_bus[5]),
        .enable(control_bus[4]),
        .data_out(accumulator_data),
      	.data_out_pt2(x)
    );

    // Register B module
    OUT_PLUS_B_REG reg_b_inst(
      	.data_in(Wbus),
        .clk(clk),
        .reset(reset),
      	.reg_load(~control_bus[1]),
        .reg_enable(1'b1),
      	.data_out(reg_b_data)
    );

    // Output Register module
    OUT_PLUS_B_REG output_register_inst(
        .data_in(Wbus),
      	.clk(clk),
      	.reset(reset),
      	.reg_load(~control_bus[0]),
      	.reg_enable(1'b1),
      	.data_out(sappie_out)
    );

    // ALU module
    ALU add_sub_inst(
      	.operand1(accumulator_data),
      	.operand2(reg_b_data),
        .mode(control_bus[3]),
        .enable(control_bus[2]),
        .result_output(alu_output_data)
    );

    // RAM module
    RAM ram_inst(
      	.ram_in(address_where),
      	.ram_enable(~control_bus[8]),
        .ram_out(ram_output)
    );

  Bus bus_inst(
    .controlbus(control_bus),
    .address_out(address_out),
    .instruction_out(ir_output),
    .sum_out(alu_output_data),
    .ram_out(ram_output),
    .acc_out2(x),
    .databus(Wbus)
  );
endmodule

