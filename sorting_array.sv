
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
