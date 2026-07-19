/* Problem Statement:
* A latin square is a NxN grid filled with N different symbols, each occuring exactly once in each row and exactly once in each column
* design a parameterized systemverilog class to generate a valid NxN latin square using numbers 1 to N
*/
class latin_square #(parameter int N =3);
	rand int grid[N][N];

	constraint grid_values{ foreach(grid[i,j])
					grid[i][j] inside {[1:N]};
				}
	constraint row_unique { foreach(grid[i])
					unique{grid[i]};
				}
	constraint col_unique { foreach(grid[i1,j])
					foreach(grid[i2,j])
						if(i1>i2)
							grid[i1][j]!=grid[i2][j];
				}
	
	function display();
		$display("------------------------------");
		foreach(grid[i])
		begin
			foreach(grid[i][j])
				$write("%3d",grid[i][j]);
			$display("");
		end
	endfunction
endclass
module test;
latin_square l1;
initial
begin
	l1=new();
	for(int i=0;i<4;i++)
		if(l1.randomize())
			l1.display();
		else
			$display("Failed to generate Latin Square");
end
latin_square #(5) l2;
initial
begin
	l2=new();
	for(int i=0;i<4;i++)
		if(l2.randomize())
			l2.display();
		else
			$display("Failed to generate Latin Square");
end

endmodule

/*OUTPUT:
xcelium> run
------------------------------
  3  2  1
  1  3  2
  2  1  3
------------------------------
  1  2  3
  3  1  2
  2  3  1
------------------------------
  1  2  3
  3  1  2
  2  3  1
------------------------------
  1  2  3
  2  3  1
  3  1  2
------------------------------
  5  1  4  2  3
  1  4  3  5  2
  2  3  5  1  4
  3  5  2  4  1
  4  2  1  3  5
------------------------------
  4  5  3  2  1
  5  2  1  4  3
  2  1  5  3  4
  1  3  4  5  2
  3  4  2  1  5
------------------------------
  1  3  5  4  2
  2  1  3  5  4
  5  4  2  1  3
  4  2  1  3  5
  3  5  4  2  1
------------------------------
  3  1  5  2  4
  4  5  2  1  3
  2  3  4  5  1
  1  2  3  4  5
  5  4  1  3  2
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
