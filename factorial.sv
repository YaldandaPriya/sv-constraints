//write a constraint to generate factorial of first 5 even and odd numbers
class factorial;
	rand int a;
	rand int fact_a;
	int cnt=0;

	constraint con1 {fact_a == factorial(a);};
	constraint con2 { if (cnt<5)
				a == (2 *(cnt+1));
			else
				a == ((2 *(cnt-5))+1);};

	function int factorial(int a);
		int fact_a1 = 1;
		for(int i = 2;i <= a;i = i+1)
			fact_a1 = (fact_a1 * i);
		return fact_a1;
	endfunction

	function void post_randomize();
		cnt=cnt+1;
		if (cnt ==10)
			cnt=0;
	endfunction
endclass

module test;
factorial f1;
initial
begin
	f1=new();
	for(int i=0;i<13;i=i+1)
	begin
		assert(f1.randomize());
		$display("a=%d factorial of a =%d",f1.a,f1.fact_a);
	end
end
endmodule

/*OUTPUT
xcelium> run
a=          2 factorial of a =          2
a=          4 factorial of a =         24
a=          6 factorial of a =        720
a=          8 factorial of a =      40320
a=         10 factorial of a =    3628800
a=          1 factorial of a =          1
a=          3 factorial of a =          6
a=          5 factorial of a =        120
a=          7 factorial of a =       5040
a=          9 factorial of a =     362880
a=          2 factorial of a =          2
a=          4 factorial of a =         24
a=          6 factorial of a =        720
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
