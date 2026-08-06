//write a constraint for an array of 10 elements where first 5 elements are in increasing order and last 5 elemnets are in decreasing order
//	all elements are in range of 50 to 100
//	all elements must be multiple of 5
class half_incre_half_decre;
	rand int arr[];
	rand int size_a;

	constraint array_size{size_a==10;arr.size==size_a;}
	constraint array_values { foreach(arr[i]) {
					arr[i] inside {[50:100]};
					arr[i]%5==0;
					}
				}
	constraint array_order { foreach(arr[i]){
					if(i>0 && i<(size_a/2))
						arr[i]>arr[i-1];
					else if( i>=(size_a/2) && i<size_a)
						arr[i]<arr[i-1];
					}
				}


	function void array_display();
		foreach(arr[i])
			$write("%d\t",arr[i]);
		$display("\n------------------------------------------------------------");
	endfunction
endclass

module test;
half_incre_half_decre arr1;
initial
begin
	arr1=new;
	for(int i=1;i<=5;i=i+1)
	begin
		if(arr1.randomize())
		begin
			$display("%d-random",i);
			arr1.array_display();
		end
		else
		begin
			$display("Randomization Failed");
		end
	end
end
endmodule

/* OUTPUT:
xcelium> run
          1-random
         50              55              65              90             100              75              65              60              55              50
------------------------------------------------------------
          2-random
         55              60              70              80             100              95              90              75              70              65
------------------------------------------------------------
          3-random
         60              70              85              90             100              95              85              80              75              70
------------------------------------------------------------
          4-random
         50              55              60              70             100              95              80              75              60              50
------------------------------------------------------------
          5-random
         55              60              65              75              95              80              70              60              55              50
------------------------------------------------------------
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
