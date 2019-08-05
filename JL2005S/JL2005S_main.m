clc
clear all
close all

% JL2005S
global theta EL


q = 0; % For constant light, q=1, constant dark, q=0
% Loading simulated data from JL2005
if q == 1
    load LockeJTB_training.mat
    r1 = 1; r2 = 192;
    mLHY = mLHY12(r1:r2);
    pcLHY = pcLHY12(r1:r2);
    pnLHY = pnLHY12(r1:r2);
    pLHY = pcLHY + pnLHY;
    mTOC1 = mTOC112(r1:r2);
    pcTOC1 = pcTOC112(r1:r2);
    pnTOC1 = pnTOC112(r1:r2);
    pTOC1 = pcTOC1 + pnTOC1;
    pP = pP12(r1:r2);
    TL = TL12(r1:r2);
elseif q == 0
    load LockeJTB_validation.mat
    r1 = 1; r2 = 192;
    mLHY = mLHY12(r1:r2);
    pcLHY = pcLHY12(r1:r2);
    pnLHY = pnLHY12(r1:r2);
    pLHY = pcLHY + pnLHY;
    mTOC1 = mTOC112(r1:r2);
    pcTOC1 = pcTOC112(r1:r2);
    pnTOC1 = pnTOC112(r1:r2);
    pTOC1 = pcTOC1 + pnTOC1;
    pP = pP12(r1:r2);
    TL = TL12(r1:r2);
end

%% Model parameter
prmLHY = [1.4361,1.3276,1.2875,4.7463];
prpcLHY = [0.40741,2.0764,1.7443];
prpnLHY = [0.91472,1.7344,1.4088];
prmTOC1 = [0.048426,-1.4874,1.5163];
prpcTOC1 = [2.3917,1.9657,0.20751];
prpnTOC1 = [0.037813,1.1309,0.026805];
prpP = [0.48862,0.40802,-1.569];

linearthetanl = [prmLHY prpcLHY prpnLHY prmTOC1 prpcTOC1 prpnTOC1 prpP];

theta = linearthetanl;

%% Initial condition (first data point of the synthetic data from JL2005)
C = [2.4051,1.3471,0.7448,0.0591,0.7377,1.3882,0.1462];
Cinit = [2.4051,1.3471,0.7448,0.0591,0.7377,1.3882,0.1462];

ProteinLevel = [];

for t = 1:length(TL)
    tspan = [t t+1];
    EL = TL(t);
    [T,C] = ode45('JL2005S_ODE',tspan,C(end,:));
    ProteinLevel = [ProteinLevel; C(end,:)];
end
ProteinLevel = [Cinit; ProteinLevel(2:end,:)];

%% Figure plotting

tp = 0:length(TL)-1;

figure(1)
subplot 421
plot(tp,mLHY,'b.-')
hold on
plot(tp,ProteinLevel(:,1),'r.-')
grid on
title('LHY/CCA1 mRNA')

subplot 422
plot(tp,pcLHY,'b.-')
hold on
plot(tp,ProteinLevel(:,2),'r.-')
grid on
title('LHY/CCA1 cytoplasmic protein')

subplot 423
plot(tp,pnLHY,'b.-')
hold on
plot(tp,ProteinLevel(:,3),'r.-')
grid on
title('LHY/CCA1 nuclear protein')

subplot 424
plot(tp,mTOC1,'b.-')
hold on
plot(tp,ProteinLevel(:,4),'r.-')
grid on
title('TOC1 mRNA')

subplot 425
plot(tp,pcTOC1,'b.-')
hold on
plot(tp,ProteinLevel(:,5),'r.-')
grid on
title('TOC1 cytoplasmic protein')

subplot 426
plot(tp,pnTOC1,'b.-')
hold on
plot(tp,ProteinLevel(:,6),'r.-')
grid on
title('TOC1 nuclear protein')

subplot 427
plot(tp,pP,'b.-')
hold on
plot(tp,ProteinLevel(:,7),'r.-')
grid on
title('Protein P')
legend('JL2005','JL2005S','Location','Best')