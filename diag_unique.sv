//write a constraint to generate unique numbers only on diagonal of a 2D array
class diag_unique;
	rand int arr[][];
	rand int size;

	constraint arr_size { size inside {[3:7]};
				size == arr.size();	//column size
				foreach(arr[i])
					arr[i].size()==size;	//each row size;
				}
	constraint arr_values { foreach(arr[i,j])
					arr[i][j] inside {[1:100]};
				}
	constraint diag_values { foreach(arr[i,j])
				//	foreach(arr[c,d])
					//	if((i!=c)&&(j!=d) &&(!((i==j) || (c==d))))	//reduced logic to single foreach loop
						if(i<j)
							arr[i][i]!=arr[j][j];
				}

	function void display();
		foreach(arr[i])
		begin
			foreach(arr[i][j])
				$write(" %3d ",arr[i][j]);
			$display("");
		end
		$display("-----------------------------------");
	endfunction
endclass

module test;
diag_unique d1;
initial
begin
	d1=new();
	for(int i=0;i<10;i++)
		if(d1.randomize())
			d1.display();
		else
			$display("Failed to generate 2D array");
end
endmodule

/*output:
* xcelium> run
  91    4   45 
  88   18   47 
   4   39   50 
-----------------------------------
  64    5   73 
  98   40   69 
  31   73   20 
-----------------------------------
  55   89   37   26   49    2    5 
  18   72   74   66   60   90   66 
  27   12    5   83   49   83   36 
  95   23    2    3   49   74   21 
  15   84   97   14   35   15   18 
  45   58   21    7   97   75   78 
  19   33   30   49    7   35   42 
-----------------------------------
  74    4   68   69   78   30 
  45   11   90   52   79   84 
  82   11   47    7   14    2 
  83   67   67   17   15   86 
  88   98   14   85   16   59 
  20   48   64   92   78    4 
-----------------------------------
  55   70   91   70 
  22   28   35   11 
  81   15   13   84 
  23   75   17   49 
-----------------------------------
  55   93   17   87 
  66   27   83   22 
   6   21   81   65 
  88   51   69   82 
  93   61   97   49   61   13 
  33   96   86   67   35   18 
  76   31   76   68   82   46 
  68   46   27   90   11  100 
  90   50   97   12   98   39 
  82   87   15   88   74   55 
-----------------------------------
  48   97   67   21 
  77   92    9   50 
  22   56   35   93 
  45   66   57   17 
-----------------------------------
  15   49   72   96   54   66 
  74   40   85   74   88   60 
  74    3   83   49   70   13 
  40   86   24  100    5   85 
  11   63   79   10   59   23 
  54    9   82   99    3   60 
-----------------------------------
  63   90   13 
  83   88   67 
  32   94   51 
-----------------------------------
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
----------------------------------
*/
