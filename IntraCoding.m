function [bitstream,XQ,MSE_X]=IntraCoding(current_frame,blockSize,q_mtx,dict_first_sym,dict_second_sym)



T_DCT=block_dct_frame(current_frame,blockSize);

quantized_frame=block_quantizer(T_DCT,blockSize,q_mtx);

bitstream=RLC(quantized_frame, blockSize, dict_first_sym,dict_second_sym);%JARRIB ORIGINAL RLC


%R = size(bitstream,2)/101376;
rev_quantized_frame=reverse_block_quantizer(quantized_frame,blockSize,q_mtx);

XQ=block_idct_frame(rev_quantized_frame,blockSize);

MSE_X=mean( (current_frame(:)-XQ(:)).^2);
end


