module sap1_controller (
    input logic clk,
    input logic reset,
    input logic [3:0] opcode,
    output logic [11:0] data_outie,
    output logic clk_out,
    output logic clr_out,
    output logic halt
);

    // State definitions
  
    localparam T0 = 4'b0000; 
  	localparam T1 = 4'b0001;
  	localparam T2 = 4'b0010; 
  	localparam T3 = 4'b0011;
    localparam T4 = 4'b0100; 
  	localparam T5 = 4'b0101;
  	localparam T6 = 4'b0110;
  	localparam T7 = 4'b0111;
    localparam T8 = 4'b1000;
  	localparam T9 = 4'b1001;
  	localparam T10 = 4'b1010;
  	localparam T11 = 4'b1011;
    localparam T12 = 4'b1100;
  	localparam T13 = 4'b1101; 
 	localparam T14 = 4'b1110; 
  	localparam T15 = 4'b1111;

    localparam LDA = 4'b0000; 
  	localparam ADD = 4'b0001; 
  	localparam SUB = 4'b0010;
  	localparam OUT = 4'b1110;
  	localparam HALT_OPCODE = 4'b1111;

  	logic [3:0] state;
  	logic [3:0] next_state;

    // State transition logic
    always_ff @(negedge clk or posedge reset) begin
        if (reset)
            state <= T0;
        else
            state <= next_state;
    end

    // Next state 
    always_comb begin
        case (state)
            T0: next_state = T1;
            T1: next_state = T2;
            T2: begin
                case (opcode)
                    LDA: next_state = T3;
                    ADD: next_state = T6;
                    SUB: next_state = T9;
                    OUT: next_state = T12;
                    HALT_OPCODE: next_state = T15;
                    default: next_state = T0;
                endcase
            end
            T3: next_state = T4;
            T4: next_state = T5;
            T6: next_state = T7;
            T7: next_state = T8;
            T9: next_state = T10;
            T10: next_state = T11;
            T12: next_state = T13;
            T13: next_state = T14;
            T14: next_state = T0;
            T15: next_state = T15; // HALT state remains
            default: next_state = T0;
        endcase
    end

    // Output logic
    always_comb begin
        case (state)
            T0: data_outie = 12'b010111100011; // 0x5E3
            T1: data_outie = 12'b101111100011; // 0xBE3
            T2: data_outie = 12'b001001100011; // 0x263
            T3: data_outie = 12'b000110100011; // 0x1A3
            T4: data_outie = 12'b001011000011; // 0x2C3
            T5: data_outie = 12'b001111100011; // 0x3E3
            T6: data_outie = 12'b000110100011; // 0x1A3
            T7: data_outie = 12'b001011100001; // 0x2E1
            T8: data_outie = 12'b001111000111; // 0x3C7
            T9: data_outie = 12'b000110100011; // 0x1A3
            T10: data_outie = 12'b001011100001; // 0x2E1
            T11: data_outie = 12'b001111001111; // 0x3CF
            T12: data_outie = 12'b001111110010; // 0x3F2
            T13: data_outie = 12'b001111100011; // 0x3E3
            T14: data_outie = 12'b001111100011; // 0x3E3
            T15: begin
                halt = 1'b1; // HALT state sets halt signal
            end
            default: data_outie = 12'b001111100011; //Prevents latches
        endcase
    end

    assign clk_out = clk;
    assign clr_out = reset;

endmodule
