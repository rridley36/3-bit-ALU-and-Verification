module alu_tb;
  localparam DATA_WIDTH = 3;
  localparam NUM_COMBINATIONS = 2 ** (2 * DATA_WIDTH + 3);
  reg [2:0] sel;
  reg [DATA_WIDTH-1:0] in0, in1;
  wire signed [DATA_WIDTH*2:0] out;		
  reg signed [DATA_WIDTH*2:0] expectedResult;

  alu DUT_1(out, sel, in0, in1);  // Instantiate ALU

  initial begin
    for (int i = 0; i < NUM_COMBINATIONS; i = i + 1) begin 
      {sel, in0, in1} = i;        // Generate inputs
      #5;                         // Delay 5 nsec for propogation delay
      // Calculate expected result based on sel
      case(sel)
        3'd0: expectedResult = in0 + in1;					// Addition
        3'd1: expectedResult = in0 - in1;					// Subtraction
        3'd2: expectedResult = in0 * in1;					// Multiplication
        3'd3: expectedResult = (in1 != 0) ? in0 / in1 : 0;  // Handle division by 0
        3'd4: expectedResult = in0 & in1;					// Logical AND
        3'd5: expectedResult = in0 | in1;					// Logical OR
        3'd6: expectedResult = in0 ^ in1;					// Logical XOR
        3'd7: expectedResult = (in1 != 0) ? in0 % in1 : 0;  // Modulo (Handle modulo by 0)
        default: expectedResult = 0;
      endcase
      verifyResult();
    end
    $display("ALL TEST CASES PASSED");
    $finish;
  end
  task verifyResult;
    if (out == expectedResult) begin
      case(sel)
        3'd0: $display("PASS: %d + %d = %d", in0, in1, out);
        3'd1: $display("PASS: %d - %d = %d", in0, in1, out);
        3'd2: $display("PASS: %d * %d = %d", in0, in1, out);
        3'd3: $display("PASS: %d / %d = %d", in0, in1, out);
        3'd4: $display("PASS: %d & %d = %d", in0, in1, out);
        3'd5: $display("PASS: %d | %d = %d", in0, in1, out);
        3'd6: $display("PASS: %d ^ %d = %d", in0, in1, out);
        3'd7: $display("PASS: %d %% %d = %d", in0, in1, out);
      endcase
    end
    else begin
      $display("FAIL: sel = %d, in0 = %d, in1 = %d, expected = %d, got = %d", sel, in0, in1, expectedResult, out);
      $finish();
    end 
  endtask
endmodule
