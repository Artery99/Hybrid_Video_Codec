RD = [R' MSEs'];
RQ = [];



figure;
plot(RD(:,1),RD(:,2),'red-x','linewidth',1);
xlabel(' Rate (Kbps)')
ylabel(' MSE')
set(gca,'FontSize',16)

figure;
plot(RQ(:,1),RQ(:,2),'red-x','linewidth',1);
%title(' RD Curve')
xlabel(' Rate (Kbps)')
ylabel(' PSNR (dB)')
set(gca,'FontSize',16)


