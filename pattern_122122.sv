//generate a pattern of 122122122... using constraints
class pattern_122122;
	rand bit [1:0] a;
	int cnt=0;
	constraint con1 {if((cnt%3)==0)
				a==1;
			else
				a==2;
			};
	function void post_randomize();
		cnt=cnt+1;
	endfunction
endclass

module test;
pattern_122122 p1;
initial
begin
	p1=new();
	for(int i=0;i<10;i=i+1)
	begin
		assert(p1.randomize());
		$display("%d",p1.a);
	end
end
endmodule

/*OUTPUT
* xcelium> run
1
2
2
1
2
2
1
2
2
1
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit*/
