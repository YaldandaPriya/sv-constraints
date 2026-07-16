//write a constraint such that in a 16 bit variable no two consecutive ones should be generated
class consecutive_ones;
	rand bit [15:0] a;
	constraint con1{ foreach(a[i])
				if(a[i]==1 && i<15)
					a[i+1]!=1;
				}

endclass

module test;
consecutive_ones c1;
initial
begin
	c1=new();
	for(int i=0;i<10;i++)
		if(c1.randomize())
			$display("a= %b",c1.a);
		else
			$display("Randomization Failed");
end
endmodule

/*OUTPUT
xcelium> run
a= 0001010101001001
a= 0000101000100101
a= 0001001000000001
a= 1001000101000000
a= 0000100010100010
a= 1001010100000010
a= 0101001010100001
a= 1000010010100101
a= 1010010010000001
a= 0101010100101000
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
