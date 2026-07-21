/* Problem Statement:
* Randomize an array of 15 integers such that ; array values are in between 1 and 100
* Rules:
	* All values are unique
	* array should be in ascending order
	* sum of all elements =750
	* exactly 5 prime numbers
	* exactly 5 even numbers
	* remaining 5 are odd(non-prime)
	* difference between consecutive numbers should be >=3
	*/
class values_prime_even_odd;
	rand int arr[15];

	constraint arr_values { foreach(arr[i])
					arr[i] inside {[1:100]};
				}
	constraint arr_sort { foreach (arr[i])
					if(i>0)
						arr[i]>arr[i-1];
				}
	constraint arr_sum { arr.sum()==750; }
	constraint arr_unique { unique {arr}; }
	constraint conse_diff { foreach (arr[i])
					if(i>0)
						arr[i]-arr[i-1]>=3;
				}
	//expensive function
/*	function is_prime(int num);
		if(num<2)
			return 0;
		for(int i=2;(i*i)<=num;i++)
			if(num%i==0)
				return 0;
		return 1;
	endfunction*/

/*	constraint arr_exact_cnt { foreach(arr[i]){
					if(i<5)
						is_prime(arr[i])==1;
					if(i>=5 && i<10)
						arr[i][0]==0;
					if(i>=10&&i<15){
						arr[i][0]==1 ; is_prime(arr[i])==0;}
					}
				}
				  */

	// Prime number pool
  	int primes[] = {
   	   2,3,5,7,11,13,17,19,23,29,
   	   31,37,41,43,47,53,59,61,
   	   67,71,73,79,83,89,97
  	};
	constraint arr_exact_cnt { foreach(arr[i]){
					if(i<5)
						arr[i] inside {primes};
					if(i>=5 && i<10)
						arr[i][0]==0; arr[i] !=2;
					if(i>=10&&i<15){
						arr[i][0]==1 ; !(arr[i] inside {primes});}
					}
				}

	function void post_randomize();
		int prime_cnt=0;
		int even_cnt=0;
		int odd_nonprime_cnt=0;
		foreach(arr[i])
			if(arr[i] inside {primes})
				prime_cnt++;
			else if(arr[i][0]==0)
				even_cnt++;
			else
				odd_nonprime_cnt++;
		$display("No of prime numbers:%2d\nNo of Even numbers:%2d\nNo of Odd numbers:%2d",prime_cnt,even_cnt,odd_nonprime_cnt);
	endfunction

	function display();
		foreach(arr[i])
			$write("%3d",arr[i]);
		$display("\n--------------------------------------------------");
	endfunction
endclass

module test;
values_prime_even_odd v1;
initial
begin
	v1=new();
	for(int i=0;i<5;i++)
		if(v1.randomize())
			v1.display();
		else
			$display("Randomization failure");
end
endmodule

/* OUTPUT:
xcelium> run
No of prime numbers: 5
No of Even numbers: 5
No of Odd numbers: 5
  5 19 23 29 37 40 46 50 54 58 63 69 77 87 93
--------------------------------------------------
No of prime numbers: 5
No of Even numbers: 5
No of Odd numbers: 5
  3  7 11 17 23 38 52 58 62 66 69 77 81 91 95
--------------------------------------------------
No of prime numbers: 5
No of Even numbers: 5
No of Odd numbers: 5
 13 19 23 31 37 42 46 50 54 58 65 69 77 81 85
--------------------------------------------------
No of prime numbers: 5
No of Even numbers: 5
No of Odd numbers: 5
 13 17 23 31 37 40 44 48 52 56 63 69 77 81 99
--------------------------------------------------
No of prime numbers: 5
No of Even numbers: 5
No of Odd numbers: 5
  3 13 19 23 37 40 50 54 58 62 65 69 75 87 95
--------------------------------------------------
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
