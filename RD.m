function Rate = RD(MSE, BPPs)
Rate = zeros(1,length(BPPs));
fps = 4;
numbofpixels = 288*352;
for i = 1:length(BPPs)
    Rate(i) = BPPs(i)*numbofpixels*fps / 8192 ;
end
plot(Rate, MSE);

    
    