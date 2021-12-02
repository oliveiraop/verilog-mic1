module bin2lcd(register, out0, out1, out2, out3, out4, out5, out6, out7);

input [31:0] register;
output reg [7:0] out0, out1, out2, out3, out4, out5, out6, out7;

parameter 
n0 = 8'h30, 
n1 = 8'h31, 
n2 = 8'h32, 
n3 = 8'h33, 
n4 = 8'h34,
n5 = 8'h35,
n6 = 8'h36,
n7 = 8'h37,
n8 = 8'h38,
n9 = 8'h39,
nA = 8'h41,
nB = 8'h42,
nC = 8'h43,
nD = 8'h44,
nE = 8'h45,
nF = 8'h46;

always @ (register)
begin
  case (register[3:0])
  0: out0 = n0;
  1: out0 = n1;
  2: out0 = n2;
  3: out0 = n3;
  4: out0 = n4;
  5: out0 = n5;
  6: out0 = n6;
  7: out0 = n7;
  8: out0 = n8;
  9: out0 = n9;
  10: out0 = nA;
  11: out0 = nB;
  12: out0 = nC;
  13: out0 = nD;
  14: out0 = nE;
  15: out0 = nF;
  default: out0 = n0;
  endcase
  case (register[7:4])
  0: out1 = n0;
  1: out1 = n1;
  2: out1 = n2;
  3: out1 = n3;
  4: out1 = n4;
  5: out1 = n5;
  6: out1 = n6;
  7: out1 = n7;
  8: out1 = n8;
  9: out1 = n9;
  10: out1 = nA;
  11: out1 = nB;
  12: out1 = nC;
  13: out1 = nD;
  14: out1 = nE;
  15: out1 = nF;
  default: out1 = n0;
  endcase
  case (register[11:8])
  0: out2 = n0;
  1: out2 = n1;
  2: out2 = n2;
  3: out2 = n3;
  4: out2 = n4;
  5: out2 = n5;
  6: out2 = n6;
  7: out2 = n7;
  8: out2 = n8;
  9: out2 = n9;
  10: out2 = nA;
  11: out2 = nB;
  12: out2 = nC;
  13: out2 = nD;
  14: out2 = nE;
  15: out2 = nF;
  default: out2 = n0;
  endcase
  case (register[15:12])
  0: out3 = n0;
  1: out3 = n1;
  2: out3 = n2;
  3: out3 = n3;
  4: out3 = n4;
  5: out3 = n5;
  6: out3 = n6;
  7: out3 = n7;
  8: out3 = n8;
  9: out3 = n9;
  10: out3 = nA;
  11: out3 = nB;
  12: out3 = nC;
  13: out3 = nD;
  14: out3 = nE;
  15: out3 = nF;
  default: out3 = n0;
  endcase
  case (register[19:16])
  0: out4 = n0;
  1: out4 = n1;
  2: out4 = n2;
  3: out4 = n3;
  4: out4 = n4;
  5: out4 = n5;
  6: out4 = n6;
  7: out4 = n7;
  8: out4 = n8;
  9: out4 = n9;
  10: out4 = nA;
  11: out4 = nB;
  12: out4 = nC;
  13: out4 = nD;
  14: out4 = nE;
  15: out4 = nF;
  default: out4 = n0;
  endcase
  case (register[23:20])
  1: out5 = n1;
  0: out5 = n0;
  2: out5 = n2;
  3: out5 = n3;
  4: out5 = n4;
  5: out5 = n5;
  6: out5 = n6;
  7: out5 = n7;
  8: out5 = n8;
  9: out5 = n9;
  10: out5 = nA;
  11: out5 = nB;
  12: out5 = nC;
  13: out5 = nD;
  14: out5 = nE;
  15: out5 = nF;
  default: out5 = n0;
  endcase
  case (register[27:24])
  0: out6 = n0;
  1: out6 = n1;
  2: out6 = n2;
  3: out6 = n3;
  4: out6 = n4;
  5: out6 = n5;
  6: out6 = n6;
  7: out6 = n7;
  8: out6 = n8;
  9: out6 = n9;
  10: out6 = nA;
  11: out6 = nB;
  12: out6 = nC;
  13: out6 = nD;
  14: out6 = nE;
  15: out6 = nF;
  default: out6 = n0;
  endcase
  case (register[31:28])
  0: out7 = n0;
  1: out7 = n1;
  2: out7 = n2;
  3: out7 = n3;
  4: out7 = n4;
  5: out7 = n5;
  6: out7 = n6;
  7: out7 = n7;
  8: out7 = n8;
  9: out7 = n9;
  10: out7 = nA;
  11: out7 = nB;
  12: out7 = nC;
  13: out7 = nD;
  14: out7 = nE;
  15: out7 = nF;
  default: out7 = n0;
  endcase


end

endmodule