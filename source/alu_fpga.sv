// interface
`include "alu_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module alu_fpga (
  input logic CLOCK_50,
  input logic [3:0] KEY,
  input logic [17:0] SW,
  output logic [6:0] HEX0, 
  output logic [6:0] HEX1, 
  output logic [6:0] HEX2,
  output logic [6:0] HEX3,
  output logic [6:0] HEX4,
  output logic [6:0] HEX5,
  output logic [6:0] HEX6,
  output logic [6:0] HEX7,
  output logic [17:0] LEDR
);

  logic [31:0] B;
  // interface
  alu_if aluif();
  // alu
  alu ALU_DUT(aluif);

always_ff @(posedge CLOCK_50)
begin
	if(SW[17] == 1)
	begin
		B[31:16] <= (SW[16] == 1) ? '{default: '1} : '{default: '0};
		B[15:0] <= SW[15:0];
	end	
	else
	begin
		aluif.PortB <= B;
	end
end
/*always_comb
begin
	casez(KEY)
		4'b0000: aluif.ALUOP = ALU_SLL;
		4'b0001: aluif.ALUOP = ALU_SRL;
		4'b0010: aluif.ALUOP = ALU_ADD;
		4'b0011: aluif.ALUOP = ALU_SUB;
		4'b0100: aluif.ALUOP = ALU_AND;
		4'b0101: aluif.ALUOP = ALU_OR;
		4'b0110: aluif.ALUOP = ALU_XOR;
		4'b0111: aluif.ALUOP = ALU_NOR;
		4'b1010: aluif.ALUOP = ALU_SLT;
		4'b1011: aluif.ALUOP = ALU_SLTU;
		default: aluif.ALUOP = ALU_SLL;
	endcase
end*/
assign aluif.ALUOP[3:0] = ~KEY[3:0];
assign aluif.PortA [31:16] = (SW[16] == 1) ? '{default: '1} : '{default: '0};
assign aluif.PortA [15:0] = SW[15:0];

/*assign HEX0 = aluif.Output[3:0];
assign HEX1 = aluif.Output[9:4];
assign HEX2 = aluif.Output[12:9];
assign HEX3 = aluif.Output[16:13];
assign HEX4 = aluif.Output[20:17];
assign HEX5 = aluif.Output[24:21];
assign HEX6 = aluif.Output[28:25];
assign HEX7 = aluif.Output[31:29];*/

  always_comb
  begin
    unique casez (aluif.Output[3:0])
      'h0: HEX0 = 7'b1000000;
      'h1: HEX0 = 7'b1111001;
      'h2: HEX0 = 7'b0100100;
      'h3: HEX0 = 7'b0110000;
      'h4: HEX0 = 7'b0011001;
      'h5: HEX0 = 7'b0010010;
      'h6: HEX0 = 7'b0000010;
      'h7: HEX0 = 7'b1111000;
      'h8: HEX0 = 7'b0000000;
      'h9: HEX0 = 7'b0010000;
      'ha: HEX0 = 7'b0001000;
      'hb: HEX0 = 7'b0000011;
      'hc: HEX0 = 7'b0100111;
      'hd: HEX0 = 7'b0100001;
      'he: HEX0 = 7'b0000110;
      'hf: HEX0 = 7'b0001110;
    endcase
   
    unique casez (aluif.Output[7:4])
      'h0: HEX1 = 7'b1000000;
      'h1: HEX1 = 7'b1111001;
      'h2: HEX1 = 7'b0100100;
      'h3: HEX1 = 7'b0110000;
      'h4: HEX1 = 7'b0011001;
      'h5: HEX1 = 7'b0010010;
      'h6: HEX1 = 7'b0000010;
      'h7: HEX1 = 7'b1111000;
      'h8: HEX1 = 7'b0000000;
      'h9: HEX1 = 7'b0010000;
      'ha: HEX1 = 7'b0001000;
      'hb: HEX1 = 7'b0000011;
      'hc: HEX1 = 7'b0100111;
      'hd: HEX1 = 7'b0100001;
      'he: HEX1 = 7'b0000110;
      'hf: HEX1 = 7'b0001110;
    endcase

    unique casez (aluif.Output[11:8])
      'h0: HEX2 = 7'b1000000;
      'h1: HEX2 = 7'b1111001;
      'h2: HEX2 = 7'b0100100;
      'h3: HEX2 = 7'b0110000;
      'h4: HEX2 = 7'b0011001;
      'h5: HEX2 = 7'b0010010;
      'h6: HEX2 = 7'b0000010;
      'h7: HEX2 = 7'b1111000;
      'h8: HEX2 = 7'b0000000;
      'h9: HEX2 = 7'b0010000;
      'ha: HEX2 = 7'b0001000;
      'hb: HEX2 = 7'b0000011;
      'hc: HEX2 = 7'b0100111;
      'hd: HEX2 = 7'b0100001;
      'he: HEX2 = 7'b0000110;
      'hf: HEX2 = 7'b0001110;
    endcase

    unique casez (aluif.Output[15:12])
      'h0: HEX3 = 7'b1000000;
      'h1: HEX3 = 7'b1111001;
      'h2: HEX3 = 7'b0100100;
      'h3: HEX3 = 7'b0110000;
      'h4: HEX3 = 7'b0011001;
      'h5: HEX3 = 7'b0010010;
      'h6: HEX3 = 7'b0000010;
      'h7: HEX3 = 7'b1111000;
      'h8: HEX3 = 7'b0000000;
      'h9: HEX3 = 7'b0010000;
      'ha: HEX3 = 7'b0001000;
      'hb: HEX3 = 7'b0000011;
      'hc: HEX3 = 7'b0100111;
      'hd: HEX3 = 7'b0100001;
      'he: HEX3 = 7'b0000110;
      'hf: HEX3 = 7'b0001110;
    endcase

    unique casez (aluif.Output[19:16])
      'h0: HEX4 = 7'b1000000;
      'h1: HEX4 = 7'b1111001;
      'h2: HEX4 = 7'b0100100;
      'h3: HEX4 = 7'b0110000;
      'h4: HEX4 = 7'b0011001;
      'h5: HEX4 = 7'b0010010;
      'h6: HEX4 = 7'b0000010;
      'h7: HEX4 = 7'b1111000;
      'h8: HEX4 = 7'b0000000;
      'h9: HEX4 = 7'b0010000;
      'ha: HEX4 = 7'b0001000;
      'hb: HEX4 = 7'b0000011;
      'hc: HEX4 = 7'b0100111;
      'hd: HEX4 = 7'b0100001;
      'he: HEX4 = 7'b0000110;
      'hf: HEX4 = 7'b0001110;
    endcase

    unique casez (aluif.Output[23:20])
      'h0: HEX5 = 7'b1000000;
      'h1: HEX5 = 7'b1111001;
      'h2: HEX5 = 7'b0100100;
      'h3: HEX5 = 7'b0110000;
      'h4: HEX5 = 7'b0011001;
      'h5: HEX5 = 7'b0010010;
      'h6: HEX5 = 7'b0000010;
      'h7: HEX5 = 7'b1111000;
      'h8: HEX5 = 7'b0000000;
      'h9: HEX5 = 7'b0010000;
      'ha: HEX5 = 7'b0001000;
      'hb: HEX5 = 7'b0000011;
      'hc: HEX5 = 7'b0100111;
      'hd: HEX5 = 7'b0100001;
      'he: HEX5 = 7'b0000110;
      'hf: HEX5 = 7'b0001110;
    endcase

    unique casez (aluif.Output[27:24])
      'h0: HEX6 = 7'b1000000;
      'h1: HEX6 = 7'b1111001;
      'h2: HEX6 = 7'b0100100;
      'h3: HEX6 = 7'b0110000;
      'h4: HEX6 = 7'b0011001;
      'h5: HEX6 = 7'b0010010;
      'h6: HEX6 = 7'b0000010;
      'h7: HEX6 = 7'b1111000;
      'h8: HEX6 = 7'b0000000;
      'h9: HEX6 = 7'b0010000;
      'ha: HEX6 = 7'b0001000;
      'hb: HEX6 = 7'b0000011;
      'hc: HEX6 = 7'b0100111;
      'hd: HEX6 = 7'b0100001;
      'he: HEX6 = 7'b0000110;
      'hf: HEX6 = 7'b0001110;
    endcase

    unique casez (aluif.Output[31:28])
      'h0: HEX7 = 7'b1000000;
      'h1: HEX7 = 7'b1111001;
      'h2: HEX7 = 7'b0100100;
      'h3: HEX7 = 7'b0110000;
      'h4: HEX7 = 7'b0011001;
      'h5: HEX7 = 7'b0010010;
      'h6: HEX7 = 7'b0000010;
      'h7: HEX7 = 7'b1111000;
      'h8: HEX7 = 7'b0000000;
      'h9: HEX7 = 7'b0010000;
      'ha: HEX7 = 7'b0001000;
      'hb: HEX7 = 7'b0000011;
      'hc: HEX7 = 7'b0100111;
      'hd: HEX7 = 7'b0100001;
      'he: HEX7 = 7'b0000110;
      'hf: HEX7 = 7'b0001110;
    endcase
  end
assign LEDR[17] = aluif.overflow;
assign LEDR[16] = aluif.zero;
assign LEDR[15] = aluif.neg; 
endmodule
