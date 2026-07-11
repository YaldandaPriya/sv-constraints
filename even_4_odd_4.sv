//write a  constraint on a 2D array to generate even numbers in the first 4 locations and odd numbers in the next 4 locations and so on...
class array_4;
	rand bit [4:0] arr[][];
	rand bit [2:0] rows,cols;

	constraint arr_size{arr.size()==rows; foreach(arr[i])
							arr[i].size()==cols;}
	constraint arr_numbers{foreach(arr[i,j])
					if(((i*cols+j)/4)%2==0)
						arr[i][j][0]==0;
					else
						arr[i][j][0]==1;
					};
	function void arr_display();
		foreach(arr[i,j])
		begin
			$write("%d\t",arr[i][j]);
			if(j==cols-1)
				$display();
		end
	endfunction
endclass

module test;
array_4 a1;
initial
begin
	a1=new();
	for(int i=1;i<=6;i++)
	begin
		if(a1.randomize())
		begin
			$display("Randomization -> %0d",i);
			a1.arr_display();
		end
		else
			$display("randomization failure");
	end
end
endmodule

/*OUTPUT
xcelium> run
Randomization -> 1
 2       
10       
30       
 6       
Randomization -> 2
22       6       
16      24       
27      29       
 1       7       
26      12       
 4      20       
Randomization -> 3
Randomization -> 4
22       8      24       6      25       
Randomization -> 5
 2      26       
28       6       
Randomization -> 6
 4       6      28      28       3       1      27       
19      16       6      16      18       9      21       
 1       9       8      24       6      16      17       
23      17      11       6      26      18       6       
 7      25       5      31       2       6      26       
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
