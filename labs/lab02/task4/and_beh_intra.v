// and_beh_intra.v
// Select delay with -DAND_DELAY=1, =2, or =3.
`ifndef AND_DELAY
`define AND_DELAY 3
`endif

module and_beh_intra (input a, input b, output reg y);
  always @(*) begin
    y = #`AND_DELAY a & b;
  end
endmodule