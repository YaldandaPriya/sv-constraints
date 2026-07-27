/* Original Idea
Generate an array of 10 elements such that:
	First 5 → Even numbers
	Last 5 → Odd numbers
	Strictly increasing within each half
	Sum(first half) == Sum(second half)

Sounds straightforward, right?
Wrong.

 Hidden Problem
Sum of 5 even numbers → Even
Sum of 5 odd numbers → Odd
Even can never equal Odd.

 The constraint is mathematically impossible.

This is where real verification thinking starts —
not writing constraints, but validating feasibility.

Redesigned Problem Statement:
Generate array[10]:
	First 4 → Even numbers
	Next 4 → Odd numbers
	Last 2 → Free values (1–100)
	Strictly increasing within each group
	Sum(first 4) == Sum(next 4)

Now:
Sum of 4 evens → Even
Sum of 4 odds → Even
Equality becomes possible */
class even_odd_sum;
	rand int arr[];
	rand int size;

	constraint arr_size { size==10; size==arr.size();}
	constraint arr_values { foreach(arr[i])
					arr[i] inside {[1:100]};
				}
	constraint arr_even_odd { foreach(arr[i])
					if(i<4)
						arr[i][0]==0;
					else if (i<8)
						arr[i][0]==1;
				}
	constraint increasing { foreach(arr[i])
					if(((i>0) && (i<4)) || ( (i>4) && (i<8)))
						arr[i]>arr[i-1];	//strcitly increasing in each group
				}
	rand int Sum1, Sum2;
	constraint arr_sum_con { Sum1==(arr[0] + arr[1] +arr[2] +arr[3]); Sum2 == (arr[4] + arr[5]+arr[6]+arr[7]); Sum1==Sum2;}

	function display();
		$display("-------------------------------------------");
		foreach(arr[i])
			$write("%3d",arr[i]);
		$display("\n Sum of evens : %3d \n Sum of odds : %3d",Sum1,Sum2);
		$display("--------------------------------------------");
	endfunction
endclass

module test;
even_odd_sum t1;
initial
begin
	t1=new();
	for(int i=0;i<5;i++)
		if(t1.randomize())
			t1.display();
		else
			$display("Randomization Failed");
end
endmodule

/*OUTPUT:
xcelium> run
-------------------------------------------
 14 22 58 66 23 37 41 59 62 22
 Sum of evens : 160 
 Sum of odds : 160
--------------------------------------------
-------------------------------------------
 18 40 42 44 17 19 51 57 23 68
 Sum of evens : 144 
 Sum of odds : 144
--------------------------------------------
-------------------------------------------
  8 50 56 58  9 37 39 87  6  7
 Sum of evens : 172 
 Sum of odds : 172
--------------------------------------------
-------------------------------------------
 12 68 80 98 51 53 55 99 18 35
 Sum of evens : 258 
 Sum of odds : 258
--------------------------------------------
-------------------------------------------
  2 10 26 28 11 15 19 21 84100
 Sum of evens :  66 
 Sum of odds :  66
--------------------------------------------
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
