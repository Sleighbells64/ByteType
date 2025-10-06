
module ps2lut( 
  input logic [6:0] key, 
  output logic [7:0] value
  );

logic [7:0] [127:0] LUT;

  assign value = LUT[key];

//****************************************
  assign LUT[0] = 8'hXX; // NUL
  assign LUT[1] = 8'hXX;// SOH
  assign LUT[2] = 8'hXX;// STX
  assign LUT[3] = 8'hXX;// ETX
  assign LUT[4] = 8'hXX;// EOT
  assign LUT[5] = 8'hXX;// ENQ
  assign LUT[6] = 8'hXX;// ACK
  assign LUT[7] = 8'hXX;// BEL
  assign LUT[8] = 8'hXX;// BS
  assign LUT[9] = 8'hXX;// HT
  assign LUT[10] = 8'hXX;// LF
  assign LUT[11] = 8'hXX;// VT
  assign LUT[12] = 8'hXX;// FF
  assign LUT[13] = 8'hXX;// CR
  assign LUT[14] = 8'hXX;// SO
  assign LUT[15] = 8'hXX;// SI
  assign LUT[16] = 8'hXX;// DLE
  assign LUT[17] = 8'hXX;// DC1 // left arrow
  assign LUT[18] = 8'hXX;// DC2 // down arrow
  assign LUT[19] = 8'hXX;// DC3 // up arrow
  assign LUT[20] = 8'hXX;// DC4 // right arrow
  assign LUT[21] = 8'hXX;// NAK
  assign LUT[22] = 8'hXX;// SYN
  assign LUT[23] = 8'hXX;// ETB
  assign LUT[24] = 8'hXX;// CAN
  assign LUT[25] = 8'hXX;// EM
  assign LUT[26] = 8'hXX;// SUB
  assign LUT[27] = 8'hXX;// ESC
  assign LUT[28] = 8'hXX;// FS
  assign LUT[29] = 8'hXX;// GS
  assign LUT[30] = 8'hXX;// RS
  assign LUT[31] = 8'hXX;// US
  assign LUT[32] = 8'hXX;// space
  assign LUT[33] = 8'hXX;// !
  assign LUT[34] = 8'hXX;// "
  assign LUT[35] = 8'hXX;// #
  assign LUT[36] = 8'hXX;// $
  assign LUT[37] = 8'hXX;// %
  assign LUT[38] = 8'hXX;// &
  assign LUT[39] = 8'hXX;// '
  assign LUT[40] = 8'hXX;// (
  assign LUT[41] = 8'hXX;// )
  assign LUT[42] = 8'hXX;// *
  assign LUT[43] = 8'hXX;// +
  assign LUT[44] = 8'hXX;// ,
  assign LUT[45] = 8'hXX;// -
  assign LUT[46] = 8'hXX;// .
  assign LUT[47] = 8'hXX;// /
  assign LUT[48] = 8'hXX;// 0
  assign LUT[49] = 8'hXX;// 1
  assign LUT[50] = 8'hXX;// 2
  assign LUT[51] = 8'hXX;// 3
  assign LUT[52] = 8'hXX;// 4
  assign LUT[53] = 8'hXX;// 5
  assign LUT[54] = 8'hXX;// 6
  assign LUT[55] = 8'hXX;// 7
  assign LUT[56] = 8'hXX;// 8
  assign LUT[57] = 8'hXX;// 9
  assign LUT[58] = 8'hXX;// :
  assign LUT[59] = 8'hXX;// ;
  assign LUT[60] = 8'hXX;// <
  assign LUT[61] = 8'hXX;// =
  assign LUT[62] = 8'hXX;// >
  assign LUT[63] = 8'hXX;// ?
  assign LUT[64] = 8'hXX;// @
  assign LUT[65] = 8'hXX;// A
  assign LUT[66] = 8'hXX;// B
  assign LUT[67] = 8'hXX;// C
  assign LUT[68] = 8'hXX;// D
  assign LUT[69] = 8'hXX;// E
  assign LUT[70] = 8'hXX;// F
  assign LUT[71] = 8'hXX;// G
  assign LUT[72] = 8'hXX;// H
  assign LUT[73] = 8'hXX;// I
  assign LUT[74] = 8'hXX;// J
  assign LUT[75] = 8'hXX;// K
  assign LUT[76] = 8'hXX;// L
  assign LUT[77] = 8'hXX;// M
  assign LUT[78] = 8'hXX;// N
  assign LUT[79] = 8'hXX;// O
  assign LUT[80] = 8'hXX;// P
  assign LUT[81] = 8'hXX;// Q
  assign LUT[82] = 8'hXX;// R
  assign LUT[83] = 8'hXX;// S
  assign LUT[84] = 8'hXX;// T
  assign LUT[85] = 8'hXX;// U
  assign LUT[86] = 8'hXX;// V
  assign LUT[87] = 8'hXX;// W
  assign LUT[88] = 8'hXX;// X
  assign LUT[89] = 8'hXX;// Y
  assign LUT[90] = 8'hXX;// Z
  assign LUT[91] = 8'hXX; // [
  assign LUT[92] = 8'hXX; // \
  assign LUT[93] = 8'hXX; // ]
  assign LUT[94] = 8'hXX; // ^
  assign LUT[95] = 8'hXX; // _
  assign LUT[96] = 8'hXX; // `
  assign LUT[97] = 8'h1C; // a
  assign LUT[98] = 8'h32; // b
  assign LUT[99] = 8'h21; // c
  assign LUT[100] = 8'h23;// d
  assign LUT[101] = 8'h24;// e
  assign LUT[102] = 8'h2B;// f
  assign LUT[103] = 8'h34;// g
  assign LUT[104] = 8'h33;// h
  assign LUT[105] = 8'h43;// i
  assign LUT[106] = 8'h3B;// j
  assign LUT[107] = 8'h42;// k
  assign LUT[108] = 8'h4B;// l
  assign LUT[109] = 8'h3A;// m
  assign LUT[110] = 8'h31;// n
  assign LUT[111] = 8'h44;// o
  assign LUT[112] = 8'h4D;// p
  assign LUT[113] = 8'h15;// q
  assign LUT[114] = 8'h2D;// r
  assign LUT[115] = 8'h1B;// s
  assign LUT[116] = 8'h2C;// t
  assign LUT[117] = 8'h3C;// u
  assign LUT[118] = 8'h2A;// v
  assign LUT[119] = 8'h1D;// w
  assign LUT[120] = 8'h22;// x
  assign LUT[121] = 8'h35;// y
  assign LUT[122] = 8'h1A;// z
  assign LUT[123] = 8'hXX; // {
  assign LUT[124] = 8'hXX; // |
  assign LUT[125] = 8'hXX; // }
  assign LUT[126] = 8'hXX; // ~
  assign LUT[127] = 8'hXX; // DEL
//****************************************

  endmodule
