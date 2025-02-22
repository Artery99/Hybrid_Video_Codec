function bit = RLC_TEST(currentBlock,dict_first_sym,dict_second_sym)

tmp = zigzag(currentBlock);
seq = Run_length_Enc(tmp);
bit=genBitstream(seq,dict_first_sym,dict_second_sym);
end


