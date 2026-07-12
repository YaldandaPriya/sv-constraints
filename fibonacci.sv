//write a constraint to generate fibonacci series
class fibonacci;
	rand int a;
	int prev1 = 0;
	int prev2 = 1;
	
	constraint con1 {a==prev1+prev2;}
	function void post_randomize();
		prev1=prev2;
		prev2=a;
	endfunction
endclass

module test;
fibonacci f1;
initial begin
	f1=new();
	for(int i=0;i<10;i++)
	begin
		if(f1.randomize())
			$write("%d\t",f1.a);
		else
			$display("randomization failure");
	end
end
endmodule

/*OUTPUT
xcelium> run
          1               2               3               5               8              13              21              34              55              89     xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
