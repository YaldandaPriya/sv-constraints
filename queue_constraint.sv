/*problem statement:
*Generate a Queue Requirements are:
size=30
even index = even number
odd index = odd number
Adjacent difference > 10
No duplicates
First= minimum
Last = maximum 
without using built-in functions*/

class generate_queue;
	rand bit [7:0] a[$];

	constraint queue_size {a.size() == 5'd30;};
	constraint queue_values { foreach(a[i])
					if(i[0]==1'b0)
						a[i][0]==1'b0;
					else
						a[i][0]==1'b1;
				};
	constraint queue_unique { foreach(a[i])
					foreach(a[j])
						if(i!=j)
							a[i]!=a[j];
				};
	constraint queue_adj_diff { foreach(a[i])
						if(i<(5'd29))
							((a[i]>a[i+1])?(a[i]-a[i+1]):(a[i+1]-a[i]))>4'd10;	//absolute difference
				};
	constraint queue_min_max {foreach(a[i]) {
					if(i!=5'd0)
						a[0]<a[i];
					if(i!=29)
						a[29]>a[i];
					}
				};

	function void queue_display();
		foreach(a[i])
			$write("%d  ",a[i]);
		$display("");
	endfunction
endclass

module test;
generate_queue q1;
initial
	 begin
		 q1=new();
		 for(int i=1;i<=7;i=i+1)
		 begin
			 q1.randomize();
			 q1.queue_display();
		 end
	 end
endmodule

/* OUTPUT
xcelium> run
 24  171  190  245  128  227   68  135  118  107   74   31  204  137  224   99  164   49  168  229  196  159   54  103   80  213  226  145  212  249  
 38   79  204  163  116   55  184   49  162  215  178  191  174  113  216  141  100  127   58  161  130   99  214   43  150  181   92  151   88  219  
 96  155  134  119  142  109  154  101  146  135  108  149  124  167  130  141  104  121  136  147  164   99  116  143  168  131  114  125  144  169  
 18  143   24   77  126  153   44   23   92  121  106   41  124  101   30  125   66   21  160  147  122   89   54   69  154   31   68   37   96  163  
154  191  176  215  174  159  202  169  196  217  204  219  158  173  190  163  220  203  192  205  168  209  194  177  218  183  198  211  166  229  
160  199  184  163  182  207  220  209  164  205  176  161  194  213  166  193  180  165  188  219  202  215  170  185  206  167  216  191  172  221  
 88   99  182  139  216  185  154  127  190  155  118  243  184  137  220  231  146  209  136  109  218  201  166  205  120  183  148  131  102  245  
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
