//generating a pattern 1 one time , 2 two times, 3 three times,.... so on based on size(122333...)
class pattern_122333;
	rand bit [4:0] a[];
	rand bit [3:0] size_a;

	constraint array_size{a.size()==size_a;};

	function void post_randomize();
		int idx=0;
		for(int i=1;i<=size_a;i=i+1)
			for(int j=0;j<i && idx<size_a;j=j+1)
			begin
				a[idx]=i;
				idx=idx+1;
			end
	endfunction

	function void array_display();
		$display("size=%d",size_a);
		foreach(a[i])
			$write("%d\t",a[i]);
		$display("");
	endfunction
endclass
module test;
pattern_122333 p1;
initial
begin
	p1=new();
	for(int i=1;i<=10;i=i+1)
	begin
		p1.randomize();
		p1.array_display();
	end
end
endmodule

/* OUTPUT:
* xcelium> run
size= 4
 1       2       2       3
size= 6
 1       2       2       3       3       3
size= 3
 1       2       2
size= 9
 1       2       2       3       3       3       4       4       4
size= 2
 1       2
size= 5
 1       2       2       3       3
size= 4
 1       2       2       3
size= 0

size=13
 1       2       2       3       3       3       4       4       4       4       5       5       5
size= 7
 1       2       2       3       3       3       4
xmsim: *W,RNQUIE: Simulation is complete.*/
