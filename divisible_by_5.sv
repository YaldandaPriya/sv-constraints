// generate a number which should always divisble by 5
class divisible_by_5;
	rand int n;
	constraint con1 { n%5==0; n inside {[0:200]};}
endclass

module test;
divisible_by_5 d1;
initial
begin
	d1=new();
	for(int i=0;i<10;i++)
		if(d1.randomize())
			$display("n = %0d",d1.n);
		else
			$display("failed");
end
endmodule

/*OUTPUT:
xcelium> run
n = 50
n = 0
n = 15
n = 100
n = 30
n = 195
n = 120
n = 35
n = 105
n = 175
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
