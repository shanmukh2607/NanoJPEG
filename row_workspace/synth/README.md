# Synthesis and Testing

Synthesized rowidct.v using yosys into rowict_synth.v <br>
rowidct_synth.v successful in simulation on tb.v too.<br>
synthesis.txt has the yosys synthesis message.<br>
To run the simulation on synthesized verilog file use command $ iverilog rowidct_synth.v tb.v /usr/share/yosys/xilinx/cells_sim.v