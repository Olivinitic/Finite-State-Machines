`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////

module VendingMoore15Cents_tb;

	// Inputs
	reg clk;
	reg reset;
	reg Nickel;
	reg Dime;

	// Outputs
	wire Vend;
	wire [1:0] State_out;

	// Reference Output
	reg Vend_compare_async, Vend_compare_sync;// checking the synchronization of your Vend output
	
	// Instantiate the Unit Under Test (UUT)
	VendingMoore uut (
		.clk(clk), 
		.reset(reset), 
		.Nickel(Nickel), 
		.Dime(Dime), 
		.Vend(Vend), 
//		.State_out_LED(State_out_LED)
	);

	task toggle_clk;
		begin
			#10 clk = ~clk;
			Vend_compare_sync = Vend_compare_async;
			#10 clk = ~clk;
		end
	endtask
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		Nickel = 0;
		Dime = 0;
		Vend_compare_sync = 0;
		Vend_compare_async = 0;
		
		// Wait 100 ns for global reset to finish
		#100;
 		//reset state machine
		reset = 1;
		#10;
		reset = 0;
		#10
		// toggle_clk;
		
		Dime = 0;
		Nickel = 0;
		toggle_clk;
		
		Dime = 0;
		Nickel = 1;
		Vend_compare_async = 1;
		toggle_clk;
		
		Dime = 1;
		Nickel = 0;
		Vend_compare_async = 0;
		toggle_clk; 
				
		Dime = 0;
		Nickel = 0;
		Vend_compare_async = 0;
		toggle_clk;
		
		Dime = 1; 
		Nickel = 0;
		Vend_compare_async = 0;
		toggle_clk;
			
		Dime = 0;
		Nickel = 1;
		Vend_compare_async = 1;
		toggle_clk;
		
		Dime = 0;
		Nickel = 0;
		Vend_compare_async = 0;
		toggle_clk;
		
		Dime = 1;
		Nickel = 0;
		Vend_compare_async = 0;
		toggle_clk;
			
		Dime = 0;
		Nickel = 1;
		Vend_compare_async = 1;
		toggle_clk;
		
		Dime = 0;
		Nickel = 0;
		Vend_compare_async = 0;
		toggle_clk;
		
		Dime = 1;
		Nickel = 0;
		Vend_compare_async = 0;
		toggle_clk;
			
		Dime = 0;
		Nickel = 1;
		Vend_compare_async = 1;
		toggle_clk;
		
	end
      
endmodule