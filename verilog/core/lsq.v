module lsq(  // load store queue
    input clk,
    input rst,
    input req_sig,
    input req_type,
    input [2:0] req_id, //max 8 buffer data, for later OoO
    input [31:0] req_addr,
    input [31:0] req_data,
    output ready,
    output resp,
    input resp_ack,
    output resp_type,
    output [2:0] resp_id,
    output [31:0] resp_data
);

parameter 
    IDLE = 2'd0,
    READ = 2'd1,
    WRITE = 2'd2;


reg read;
wire read_not_ready;
wire [67:0] read_pkt;
reg read_tmp;
reg [31:0] read_data;

reg write;
reg [67:0] write_pkt;

wire [31:0] write_addr; // discard

assign ready = !not_ready_1 & !not_ready_2;
assign resp = !resp_invalid;

fifo req_fifo(.clk(clk), .rst(rst), 
    .rsig(read), .wsig(req_sig), 
    .wdata({req_type, req_id, req_addr, req_data}),
    .rdata(read_pkt), 
    .full(not_ready_1), .empty(read_not_ready) );

fifo resp_fifo(.clk(clk), .rst(rst), 
    .rsig(resp_ack), .wsig(write), 
    .wdata(write_pkt),
    .rdata({resp_type, resp_id, write_addr, resp_data}), 
    .full(not_ready_2), .empty(resp_invalid) );


reg [31:0] data_mem [0:127];


reg [2:0] CS, NS;

always@(posedge clk or negedge rst)
begin
    if(!rst)
    begin
        read_tmp <= 1'b0;
        CS <= 2'b0;
        NS <= 2'b0;
    end
    else
        CS <= NS;
end

always@(CS or read_not_ready)
begin
    case(CS)
    IDLE:begin
        write <= 1'b0;
        if(!read_not_ready) begin
            read <= 1'b1;
            NS <= READ;
        end
    end
    READ:begin
        read <= 1'b0;
        read_data <= data_mem[read_pkt[40:32]];      // only select low 8bit of addr
        NS <= WRITE;
    end
    WRITE:begin
        write_pkt <= {read_pkt[67],read_pkt[66:64],332'b0, read_data};
        write <= 1'b1;
        NS <= WRITE;
    end
    endcase
end



endmodule
