/*Generate a custom pattern sequence using constraints only.

Pattern:
 0 1 3 2 4 5 7 6 8 9 11 10 ...
 */
class pattern_013245;
	rand int arr[];
	rand int size;

	constraint arr_size{ arr.size()==size ; size inside {[10:25]};}
	constraint arr_values {foreach(arr[i]) {
					if((i%4)<2)
						arr[i]==i;
					else if((i%4)==2)
						arr[i]==i+1;
					else
						arr[i]==i-1;
					}
				}
	function display();
		foreach(arr[i])
			$write("%3d",arr[i]);
		$display("\n----------------------------------------------");
	endfunction
endclass

module test;
pattern_013245 p1;
initial
begin
	p1=new();
	for(int i=0;i<10;i++)
		if(p1.randomize())
			p1.display();
		else
			$display("Randomization failure");
end
endmodule

/* OUTPUT:
xcelium> run
  0  1  3  2  4  5  7  6  8  9
----------------------------------------------
  0  1  3  2  4  5  7  6  8  9 11 10 12 13 15 14 16 17 19 18 20 21 23
----------------------------------------------
  0  1  3  2  4  5  7  6  8  9 11 10 12 13 15 14 16 17 19 18 20 21
----------------------------------------------
  0  1  3  2  4  5  7  6  8  9 11 10 12
----------------------------------------------
  0  1  3  2  4  5  7  6  8  9 11 10 12 13 15 14 16
----------------------------------------------
  0  1  3  2  4  5  7  6  8  9 11
----------------------------------------------
  0  1  3  2  4  5  7  6  8  9 11 10 12
----------------------------------------------
  0  1  3  2  4  5  7  6  8  9 11
----------------------------------------------
  0  1  3  2  4  5  7  6  8  9 11 10 12 13 15
----------------------------------------------
  0  1  3  2  4  5  7  6  8  9 11 10 12 13 15 14 16 17 19 18 20 21 23
----------------------------------------------
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
