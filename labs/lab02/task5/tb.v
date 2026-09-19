// tb.v
// Self-checking testbench.

module tb;
  reg [3:0] t_a, t_b;
  reg t_op;
  wire [3:0] t_result;
  reg [3:0] expected;
  integer a_value, b_value, errors, checks;

  alu DUT (.a(t_a), .b(t_b), .op(t_op), .result(t_result));

  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  task check_result;
    begin
      // Assignment to four bits implements arithmetic modulo 16.
      expected = t_op ? (t_a - t_b) : (t_a + t_b);
      #1;
      checks = checks + 1;
      if (t_result !== expected) begin
        $display("FAIL at time %0t: a=%0d b=%0d op=%b got=%b expected=%b",
                 $time, t_a, t_b, t_op, t_result, expected);
        errors = errors + 1;
      end
    end
  endtask

  initial begin
    errors = 0;
    checks = 0;
    for (a_value = 0; a_value < 16; a_value = a_value + 1) begin
      for (b_value = 0; b_value < 16; b_value = b_value + 1) begin
        t_a = a_value;
        t_b = b_value;
        t_op = 0;
        check_result;
        // Only the opcode changes; both operands stay fixed.
        t_op = 1;
        check_result;
        t_op = 0;
        check_result;
      end
    end
    // Hold subtraction selected while changing the operands.
    t_op = 1;
    for (a_value = 0; a_value < 16; a_value = a_value + 1) begin
      for (b_value = 0; b_value < 16; b_value = b_value + 1) begin
        t_a = a_value;
        t_b = b_value;
        check_result;
      end
    end
    $display("ALU: %0d/%0d passed; errors=%0d", checks - errors, checks, errors);
    if (errors != 0) $fatal(1, "ALU failed");
    $finish;
  end
endmodule