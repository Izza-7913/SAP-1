module PC(
    input logic CLK,
    input logic CLR, 
    input logic PE_in,
  	input logic PE_enable,
    output logic [3:0] address
);
  reg [3:0] pc_temp;
  always_ff @(posedge CLK or posedge CLR) begin
    if (CLR) begin
            pc_temp <= 4'b0000; 
    end 
    else if (PE_in) begin
      pc_temp <= (pc_temp + 1) % 8;; 
    end
  end
  
  assign address = PE_enable ? pc_temp : 4'bzzzz;
  
endmodule
