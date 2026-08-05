/*take a rand variable with array size 10 , need to get unique values in each
* location without using unique keyword and for any of 2 locations we need to
* get same values(not necessarily same index always)*/
class array_unique_but_2_same_values;
	rand int arr[];
	rand int size,i1,i2;

	constraint arr_size { size==10; size==arr.size();
				foreach(arr[i])
					arr[i] inside {[0:100]};
				}
	constraint same_index_values {i1 inside {[0:size-1]};i2 inside {[0:size-1]};i1!=i2;};
				
	constraint array_same_values { arr[i1]==arr[i2];}
	constraint array_unique { foreach(arr[i])
					foreach(arr[j])
						if((i>j) && !((i==i1 && j==i2)||(i==i2 && j==i1)))
							arr[i]!=arr[j];
					}

	function display();
		foreach(arr[i])
			$write("%d",arr[i]);
		$display("\n--------------------------------------------");
	endfunction
endclass

module test;
array_unique_but_2_same_values t1;
initial
begin
	t1=new();
	for(int i=0;i<5;i++)
		if(t1.randomize())
			t1.display();
		else
			$display("Randomization Failed");
end
endmodule

/*OUTPUT:
xcelium> run
         99          0         84        100         30         68         98         89         25         25
--------------------------------------------
         92         72         30         37         99          1         47         92         39         59
--------------------------------------------
         90         32         28         99         54         50         46         50         77         73
--------------------------------------------
         23         49         93         93         86         48         58         47         35         78
--------------------------------------------
         80         28         60         63         68          1         98         25         60         84
--------------------------------------------
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
