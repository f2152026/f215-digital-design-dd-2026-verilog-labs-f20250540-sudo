// tb.v
// Check all 8 combinations of I0, I1, S, applied 5 time units apart.

module tb;

  reg t_i0, t_i1, t_s;
  wire t_y;
  integer i;
  integer errors;

  DUT DUT (.I0(t_i0), .I1(t_i1), .S(t_s), .Y(t_y));


  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    errors = 0;
    for (i = 0; i < 8; i = i + 1) begin
      {t_i0, t_i1, t_s} = i;
      #5;
      if (t_y !== (t_s ? t_i1 : t_i0)) begin
        $display("FAIL at time %0t: I0=%b I1=%b S=%b Y=%b",
                 $time, t_i0, t_i1, t_s, t_y);
        errors = errors + 1;
      end
    end
    $display("Mux: %0d/8 passed", 8 - errors);
    if (errors != 0) $fatal(1, "Mux failed");
    $finish;
  end

  initial
    $monitor($time, " I0=%b I1=%b S=%b | Y=%b", t_i0, t_i1, t_s, t_y);

endmodule