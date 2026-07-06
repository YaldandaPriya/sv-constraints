//Generate consecutive powers of 2 in ascending order using a 16-bit variable through constraints
class powers_of_two;
	rand bit [15:0] a;
	bit [15:0] prev_data=1;
	constraint power_of_2{a==(prev_data<<1);};

	function void post_randomize();
		prev_data=a;
	endfunction
endclass

module test;
powers_of_two t1;

initial 
begin
	t1=new();
	for(int i=0;i<6 ;i=i+1)
		begin
			assert(t1.randomize());
			$display("data=%d",t1.a);
		end
end
endmodule
/*OUTPUT
xcelium> run
data=    2
data=    4
data=    8
data=   16
data=   32
data=   64
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/

/*//Generate powers of 2 in ascending order using a 16-bit variable through constraints
class powers_of_two;
	rand bit [15:0] a;
	bit [15:0] prev_data=1;
	constraint power_of_2{$countones(a)==1;};
	constraint ascending_order{ a > prev_data;};

	function void post_randomize();
		prev_data=a;
	endfunction
endclass

module test;
powers_of_two t1;

initial 
begin
	t1=new();
	for(int i=0;i<6 ;i=i+1)
		begin
			assert(t1.randomize());	//So if you run enough iterations, this assertion may fail due to width is limited to 16 bits
			$display("data=%d",t1.a);
		end
end
endmodule
*/
