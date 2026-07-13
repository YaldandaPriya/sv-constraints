/* Problem Statement:
* N-Queens problem requires placing N chess queens on an NxN chessboard 
* so that no two queens attack each other. This means:
	*No  two queens share the same row
	No two queens share the same column
	No two queens share the same diagonal
Design a parameterized system verilog class that solves this problem for any board size N>=4*/


class Nqueens #(parameter int N=8);
	rand int board[N];

	constraint row_unique { foreach(board[i])
					board[i] inside {[0:N-1]};//board[i] value indicates the Queen position in column of row i
					}
	constraint col_unique { unique{board};}

	constraint diag_unique {foreach(board[i])
					foreach(board[j])
						if(i>j){
							(board[i]-board[j])!=i-j;
							(board[j]-board[i])!=j-i;
						}
				}
	function void print_board();
		foreach(board[i])
		begin
			for(int j=0;j<N;j++)
			begin
				if(board[i]==j)
					$write(" Q ");
				else
					$write(" . ");
			end
			$display("");
		end
	endfunction

endclass

module test;
Nqueens n1;
initial
begin
	n1=new();
	for(int i=1;i<5;i++)
	begin
		if(n1.randomize())
		begin
			$display("Random-> %0d",i);
			n1.print_board();
		end
		else
			$display("Randomization failed");
	end
end
endmodule

/*OUTPUT
xcelium> run
Random-> 1
 .  .  .  .  .  .  Q  . 
 .  Q  .  .  .  .  .  . 
 .  .  .  .  Q  .  .  . 
 .  .  Q  .  .  .  .  . 
 .  .  .  .  .  .  .  Q 
 Q  .  .  .  .  .  .  . 
 .  .  .  Q  .  .  .  . 
 .  .  .  .  .  Q  .  . 
Random-> 2
 .  .  .  .  .  .  Q  . 
 Q  .  .  .  .  .  .  . 
 .  .  .  .  .  .  .  Q 
 .  .  .  .  .  Q  .  . 
 .  .  .  .  Q  .  .  . 
 .  .  Q  .  .  .  .  . 
 .  Q  .  .  .  .  .  . 
 .  .  .  Q  .  .  .  . 
Random-> 3
 .  .  .  Q  .  .  .  . 
 .  .  Q  .  .  .  .  . 
 .  .  .  .  Q  .  .  . 
 .  .  .  .  .  .  .  Q 
 .  Q  .  .  .  .  .  . 
 .  .  .  .  .  Q  .  . 
 Q  .  .  .  .  .  .  . 
 .  .  .  .  .  .  Q  . 
Random-> 4
 Q  .  .  .  .  .  .  . 
 .  .  .  .  Q  .  .  . 
 .  .  .  .  .  .  .  Q 
 .  Q  .  .  .  .  .  . 
 .  .  .  .  .  .  Q  . 
 .  .  Q  .  .  .  .  . 
 .  .  .  .  .  Q  .  . 
 .  .  .  Q  .  .  .  . 
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/

/*USE CASE: if we have N masters and N slaves, and we must route transactions such that no 2 masters target the same slves, and no route paths cross*/




                          
