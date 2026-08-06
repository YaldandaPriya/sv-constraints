//write a constraint to generate 1'bx and 1'bz randomly
//use post randomize to assign x and z based on other variables
class generate_x_z;
	rand bit flag;
	logic value;
	 constraint con1 { flag dist {1:=1,0:=1};}
	function void post_randomize();
		if(flag)
			value=1'bx;
		else
			value=1'bz;
	endfunction
endclass

module test;
generate_x_z g1;
initial
begin
	g1=new();
	for(int i=0;i<10;i++)
		if(g1.randomize())
			$display("value = %b",g1.value);
		else
			$display("Randmomization Failed");
end
endmodule

/* OUTPUT
xcelium> run
value = x
value = x
value = z
value = z
value = x
value = x
value = x
value = z
value = x
value = x
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
