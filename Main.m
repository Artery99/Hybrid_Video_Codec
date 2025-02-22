%sequenceName = 'foreman'; 
%resolution = 'cif'; 
%colorspace = 'y';
%fileName = [sequenceName '_' resolution '.' colorspace];



timetoencode = tic;
                                            
OriginalFrames = [];
iGOP = 1;
CompFrames = [];
MSE = [];
CRs = [];
BPPs = [];

bitstream=[];
load('dict_first_sym.mat');
load('dict_second_sym.mat');
mv_codebook=load('mv_codebook.mat');
mv_codebook=mv_codebook.mv_codebook;
alpha=0;
search=0;

isRemainingFrame = true;
startingFrame=1;
encodedFrame=0;
nFrame = 4;
nGOP = 1;
%frames = [];

numberOfFrames2Encode = nFrame*nGOP;


% prepare log file
fid = fopen('Log.txt', 'a');
if fid == -1
  error('Cannot open log file.');
end

fprintf(fid, '%s: %s  \n', datestr(now, 0),'START ENCODER');
fprintf(fid,'----Number of frame to encode:                 %d \n',numberOfFrames2Encode);
fprintf(fid,'----GOP Structure:                             %d \n',nFrame);
fprintf(fid,'----Alpha:                                     %4.2f \n',alpha);
fprintf(fid,'----Search(0 for full search, 1 for 2D Log):   %d \n',search);

fprintf(fid,'----Size of frame(k.byte)        MSE\n');
                                            


%R = zeros(1, numberOfFrames2Encode);
%MSEs = zeros(1, numberOfFrames2Encode);


%Enc

while(isRemainingFrame)
  if encodedFrame>=numberOfFrames2Encode
     sprintf('Encoding finished')
     isRemainingFrame=false;
  else
     %[grayFrame]= readFrame(fileName, startingFrame+encodedFrame)
     [grayimgs] = getCifYUVframe('foreman_cif.yuv',startingFrame+encodedFrame,numberOfFrames2Encode);
      %frames = grayimgs(:,:,encodedFrame +1 : nFrame+encodedFrame);
      OriginalFrames(:,:,:,iGOP) = grayimgs;
     
     %Encoder
     

     [GOP_bitstream,CompressedFrames,MSEs, CR, BPP] = Encoder(fid, grayimgs, nFrame, dict_first_sym,dict_second_sym,mv_codebook,alpha,search);
     CRs = [CRs CR];
     BPPs = [BPPs BPP];
     MSE = [MSE MSEs];
     CompFrames(:,:,:,iGOP) = CompressedFrames;
     iGOP=iGOP + 1;
     
     encodedFrame = encodedFrame + nFrame;
     bitstream = [bitstream GOP_bitstream];
  end 
end

    
elapsedTime = toc(timetoencode)




fprintf(fid,'----Size of encoded video(in k.byte):          %4.2f \n',size(bitstream,2)/8192);
fprintf(fid,'----Encoding duration(s):                      %4.2f \n',elapsedTime);
fprintf(fid, '%s: %s \n', datestr(now, 0), 'ENCODING FINISHED');
fclose(fid);



save bitstream


