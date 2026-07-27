//write a constraint to generate a pattern like 1 0 2 0 3 0 4 0 5 0 ... based on the array size
class pattern_102030;
	rand int arr[];
	rand int size;
	int prev_value=0;
	constraint arr_size { size == arr.size(); size inside {[10:30]};}
	constraint arr_values {foreach(arr[i])
					if(i[0]==0)
						arr[i]==(i/2) + 1;
					else
						arr[i]==0;
				}
	function void display();
		foreach(arr[i])
			$write(" %3d ",arr[i]);
		$display("\n-----------------------------------------");
	endfunction
endclass

module test;
pattern_102030 p1;
initial
begin
	p1=new();
	for(int i=0;i<10;i++)
		if(p1.randomize())
			p1.display();
		else
			$display("Failed to randomize");
end
endmodule

/*OUTPUT:
xcelium> run
   1    0    2    0    3    0    4    0    5    0    6    0    7    0    8    0    9    0   10    0   11    0   12    0   13    0 
-----------------------------------------
   1    0    2    0    3    0    4    0    5    0    6    0    7    0    8    0    9    0   10    0   11    0   12    0   13    0 
-----------------------------------------
   1    0    2    0    3    0    4    0    5    0    6    0    7    0    8    0    9    0   10    0   11    0   12    0   13    0   14    0   15    0 
-----------------------------------------
   1    0    2    0    3    0    4    0    5    0    6    0    7 
-----------------------------------------
   1    0    2    0    3    0    4    0    5    0    6    0    7    0    8    0    9 
-----------------------------------------
   1    0    2    0    3    0    4    0    5    0    6    0    7    0    8    0    9    0   10    0   11    0   12    0   13    0   14 
-----------------------------------------
   1    0    2    0    3    0    4    0    5    0    6    0    7 
-----------------------------------------
   1    0    2    0    3    0    4    0    5    0    6    0    7    0    8    0    9    0   10    0   11    0   12    0   13    0   14 
-----------------------------------------
   1    0    2    0    3    0    4    0    5    0    6    0    7    0    8 
-----------------------------------------
   1    0    2    0    3    0    4    0    5    0    6    0    7    0    8    0    9    0   10    0   11    0   12 
-----------------------------------------
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
