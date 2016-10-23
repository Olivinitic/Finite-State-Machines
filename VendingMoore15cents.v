`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Design Name: 
// Module Name:    Vending Machine
// Project Name: 

//
//////////////////////////////////////////////////////////////////////////////////
module VendingMoore(
    input clk,
    input reset,
	input Nickel,
    input Dime,
    output reg Vend,
	 //output wire Ndisplay, Ddisplay, // show the display of Nickel and Dime
    output [1:0] State_out
    );
	 
// State Variable Declaration
	reg [1:0] present_state = 2'b00;
	reg [1:0] next_state = 2'b00;
	
	// Binary state assignment
	parameter [1:0]
		Zero_Cents		=	2'b00,
		Five_Cents		=	2'b01,
		Ten_Cents 		= 	2'b10,
		Fifteen_cents	=	2'b11;
		
	// Output present state binary
	assign State_out = present_state;
	
	// Register generation (D flip flops)
	always @(posedge clk or posedge reset)
		begin : register_generation
			if (reset) 
			present_state <= Zero_Cents;
			else 
			present_state <= next_state;
		end
		
	// Next State Logic
	always @(present_state or Nickel or Dime)
		begin : next_state_logic
		// Default state assignment; use don't cares
		next_state <= 2'bx;
		// Default output assignment
		Vend <= 0;
			case (present_state)
				Zero_Cents: 
					begin
						// List all input conditions
						if (!Dime & !Nickel) 
							next_state <= Zero_Cents;
						else if (!Dime & Nickel) 
							next_state <= Five_Cents;
						else if (Dime & !Nickel) 
							next_state <= Ten_Cents;
						else next_state <= 2'bx;
						// Assign output
						Vend <= 0;
					end
				Five_Cents:
				begin
						// List all input conditions
						if (!Dime & !Nickel) 
							next_state <= Five_Cents;
						else if (!Dime & Nickel) 
							next_state <= Ten_Cents;
						else if (Dime& !Nickel) 
							next_state <= Fifteen_cents;
						else next_state <= 2'bx;
						// Assign output
						Vend <= 0;
					end
				Ten_Cents:
				begin
						// List all input conditions
						if (!Dime & !Nickel) 
							next_state <= Ten_Cents;
						else if (!Dime & Nickel) 
							next_state <= Fifteen_cents;
						else if (Dime & !Nickel) 
							next_state <= Fifteen_cents;
						else next_state <= 2'bx;
						// Assign output
						Vend <= 0;
					end
				Fifteen_cents:
					begin
						// List all input conditions
						if (!Dime & !Nickel) 
							next_state <= Zero_Cents;
						else if (!Dime & Nickel) 
							next_state <= Five_Cents;  // this is different than state diagram
						else if (Dime & !Nickel)      // this is different than state diagram
							next_state <= Ten_Cents;
						else next_state <= 2'bx;
						// Assign output
						Vend <= 1;
					end
				default:
					next_state <= Zero_Cents; // necessary to prevent warnings about uncovered states
			endcase
		end

endmodule
