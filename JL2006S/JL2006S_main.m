clc
clear all
close all

% JL2006S

global theta EL

q = 0; % For constant light, q=1, constant dark, q=0
if q == 1
    load LockeMSB_training.mat
    r1 = 1; r2 = 192;
    mLHY = mLHY12(r1:r2);
    pcLHY = pcLHY12(r1:r2);
    pnLHY = pnLHY12(r1:r2);
    pLHY = pcLHY + pnLHY;
    mTOC1 = mTOC112(r1:r2);
    pcTOC1 = pcTOC112(r1:r2);
    pnTOC1 = pnTOC112(r1:r2);
    pTOC1 = pcTOC1 + pnTOC1;
    mX = mX12(r1:r2);
    pcX = pcX12(r1:r2);
    pnX = pnX12(r1:r2);
    pX = pcX + pnX;
    mY = mY12(r1:r2);
    pcY = pcY12(r1:r2);
    pnY = pnY12(r1:r2);
    pY = pcY + pnY;
    pP = pP12(r1:r2);
    mP7P9 = mP7P912(r1:r2);
    pcP7P9 = pcP7P912(r1:r2);
    pnP7P9 = pnP7P912(r1:r2);
    TL = TL12(r1:r2);
    
elseif q == 0
    load LockeMSB_validation.mat
    r1 = 1; r2 = 192;
    mLHY = mLHY12(r1:r2);
    pcLHY = pcLHY12(r1:r2);
    pnLHY = pnLHY12(r1:r2);
    pLHY = pcLHY + pnLHY;
    mTOC1 = mTOC112(r1:r2);
    pcTOC1 = pcTOC112(r1:r2);
    pnTOC1 = pnTOC112(r1:r2);
    pTOC1 = pcTOC1 + pnTOC1;
    mX = mX12(r1:r2);
    pcX = pcX12(r1:r2);
    pnX = pnX12(r1:r2);
    pX = pcX + pnX;
    mY = mY12(r1:r2);
    pcY = pcY12(r1:r2);
    pnY = pnY12(r1:r2);
    pY = pcY + pnY;
    pP = pP12(r1:r2);
    mP7P9 = mP7P912(r1:r2);
    pcP7P9 = pcP7P912(r1:r2);
    pnP7P9 = pnP7P912(r1:r2);
    TL = TL12(r1:r2);
end

%% Model Parameter
prpP = [0.4597,0.37707,-4.2379];
prmLHY = [0.45369,0.0011865,-3.5046,0.61166,3.0769,-2.8305];
prpcLHY = [0.1151,1.0993,4.5548];
prpnLHY = [9.2696,0.82823,2.7978];
prmTOC1 = [3.6836,-0.21643,0.52322,1.222];
prpcTOC1 = [2.3001,1.5802,0.22262,-0.00016422];
prpnTOC1 = [0.0067181,1.8217,1.0125,-0.00010636];
prmX = [0.1676,0.48537,1.7277];
prpcX = [2.1878,1.0808,0.14799];
prpnX = [0.3147,1.1689,1.1132];
prmY = [0.0023852,-0.54479,-1.6621,1.8331,1.8447,-0.061316,0.015028,-0.11211,-0.19662];
prpcY = [0.11596,0.77797,1.3022];
prpnY = [1.9436,0.9501,0.5854];
prmP7P9 = [9.5387,0.25577,0.25118,1.0569];
prpcP7P9 = [0.00021687,2.9325,0.25463];
prpnP7P9 = [0.12392,1.6268,0.2576];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

linearthetanl = [prpP prmLHY prpcLHY prpnLHY prmTOC1 prpcTOC1 prpnTOC1...
    prmX prpcX prpnX prmY prpcY prpnY prmP7P9 prpcP7P9 prpnP7P9];

theta = linearthetanl;

%% Initial condition (first data point of synthetic data)
C = [0.1463,1.3923,0.0402,0.2150,0.5031,7.8418,0.3482,0.0709,1.4869,0.4455,0.1205,0.0173,0.0303,16.4165,1.1309,0.8871];
Cinit = [0.1463,1.3923,0.0402,0.2150,0.5031,7.8418,0.3482,0.0709,1.4869,0.4455,0.1205,0.0173,0.0303,16.4165,1.1309,0.8871];

ProteinLevel = [];

for t = 1:length(TL)
    tspan = [t t+1];
    EL = TL(t);
    [T,C] = ode45('JL2006S_ODE',tspan,C(end,:));
    ProteinLevel = [ProteinLevel; C(end,:)];
end
ProteinLevel = [Cinit; ProteinLevel(2:end,:)];

%% Figure plotting

tp = 0:length(TL)-1;

figure(1)
subplot (4,4,1)
plot(tp,pP,'b.-')
hold on
plot(tp,ProteinLevel(:,1),'r.-')
title('Protein P')
grid on

subplot (4,4,2)
plot(tp,mLHY,'b.-')
hold on
plot(tp,ProteinLevel(:,2),'r.-')
title('LHY/CCA1 mRNA')
grid on

subplot (4,4,3)
plot(tp,pcLHY,'b.-')
hold on
plot(tp,ProteinLevel(:,3),'r.-')
title('LHY/CCA1 cytoplasmic protein')
grid on

subplot (4,4,4)
plot(tp,pnLHY,'b.-')
hold on
plot(tp,ProteinLevel(:,4),'r.-')
title('LHY/CCA1 nuclear protein')
grid on

subplot (4,4,5)
plot(tp,mTOC1,'b.-')
hold on
plot(tp,ProteinLevel(:,5),'r.-')
title('TOC1 mRNA')
grid on

subplot (4,4,6)
plot(tp,pcTOC1,'b.-')
hold on
plot(tp,ProteinLevel(:,6),'r.-')
title('TOC1 cytoplasmic protein')
grid on

subplot (4,4,7)
plot(tp,pnTOC1,'b.-')
hold on
plot(tp,ProteinLevel(:,7),'r.-')
title('TOC1 nuclear protein')
grid on

subplot (4,4,8)
plot(tp,mX,'b.-')
hold on
plot(tp,ProteinLevel(:,8),'r.-')
title('X mRNA')
grid on

subplot (4,4,9)
plot(tp,pcX,'b.-')
hold on
plot(tp,ProteinLevel(:,9),'r.-')
title('X cytoplasmic protein')
grid on

subplot (4,4,10)
plot(tp,pnX,'b.-')
hold on
plot(tp,ProteinLevel(:,10),'r.-')
title('X nuclear protein')
grid on

subplot (4,4,11)
plot(tp,mY,'b.-')
hold on
plot(tp,ProteinLevel(:,11),'r.-')
title('Y mRNA')
grid on

subplot (4,4,12)
plot(tp,pcY,'b.-')
hold on
plot(tp,ProteinLevel(:,12),'r.-')
title('Y cytoplasmic protein')
grid on

subplot (4,4,13)
plot(tp,pnY,'b.-')
hold on
plot(tp,ProteinLevel(:,13),'r.-')
title('Y nuclear protein')
grid on

subplot (4,4,14)
plot(tp,mP7P9,'b.-')
hold on
plot(tp,ProteinLevel(:,14),'r.-')
title('PRR7/PRR9 mRNA')
grid on

subplot (4,4,15)
plot(tp,pcP7P9,'b.-')
hold on
plot(tp,ProteinLevel(:,15),'r.-')
title('PRR7/PRR9 cytoplasmic protein')
grid on

subplot (4,4,16)
plot(tp,pnP7P9,'b.-')
hold on
plot(tp,ProteinLevel(:,16),'r.-')
title('PRR7/PRR9 nuclear protein')
grid on
legend('JL2006','JL2006S','Location','Best')