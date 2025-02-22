
function y = Run_length_Enc(x)
y=[];
c=1;
for i=1:length(x)-1
    if(x(i)==x(i+1))
        c=c+1;
    else
        y=[y,c,x(i),];
    c=1;
    end
end
y=[y,c,x(length(x))];

%https://www.matlabcoding.com/2019/07/run-length-encoder-decoder-in-matlab.html