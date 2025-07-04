module ACC (
    input logic [7:0] data_in,               
    input logic clk, 
  	input logic reset,
    input logic load,              
    input logic enable,              
  	output logic [7:0] data_out, //output bus
  	output logic [7:0] data_out_pt2   //output sub
);

    reg [7:0] reg_data;           

  always_ff @(posedge clk or posedge reset) begin
    if(reset) begin
		reg_data <= 8'b0;
      end 
    else if (load) begin
            reg_data <= data_in;   
        end
    end

    assign data_out = reg_data;
    assign data_out_pt2 = enable ? reg_data: 8'bz;

endmodule
