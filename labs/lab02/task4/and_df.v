// and_df.v
// Compile with -DAND_DELAY=1, =2, or =3 to run parts (a), (b), and (c).
// (a) Delay 1: all three reproduce the AND result one time unit later.
//     Outputs rise at 5, 9, 13 and fall at 7, 11, 15.
// (b) Delay 2: dataflow reproduces the two-unit pulses, delayed by two.
//     In this Icarus run, before stays 0; intra rises at 6 and stays 1.
//     Procedural wakeups coincide with stimulus changes, creating races;
//     neither procedural result is a reliable delayed AND waveform.
// (c) Delay 3: dataflow stays 0 after time 3, correctly filtering pulses
//     shorter than its inertial delay. Before also stays 0 in this run;
//     intra rises at 7 and stays 1 after missing the falling transitions.
//     None reproduces every input pulse as a pure transport delay would.
// (d) Continuous assignment reevaluates on input changes and cancels pending
//     changes for pulses shorter than its delay. A blocking procedural delay
//     suspends the always block, so input events during that wait are lost.
//     Before samples the inputs after waiting; intra saves the input result
//     before waiting, then writes that saved (possibly stale) value.
// (e) Allow inputs to settle longer than the modeled delay when checking
//     steady-state logic. Avoid driving inputs exactly at procedural wakeups;
//     compare signals after propagation and account for inertial filtering.
`ifndef AND_DELAY
`define AND_DELAY 3
`endif

module and_df (input a, input b, output wire y);
  assign #`AND_DELAY y = a & b;
endmodule