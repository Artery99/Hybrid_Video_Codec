 % create the video writer with 1 fps
 writerObj = VideoWriter('MyOriginalVideo.avi');
 writerObj.FrameRate = 4;
 % set the seconds per image
 %secsPerImage = [5 10 15];
 % open the video writer
 open(writerObj);
 % write the frames to the video
  for z = 1:size(CompFrames,4)
    for u=1:size(CompFrames,3) / size(OriginalFrames,4)
     % convert the image to a frame
     
     
        writeVideo(writerObj, uint8(OriginalFrames(:,:,u,z)));
     
    end
end
 % close the writer object
 close(writerObj);


 % create the video writer with 1 fps
 writerObj = VideoWriter('MyCompressedVideo.avi');
 writerObj.FrameRate = 4;
 % set the seconds per image
 %secsPerImage = [5 10 15];
 % open the video writer
 open(writerObj);
 % write the frames to the video
 for z = 1:size(CompFrames,4)
    for u=1:size(CompFrames,3) / size(CompFrames,4)
     % convert the image to a frame
     
     
        writeVideo(writerObj, uint8(CompFrames(:,:,u,z)));
     
    end
end
 % close the writer object
 close(writerObj);