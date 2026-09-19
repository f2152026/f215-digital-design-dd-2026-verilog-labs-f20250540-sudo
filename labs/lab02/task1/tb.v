// mux_df.v
// 2-to-1 multiplexer, DATAFLOW style.
//
// A continuous assignment drives a net, so Y must be a wire in Verilog.
// Declaring Y as reg incorrectly makes a procedural variable its target.

module mux_df (
  input      I0,
  input      I1,
  input      S,
  output wire Y
);

  assign Y = S ? I1 : I0;

endmodule