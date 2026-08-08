//given a 16 bit address write a constraint so that the lower 2 bits are always 00 (word-aligned address)
//write a constraint to generate another 16-bit addresss with exactly 8 bits set to 1
class word_aligned_address;
	rand bit [15:0] addr1;
	rand bit [15:0] addr2;

	constraint word_aligned { addr1[1:0] ==2'b0; }
	constraint set_bits_8 {$countones(addr2)==5'd8;}					

	function void display();
		$display("The generated addresses are :");
		$display("addr1 = %b",addr1);
		$display("addr2 = %b",addr2);
		$display("--------------------------------------------------------------------------");
	endfunction
endclass

module test;
word_aligned_address a1;
	parameter NUM_RUNS = 5;
	initial
	begin
		a1=new();
		repeat(NUM_RUNS)
			begin
			assert(a1.randomize());
			a1.display();
			end
	end
endmodule

/* OUTPUT:
xcelium> run
The generated addresses are :
addr1 = 1111100110011100
addr2 = 0010101110100011
--------------------------------------------------------------------------
The generated addresses are :
addr1 = 1100001110100100
addr2 = 1110010001011010
--------------------------------------------------------------------------
The generated addresses are :
addr1 = 1100111001101000
addr2 = 1100101011011000
--------------------------------------------------------------------------
The generated addresses are :
addr1 = 0001111100000100
addr2 = 0000101111101001
--------------------------------------------------------------------------
The generated addresses are :
addr1 = 1101101000010100
addr2 = 1110011100010001
--------------------------------------------------------------------------
xmsim: *W,RNQUIE: Simulation is complete.
xcelium> exit
*/
