/*write a generalized SystemVerilog constraint to generate the following matrix pattern for any N×N matrix size?

The same constraint should work for:

✅ 3×3
✅ 4×4
✅ 5×5
✅ 6×6
✅ Any configurable N×N matrix

Example output for N = 6:

1 2 3 4 5 6
1 2 3 4 5 5
1 2 3 4 4 4
1 2 3 3 3 3
1 2 2 2 2 2
1 1 1 1 1 1

Challenge Rules:
 Use a two-dimensional randomized array
 Use a foreach loop
 Use row and column indices
 Do not assign each matrix element manually
 The matrix size N must be configurable
 The same constraint must work without modification for every N×N size
 */
class pattern_NxN;
	rand int mat[][];
	rand int size;

	constraint valid_sizes{size inside { [2:7]};}
	constraint mat_size { mat.size()==size;
				foreach(mat[i])
					mat[i].size()==size;
			}
	constraint mat_values { foreach(mat[i,j])
					mat[i][j]==(j<=(size-1-i)?(j+1):(size-i));
			}

	//max function
	function int max(int a, int b);
		if(a>b)
			return a;
		else
			return b;
	endfunction

	//display function
	function display();
		$display("--------------for N = %0d",size,"------------------");
		foreach(mat[i])
		begin
			foreach(mat[i][j])
				$write("%2d",mat[i][j]);
			$display("");
		end
	endfunction
endclass

module test;
pattern_NxN p1;
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

/* OUTPUT:
xcelium> run
--------------for N = 2------------------
 1 2
 1 1
--------------for N = 7------------------
 1 2 3 4 5 6 7
 1 2 3 4 5 6 6
 1 2 3 4 5 5 5
 1 2 3 4 4 4 4
 1 2 3 3 3 3 3
 1 2 2 2 2 2 2
 1 1 1 1 1 1 1
--------------for N = 6------------------
 1 2 3 4 5 6
 1 2 3 4 5 5
 1 2 3 4 4 4
 1 2 3 3 3 3
 1 2 2 2 2 2
 1 1 1 1 1 1
--------------for N = 5------------------
 1 2 3 4 5
 1 2 3 4 4
 1 2 3 3 3
 1 2 2 2 2
 1 1 1 1 1
--------------for N = 3------------------
 1 2 3
 1 2 2
 1 1 1
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
