// define gates with delays
`define AND and #50
`define OR or #50
`define NOT not #50

module behavioralMultiplexer(out, address0,address1, in0,in1,in2,in3);
output out;
input address0, address1;
input in0, in1, in2, in3;
wire[3:0] inputs = {in3, in2, in1, in0};
wire[1:0] address = {address1, address0};
assign out = inputs[address];
endmodule

module structuralMultiplexer(out, address0,address1, in0,in1,in2,in3);
output out;
input address0, address1;
input in0, in1, in2, in3;

wire nA0wire;
wire nA1wire;
wire aI0wire;
wire a1Iwire;
wire aI2wire;
wire aI3wire;

`NOT notA0(nA0wire, address0);
`NOT notA1(nA1wire, address1);

`AND andI0(aI0wire,in0,nA0wire,nA1wire);
`AND andI1(aI1wire,in1,address0,nA1wire);
`AND andI2(aI2wire,in2,nA0wire,address1);
`AND andI3(aI3wire,in3,address0,address1);

`OR orGate(out,aI0wire,aI1wire,aI2wire,aI3wire);
 
endmodule


module testMultiplexer;
reg addr0, addr1;
reg in0,in1,in2,in3;
wire out;
// behavioralMultiplexer multiplexer (out, addr0,addr1, in0,in1,in2,in3);
structuralMultiplexer multiplexer (out, addr0,addr1, in0,in1,in2,in3); // Swap after testing

initial begin
$display("A0 A1| I0 I1 I2 I3 | O | Expected Output");
addr0=1;addr1=1;in0=1'bX;in1=1'bX;in2=1'bX;in3=0; #1000 
$display("%b  %b |  %b  %b  %b  %b | %b | 0", addr0, addr1, in0, in1, in2, in3, out);
addr0=1;addr1=1;in0=1'bX;in1=1'bX;in2=1'bX;in3=1; #1000
$display("%b  %b |  %b  %b  %b  %b | %b | 1", addr0, addr1, in0, in1, in2, in3, out);
addr0=0;addr1=1;in0=1'bX;in1=1'bX;in2=0;in3=1'bX; #1000 
$display("%b  %b |  %b  %b  %b  %b | %b | 0", addr0, addr1, in0, in1, in2, in3, out);
addr0=0;addr1=1;in0=1'bX;in1=1'bX;in2=1;in3=1'bX; #1000 
$display("%b  %b |  %b  %b  %b  %b | %b | 1", addr0, addr1, in0, in1, in2, in3, out);
addr0=1;addr1=0;in0=1'bX;in1=0;in2=1'bX;in3=1'bX; #1000 
$display("%b  %b |  %b  %b  %b  %b | %b | 0", addr0, addr1, in0, in1, in2, in3, out);
addr0=1;addr1=0;in0=1'bX;in1=1;in2=1'bX;in3=1'bX; #1000 
$display("%b  %b |  %b  %b  %b  %b | %b | 1", addr0, addr1, in0, in1, in2, in3, out);
addr0=0;addr1=0;in0=0;in1=1'bX;in2=1'bX;in3=1'bX; #1000 
$display("%b  %b |  %b  %b  %b  %b | %b | 0", addr0, addr1, in0, in1, in2, in3, out);
addr0=0;addr1=0;in0=1;in1=1'bX;in2=1'bX;in3=1'bX; #1000 
$display("%b  %b |  %b  %b  %b  %b | %b | 1", addr0, addr1, in0, in1, in2, in3, out);
end
endmodule
