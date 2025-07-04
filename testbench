module SAP1_tb;
  logic clock;                   
  logic reset_signal;                   
  logic halt;
  logic [7:0] data_output;
  
  
  SAP1 SAPPIE (
      .clk(clock),
      .reset(reset_signal),
      .sappie_out(data_output),
      .halt(halt)
  );
  
  initial begin
    clock = 1;
    forever #5 clock = ~clock;
  end

  initial begin
    reset_signal = 1;
    #10
    reset_signal = 0;
    
    repeat (48) begin
      if(halt == 1'b1)
        $finish;
      @(posedge clock);
  	end
    $finish;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, SAPPIE); 
  end
endmodule



