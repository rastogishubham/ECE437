
`include "cpu_types_pkg.vh"
`include "register_file_if.vh"
import cpu_types_pkg::*;
module register_file
(
	input logic CLK,
	input logic nRST,
	register_file_if.rf rfif
);
	word_t register [31:0];
	always_ff @ (posedge CLK, negedge nRST)
	begin
		if(nRST == 0)
			register <= '{default: '0};
		else if(rfif.WEN == 1 && rfif.wsel != 0)
			register[rfif.wsel] <= rfif.wdat;
		else
			register[0] <= '0;
	
	end
	assign rfif.rdat1 = register[rfif.rsel1];
	assign rfif.rdat2 = register[rfif.rsel2];

endmodule
