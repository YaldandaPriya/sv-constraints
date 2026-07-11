//write a constraint to generate 10 unique numbers between 99 and 100
class unique_numbers;
	rand int a;
	constraint con1 { a inside {[9900:10000]};}
	
	real unique_num;
	function void post_randomize();
		unique_num = a/100.00;
	endfunction
endclass

module test;
unique_numbers u1;
initial
begin
	u1=new();
	for(int i=0;i<10;i=i+1)
	begin
		if(u1.randomize())
			$display("a = %0.2f",u1.unique_num);
		else
			$display("randmoization failed");
	end
end
endmodule

/*OUTPUT
xcelium> run
a = 99.84
a = 99.99
a = 99.97
a = 99.02
a = 99.68
a = 99.76
a = 99.46
a = 99.54
a = 99.22
a = 99.38
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
