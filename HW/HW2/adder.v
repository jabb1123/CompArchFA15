// define gates with delays
`define AND and #50
`define OR or #50
`define NOT not #50

module behavioralFullAdder(sum, carryout, a, b, carryin);
output sum, carryout;
input a, b, carryin;
assign {carryout, sum}=a+b+carryin;
endmodule

module structuralFullAdder(out, carryout, a, b, carryin);
output out, carryout;
input a, b, carryin;

wire nA;
wire nB;
wire nCi;

wire anAanBaCi;
wire anAaBanCi;
wire aAanBanCi;
wire anAaBaCi;
wire aAanBaCi;
wire aAaBanCi;
wire aAaBaCi;

`NOT notA(nA,a);
`NOT notB(nB,b);
`NOT notCi(nCi,carryin);

`AND and0(anAanBaCi,nA,nB,carryin);
`AND and1(aAanBanCi,a,nB,nCi);
`AND and2(anAaBanCi,nA,b,nCi);

`AND and3(aAaBaCi,a,b,carryin);

`AND and4(aAanBaCi,a,nB,carryin);
`AND and5(anAaBaCi,nA,b,carryin);
`AND and6(aAaBanCi,a,b,nCi);

`OR orSum(out,anAanBaCi,aAanBanCi,anAaBanCi,aAaBaCi);

`OR orCo(carryout,aAanBaCi,anAaBaCi,aAaBanCi,aAaBaCi);

endmodule

module testFullAdder;
reg a, b, carryin;
wire sum, carryout;
// behavioralFullAdder adder (sum, carryout, a, b, carryin);
structuralFullAdder adder (sum, carryout, a, b, carryin);

initial begin
$display("A  B  Ci | Co  O  | Expected Output");
a=0;b=0;carryin=0; #1000 
$display("%b  %b  %b  |  %b  %b  | 0  0", a, b, carryin, carryout, sum);
a=0;b=0;carryin=1; #1000 
$display("%b  %b  %b  |  %b  %b  | 0  1", a, b, carryin, carryout, sum);
a=1;b=0;carryin=0; #1000 
$display("%b  %b  %b  |  %b  %b  | 0  1", a, b, carryin, carryout, sum);
a=1;b=0;carryin=1; #1000 
$display("%b  %b  %b  |  %b  %b  | 1  0", a, b, carryin, carryout, sum);
a=0;b=1;carryin=0; #1000 
$display("%b  %b  %b  |  %b  %b  | 0  1", a, b, carryin, carryout, sum);
a=0;b=1;carryin=1; #1000 
$display("%b  %b  %b  |  %b  %b  | 1  0", a, b, carryin, carryout, sum);
a=1;b=1;carryin=0; #1000 
$display("%b  %b  %b  |  %b  %b  | 1  0", a, b, carryin, carryout, sum);
a=1;b=1;carryin=1; #1000 
$display("%b  %b  %b  |  %b  %b  | 1  1", a, b, carryin, carryout, sum);
end
endmodule
