/* problem statement:
* Magic square of order N is an arrangement of different integers(from 1 to N^2) in a NxN grid
* such that sum of any horizontal row, vertical column, and both main diagonals should be equal to MAGIC CONSTANT(M)
* MAGIC CONSTANT(M) should be calculated as M(N)=(N*(N^2+1))/2 
* Design a system verilog class to generate a valid magic square of order N=3
*/
class magic_square #(parameter int N=3);
	rand int grid[N][N];	//grid
	rand int flat_grid[N*N];	//for unqiueness
	//magic constant
	localparam int M = (N*((N*N)+1))/2;

	constraint unique_grid { unique{flat_grid};}
	constraint grid_values {foreach(flat_grid[i]){
					flat_grid[i] inside {[1:N*N]};
					grid[i/N][i%N]==flat_grid[i];
					}
				}
	constraint row_sum { foreach(grid[i])
					grid[i][0]+grid[i][1]+grid[i][2]==M;
				}
	constraint col_sum { foreach(grid[,i])
					grid[0][i]+grid[1][i]+grid[2][i]==M;
				}
	constraint diag_sum { grid[0][0]+grid[1][1]+grid[2][2]==M;
				grid[0][2]+grid[1][1]+grid[2][0]==M;
				}
	
	function display();
		$display("--------------------------------------");		
		for(int i=0;i<N;i++)
		begin
			for(int j=0;j<N;j++)
				$write("%d\t",grid[i][j]);
			$display("");
		end
		$display("--------------------------------------");
	endfunction
endclass
module test;
magic_square #(3) m1;
initial
begin
	m1=new();
	for(int i=0;i<5;i++)
		if(m1.randomize())
			m1.display();
		else
			$display("Failed to generate Magic Square");
end
endmodule


/*OUTPUT:
xcelium> run
--------------------------------------
          8	          1	          6	
          3	          5	          7	
          4	          9	          2	
--------------------------------------
--------------------------------------
          2	          7	          6	
          9	          5	          1	
          4	          3	          8	
--------------------------------------
--------------------------------------
          6	          1	          8	
          7	          5	          3	
          2	          9	          4	
--------------------------------------
--------------------------------------
          4	          3	          8	
          9	          5	          1	
          2	          7	          6	
--------------------------------------
--------------------------------------
          6	          1	          8	
          7	          5	          3	
          2	          9	          4	
--------------------------------------
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
