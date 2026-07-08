//generate a pattern of 56789987656789.. using constraints
class pattern_5678998765;
	rand bit [3:0] a;
	int cnt = 0;
	constraint con1 { if((cnt%10)<5)
				a == 5+ (cnt%10);
			else
				a == 14 -(cnt%10);
		};

	function void post_randomize();
		cnt++;
	endfunction
endclass

module test;
pattern_5678998765 p1;
initial
begin
	p1=new();
	for(int i=0;i<15;i=i+1)
	begin
		assert(p1.randomize());
		$write("%d\t",p1.a);
	end
end
endmodule

/*OUTPUT
xcelium> run
 5       6       7       8       9       9       8       7       6       5       5       6       7       8       9      xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
