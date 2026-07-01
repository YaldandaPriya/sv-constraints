//sorting array without using built-in sort function
class sort_array;
	rand bit [4:0] a[];
	rand bit [4:0] size_a;

	constraint array_size{size_a >=2;a.size==size_a;}

	function void post_randomize();
		int temp;
		for(int i=0;i<size_a-1;i=i+1)
			for(int j=i+1;j<size_a;j=j+1)
				if(a[i]>a[j])
				begin
					temp=a[j];
					a[j]=a[i];
					a[i]=temp;
				end
	endfunction

	function void array_display();
		foreach(a[i])
			$write("%d\t",a[i]);
		$display("");
	endfunction
endclass

module test;
sort_array arr1;
initial
begin
	arr1=new;
	for(int i=1;i<=5;i=i+1)
	begin
		arr1.randomize();
		$display("%d-random",i);
		arr1.array_display();
	end
end
endmodule

/* OUTPUT
xcelium> run
          1-random
 1       3       3       4       5       5       5       6       8       8       9      10      11      14      15      15      18      22      23      27      29      31
          2-random
 6       8      15      19      23      27      27      27
          3-random
 3       9      13      18      20
          4-random
 3       5       9      10      11      12      13      14      14      17      17      19      20      21      21      23      24      25      25      25      27      27   28       28      29      30      30
          5-random
 1       1       1       1       2      10      12      13      14      18      18      19      23      24      24      25      25      26      27      30
xmsim: *W,RNQUIE: Simulation is complete.
*/
