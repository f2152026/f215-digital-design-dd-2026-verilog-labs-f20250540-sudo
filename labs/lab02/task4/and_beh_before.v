// and_beh_before.v
// Select delay with -DAND_DELAY=1, =2, or =3.
`ifndef AND_DELAY
`define AND_DELAY 3
`endif

module and_beh_before (input a, input b, output reg y);
  always @(*) begin
    #`AND_DELAY y = a & b;
  end
endmodule