function [bitstream_re, bit_mv,flag,block]=BlockInterCoding(current_block,r,c , ref_frame,blocksize,q_mtx,search,dict_first_sym,dict_second_sym,mv_codebook,alpha)


% block intra coding
[bit_Intra,MSE_Intra,block_Intra]=BlockIntraCoding(current_block,q_mtx,dict_first_sym,dict_second_sym);


% block bsed motion estimation

mv = me_blockv2(current_block,r,c, ref_frame, blocksize, search);

block_comp = mc_block(ref_frame,mv,blocksize,r,c);
residual=current_block-block_comp;

%imagesc(residual);colormap('gray')

[bit_re,~,resualB]=BlockIntraCoding(residual,q_mtx,dict_first_sym,dict_second_sym);

%reverse from bitstream to image
bit_mv=mv2bs(mv,mv_codebook,'enc');
mcBlock=resualB+mc_block(ref_frame,mv,blocksize,r,c);

MSE_Inter=mean( (current_block(:)-mcBlock(:)).^2);


J_inter=MSE_Inter+alpha*(size(bit_mv,2)+size(bit_re,2)+1);
J_intra=MSE_Intra+alpha*(size(bit_Intra,2)+1);


if J_inter>J_intra
    bitstream_re=bit_Intra;
    bit_mv=[];
    flag=0;
    block=block_Intra;
else
    bitstream_re=bit_re;
    bit_mv=bit_mv;
    flag=1;
    block=mcBlock;

end
  %R =  size(flag,2)/8 + size(bit_mv,2)/8 + size(bitstream_re,2)/8;
  
end

