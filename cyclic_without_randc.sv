//simulating cyclic randomization behaviour without using the "randc" keyword
class cyclic;
	rand bit [2:0] a;
	int dummy_que[$];

	constraint con1 { !(a inside {dummy_que});};

	function void post_randomize();
		dummy_que.push_back(a);
		if(dummy_que.size()==8)
			dummy_que={};
	endfunction
endclass

module test;
cyclic c1;
initial
begin
	c1=new();
	for(int i=0;i<16;i=i+1)
	begin
		c1.randomize();
		$write("%d  ",c1.a);
	end
end
endmodule

/*OUTPUT
xcelium> run
4  3  1  5  0  2  6  7  6  7  4  1  3  5  0  2  xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
