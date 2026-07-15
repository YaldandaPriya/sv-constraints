//write a constraint to generate a pattern 7 77 777 7777 77777...
class pattern_7_77;
	rand longint a;
	int prev_a=7;
	
	constraint pattern{ a==((prev_a*10)+7);}
	function void post_randomize();
		prev_a=a;
	endfunction
endclass

module test;
pattern_7_77 p1;
initial
begin
	p1=new();
	for(int i=1;i<10;i++)
		if(p1.randomize())
			$display("%d",p1.a);
		else
			$display("Randomization Failure");
end
endmodule

/*OUTPUT
xcelium> run
                   77
                  777
                 7777
                77777
               777777
              7777777
             77777777
            777777777
           7777777777
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
