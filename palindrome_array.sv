/* thought process:
* can a random array be forced to remember its own reflection?
* that is palindrome array
* Problem statement:
	* randomize a dynamic array such that the array elements remain identical when read from left to right or from right to left
features:
	random dynamic array size
	size randomized within a given range
	element value range control
	palindrome behaviour enforced using mirrored index constraints
	optimise constraint by applying the relation only to halfarray
*/
class palindrome_array;
	rand int arr_size;
	rand int arr[];

	constraint array_size { arr_size inside {[5:15]};
				arr.size()==arr_size;
				foreach(arr[i])
					arr[i] inside {[1:100]};
				}
	constraint palindrome_logic {foreach(arr[i])
					if(i<arr_size/2)
						arr[i]==arr[arr_size-i-1];
					}
	
	function display();
		$display("size of an array = %0d",arr_size);
		$display("The generated palindrome array is :");
			foreach(arr[i])
				$write("%d",arr[i]);
		$display("\n--------------------------------------------------------------------------");
	endfunction
endclass

module test;
palindrome_array a1;
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
size of an array = 5
The generated palindrome array is :
         33          2         22          2         33
--------------------------------------------------------------------------
size of an array = 12
The generated palindrome array is :
         61         45         14          7         27         61         61         27          7         14         45         61
--------------------------------------------------------------------------
size of an array = 13
The generated palindrome array is :
         65         77          2         88         90         35         30         35         90         88          2         77         65
--------------------------------------------------------------------------
size of an array = 8
The generated palindrome array is :
         64         40         87         88         88         87         40         64
--------------------------------------------------------------------------
size of an array = 12
The generated palindrome array is :
         42         73         63         61         77         54         54         77         61         63         73         42
--------------------------------------------------------------------------
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
