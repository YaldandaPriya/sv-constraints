//generate a constraint to generate a symmetric matrix and with unique in the half if the numbers
class symmetric_array;
	rand bit [6:0] arr[];
	rand int size;

	constraint arr_size{ size == arr.size(); size inside {[10:20]};size[0]==0;}
	constraint arr_unique{ unique{arr};}
	
	function void post_randomize();
		int x= size/2;
		for(int i=0;i<x;i=i+1)
			arr[i+x]=arr[i];	//symmetric condition
	endfunction

	function arr_display();
		foreach(arr[i])
		begin
			$write("%d\t",arr[i]);
			if(i==((size/2)-1))
				$write("|");
		end
		$display();
	endfunction
endclass

module test;
symmetric_array s1;
initial
begin
	s1=new();
	for(int i=1;i<=10;i++)
	begin
		if(s1.randomize())
		begin
			$display("Random -> %0d",i);
			s1.arr_display();
		end
		else
			$display("Randomization failure");
	end
end
endmodule

/*OUTPUT
xcelium> run
Random -> 1
 37	 70	 75	 33	  4	106	 57	118	 43	 73	| 37	 70	 75	 33	  4	106	 57	118	 43	 73	 
Random -> 2
 38	 27	 28	126	 58	 54	| 38	 27	 28	126	 58	 54	 
Random -> 3
105	115	 99	119	 13	 26	|105	115	 99	119	 13	 26	 
Random -> 4
  5	111	 10	 77	121	 54	 89	 63	 21	|  5	111	 10	 77	121	 54	 89	 63	 21	 
Random -> 5
 23	 60	 67	 34	 26	 82	 25	101	 85	| 23	 60	 67	 34	 26	 82	 25	101	 85	 
Random -> 6
 78	 57	 13	101	 39	  3	| 78	 57	 13	101	 39	  3	 
Random -> 7
 42	114	 56	 74	  0	| 42	114	 56	 74	  0	 
Random -> 8
 43	  1	 51	 35	 18	 65	121	 21	| 43	  1	 51	 35	 18	 65	121	 21	 
Random -> 9
 82	 29	124	 49	 89	 66	 65	  1	| 82	 29	124	 49	 89	 66	 65	  1	 
Random -> 10
 35	117	 60	 13	125	 49	 10	 30	 90	| 35	117	 60	 13	125	 49	 10	 30	 90	 
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
