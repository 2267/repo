module state2 (nrst,clk,i1,i2,o1,o2,err);

input nrst,clk;
input i1,i2;
output reg o1,o2,err;


reg [2:0] CS,NS; // next state

parameter [2:0] 
    IDLE = 3'b000,
    S1 = 3'b001,
    S2 = 3'b010,
    ERROR = 3'b100;

always @ (posedge clk or negedge nrst)
if(!nrst)
begin
    CS <= IDLE;
end
else
begin
    CS <= NS;
end

always @ (CS or i1 or i2)
begin
    case (CS)
    IDLE:begin
        if(~i1)  NS <= IDLE;
        if(i1 && i2)  NS <= S1;
        if(i1 && ~i2) NS <= ERROR; 
    end
    S1:begin
        if(~i2) NS <= S1;
        if(i2&&i1)  NS <= S2; 
        if(i2&&(~i1)) NS <= ERROR;
    end
    S2:begin
        if(i2)  NS <= S2;
        if(~i2&&i1)  NS <= IDLE;
        if(~i2&&(~i1)) NS <= ERROR;
    end
    ERROR:begin
        if(i1) NS <= ERROR;
        if(~i1) NS <= IDLE;
    end
    endcase
end


always @ (posedge clk or negedge nrst)
if(!nrst)
    {o1,o2,err} <= 3'b000;
else
begin
case(NS)
    IDLE:     {o1,o2,err} <= 3'b000;
    S1:     {o1,o2,err} <= 3'b001;
    S2:     {o1,o2,err} <= 3'b010;
    ERROR:     {o1,o2,err} <= 3'b100;
endcase
end

endmodule


