module OUT_PLUS_B_REG(
  input logic [7:0] data_in,
  input logic clk,
  input logic reset,
  input logic reg_load,
  input logic reg_enable,
  output logic [7:0] data_out
);
  
  logic [7:0] data_tempie;


  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      data_tempie <= 8'b0; 
    end 
    else if (reg_load) begin
      data_tempie <= data_in; 
    end
  end

 
  assign data_out = reg_enable ? data_tempie : 8'bz; 

endmodule
