// mux_beh.v
// 2-to-1 multiplexer, BEHAVIORAL style.
//
// Procedural assignments need a variable (reg) to hold their assigned value.
// A wire cannot be a procedural assignment target; reg does not imply a flop.

module mux_beh (
  input       I0,
  input       I1,
  input       S,
  output reg Y
);

  always @(*) begin
    if (S)
      Y = I1;
    else
      Y = I0;
  end

endmodule

