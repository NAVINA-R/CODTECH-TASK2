`timescale 1ns / 1ps

module fsm_testbench;

// Testbench signals
reg clk;
reg reset;
reg in;
wire out;

// Instantiate FSM module
fsm_example uut (
    .clk(clk),
    .reset(reset),
    .in(in),
    .out(out)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns clock period
end

// Test sequence
initial begin
    // Initialize inputs
    reset = 1;
    in = 0;

    // Reset FSM
    #10 reset = 0;

    // Test IDLE to LOAD
    #10 in = 1; // Transition to LOAD
    #20 in = 1; // Transition to PROCESS
    #20 in = 0; // Transition back to IDLE

    // Test reset
    #10 reset = 1;
    #10 reset = 0;

    // Test IDLE to LOAD again
    #10 in = 1;
    #10 in = 0;

    // Finish simulation
    #20 $stop;
end

// Monitor signals
initial begin
    $monitor("Time=%0t | reset=%b | in=%b | current_state=%0d | out=%b",
             $time, reset, in, uut.current_state, out);
end

endmodule
