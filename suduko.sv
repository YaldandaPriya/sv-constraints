/*problem statement:
Suduko generator 9x9 valid suduko, where every row should contain 1-9excatly once, every column contains 1-9 exactly once and every 3x3 block
contains 1-9 exactly once*/
class suduko;
	//rand bit [3:0] row, col;
	rand bit [3:0] arr[9][9];

	constraint con3{ foreach(arr[i,j])
				arr[i][j] inside {[1:9]};}
	constraint row_cons{ foreach(arr[i,j])
				foreach(arr[i,k])
					if(j<k)
						arr[i][j]!=arr[i][k];
				}
	constraint col_cons{ foreach(arr[i,j])
				foreach(arr[k,j])
					if(i<k)
						arr[i][j]!=arr[k][j];
				}
	constraint cons_3x3{ foreach(arr[i,j]){
				foreach(arr[c,d]){
					if((i/3==c/3) && (j/3==d/3) && !((i==c)&&(j==d))){
						arr[i][j]!=arr[c][d];}
						}}
			}
	
	function void suduko_display;
		int i,j;
		for (i=0;i<9;i=i+1)
		begin
			for(j=0;j<9;j=j+1)
				$write("%d\t",arr[i][j]);
			$write("\n");
		end
	endfunction

endclass	
module test;
suduko s1;
initial 
begin
	s1=new();
	for(int i=0;i<1; i=i+1)
	begin
		s1.randomize();
		s1.suduko_display;
	end
end
endmodule

/* OUTPUT
xcelium> run
 5       7       8       9       2       3       1       6       4
 6       1       9       7       8       4       2       5       3
 4       2       3       1       5       6       8       9       7
 3       6       5       8       4       1       7       2       9
 2       4       1       6       7       9       5       3       8
 8       9       7       5       3       2       6       4       1
 1       3       4       2       6       8       9       7       5
 7       8       2       3       9       5       4       1       6
 9       5       6       4       1       7       3       8       2
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
