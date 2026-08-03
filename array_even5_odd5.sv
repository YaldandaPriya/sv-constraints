/* Problem statement:
	generate array of size 10 which should contain exactly 5 even numbers and 5 odd numbers
*/
class array_even5_odd5;
	rand int arr_size;
	rand int arr[];

	constraint array_size { arr_size==10;
				arr.size()==arr_size;
				foreach(arr[i])
					arr[i] inside {[1:100]};
				}
	constraint even_5 {arr.sum() with (int'(item%2==0)) ==5;}			//Since the array size is 10, if exactly 5 elements are even, the remaining 5 will automatically be odd.	
				
	
	function void display();
		$display("The generated array is :");
			foreach(arr[i])
				$write("%d",arr[i]);
		$display("\n--------------------------------------------------------------------------");
	endfunction
endclass

module test;
array_even5_odd5 a1;
	parameter NUM_RUNS = 5;
	initial
	begin
		a1=new();
		repeat(NUM_RUNS)
			begin
			assert(a1.randomize());
			a1.display();
			end
	end
endmodule
/* OUTPUT:
xcelium> run
The generated array is :
         62         50         68         83         15          2         85         98          3         71
--------------------------------------------------------------------------
The generated array is :
         57         92         88         82         17         56         98         91         17          3
--------------------------------------------------------------------------
The generated array is :
         50         32         21         54         61         91         59         50         17          2
--------------------------------------------------------------------------
The generated array is :
         78         32         11         51          3         37         68         30         95         56
--------------------------------------------------------------------------
The generated array is :
         96         54         78         32          7         82         93         27         89         35
--------------------------------------------------------------------------
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
