function [bitstream,XQ,MSE_X,R]=IntraCoding2(current_frame,blocksize,q_mtx,dict_first_sym,dict_second_sym)
MSE_Intra_Vector = zeros(1,1584);
R_Vector = zeros(1,1584);
bitstream_I = [];
iBlock = 1;
retBlock = current_frame;
for i=1:blocksize:size(current_frame,1)-blocksize+1
        
        for j=1:blocksize:size(current_frame,2)-blocksize+1
            B = current_frame(i:i+blocksize-1,j:j+blocksize-1);
            
            [bit_Intra,MSE_Intra,block_Intra, R_B] = BlockIntraCoding2(B,q_mtx,dict_first_sym,dict_second_sym);
             
            bitstream_I = [bitstream_I bit_Intra];
            MSE_Intra_Vector(iBlock)= MSE_Intra;
            R_Vector(iBlock) = R_B;
            retBlock(i:i+blocksize-1,j:j+blocksize-1) = block_Intra;

        end
end

bitstream =  bitstream_I;
XQ = retBlock;
MSE_X = mean(MSE_Intra_Vector);
R = mean(R_Vector);


end

