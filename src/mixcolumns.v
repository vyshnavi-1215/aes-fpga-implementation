
module mixcolumns (
    input  [127:0] state_in,
    output [127:0] state_out
);

function [7:0] xtime(input [7:0] x);
begin
    xtime = (x[7]) ? ((x << 1) ^ 8'h1b) : (x << 1);
end
endfunction

function [7:0] mul2(input [7:0] x);
begin
    mul2 = xtime(x);
end
endfunction

function [7:0] mul3(input [7:0] x);
begin
    mul3 = xtime(x) ^ x;
end
endfunction

// ---------------- CORRECT BYTE UNPACK (FIXED) ----------------
// AES expects: state_in[127:120] = first byte in HEX string

wire [7:0] s [0:15];

assign {
    s[0],  s[1],  s[2],  s[3],
    s[4],  s[5],  s[6],  s[7],
    s[8],  s[9],  s[10], s[11],
    s[12], s[13], s[14], s[15]
} = state_in;

// ---------------- MIXCOLUMNS ----------------
wire [7:0] o [0:15];

// Column 0
assign o[0] = mul2(s[0]) ^ mul3(s[1]) ^ s[2] ^ s[3];
assign o[1] = s[0] ^ mul2(s[1]) ^ mul3(s[2]) ^ s[3];
assign o[2] = s[0] ^ s[1] ^ mul2(s[2]) ^ mul3(s[3]);
assign o[3] = mul3(s[0]) ^ s[1] ^ s[2] ^ mul2(s[3]);

// Column 1
assign o[4] = mul2(s[4]) ^ mul3(s[5]) ^ s[6] ^ s[7];
assign o[5] = s[4] ^ mul2(s[5]) ^ mul3(s[6]) ^ s[7];
assign o[6] = s[4] ^ s[5] ^ mul2(s[6]) ^ mul3(s[7]);
assign o[7] = mul3(s[4]) ^ s[5] ^ s[6] ^ mul2(s[7]);

// Column 2
assign o[8]  = mul2(s[8]) ^ mul3(s[9]) ^ s[10] ^ s[11];
assign o[9]  = s[8] ^ mul2(s[9]) ^ mul3(s[10]) ^ s[11];
assign o[10] = s[8] ^ s[9] ^ mul2(s[10]) ^ mul3(s[11]);
assign o[11] = mul3(s[8]) ^ s[9] ^ s[10] ^ mul2(s[11]);

// Column 3
assign o[12] = mul2(s[12]) ^ mul3(s[13]) ^ s[14] ^ s[15];
assign o[13] = s[12] ^ mul2(s[13]) ^ mul3(s[14]) ^ s[15];
assign o[14] = s[12] ^ s[13] ^ mul2(s[14]) ^ mul3(s[15]);
assign o[15] = mul3(s[12]) ^ s[13] ^ s[14] ^ mul2(s[15]);

// ---------------- CORRECT OUTPUT PACKING ----------------
assign state_out = {
    o[0], o[1], o[2], o[3],
    o[4], o[5], o[6], o[7],
    o[8], o[9], o[10], o[11],
    o[12], o[13], o[14], o[15]
};

endmodule 


