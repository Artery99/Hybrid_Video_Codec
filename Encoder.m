function [bitstream,decodedFrames,MSEs_X, CR, BPP] = Encoder(fid, frames, nFrame,dict_first_sym,dict_second_sym,mv_codebook,alpha,search)



isRemainingGOPFrame=true;
encodedFrame=0;


q_mtx =     [16 11 10 16 24 40 51 61; %multiply by 0.5 to increase quality
             12 12 14 19 26 58 60 55; % of compressed video
             14 13 16 24 40 57 69 56; 
             14 17 22 29 51 87 80 62;
             18 22 37 56 68 109 103 77;
             24 35 55 64 81 104 113 92;
             49 64 78 87 103 121 120 101;
             72 92 95 98 112 100 103 99];

CRs = [];
BPPs = [];
decodedFrames=zeros(size(frames));
MSEs_X=zeros(1, nFrame);
%Rs = zeros(1, nFrame);
bitstream=[];
blocksize=8;

while(isRemainingGOPFrame)
    currentFrameIdx=encodedFrame+1;
    
    if(encodedFrame == 0)

       [bitIntra,decodedFrames(:,:,currentFrameIdx),MSEs_X(currentFrameIdx)] = IntraCoding(frames(:,:,currentFrameIdx),8,q_mtx,dict_first_sym,dict_second_sym);
        encodedFrame = encodedFrame + 1;
        
        bitstream=[bitstream bitIntra];
        
        
        
        fprintf(fid,'         %4.2f                   %4.2f \n', size(bitIntra,2)/8192,  MSEs_X(currentFrameIdx));
        %fprintf(fid,'----Size of I frame (in k.byte):               %4.2f \n',size(bitIntra,2)/8192);
        %sprintf('Finished intra')
        
       
        %8192 = 8 (for finding it in bytes) * 1024 ( for transforming it into Kilo bytes)       
        
        %Finding CR
        
        CR(currentFrameIdx) = 101.376 /(size(bitIntra,2)/8192);
        BPP(currentFrameIdx) = 8 / CR(currentFrameIdx);
        
        
        
        
        
        
    else
      
      
       [bitRe, bitMv,bitFlag,decodedFrames(:,:,currentFrameIdx),MSEs_X(currentFrameIdx)]=InterCoding(frames(:,:,currentFrameIdx),decodedFrames(:,:,currentFrameIdx - 1),blocksize,q_mtx,search,dict_first_sym,dict_second_sym,mv_codebook,alpha);

        encodedFrame = encodedFrame+1;
        bitstream=[bitstream bitFlag bitMv bitRe];
        
        
        
        fprintf(fid,'         %4.2f                   %4.2f \n', (size(bitFlag,2)+size(bitMv,2)+size(bitRe,2))/8192,  MSEs_X(currentFrameIdx));
        %fprintf(fid,'----Size of P frame (in k.byte):               %4.2f \n',(size(bitFlag,2)+size(bitMv,2)+size(bitRe,2))/8192);
        %bitFlag(1:100)
        %sprintf('finished 1 inter')
        
        
        CR(currentFrameIdx) = 101.376/((size(bitFlag,2)+size(bitMv,2)+size(bitRe,2))/8192);
        BPP(currentFrameIdx) = 8 / CR(currentFrameIdx);
        
    
        

        

    end
    if(encodedFrame==nFrame)
        isRemainingGOPFrame = false;
    end

end

end

