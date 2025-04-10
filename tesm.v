//stage 0 is decode
//stage 1 is read regs
//stage 2 is read memory
//stage 3 is execute
// This task focuses on the implementation of stage 0 (ID) and stage 1 (read_regs)
module processor (
    clk, mem_en_w, mem_addr_w, mem_val_w, curr_pc, set_pc, request_pc, new_pc, instr, r_reg0, r_reg1, data_reg_0, data_reg_1, reg_en_w, reg_addr_w, reg_val_w, read_mem, queue_en_w, queue_number, pred_en_w, pred, pred_val, pred_val_w, pred_addr_w
);
    //-----------Declare-----------//
    input clk;
    //PC
    input set_pc;
    input [15 : 0] new_pc;
    output request_pc;
    output [15 : 0] curr_pc;
    reg request_pc_;
    assign request_pc = request_pc_;
    //Instruction 
    input [31 : 0] instr;
    reg [31 : 0] queue_instr;
    reg [2 : 0] stage = 0;
    //Predict
    output [1 : 0] pred;                     
    input pred_val;
    output pred_en_w;
    output [1 : 0] pred_addr_w;
    output pred_val_w;
    //Register
    input [31 : 0] data_reg_0, data_reg_1;
    output [3 : 0] r_reg0, r_reg1;
    output reg_en_w;
    output [3 : 0] reg_addr_w;
    output [31 : 0] reg_val_w;
    //Memory
    output [15 : 0] read_mem;
    output mem_en_w;
    output [15 : 0] mem_addr_w;
    output [31 : 0] mem_val_w;
    //Queue 
    output queue_en_w;
    output [3 : 0] queue_number;

    //-----------Execute-----------//
    //Instruction decode 
    wire [31 : 0] ins = (stage == 0) ? instr : queue_instr;
    assign pred = ins[31 : 30];
    wire optype = ins[29];
    wire [4 : 0] opcode = ins[28 : 24];
    assign r_reg0 = ins[23 : 20];
    assign r_reg1 = ins[19 : 16];
    wire[3 : 0] tgtreg = (opcode == 0 || opcode == 5 || opcode == 6 || opcode == 8) ? r_reg0 : (opcode == 12) ? r_reg1 : ins[15 : 12];
    wire [15 : 0] imm;
    assign imm = ins[15 : 0];
    //Condition to don't write is value is error
    wire not_write = (stage == 1 && (pred_val == 0 && pred != 0)) || request_pc;
    wire continue = (stage == 1 && (pred_val == 0 && pred != 0)) || (stage == 1 && (opcode == 1 || opcode == 2 || opcode == 3 || opcode == 4 || opcode == 5 || opcode == 6 || opcode == 7 || opcode == 8 || opcode == 9 || opcode == 10 || opcode == 11 || opcode == 12 || opcode == 13 || opcode == 14 || opcode == 15 || opcode == 16)) || (stage == 2 && opcode == 0);

    //PC 
    //Control stage of program 
    reg [15 : 0] pc; 
    initial request_pc_ = 1'b1;
    assign curr_pc = (set_pc) ? new_pc : continue ? pc + 1 : pc; 
    always @(posedge clk) begin
        if (set_pc && request_pc_) begin
            pc <= new_pc;
            request_pc_ <= 1'b0;
        end
    end

    // Memory
    //In memory, 1 reg storage data, 1 reg storage address for this data
    assign read_mem = data_reg_0[15 : 0];
    assign mem_en_w = !not_write && (stage == 1 && opcode == 1);
    assign mem_addr_w = data_reg_1[15 : 0];
    assign mem_val_w = data_reg_0;

    //Queue
    // In the instruction, each instr has bits [15:0] for imm, but only bits [3:0] are actually used for imm. The remaining bits are used for another purpose.
    assign queue_en_w = !not_write && ((stage == 1 && opcode == 14) || (stage == 1 && opcode == 15));
    assign queue_number = (opcode == 15) ? imm[3 : 0] : data_reg_0[3 : 0];

    //Predicate 
    assign pred_en_w = !not_write && (stage == 1 && opcode == 13);
    assign pred_addr_w = tgtreg [1 : 0];
    wire [31 : 0] temp_in_reg0 = data_reg_0;
    wire [31 : 0] temp_in_reg1 = data_reg_1;
    assign pred_val_w = (opcode == 13) ? (temp_in_reg0 < temp_in_reg1) : 1'b0;
    wire [31 : 0] mult = temp_in_reg0 * temp_in_reg1;
    
    //Register writing
    assign reg_en_w = !not_write && ((stage == 1 && opcode == 12) || (stage == 1 && (opcode == 1 || opcode == 2 || opcode == 3 || opcode == 4 || opcode == 6 || opcode == 7 || opcode == 8 || opcode == 9 || opcode == 10 || opcode == 11)) || (stage == 2 && opcode == 0));
    assign reg_addr_w = tgtreg;
    assign reg_val_w = 
                    opcode == 2 ? ({{16{1'b0}} , mult}) :
                    opcode == 3 ? (data_reg_0 + data_reg_1) :
                    opcode == 4 ? (data_reg_0 - data_reg_1) : 
                    opcode == 5 ? (data_reg_0 >> imm) :
                    opcode == 6 ? (data_reg_0 << imm) :
                    opcode == 7 ? (data_reg_0 & data_reg_1) :
                    opcode == 8 ? (~data_reg_0) :
                    opcode == 9 ? (data_reg_0 ^ data_reg_1) :
                    opcode == 10 ? (data_reg_0 | data_reg_1) :
                    opcode == 11 ? (~(data_reg_0 & data_reg_1)) :
                    opcode == 12 ? ({{16{1'b0}}, imm}) :
                    opcode == 0 ? mem_val_w : 32'b0;

    //Stage machine
    always @(posedge clk) begin 
        if (!request_pc) begin
            if (stage == 0) begin
                queue_instr <= ins;
            end
            else if (stage == 1) begin
                if (opcode == 16) begin
                    request_pc_ <= 1;
                end
            end
            if (continue == 1'b1) begin
                pc <= pc + 1;
                stage <= 0;
            end
            else begin
                stage <= stage + 1;
            end
        end
    end
endmodule