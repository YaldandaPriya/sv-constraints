/*Combining multiple constraint types in a single problem
 Scenario:
A class with multiple constraints:
 Range constraint (id)
 Dynamic array size + pattern constraint
 Distribution constraint (valid)
 Computed constraint (parity based on sum)
 Think about it:
 How does solver handle ALL constraints together?
 Which constraint depends on others?
 Does order of constraints matter?
 What’s happening internally:
	 id :restricted to small range
	 payload: 
		size between 4–10
		even index → increasing pattern
 	 valid
		80% probability of being 1
	 parity
		depends on payload.sum()
 Core Concept:
 This is NOT one constraint
 This is constraint interaction + dependency solving
 Deep Insight:
 payload gets solved first
 payload.sum() evaluated
 THEN parity is decided
 Solver handles dependencies automatically
Important Trap:
 Many think constraints run sequentially
WRONG
 Solver solves all together */

class integrated_constraints;
	rand bit [3:0] id;
	rand bit [15:0] payload[]; //dynamic array
	rand bit valid;
	rand bit parity;

	constraint id_range { id inside {[0:5]};}
	constraint payload_constraints { payload.size() inside {[4:10]};
						foreach(payload[i])
							if(i[0]==0 && i<(payload.size()-2))
								payload[i]<payload[i+2];
						}
	constraint id_probability {valid dist {1:=80,0:=20};}
	constraint parity_on_payload_sum { parity == !(payload.sum()%2);}

	function display();
		$display(" id = %2d",id);
		$display("payload data:");
		foreach(payload[i])
			$write(" %0d ",payload[i]);
		$display("\nvalid = %2d\nsum = %2d\nparity = %2d",valid,payload.sum(),parity);
		$display("---------------------------------------------------");
	endfunction
endclass
module test;
integrated_constraints r1;
initial
begin
	r1=new();
	for(int i=0;i<5;i++)
		if(r1.randomize())
			r1.display();
		else
			$display("Randomization Failed");
end
endmodule

/*OUTPUT:
* xcelium> run
 id =  2
payload data:
 4993  11646  7740  9059  8263  41279  8277 
valid =  1
sum = 25721
parity =  0
---------------------------------------------------
 id =  5
payload data:
 46756  36647  58416  39211 
valid =  1
sum = 49958
parity =  1
---------------------------------------------------
 id =  5
payload data:
 1549  49792  2961  38979  31489  14596  35891 
valid =  1
sum = 44185
parity =  0
---------------------------------------------------
 id =  0
payload data:
 54131  24072  55784  63047  55806  35293  61850  38127  65470 
valid =  0
sum = 60364
parity =  1
---------------------------------------------------
 id =  4
payload data:
 51252  28982  58771  16055  59576  41088 
valid =  0
sum = 59116
parity =  1
---------------------------------------------------
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
