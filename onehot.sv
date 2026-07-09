// write a constraint to generate only one bit is one and remaining all zeroes
// , for a 16 bit variable and 1st time 1 will be at msb, 2nd time 1 should be
// at msb -1 position and so on upto lsb
// approach 1
class onehot;
	rand shortint a=16'h8000;
	shortint prev_a;

	constraint con1 { a== prev_a>>1;};
	function void pre_randomize();
		prev_a=a;
	endfunction
endclass

module test;
onehot o1;
initial
begin
	o1=new();
	for(int i=0;i<15;i=i+1)
	begin
		assert(o1.randomize());
		$display("a=%b",o1.a);
	end
end
endmodule

/* OUTPUT
xcelium> run
a=0100000000000000
a=0010000000000000
a=0001000000000000
a=0000100000000000
a=0000010000000000
a=0000001000000000
a=0000000100000000
a=0000000010000000
a=0000000001000000
a=0000000000100000
a=0000000000010000
a=0000000000001000
a=0000000000000100
a=0000000000000010
a=0000000000000001
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/

//approach 2
/*class onehot;
	rand bit [15:0] a;
	int cnt=0;

	constraint con1 { a[15-cnt]== 1; $onehot(a)==1;};
	function void post_randomize();
		cnt=cnt+1;
		if(cnt==16)
			cnt=0;
	endfunction
endclass

module test;
onehot o1;
initial
begin
	o1=new();
	for(int i=0;i<15;i=i+1)
	begin
		assert(o1.randomize());
		$display("a=%b",o1.a);
	end
end
endmodule */

/* OUTPUT
xcelium> run
a=1000000000000000
a=0100000000000000
a=0010000000000000
a=0001000000000000
a=0000100000000000
a=0000010000000000
a=0000001000000000
a=0000000100000000
a=0000000010000000
a=0000000001000000
a=0000000000100000
a=0000000000010000
a=0000000000001000
a=0000000000000100
a=0000000000000010
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
