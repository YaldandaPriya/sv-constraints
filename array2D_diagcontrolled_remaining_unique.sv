/* problem statement: generating a 2D array with controlled diagonal element
* and remaining elements are unique(without using unique keyword)
*steps
	Random 2D dynamic array with size between 3 to 6
	same values across the diagonal
	all non-diagonal elements must be unique
	controlled value ranges
	reproducible randomization using a seed

	*/
class array_2D;
	rand int arr_size;
	rand int arr[][];
	rand int diag;

	constraint array_size { arr_size inside {[3:6]};
				arr.size()==arr_size;
				foreach(arr[i])
					arr[i].size()==arr_size;
				}
	constraint diag_values {diag inside {[1:100]};}
	constraint array_values { foreach(arr[i,j])
					if(i==j)
						arr[i][j]==diag;
					else
						arr[i][j] inside {[1:200]} && arr[i][j] !=diag;
				}
	constraint unqiue_remaining { foreach(arr[i,j])
					foreach(arr[c,d])
						if((c!=i) && (d!=j) &&(!(i==j &&c==d)))
							arr[i][j] !=arr[c][d];
					}

	function display();
		$display("size of an array = %0d",arr_size);
		$display("value of the diagonal element = %0d",diag);
		$display("The array generated is :");
		foreach(arr[i])
		begin
			foreach(arr[i][j])
				$write("%d",arr[i][j]);
			$display("");
		end
		$display("--------------------------------------------------------------------------");
	endfunction
endclass

module test;
array_2D a1;
	parameter NUM_RUNS = 4;
	parameter RANDOM_SEED = 123;
	initial
	begin
		$srandom(RANDOM_SEED);
		a1=new();
		repeat(NUM_RUNS)
			begin
			assert(a1.randomize());
			a1.display();
			end
	end
endmodule
/*OUTPUT:
* xcelium> run
size of an array = 5
value of the diagonal element = 8
The array generated is :
          8        103         37         26        167
        145          8         77         56        196
         24        163          8         89         53
         75        129        198          8        200
        194         96         46         57          8
--------------------------------------------------------------------------
size of an array = 3
value of the diagonal element = 40
The array generated is :
         40         89         96
        191         40        152
        177         59         40
--------------------------------------------------------------------------
size of an array = 5
value of the diagonal element = 87
The array generated is :
         87         20        192        196        162
        184         87        164        196        112
        137        144         87        149        115
        199         80          2         87        197
         81         89        125         61         87
--------------------------------------------------------------------------
size of an array = 6
value of the diagonal element = 47
The array generated is :
         47         82        194        162         88        186
        108         47        127         99         15        177
         78        182         47         27        159          9
        111          3         93         47        134         65
         50         32         35        129         47        180
         56         85        200        172        170         47
--------------------------------------------------------------------------
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
