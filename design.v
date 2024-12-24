`timescale 1ns / 1ps
module fsm_example (
    input clk,          // Clock signal
    input reset,        // Synchronous reset
    input in,           // Input signal to control state transitions
    output reg out      // Output based on the state
);

// State encoding
typedef enum reg [1:0] {
    IDLE    = 2'b00,
    LOAD    = 2'b01,
    PROCESS = 2'b10
} state_t;

state_t current_state, next_state;

// Sequential block: State transition on clock edge
always @(posedge clk or posedge reset) begin
    if (reset)
        current_state <= IDLE;
    else
        current_state <= next_state;
end

// Combinational block: Next state logic and output
always @(*) begin
    // Default assignments
    next_state = current_state;
    out = 0;

    case (current_state)
        IDLE: begin
            if (in)
                next_state = LOAD;
            out = 0;
        end

        LOAD: begin
            if (in)
                next_state = PROCESS;
            else
                next_state = IDLE;
            out = 1;
        end

        PROCESS: begin
            if (!in)
                next_state = IDLE;
            out = 1;
        end

        default: next_state = IDLE;
    endcase
end

endmodule
