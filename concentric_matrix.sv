/* Problem statement:
* Concentric Square Matrix

Can you write a generalized SystemVerilog constraint to generate a concentric square matrix pattern?

The challenge is to build a reusable constraint that works for both odd and even N×N matrix sizes without manual assignment of each element.

Requirements:

 Use a two-dimensional randomized array
 Use a foreach loop
 Use row and column indices
 Do not assign each matrix element manually
 Do not use post_randomize()
 Keep the matrix size configurable
 The same logic should work for both odd and even N×N sizes

The key is to identify the relationship between each matrix element and its distance from the four matrix boundaries.*/

class concentric_matrix;
	rand int arr[][];
	rand int N;	//size of array

	constraint N_values { N inside {[3:10]};}
	constraint arr_size { arr.size()==N;
				foreach(arr[i])
					arr[i].size()==N;
				}
	constraint arr_values { foreach(arr[i,j]){
					if(i<=j && i<=(N-1-i) && i<=(N-1-j))
						arr[i][j]==i+1;					
					else if(j<=i && j<=(N-1-i) && j<=(N-1-j))
						arr[i][j]==j+1;
					else if((N-i-1)<=j && (N-1-i)<=i && (N-i-1)<=(N-1-j))
						arr[i][j]==N-i;
					else 
						arr[i][j]==N-j;
				}
			}

	function void display();
		foreach(arr[i])
		begin
			foreach(arr[i][j])
				$write("%1d",arr[i][j]);
			$display("");
		end
		$display("--------------------------------------------------");
	endfunction
endclass

module test;
concentric_matrix p1;
initial
begin
	p1=new();
	for(int i=0;i<5;i++)
		if(p1.randomize())
			p1.display();
		else
			$display("Can't generate pattern");
end
endmodule
						

/*OUTPUT
* xcelium> run
111
121
111
--------------------------------------------------
11111111
12222221
12333321
12344321
12344321
12333321
12222221
11111111
--------------------------------------------------
1111111
1222221
1233321
1234321
1233321
1222221
1111111
--------------------------------------------------
111111
122221
123321
123321
122221
111111
--------------------------------------------------
1111111111
1222222221
1233333321
1234444321
1234554321
1234554321
1234444321
1233333321
1222222221
1111111111
--------------------------------------------------
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
