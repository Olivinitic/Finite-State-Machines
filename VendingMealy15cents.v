`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Design Name: 
// Module Name:    GasPumpMealy
// Project Name: 

//
//////////////////////////////////////////////////////////////////////////////////
module VendingMoore(
    input clk,
    input reset,
	 input Nickel,
    input Dime,
    output reg Vend,
    output [1:0] State_out  // 3 states that are needed. 2 FFs with 2bits each
    );
	 
// State Variable Declaration
	reg [1:0] present_state = 2'b00;
	reg [1:0] next_state = 2'b00;
	
// Binary state assignment
	parameter [1:0]
		Zero_Cents		=	2'b00,  // state S0
		Five_Cents		=	2'b01,  // State S1
		Ten_Cents 		= 	2'b10;  // Stare S2
		
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
				Zero_Cents:      // State S0
					begin
						// List all input conditions
						if (!Dime & !Nickel) begin
							next_state <= Zero_Cents;
							    Vend <= 0;
							    end
						else if (!Dime & Nickel) begin
							next_state <= Five_Cents;
							    Vend <= 0;
							    end
						else if (Dime & !Nickel) begin
							next_state <= Ten_Cents;
							    Vend <= 0;
							    end
						else next_state <= 2'bx; //don't care state when inputs are 11
						
					end
					
				Five_Cents:       // State S1
				begin
						// List all input conditions
						if (!Dime & !Nickel) begin
							next_state <= Five_Cents;
							   Vend <= 0;
							   end
						else if (!Dime & Nickel) begin
							next_state <= Ten_Cents;
							   Vend <= 0;
							   end
						else if (Dime & !Nickel) begin
							next_state <= Zero_Cents;
							   Vend <= 1;
							   end
						else next_state <= 2'bx;  //don't care state when inputs are 11
						
					end
				Ten_Cents:    // State S2
				begin
						// List all input conditions
						if (!Dime & !Nickel) begin
							next_state <= Ten_Cents;
							    Vend <= 0;
							    end
						else if (!Dime & Nickel) begin
							next_state <= Zero_Cents;
							    Vend <= 1;
							    end
						else if (Dime & !Nickel) begin
							next_state <= Zero_Cents;
							    Vend <= 1;
							    end
						else next_state <= 2'bx;
						
					end
				
				default:
					next_state <= Zero_Cents; // necessary to prevent warnings about uncovered states
			endcase
		end

endmodule
