/* problem statement:
* a dynamic array is randomized with the following constraints:
* 1. values are biased using dist constraint toward 0
* 2. all elements must be unique
* will the randomization fail or succeed? */
class randomization_check1;
	rand int arr[];	//dynamic array
	
	constraint arr_size { arr.size()==10;}
	constraint arr_values { foreach(arr[i])
					arr[i] dist {0:=10};
				}
	constraint arr_unique {unique{arr};}

	function display();
		foreach(arr[i])
			$write("%3d",arr[i]);
		$display("\n------------------------------------------");
	endfunction
endclass

module test1;
randomization_check1 r1;
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
/* OUTPUT: 
* Randomization Failed
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/

/* Why constraint randomization fails (dist vs unique conflict)
 Scenario:
A dynamic array is randomized with:
 dist {0 := 10}
 unique {a}
 Think about it:
 Can all values be 0 AND unique at the same time?
 Result:
 Randomization FAILS
 Core Concept:
 Constraints must be satisfied simultaneously
 Deep Insight:
 dist {0:=10}
Pushes values toward 0
 unique {a}
Forces all elements to be different
 No overlapping solution space
 Important Point:
 Constraint conflict = no solution → randomize() fails
 Correct Approach:
Allow multiple values:
 	dist {0:=10, [1:15]:=1}
	unique {a}
*/

class randomization_check2;
	rand int arr[];	//dynamic array
	
	constraint arr_size { arr.size()==10;}
	constraint arr_values { foreach(arr[i])
					arr[i] dist {0:=10, [1:15]:=1};
				}
	constraint arr_unique {unique{arr};}

	function display();
		foreach(arr[i])
			$write("%3d",arr[i]);
		$display("\n------------------------------------------");
	endfunction
endclass

module test2;
randomization_check2 r2;
initial
begin
	r2=new();
	for(int i=0;i<5;i++)
		if(r2.randomize())
			r2.display();
		else
			$display("Randomization Failed");
end
endmodule

/*OUTPUT:
  9 10  5  1 12 13  0  8 15  6
------------------------------------------
  4  6  1  3 14 10  5  8  0 12
------------------------------------------
 10  0  6  4  7 14 11  5  8 13
------------------------------------------
  9  0  6 14 12  1 10  4 15 13
------------------------------------------
  0  7  8  1  4 10 14 11  9  5
------------------------------------------
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/

/* key observation: by allowing range of values from 1 to 15 increase solution space -> this enables unique values while still maintaining bias towards 0
* constraint solving when randomization fails is all about finding the intersection between all conditions */
