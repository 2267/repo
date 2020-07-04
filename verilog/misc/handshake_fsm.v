module receiver(input clk, input rst, input valid, output ready, input data);
parameter IDLE=0;
parameter WAIT=1;
parameter END=2;


reg state; 
reg inner_ready;
reg data_reg;
always@(posedge clk)begin
    if(!rst)begin
        state <= IDLE;
        inner_ready <= 0;
    end

    case(state)
        IDLE: begin
            if(inner_ready)begin
                state <= WAIT;
                ready <= 1;
            end 
        end
        WAIT:begin
            if(valid) begin
                state <= END;
                data_reg <= data;
            end
        end
    endcase


end



endmodule