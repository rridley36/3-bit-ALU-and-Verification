module alu #(DATA_WIDTH = 3)(out,sel,in0, in1);
  input [2:0] sel;
  input [DATA_WIDTH-1:0] in0, in1;
  output signed [DATA_WIDTH*2:0] out;		
  reg signed [DATA_WIDTH*2:0] result;
  
  always_comb begin
    case(sel)
      3'd0: result = in0 + in1;				       // Addition
      3'd1: result = in0 - in1;				       // Subtraction
      3'd2: result = in0 * in1; 			       // Multiplication
      3'd3: result = (in1==0) ? 0:in0 / in1;	   // Division (Handle divide by 0)
      3'd4: result = in0 & in1; 				   // Logical AND
      3'd5: result = in0 | in1;				       // Logical OR
      3'd6: result = in0 ^ in1;				       // Logical XOR
      3'd7: result = (in1 != 0) ? in0 % in1 : 0;   // Modulo (Handle modulo by 0)
      default: result = result;
    endcase
  end
  assign out = result;
endmodule
