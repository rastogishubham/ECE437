/*
  Eric Villasenor
  evillase@gmail.com

  cpu memory interface
  some redundancy so testbench can control ram
*/
`ifndef CPU_RAM_IF_VH
`define CPU_RAM_IF_VH
// typedefs
`include "cpu_types_pkg.vh"
`timescale 1 ns / 1 ns
interface cpu_ram_if;
  import cpu_types_pkg::*;

    parameter PERIOD = 20; 
    logic CLK = 0;

    always #(PERIOD/2) CLK++;

  // ram signals
  logic               ramREN, ramWEN;
  word_t              ramaddr, ramstore, ramload;
  ramstate_t          ramstate;

  // cpu signals
  logic               memREN, memWEN;
  word_t              memaddr, memstore;

  //Dump task signals
  logic               dumpramREN, dumpramWEN;
  word_t              dumpramaddr, dumpramstore;

  logic dumpCTRL;


  assign ramREN = (dumpCTRL) ? dumpramREN : memREN;
  assign ramWEN = (dumpCTRL) ? dumpramWEN : memWEN;
  assign ramaddr = (dumpCTRL) ? dumpramaddr : memaddr;
  assign ramstore = (dumpCTRL) ? dumpramstore : memstore;

  // cpu ports
  modport cpu (
    input   ramstate, ramload,
    output  memaddr, memREN, memWEN, memstore
  );

  // ram ports
  modport ram (
    input   ramaddr, ramstore, ramREN, ramWEN,
    output  ramstate, ramload
  );

  // unused and may change
  modport sdram (
    input   ramaddr, ramstore, ramREN, ramWEN,
    output  ramstate, ramload
  );

  task automatic dump_memory();

    string filename = "memcpu.hex";
    int memfd;
    dumpramaddr = 0;
    dumpramWEN = 0;
    dumpramREN = 0;
    dumpramstore = 0;
    dumpCTRL = 1;

    memfd = $fopen(filename,"w");
    if (memfd)
      $display("Starting memory dump.");
    else
      begin $display("Failed to open %s.",filename); $finish; end

    for (int unsigned i = 0; memfd && i < 16384; i++)
    begin
      int chksum = 0;
      bit [7:0][7:0] values;
      string ihex;

      dumpramaddr = i << 2;
      dumpramREN = 1;
      repeat (4) @(posedge CLK);
      if (ramload === 0)
        continue;
      values = {8'h04,16'(i),8'h00,ramload};
      foreach (values[j])
        chksum += values[j];
      chksum = 16'h100 - chksum;
      ihex = $sformatf(":04%h00%h%h",16'(i),ramload,8'(chksum));
      $fdisplay(memfd,"%s",ihex.toupper());
    end //for
    if (memfd)
    begin
      dumpCTRL = 0;
      dumpramREN = 0;
      $fdisplay(memfd,":00000001FF");
      $fclose(memfd);
      $display("Finished memory dump.");
    end
  endtask

endinterface

`endif //CPU_RAM_IF_VH
