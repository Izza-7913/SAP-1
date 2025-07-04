module out_reg(
    input wire [7:0] data_in,
    input wire load,           
    input wire clk, 
    input wire reset,
    output reg [7:0] data_out  
);

  reg [7:0] out_temppie;
  
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      out_temppie <= 8'b0;
    end else if (load) begin
      out_temppie <= data_in;
  	end
  end

  assign data_out = out_temppie;

endmodule
