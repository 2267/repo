module receiver(input clk, input rst, input data_in, input data_in_valid, output reg ready);

reg inner_state; //控制state来控制什么时间ready，比如可以是fifo的非满状态
reg data_recv;

always@(posedge clk or negedge rst)
begin
    if(!rst)begin
        inner_state <= 1;
        ready <= 0;
    end

    if(inner_state)begin
        ready <= 1;
        inner_state <= 0;
    end 

    if(data_in_valid)begin
        ready <= 0;
        inner_state <= 1;
        data_recv <= data_in; 
    end
end
endmodule

module sender(input clk, input rst, output reg data_out, output reg data_out_valid, input data_out_ready);

reg data_to_send;
reg state; //控制state来控制是否发送，比如可以是fifo的非空状态

always@(posedge clk or negedge rst)begin
    if(!rst)begin
        data_out_valid <= 0;
    end

    if(data_out_ready & state)begin
        data_out <=  data_to_send;
        data_out_valid <= 1;   
    end

    else if(!data_out_ready) begin
        data_out_valid <= 0;
    end

end

endmodule